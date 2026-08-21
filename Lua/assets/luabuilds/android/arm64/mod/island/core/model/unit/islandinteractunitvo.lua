local var_0_0 = class("IslandInteractUnitVO", import(".IslandUnitVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.config = pg.island_unit_interactive_item[arg_1_0.modelId]
	arg_1_0.slots = {}

	for iter_1_0 = 1, arg_1_0.config.slot_cnt do
		table.insert(arg_1_0.slots, InteractSlot.New(iter_1_0, arg_1_0.id))
	end

	arg_1_0:InitTimlineInfo()

	return
end

function var_0_0.InitTimlineInfo(arg_2_0)
	arg_2_0.timelineInfo = {}

	if arg_2_0.config.timeline == nil or arg_2_0.config.timeline == "" then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.config.timeline) do
		table.insert(arg_2_0.timelineInfo, pg.island_item_timeline[iter_2_1])
	end

	return
end

function var_0_0.GetEmptySlot(arg_3_0)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.slots) do
		if iter_3_1:IsEmpty() then
			return iter_3_1
		end
	end

	return nil
end

function var_0_0.GetSlotById(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.slots) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function var_0_0.GetUsingSlot(arg_5_0, arg_5_1)
	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(arg_5_0.slots) do
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

function var_0_0.AnySlotUsing(arg_6_0)
	for iter_6_0, iter_6_1 in ipairs(arg_6_0.slots) do
		if not iter_6_1:IsEmpty() then
			return true
		end
	end

	return false
end

function var_0_0.GetTimeline(arg_7_0)
	return arg_7_0.timelineInfo
end

function var_0_0.HasTimeline(arg_8_0)
	return #arg_8_0.timelineInfo > 0
end

function var_0_0.GetSlot(arg_9_0)
	return arg_9_0.config.slotCnt
end

function var_0_0.GetBlackboardParam(arg_10_0)
	return arg_10_0.config.param
end

return var_0_0
