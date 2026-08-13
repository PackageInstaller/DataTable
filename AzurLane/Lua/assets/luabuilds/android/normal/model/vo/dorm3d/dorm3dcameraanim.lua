class = var_0_10000

local var_0_0 = "Dorm3dCameraAnim"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_camera_anim_template
end

function var_0_1.GetName(arg_2_0)
	return arg_2_0:getConfig("desc")
end

function var_0_1.GetStateName(arg_3_0)
	return arg_3_0:getConfig("state")
end

function var_0_1.GetAnimTime(arg_4_0)
	return arg_4_0:getConfig("anim_time")
end

function var_0_1.GetPreAnimID(arg_5_0)
	return arg_5_0:getConfig("pre_anim")
end

function var_0_1.GetFinishAnimID(arg_6_0)
	return arg_6_0:getConfig("finish_anim")
end

function var_0_1.GetUnlockRequirment(arg_7_0)
	return arg_7_0:getConfig("unlock")
end

function var_0_1.GetFurnitureID(arg_8_0)
	return arg_8_0:getConfig("furniture_id")
end

function var_0_1.GetZoneName(arg_9_0)
	tonumber = var_1_10001

	local var_9_0 = var_1_10001(arg_9_0:getConfig("zone"))

	pg = var_2

	return var_2.dorm3d_camera_zone_template[var_9_0].name
end

function var_0_1.GetZoneIcon(arg_10_0)
	return arg_10_0:getConfig("icon")
end

function var_0_1.GetStartPoint(arg_11_0)
	return arg_11_0:getConfig("staypoint")
end

function var_0_1.GetEnterSceneAnim(arg_12_0)
	if arg_12_0:getConfig("enter_scene_anim") and var_1 ~= "" and #var_1 > 0 then
		return var_1
	else
		return {}
	end

	return
end

function var_0_1.GetEnterExtraItem(arg_13_0)
	if arg_13_0:getConfig("enter_extra_item") and var_1 ~= "" and #var_1 > 0 then
		return var_1
	else
		return {}
	end

	return
end

function var_0_1.GetHideSceneItem(arg_14_0)
	if arg_14_0:getConfig("hide_scene_item") and var_1 ~= "" and #var_1 > 0 then
		return var_1
	else
		return {}
	end

	return
end

return var_0_1
