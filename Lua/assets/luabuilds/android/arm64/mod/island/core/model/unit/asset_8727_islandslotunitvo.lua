local IslandSlotUnitVO = class("IslandSlotUnitVO", import(".IslandUnitVO"))

function IslandSlotUnitVO:Ctor(arg_1_1)
	IslandSlotUnitVO.super.Ctor(self, arg_1_1)

	self.formula_id = arg_1_1.formula_id
	self.slotType = arg_1_1.slotType
	self.slotId = arg_1_1.slotId
	self.isSelfIsland = arg_1_1.isSelfIsland

	return
end

function IslandSlotUnitVO:SetHighLight(arg_2_1)
	self.isHighLight = arg_2_1

	return
end

function IslandSlotUnitVO:GetHighLight(arg_3_1)
	return self.isHighLight
end

return IslandSlotUnitVO
