local IslandInteractUnitVO = class("IslandInteractUnitVO", import(".IslandUnitVO"))

function IslandInteractUnitVO:Ctor(arg_1_1)
	IslandInteractUnitVO.super.Ctor(self, arg_1_1)

	self.config = pg.island_unit_interactive_item[self.modelId]
	self.slots = {}

	for iter_1_0 = 1, self.config.slot_cnt do
		table.insert(self.slots, InteractSlot.New(iter_1_0, self.id))
	end

	self:InitTimlineInfo()

	return
end

function IslandInteractUnitVO:InitTimlineInfo()
	self.timelineInfo = {}

	if self.config.timeline == nil or self.config.timeline == "" then
		return
	end

	for iter_2_0, iter_2_1 in ipairs(self.config.timeline) do
		table.insert(self.timelineInfo, pg.island_item_timeline[iter_2_1])
	end

	return
end

function IslandInteractUnitVO:GetEmptySlot()
	for iter_3_0, iter_3_1 in ipairs(self.slots) do
		if iter_3_1:IsEmpty() then
			return iter_3_1
		end
	end

	return nil
end

function IslandInteractUnitVO:GetSlotById(arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(self.slots) do
		if iter_4_1.id == arg_4_1 then
			return iter_4_1
		end
	end

	return nil
end

function IslandInteractUnitVO:GetUsingSlot(arg_5_1)
	if arg_5_1 then
		for iter_5_0, iter_5_1 in ipairs(self.slots) do
			if not iter_5_1:IsEmpty() and iter_5_1:IsUsing(arg_5_1) then
				return iter_5_1
			end
		end

		return nil
	else
		return self.slots[1]
	end

	return
end

function IslandInteractUnitVO:AnySlotUsing()
	for iter_6_0, iter_6_1 in ipairs(self.slots) do
		if not iter_6_1:IsEmpty() then
			return true
		end
	end

	return false
end

function IslandInteractUnitVO:GetTimeline()
	return self.timelineInfo
end

function IslandInteractUnitVO:HasTimeline()
	return #self.timelineInfo > 0
end

function IslandInteractUnitVO:GetSlot()
	return self.config.slotCnt
end

function IslandInteractUnitVO:GetBlackboardParam()
	return self.config.param
end

return IslandInteractUnitVO
