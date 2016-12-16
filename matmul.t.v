`include "matmul.v"

module test_matmul();

reg rst_n = 1'b0;
reg clk = 1'b0;
reg start = 1'b0;

reg [2*2*32-1:0] a;
reg [2*2*32-1:0] b;
wire [2*2*32-1:0] o;

wire done;

matmul #(.S(32), .W(2), .H(2), .C(2)) m(rst_n, clk, start, a, b, o, done);

always begin
	#10
	clk = !clk;
end

always @(posedge done) begin
	$display("a b o");
	$display("%H %H %H", a, b, o);
end

initial begin
    $dumpfile("matmul.vcd");
    $dumpvars(0, test_matmul);

	rst_n = 1'b0;
	@(negedge clk);

	a = {32'h40a00000, 32'h40a00000, 32'h40a00000, 32'h40a00000};
	b = {32'h40a00000, 32'h40a00000, 32'h40a00000, 32'h40a00000};

	start = 1'b1;
	@(negedge clk);
	start = 1'b0;
	rst_n = 1'b1;
	#500;
	$finish;
end

endmodule