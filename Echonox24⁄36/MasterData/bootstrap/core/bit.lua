module("bootstrap.core.bit", package.seeall)

bit.data32 = {}

for iter_0_0 = 1, 32 do
	bit.data32[iter_0_0] = 2^(32 - iter_0_0)
end

function bit._b2d(arg_1_0)
	local var_1_0 = 0

	for iter_1_0 = 1, 32 do
		if arg_1_0[iter_1_0] == 1 then
			var_1_0 = var_1_0 + bit.data32[iter_1_0]
		end
	end

	return var_1_0
end

function bit._d2b(arg_2_0)
	arg_2_0 = arg_2_0 >= 0 and arg_2_0 or 4294967295 + arg_2_0 + 1

	local var_2_0 = {}

	for iter_2_0 = 1, 32 do
		if arg_2_0 >= bit.data32[iter_2_0] then
			var_2_0[iter_2_0] = 1
			arg_2_0 = arg_2_0 - bit.data32[iter_2_0]
		else
			var_2_0[iter_2_0] = 0
		end
	end

	return var_2_0
end

function bit._and(arg_3_0, arg_3_1)
	local var_3_0 = bit._d2b(arg_3_0)
	local var_3_1 = bit._d2b(arg_3_1)
	local var_3_2 = {}

	for iter_3_0 = 1, 32 do
		if var_3_0[iter_3_0] == 1 and var_3_1[iter_3_0] == 1 then
			var_3_2[iter_3_0] = 1
		else
			var_3_2[iter_3_0] = 0
		end
	end

	return bit._b2d(var_3_2)
end

function bit._rshift(arg_4_0, arg_4_1)
	local var_4_0 = bit._d2b(arg_4_0)

	arg_4_1 = arg_4_1 <= 32 and arg_4_1 or 32
	arg_4_1 = arg_4_1 >= 0 and arg_4_1 or 0

	for iter_4_0 = 32, arg_4_1 + 1, -1 do
		var_4_0[iter_4_0] = var_4_0[iter_4_0 - arg_4_1]
	end

	for iter_4_1 = 1, arg_4_1 do
		var_4_0[iter_4_1] = 0
	end

	return bit._b2d(var_4_0)
end

function bit._not(arg_5_0)
	local var_5_0 = bit._d2b(arg_5_0)
	local var_5_1 = {}

	for iter_5_0 = 1, 32 do
		if var_5_0[iter_5_0] == 1 then
			var_5_1[iter_5_0] = 0
		else
			var_5_1[iter_5_0] = 1
		end
	end

	return bit._b2d(var_5_1)
end

function bit._or(arg_6_0, arg_6_1)
	local var_6_0 = bit._d2b(arg_6_0)
	local var_6_1 = bit._d2b(arg_6_1)
	local var_6_2 = {}

	for iter_6_0 = 1, 32 do
		if var_6_0[iter_6_0] == 1 or var_6_1[iter_6_0] == 1 then
			var_6_2[iter_6_0] = 1
		else
			var_6_2[iter_6_0] = 0
		end
	end

	return bit._b2d(var_6_2)
end

bit.band = bit._and
bit.rshift = bit._rshift
bit.bnot = bit._not
bit.bor = bit._or
