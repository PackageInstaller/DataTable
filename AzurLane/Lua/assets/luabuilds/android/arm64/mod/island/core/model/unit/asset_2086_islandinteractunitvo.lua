class = var_0_10000

local var_0_0 = "IslandInteractUnitVO"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandUnitVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	pg = var_2
	arg_1_0.config = var_2.island_unit_interactive_item[arg_1_0.modelId]
	arg_1_0.slots = {}

	for iter_1_0 = 1, arg_1_0.config.slot_cnt do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_1_0 = arg_1_0.slots

		InteractSlot = var_1_10009

		var_1_10006(var_1_0, var_1_10009.New(iter_1_0, arg_1_0.id))
	end

	arg_1_0:InitTimlineInfo()

	return
end

function var_0_1.InitTimlineInfo(arg_2_0)
	arg_2_0.timelineInfo = {}

	if arg_2_0.config.timeline == nil or arg_2_0.config.timeline == "" then
		return
	end

	ipairs = var_1

	for iter_2_0, iter_2_1 in var_1(arg_2_0.config.timeline) do
		table = var_1_10006
		var_1_10006 = var_1_10006.insert

		local var_2_0 = arg_2_0.timelineInfo

		pg = var_1_10009

		var_1_10006(var_2_0, var_1_10009.island_item_timeline[iter_2_1])
	end

	return
end

function var_0_1.GetEmptySlot(arg_3_0)
	ipairs = var_1_10001

	for iter_3_0, iter_3_1 in var_1_10001(arg_3_0.slots) do
		if iter_3_1:IsEmpty() then
			return iter_3_1
		end
	end

	return nil
end

function var_0_1.GetSlotById(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.slots) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_1.GetUsingSlot(arg_5_0, arg_5_1)
	if arg_5_1 then
		ipairs = var_1_10002

		for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.slots) do
			if not iter_5_1:IsEmpty() and iter_5_1:IsUsing(arg_5_1) then
				return iter_5_1
			end
		end

		return nil
	else
		return arg_5_0.slots[1]
	end

	return
end

function var_0_1.AnySlotUsing(arg_6_0)
	ipairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0.slots) do
		if not iter_6_1:IsEmpty() then
			return true
		end
	end

	return false
end

function var_0_1.GetTimeline(arg_7_0)
	return arg_7_0.timelineInfo
end

function var_0_1.HasTimeline(arg_8_0)
	return #arg_8_0.timelineInfo > 0
end

function var_0_1.GetSlot(arg_9_0)
	return arg_9_0.config.slotCnt
end

function var_0_1.GetBlackboardParam(arg_10_0)
	return arg_10_0.config.param
end

return var_0_1
