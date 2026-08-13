class = var_0_10000

local var_0_0 = "Dorm3dIK"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

var_0_1.TRIGGER = {
	TOUCH_BODY = 2
}
var_0_1.ACTION_TRIGGER = {
	RELEASE = 1,
	TOUCH_TARGET = 3,
	RELEASE_ON_TARGET = 2
}
var_0_1.ACTION = {
	ANIM = 1,
	TIMELINE = 2
}

function var_0_1.bindConfigTable(arg_1_0)
	pg = var_1_10001

	return var_1_10001.dorm3d_ik
end

function var_0_1.GetShipGroupId(arg_2_0)
	return arg_2_0:getConfig("char_id")
end

function var_0_1.GetControllerPath(arg_3_0)
	return arg_3_0:getConfig("controller")
end

function var_0_1.GetTriggerParams(arg_4_0)
	return arg_4_0:getConfig("trigger_param")
end

function var_0_1.IsTrigger(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0:GetTriggerParams()[1] ~= arg_5_1 then
		return false
	end

	switch = var_4

	return var_4(arg_5_1, {
		[var_0_1.TRIGGER.TOUCH_BODY] = function()
			return arg_5_2 == var_0[2]
		end
	})
end

function var_0_1.GetTriggerBoneName(arg_7_0)
	if arg_7_0:GetTriggerParams()[1] ~= var_0_1.TRIGGER.TOUCH_BODY then
		return
	end

	return var_1[2]
end

function var_0_1.GetActionTriggerParams(arg_8_0)
	return arg_8_0:getConfig("action_trigger")
end

function var_0_1.GetSubTargets(arg_9_0)
	local var_9_0 = arg_9_0
	local var_9_1 = arg_9_0.getConfig(var_9_0, "sub_targets")

	type = var_9_0

	if var_9_0(var_9_1) ~= "table" then
		return {}
	end

	return var_9_1
end

function var_0_1.GetRect(arg_10_0)
	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.getConfig(var_10_0, "rect")

	UnityEngine = var_10_0

	local var_10_2 = var_10_0.Rect.New

	unpack = var_3

	return (var_10_2(var_3(var_10_1)))
end

function var_0_1.GetTriggerRect(arg_11_0)
	local var_11_0 = arg_11_0
	local var_11_1 = arg_11_0.getConfig(var_11_0, "trigger_rect")

	UnityEngine = var_11_0

	local var_11_2 = var_11_0.Rect.New

	unpack = var_3

	return (var_11_2(var_3(var_11_1)))
end

function var_0_1.GetPlaneRotations(arg_12_0)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.getConfig(var_12_0, "plane_rotation")

	_ = var_12_0

	return var_12_0.map(var_12_1, function(arg_13_0)
		Quaternion = var_2_10001

		local var_13_0 = var_2_10001.New

		unpack = var_2_10002

		return var_13_0(var_2_10002(arg_13_0))
	end)
end

function var_0_1.GetPlaneScales(arg_14_0)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.getConfig(var_14_0, "plane_scale")

	_ = var_14_0

	return var_14_0.map(var_14_1, function(arg_15_0)
		Vector3 = var_2_10001

		local var_15_0 = var_2_10001.New

		unpack = var_2_10002

		return var_15_0(var_2_10002(arg_15_0))
	end)
end

function var_0_1.GetRevertTime(arg_16_0)
	return arg_16_0:getConfig("back_time")
end

function var_0_1.GetActionRevertTime(arg_17_0)
	return arg_17_0:getConfig("action_back_time")
end

function var_0_1.GetHeadTrackPath(arg_18_0)
	return arg_18_0:getConfig("head_track")
end

function var_0_1.GetTriggerFaceAnim(arg_19_0)
	return arg_19_0:getConfig("action_emote")
end

function var_0_1.GetIKTipOffset(arg_20_0)
	local var_20_0 = arg_20_0
	local var_20_1 = arg_20_0.getConfig(var_20_0, "tip_offset")

	type = var_20_0

	if var_20_0(var_20_1) ~= "table" then
		Vector2 = var_2

		return var_2.zero
	end

	Vector2 = var_2

	local var_20_2 = var_2.New

	unpack = var_3

	return var_20_2(var_3(var_20_1))
end

function var_0_1.GetTimelineAction(arg_21_0)
	local var_21_0 = arg_21_0
	local var_21_1 = arg_21_0.getConfig(var_21_0, "timeline_action")

	type = var_21_0

	if var_21_0(var_21_1) ~= "table" then
		return
	end

	local var_21_2 = {
		intParameter = 0,
		floatParameter = 0,
		stringParameter = var_21_1[1]
	}

	switch = var_3

	local var_21_3 = var_21_1[1]
	local var_21_4 = {
		TimelineIKStart = function(arg_22_0)
			var_21_2.intParameter = arg_22_0

			return
		end,
		TimelineSelect = function(arg_23_0)
			var_21_2.intParameter = arg_23_0

			return
		end,
		TimelinePlayOnTime = function(arg_24_0)
			var_21_2.floatParameter = arg_24_0

			return
		end
	}
	local var_21_5

	unpack = var_1_10007

	var_3(var_21_3, var_21_4, var_21_5, var_1_10007(var_21_1, 2))

	return var_21_2
end

return var_0_1
