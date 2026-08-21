local var_0_0 = class("Dorm3dZone", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_zone_template
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0:getConfig("name")
end

function var_0_0.IsGlobal(arg_3_0)
	return arg_3_0:getConfig("is_global") == 1
end

function var_0_0.GetWatchCameraName(arg_4_0)
	return arg_4_0:getConfig("watch_camera")
end

function var_0_0.GetSlotIDList(arg_5_0)
	return pg.dorm3d_furniture_slot_template.get_id_list_by_zone_id[arg_5_0.configId] or {}
end

function var_0_0.SetSlots(arg_6_0, arg_6_1)
	arg_6_0.slots = arg_6_1

	return
end

function var_0_0.GetSlots(arg_7_0)
	return arg_7_0.slots or {}
end

function var_0_0.GetTypePriorities(arg_8_0)
	local var_8_0 = arg_8_0:getConfig("type_prioritys")

	if var_8_0 == nil or var_8_0 == "" then
		return {}
	end

	return var_8_0
end

function var_0_0.SortTypes(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_0:GetTypePriorities()

	table.sort(arg_9_1, CompareFuncs({
		function(arg_10_0)
			return table.indexof(var_9_0, arg_10_0) or 99
		end,
		function(arg_11_0)
			return -arg_11_0
		end
	}))

	return
end

return var_0_0
