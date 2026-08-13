class = var_0_10000

local var_0_0 = "Dorm3dZone"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_zone_template
end

function var_0_1.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_1.IsGlobal(arg_3_0)
	return arg_3_0:getConfig("is_global") == 1
end

function var_0_1.GetWatchCameraName(arg_4_0)
	return arg_4_0:getConfig("watch_camera")
end

function var_0_1.GetSlotIDList(arg_5_0)
	pg = var_1_10001

	local var_5_0

	if not var_1_10001.dorm3d_furniture_slot_template.get_id_list_by_zone_id[arg_5_0.configId] then
		var_5_0 = {}
	end

	return var_5_0
end

function var_0_1.SetSlots(arg_6_0, arg_6_1)
	arg_6_0.slots = arg_6_1

	return
end

function var_0_1.GetSlots(arg_7_0)
	local var_7_0

	if not arg_7_0.slots then
		var_7_0 = {}
	end

	return var_7_0
end

function var_0_1.GetTypePriorities(arg_8_0)
	if arg_8_0:getConfig("type_prioritys") == nil or var_1 == "" then
		return {}
	end

	return var_1
end

function var_0_1.SortTypes(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetTypePriorities()

	table = var_1_10003

	local var_9_1 = var_1_10003.sort
	local var_9_2 = arg_9_1

	CompareFuncs = var_1_10006

	var_9_1(var_9_2, var_1_10006({
		function(arg_10_0)
			table = var_2_10001

			local var_10_0

			if not var_2_10001.indexof(var_9_0, arg_10_0) then
				var_10_0 = 99
			end

			return var_10_0
		end,
		function(arg_11_0)
			return -arg_11_0
		end
	}))

	return
end

return var_0_1
