class = var_0_10000

local var_0_0 = var_0_10000("CrossRoadGameQue")

function var_0_0.Ctor(arg_1_0)
	arg_1_0.hh = 0
	arg_1_0.tt = -1
	arg_1_0._q = {}
	arg_1_0._map = {}

	return
end

function var_0_0.push(arg_2_0, arg_2_1)
	if arg_2_1 == nil then
		return
	end

	if arg_2_0._map[arg_2_1] == nil then
		arg_2_0.tt = arg_2_0.tt + 1
		arg_2_0._q[arg_2_0.tt] = arg_2_1
		arg_2_0._map[arg_2_1] = true
	end

	return
end

function var_0_0.head(arg_3_0)
	if arg_3_0:empty() then
		return nil
	end

	return arg_3_0._q[arg_3_0.hh]
end

function var_0_0.pop(arg_4_0)
	if arg_4_0:empty() then
		return nil
	end

	local var_4_0 = arg_4_0._q[arg_4_0.hh]

	arg_4_0._q[arg_4_0.hh] = nil
	arg_4_0.hh = arg_4_0.hh + 1
	arg_4_0._map[var_4_0] = nil

	return var_4_0
end

function var_0_0.empty(arg_5_0)
	return arg_5_0.hh > arg_5_0.tt
end

function var_0_0.queryHasVal(arg_6_0, arg_6_1)
	return arg_6_0._map[arg_6_1]
end

function var_0_0.clear(arg_7_0)
	local var_7_0 = arg_7_0.hh
	local var_7_1 = arg_7_0.tt

	for iter_7_0 = var_7_0, var_7_1 do
		arg_7_0._q[iter_7_0] = nil
	end

	arg_7_0.hh = 0
	arg_7_0.tt = -1
	arg_7_0._map = {}

	return
end

function var_0_0.size(arg_8_0)
	return arg_8_0.tt - arg_8_0.hh + 1
end

return var_0_0
