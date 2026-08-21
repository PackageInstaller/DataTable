local var_0_0 = class("Dorm3dIK", import("model.vo.BaseVO"))

var_0_0.TRIGGER = {
	TOUCH_BODY = 2
}
var_0_0.ACTION_TRIGGER = {
	RELEASE = 1,
	TOUCH_TARGET = 3,
	RELEASE_ON_TARGET = 2
}
var_0_0.ACTION = {
	ANIM = 1,
	TIMELINE = 2
}

function var_0_0.bindConfigTable(arg_1_0)
	return pg.dorm3d_ik
end

function var_0_0.GetShipGroupId(arg_2_0)
	return arg_2_0:getConfig("char_id")
end

function var_0_0.GetControllerPath(arg_3_0)
	return arg_3_0:getConfig("controller")
end

function var_0_0.GetTriggerParams(arg_4_0)
	return arg_4_0:getConfig("trigger_param")
end

function var_0_0.IsTrigger(arg_5_0, arg_5_1, arg_5_2)
	if arg_5_0:GetTriggerParams()[1] ~= arg_5_1 then
		return false
	end

	return switch(arg_5_1, {
		[var_0_0.TRIGGER.TOUCH_BODY] = function()
			return arg_5_2 == var_0[2]
		end
	})
end

function var_0_0.GetTriggerBoneName(arg_7_0)
	local var_7_0 = arg_7_0:GetTriggerParams()

	if var_7_0[1] ~= var_0_0.TRIGGER.TOUCH_BODY then
		return
	end

	return var_7_0[2]
end

function var_0_0.GetActionTriggerParams(arg_8_0)
	return arg_8_0:getConfig("action_trigger")
end

function var_0_0.GetSubTargets(arg_9_0)
	local var_9_0 = arg_9_0:getConfig("sub_targets")

	if type(var_9_0) ~= "table" then
		return {}
	end

	return var_9_0
end

function var_0_0.GetRect(arg_10_0)
	return (UnityEngine.Rect.New(unpack((arg_10_0:getConfig("rect")))))
end

function var_0_0.GetTriggerRect(arg_11_0)
	return (UnityEngine.Rect.New(unpack((arg_11_0:getConfig("trigger_rect")))))
end

function var_0_0.GetPlaneRotations(arg_12_0)
	return _.map(arg_12_0:getConfig("plane_rotation"), function(arg_13_0)
		return Quaternion.New(unpack(arg_13_0))
	end)
end

function var_0_0.GetPlaneScales(arg_14_0)
	return _.map(arg_14_0:getConfig("plane_scale"), function(arg_15_0)
		return Vector3.New(unpack(arg_15_0))
	end)
end

function var_0_0.GetRevertTime(arg_16_0)
	return arg_16_0:getConfig("back_time")
end

function var_0_0.GetActionRevertTime(arg_17_0)
	return arg_17_0:getConfig("action_back_time")
end

function var_0_0.GetHeadTrackPath(arg_18_0)
	return arg_18_0:getConfig("head_track")
end

function var_0_0.GetTriggerFaceAnim(arg_19_0)
	return arg_19_0:getConfig("action_emote")
end

function var_0_0.GetIKTipOffset(arg_20_0)
	local var_20_0 = arg_20_0:getConfig("tip_offset")

	if type(var_20_0) ~= "table" then
		return Vector2.zero
	end

	return Vector2.New(unpack(var_20_0))
end

function var_0_0.GetTimelineAction(arg_21_0)
	local var_21_0 = arg_21_0:getConfig("timeline_action")

	if type(var_21_0) ~= "table" then
		return
	end

	local var_21_1 = {
		intParameter = 0,
		floatParameter = 0,
		stringParameter = var_21_0[1]
	}

	switch(var_21_0[1], {
		TimelineIKStart = function(arg_22_0)
			var_21_1.intParameter = arg_22_0

			return
		end,
		TimelineSelect = function(arg_23_0)
			var_21_1.intParameter = arg_23_0

			return
		end,
		TimelinePlayOnTime = function(arg_24_0)
			var_21_1.floatParameter = arg_24_0

			return
		end
	}, nil, unpack(var_21_0, 2))

	return var_21_1
end

return var_0_0
