#include <iostream>

#int main()
#{
#    int nterms = 1000 ; // accept from user
#    double sum = 0.0 ;
#    int numerator = -1 ;
#    n = 1;
#    for( int counter = 1 ; counter < nterms ; n += 2; counter +=1) // for each term upto nterms
#    {
#        numerator *= -1 ; // alernating +1, -1, +1, -1 ...
#        const double term = numerator / double(n) ; // +1/1.0, -1/3.0, +1/5.0 ...
#       sum += term ; // +1/1.0 + -1/3.0, + 1/5.0 + -1/7.0 ...
#    }
#   const double pi = 4 * sum ; // 4 * ( 1/1.0 + -1/3.0, + 1/5.0 + -1/7.0 ... )
#    std::cout << "pi upto " << nterms << " terms: " << pi << '\n' ;
#}

#a2: Number of terms
#fa0: the estimation of PI
#fa1 : set to 4
#fa2 : numerator
#fa3: sum value
#fa4: term
#a3: upperBounds (int)
#a4: counter (int)

.text
	.globl calcPI
calcPI:
	
	INITIALIZE:
	
			#Initialize needed variables
			add t0, zero, zero #set a temp variable to 0
			addi t1, zero, 4 #set a temp variable to 4
			addi t2, zero, 2 #set a temp variable to 2
			addi t3, zero,-1 #set a temp variable to -1
			addi t4, zero, 1 #set a temp variable to 1
			fcvt.s.w fa0, t0 #set FP register to 0
			fcvt.s.w fa1, t1 #const double: convert into to float
			fcvt.s.w fa2, t4 #numerator: convert into to float	
			fcvt.s.w fa3, t4 #sum: convert into to float
			fcvt.s.w fa4, t4 #term: convert into to float
			fcvt.s.w fa7, t3 #set a floating point to -1
			addi a4, zero,1 #set counter to 1
			addi a5, zero, 3 #set to 3
			jal, zero, BODY
		
	beq a2, t4, FINISH #if nterms = 1 then finish
	
	BODY:
		blt a4, a2, LOOP #n= (starts at 1) < a3 = upper_bound=(nterm *2)
		#else
		jal zero, FINISH  #Clean the stack and go back to caller
			
		LOOP:
			fmul.s fa2,fa2,fa7 #numerator *= -1 ; // alernating +1, -1, +1, -1 ...
			fcvt.s.w  fa5, a5 #float(n)
			fdiv.s fa6,fa4,fa5  #term = numerator / double(n)
			fmul.s fa6, fa2, fa6 #term += numerator
			fadd.s fa3, fa3, fa6 #sum += term ; // +1/1.0 + -1/3.0, + 1/5.0 + -1/7.0 ...
			addi a5, a5, 2 #increment by 2 ie (n += 2)
			addi a4, a4, 1 #increment counter by 1
			jal zero, BODY #jump back to loop
				
	FINISH:
		#done
		fmul.s fa0, fa1, fa3 #pi = 4 * sum ; // 4 * ( 1/1.0 + -1/3.0, + 1/5.0 + -1/7.0 ... )
		jalr zero, ra, 0 #jump back to caller
		
				


		
		

	
	
	
	
