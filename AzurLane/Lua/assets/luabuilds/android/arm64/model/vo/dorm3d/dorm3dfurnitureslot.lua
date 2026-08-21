local var_0_0 = class("Dorm3dFurnitureSlot", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_furniture_slot_template
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_0.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_0.GetZoneID(arg_4_0)
	return arg_4_0:getConfig("zone_id")
end

function var_0_0.GetDefaultFurniture(arg_5_0)
	return arg_5_0:getConfig("default_furniture")
end

function var_0_0.GetFurnitureName(arg_6_0)
	return arg_6_0:getConfig("furniture_name")
end

function var_0_0.CanUseFurniture(arg_7_0, arg_7_1)
	if arg_7_1:GetType() ~= arg_7_0:GetType() then
		return false
	end

	local var_7_0 = arg_7_1:GetTargetSlots()

	if #var_7_0 == 0 then
		return true
	end

	return table.contains(var_7_0, arg_7_0:GetConfigID())
end

return var_0_0
