local IslandHandSlot = class("IslandHandSlot", import("model.vo.BaseVO"))

function IslandHandSlot:Ctor(arg_1_1, arg_1_2)
	self.placeId = arg_1_1

	self:UpdateData(arg_1_2)

	return
end

function IslandHandSlot:bindConfigTable()
	return pg.island_production_slot
end

function IslandHandSlot:UpdateData(arg_3_1)
	self.configId = arg_3_1.id
	self.state = arg_3_1.state
	self.formula_id = arg_3_1.formula_id
	self.end_time = arg_3_1.end_time
	self.start_time = arg_3_1.start_time

	return
end

function IslandHandSlot:GetPlantFormulaId()
	if self.state == 0 then
		return false
	end

	return self.formula_id
end

return IslandHandSlot
