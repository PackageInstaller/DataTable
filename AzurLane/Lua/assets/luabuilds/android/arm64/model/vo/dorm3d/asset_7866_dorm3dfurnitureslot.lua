class = var_0_10000

local var_0_0 = "Dorm3dFurnitureSlot"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_furniture_slot_template
end

function var_0_1.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_1.GetType(arg_3_0)
	return arg_3_0:getConfig("type")
end

function var_0_1.GetZoneID(arg_4_0)
	return arg_4_0:getConfig("zone_id")
end

function var_0_1.GetDefaultFurniture(arg_5_0)
	return arg_5_0:getConfig("default_furniture")
end

function var_0_1.GetFurnitureName(arg_6_0)
	return arg_6_0:getConfig("furniture_name")
end

function var_0_1.CanUseFurniture(arg_7_0, arg_7_1)
	if arg_7_1:GetType() ~= arg_7_0:GetType() then
		return false
	end

	if #arg_7_1:GetTargetSlots() == 0 then
		return true
	end

	table = var_3

	return var_3.contains(var_2, arg_7_0:GetConfigID())
end

return var_0_1
