local var_0_0 = class("Dorm3dCameraAnim", import("model.vo.BaseVO"))

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_camera_anim_template
end

function var_0_0.GetName(arg_2_0)
	return arg_2_0:getConfig("desc")
end

function var_0_0.GetStateName(arg_3_0)
	return arg_3_0:getConfig("state")
end

function var_0_0.GetAnimTime(arg_4_0)
	return arg_4_0:getConfig("anim_time")
end

function var_0_0.GetPreAnimID(arg_5_0)
	return arg_5_0:getConfig("pre_anim")
end

function var_0_0.GetFinishAnimID(arg_6_0)
	return arg_6_0:getConfig("finish_anim")
end

function var_0_0.GetUnlockRequirment(arg_7_0)
	return arg_7_0:getConfig("unlock")
end

function var_0_0.GetFurnitureID(arg_8_0)
	return arg_8_0:getConfig("furniture_id")
end

function var_0_0.GetZoneName(arg_9_0)
	return pg.dorm3d_camera_zone_template[tonumber(arg_9_0:getConfig("zone"))].name
end

function var_0_0.GetZoneIcon(arg_10_0)
	return arg_10_0:getConfig("icon")
end

function var_0_0.GetStartPoint(arg_11_0)
	return arg_11_0:getConfig("staypoint")
end

function var_0_0.GetEnterSceneAnim(arg_12_0)
	local var_12_0 = arg_12_0:getConfig("enter_scene_anim")

	if var_12_0 and var_12_0 ~= "" and #var_12_0 > 0 then
		return var_12_0
	else
		return {}
	end

	return
end

function var_0_0.GetEnterExtraItem(arg_13_0)
	local var_13_0 = arg_13_0:getConfig("enter_extra_item")

	if var_13_0 and var_13_0 ~= "" and #var_13_0 > 0 then
		return var_13_0
	else
		return {}
	end

	return
end

function var_0_0.GetHideSceneItem(arg_14_0)
	local var_14_0 = arg_14_0:getConfig("hide_scene_item")

	if var_14_0 and var_14_0 ~= "" and #var_14_0 > 0 then
		return var_14_0
	else
		return {}
	end

	return
end

return var_0_0
