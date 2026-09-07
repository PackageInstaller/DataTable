local Dorm3dFurnitureSlot = class("Dorm3dFurnitureSlot", import("model.vo.BaseVO"))

function Dorm3dFurnitureSlot:bindConfigTable()
	return pg.dorm3d_furniture_slot_template
end

function Dorm3dFurnitureSlot:GetName()
	return self:getConfig("name")
end

function Dorm3dFurnitureSlot:GetType()
	return self:getConfig("type")
end

function Dorm3dFurnitureSlot:GetZoneID()
	return self:getConfig("zone_id")
end

function Dorm3dFurnitureSlot:GetDefaultFurniture()
	return self:getConfig("default_furniture")
end

function Dorm3dFurnitureSlot:GetFurnitureName()
	return self:getConfig("furniture_name")
end

function Dorm3dFurnitureSlot:CanUseFurniture(arg_7_1)
	if arg_7_1:GetType() ~= self:GetType() then
		return false
	end

	local var_7_0 = arg_7_1:GetTargetSlots()

	if #var_7_0 == 0 then
		return true
	end

	return table.contains(var_7_0, self:GetConfigID())
end

return Dorm3dFurnitureSlot
