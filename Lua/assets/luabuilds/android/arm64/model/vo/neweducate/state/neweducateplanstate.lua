local var_0_0 = class("NewEducatePlanState", import(".NewEducateStateBase"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1.plans or {}

	arg_1_0:SetPlans(var_1_0)

	arg_1_0.curIdx = arg_1_1.cur_index or 0

	return
end

function var_0_0.SetPlans(arg_2_0, arg_2_1)
	arg_2_0.plans = {}
	arg_2_0.idxList = {}
	arg_2_0.drops = {}
	arg_2_0.costs = {}
	arg_2_0.curIdx = 0

	for iter_2_0, iter_2_1 in ipairs(arg_2_1) do
		arg_2_0.plans[iter_2_1.key] = iter_2_1.value

		table.insert(arg_2_0.idxList, iter_2_1.key)
	end

	table.sort(arg_2_0.idxList)

	return
end

function var_0_0.GetIdxList(arg_3_0)
	return arg_3_0.idxList
end

function var_0_0.GetPlans(arg_4_0)
	return arg_4_0.plans
end

function var_0_0.GetCurIdx(arg_5_0)
	return arg_5_0.curIdx
end

function var_0_0.SetNextPlanIdx(arg_6_0)
	arg_6_0.curIdx = arg_6_0.curIdx == 0 and arg_6_0.idxList[1] or arg_6_0.idxList[table.indexof(arg_6_0.idxList, arg_6_0.curIdx) + 1]

	return
end

function var_0_0.SetDrops(arg_7_0, arg_7_1)
	arg_7_0.drops = arg_7_1

	return
end

function var_0_0.AddDrops(arg_8_0, arg_8_1)
	arg_8_0.drops = table.mergeArray(arg_8_0.drops, arg_8_1)

	return
end

function var_0_0.GetDrops(arg_9_0)
	return arg_9_0.drops
end

function var_0_0.SetResources(arg_10_0, arg_10_1)
	arg_10_0.resources = arg_10_1

	return
end

function var_0_0.GetResources(arg_11_0)
	return arg_11_0.resources
end

function var_0_0.SetAttrs(arg_12_0, arg_12_1)
	arg_12_0.attrs = arg_12_1

	return
end

function var_0_0.GetAttrs(arg_13_0)
	return arg_13_0.attrs
end

function var_0_0.MarkFinish(arg_14_0)
	arg_14_0.curIdx = arg_14_0.idxList[#arg_14_0.idxList]

	return
end

function var_0_0.IsFinish(arg_15_0)
	if #arg_15_0.idxList == 0 then
		return true
	end

	return arg_15_0.curIdx == arg_15_0.idxList[#arg_15_0.idxList]
end

function var_0_0.Reset(arg_16_0)
	arg_16_0.plans = {}
	arg_16_0.idxList = {}
	arg_16_0.drops = {}
	arg_16_0.resources = {}
	arg_16_0.attrs = {}
	arg_16_0.curIdx = 0

	return
end

return var_0_0
