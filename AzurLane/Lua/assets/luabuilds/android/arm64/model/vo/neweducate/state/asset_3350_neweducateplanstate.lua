class = var_0_10000

local var_0_0 = "NewEducatePlanState"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NewEducateStateBase"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.SetPlans
	local var_1_2

	if not arg_1_1.plans then
		var_1_2 = {}
	end

	var_1_1(var_1_0, var_1_2)

	local var_1_3

	if not arg_1_1.cur_index then
		var_1_3 = 0
	end

	arg_1_0.curIdx = var_1_3

	return
end

function var_0_1.SetPlans(arg_2_0, arg_2_1)
	arg_2_0.plans = {}
	arg_2_0.idxList = {}
	arg_2_0.drops = {}
	arg_2_0.costs = {}
	arg_2_0.curIdx = 0
	ipairs = var_2

	for iter_2_0, iter_2_1 in var_2(arg_2_1) do
		local var_2_0 = arg_2_0.plans

		var_2_0[iter_2_1.key] = iter_2_1.value
		table = var_2_0

		var_2_0.insert(arg_2_0.idxList, iter_2_1.key)
	end

	table = var_2

	var_2.sort(arg_2_0.idxList)

	return
end

function var_0_1.GetIdxList(arg_3_0)
	return arg_3_0.idxList
end

function var_0_1.GetPlans(arg_4_0)
	return arg_4_0.plans
end

function var_0_1.GetCurIdx(arg_5_0)
	return arg_5_0.curIdx
end

function var_0_1.SetNextPlanIdx(arg_6_0)
	if arg_6_0.curIdx == 0 then
		arg_6_0.curIdx = arg_6_0.idxList[1]
	else
		table = var_1

		local var_6_0 = var_1.indexof(arg_6_0.idxList, arg_6_0.curIdx)

		arg_6_0.curIdx = arg_6_0.idxList[var_6_0 + 1]
	end

	return
end

function var_0_1.SetDrops(arg_7_0, arg_7_1)
	arg_7_0.drops = arg_7_1

	return
end

function var_0_1.AddDrops(arg_8_0, arg_8_1)
	table = var_1_10002
	arg_8_0.drops = var_1_10002.mergeArray(arg_8_0.drops, arg_8_1)

	return
end

function var_0_1.GetDrops(arg_9_0)
	return arg_9_0.drops
end

function var_0_1.SetResources(arg_10_0, arg_10_1)
	arg_10_0.resources = arg_10_1

	return
end

function var_0_1.GetResources(arg_11_0)
	return arg_11_0.resources
end

function var_0_1.SetAttrs(arg_12_0, arg_12_1)
	arg_12_0.attrs = arg_12_1

	return
end

function var_0_1.GetAttrs(arg_13_0)
	return arg_13_0.attrs
end

function var_0_1.MarkFinish(arg_14_0)
	arg_14_0.curIdx = arg_14_0.idxList[#arg_14_0.idxList]

	return
end

function var_0_1.IsFinish(arg_15_0)
	if #arg_15_0.idxList == 0 then
		return true
	end

	return arg_15_0.curIdx == arg_15_0.idxList[#arg_15_0.idxList]
end

function var_0_1.Reset(arg_16_0)
	arg_16_0.plans = {}
	arg_16_0.idxList = {}
	arg_16_0.drops = {}
	arg_16_0.resources = {}
	arg_16_0.attrs = {}
	arg_16_0.curIdx = 0

	return
end

return var_0_1
