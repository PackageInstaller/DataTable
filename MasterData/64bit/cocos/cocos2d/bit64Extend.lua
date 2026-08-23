bit64 = bit64 or {}
bit64.data64 = {}

for iter_0_0 = 1, 64 do
	bit64.data64[iter_0_0] = 2^(64 - iter_0_0)
end

function bit64:_b2d()
	local var_1_0 = 0

	for iter_1_0 = 1, 64 do
		if self[iter_1_0] == 1 then
			var_1_0 = var_1_0 + bit64.data64[iter_1_0]
		end
	end

	return var_1_0
end

function bit64._d2b(arg_2_0)
	arg_2_0 = arg_2_0 >= 0 and arg_2_0 or 4294967295 + arg_2_0 + 1

	local var_2_0 = {}

	for iter_2_0 = 1, 64 do
		if arg_2_0 >= bit64.data64[iter_2_0] then
			var_2_0[iter_2_0] = 1
			arg_2_0 = arg_2_0 - bit64.data64[iter_2_0]
		else
			var_2_0[iter_2_0] = 0
		end
	end

	return var_2_0
end

function bit64._and(arg_3_0, arg_3_1)
	local var_3_0 = bit64._d2b(arg_3_0)
	local var_3_1 = bit64._d2b(arg_3_1)
	local var_3_2 = {}

	for iter_3_0 = 1, 64 do
		var_3_2[iter_3_0] = var_3_0[iter_3_0] == 1 and var_3_1[iter_3_0] == 1 and 1 or 0
	end

	return bit64._b2d(var_3_2)
end

function bit64._rshift(arg_4_0, arg_4_1)
	local var_4_0 = bit64._d2b(arg_4_0)

	arg_4_1 = arg_4_1 <= 64 and arg_4_1 or 64
	arg_4_1 = arg_4_1 >= 0 and arg_4_1 or 0

	for iter_4_0 = 64, arg_4_1 + 1, -1 do
		var_4_0[iter_4_0] = var_4_0[iter_4_0 - arg_4_1]
	end

	for iter_4_1 = 1, arg_4_1 do
		var_4_0[iter_4_1] = 0
	end

	return bit64._b2d(var_4_0)
end

function bit64._lshift(arg_5_0, arg_5_1)
	local var_5_0 = bit64._d2b(arg_5_0)

	arg_5_1 = arg_5_1 <= 64 and arg_5_1 or 64
	arg_5_1 = arg_5_1 >= 0 and arg_5_1 or 0

	for iter_5_0 = 1, 64 - arg_5_1 do
		var_5_0[iter_5_0] = var_5_0[iter_5_0 + arg_5_1]
	end

	for iter_5_1 = 64, 64 - arg_5_1 + 1, -1 do
		var_5_0[iter_5_1] = 0
	end

	return bit64._b2d(var_5_0)
end

function bit64._not(arg_6_0)
	local var_6_0 = bit64._d2b(arg_6_0)
	local var_6_1 = {}

	for iter_6_0 = 1, 64 do
		var_6_1[iter_6_0] = var_6_0[iter_6_0] == 1 and 0 or 1
	end

	return bit64._b2d(var_6_1)
end

function bit64._or(arg_7_0, arg_7_1)
	local var_7_0 = bit64._d2b(arg_7_0)
	local var_7_1 = bit64._d2b(arg_7_1)
	local var_7_2 = {}

	for iter_7_0 = 1, 64 do
		var_7_2[iter_7_0] = (var_7_0[iter_7_0] == 1 or var_7_1[iter_7_0] == 1) and 1 or 0
	end

	return bit64._b2d(var_7_2)
end

bit64.band = bit64.band or bit64._and
bit64.rshift = bit64.rshift or bit64._rshift
bit64.bnot = bit64.bnot or bit64._not
