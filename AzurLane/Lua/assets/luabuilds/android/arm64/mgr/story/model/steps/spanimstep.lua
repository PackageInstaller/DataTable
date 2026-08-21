local var_0_0 = class("SpAnimStep", import(".StoryStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.name = arg_1_1.name
	arg_1_0.actionName = defaultValue(arg_1_1.actionName, "normal")
	arg_1_0.speed = defaultValue(arg_1_1.speed, 1)
	arg_1_0.hideSkip = defaultValue(arg_1_1.hideSkip, false)
	arg_1_0.stopTime = defaultValue(arg_1_1.stopTime, 0)

	return
end

function var_0_0.GetMode(arg_2_0)
	return Story.MODE_SPANIM
end

function var_0_0.GetSpineName(arg_3_0)
	return arg_3_0.name
end

function var_0_0.GetActionName(arg_4_0)
	return arg_4_0.actionName
end

function var_0_0.ShouldAdjustSpeed(arg_5_0)
	return arg_5_0:GetSpeed() ~= 1
end

function var_0_0.GetSpeed(arg_6_0)
	return arg_6_0.speed
end

function var_0_0.ShouldHideSkipBtn(arg_7_0)
	return arg_7_0.hideSkip
end

function var_0_0.HasStopTime(arg_8_0)
	return arg_8_0:GetStopTime() ~= 0
end

function var_0_0.GetStopTime(arg_9_0)
	return arg_9_0.stopTime
end

return var_0_0
