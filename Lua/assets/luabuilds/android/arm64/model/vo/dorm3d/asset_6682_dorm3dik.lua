local Dorm3dIK = class("Dorm3dIK", import("model.vo.BaseVO"))

Dorm3dIK.TRIGGER = {
	TOUCH_BODY = 2
}
Dorm3dIK.ACTION_TRIGGER = {
	RELEASE = 1,
	TOUCH_TARGET = 3,
	RELEASE_ON_TARGET = 2
}
Dorm3dIK.ACTION = {
	ANIM = 1,
	TIMELINE = 2
}

function Dorm3dIK:bindConfigTable()
	return pg.dorm3d_ik
end

function Dorm3dIK:GetShipGroupId()
	return self:getConfig("char_id")
end

function Dorm3dIK:GetControllerPath()
	return self:getConfig("controller")
end

function Dorm3dIK:GetTriggerParams()
	return self:getConfig("trigger_param")
end

function Dorm3dIK:IsTrigger(arg_5_1, arg_5_2)
	local var_5_0 = self:GetTriggerParams()

	if var_5_0[1] ~= arg_5_1 then
		return false
	end

	return switch(arg_5_1, {
		[Dorm3dIK.TRIGGER.TOUCH_BODY] = function()
			return arg_5_2 == var_5_0[2]
		end
	})
end

function Dorm3dIK:GetTriggerBoneName()
	local var_7_0 = self:GetTriggerParams()

	if var_7_0[1] ~= Dorm3dIK.TRIGGER.TOUCH_BODY then
		return
	end

	return var_7_0[2]
end

function Dorm3dIK:GetActionTriggerParams()
	return self:getConfig("action_trigger")
end

function Dorm3dIK:GetSubTargets()
	local var_9_0 = self:getConfig("sub_targets")

	if type(var_9_0) ~= "table" then
		return {}
	end

	return var_9_0
end

function Dorm3dIK:GetRect()
	return (UnityEngine.Rect.New(unpack((self:getConfig("rect")))))
end

function Dorm3dIK:GetTriggerRect()
	return (UnityEngine.Rect.New(unpack((self:getConfig("trigger_rect")))))
end

function Dorm3dIK:GetPlaneRotations()
	return _.map(self:getConfig("plane_rotation"), function(arg_13_0)
		return Quaternion.New(unpack(arg_13_0))
	end)
end

function Dorm3dIK:GetPlaneScales()
	return _.map(self:getConfig("plane_scale"), function(arg_15_0)
		return Vector3.New(unpack(arg_15_0))
	end)
end

function Dorm3dIK:GetRevertTime()
	return self:getConfig("back_time")
end

function Dorm3dIK:GetActionRevertTime()
	return self:getConfig("action_back_time")
end

function Dorm3dIK:GetHeadTrackPath()
	return self:getConfig("head_track")
end

function Dorm3dIK:GetTriggerFaceAnim()
	return self:getConfig("action_emote")
end

function Dorm3dIK:GetIKTipOffset()
	local var_20_0 = self:getConfig("tip_offset")

	if type(var_20_0) ~= "table" then
		return Vector2.zero
	end

	return Vector2.New(unpack(var_20_0))
end

function Dorm3dIK:GetTimelineAction()
	local var_21_0 = self:getConfig("timeline_action")

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

return Dorm3dIK
