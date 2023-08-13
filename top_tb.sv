// Define the top level component
//`include "mux3to8_test.sv"
module top;

class my_item;
  rand logic reset;
  rand logic enable;
  rand logic d;
  logic q;
  rand int delay;
  
  constraint c_reset {reset dist {1:=1, 0:=5};}  
  constraint c_delay {delay < 3;}

  covergroup Cov;
    option.per_instance = 1;
    cp_reset: coverpoint reset;
    cp_enable: coverpoint enable;
    cp_d : coverpoint d;
    cc_all: cross cp_reset, cp_enable, cp_d;
  endgroup

  function new();
        Cov = new();
  endfunction
endclass

initial begin
  my_item m_item = new();
    
  for (int i = 1; i < 5; i++) begin
    m_item.randomize();
    m_item.Cov.sample();
  end
  
  $display("Coverage = %d", m_item.Cov.get_coverage());

end
endmodule
