class = var_0_10000

local var_0_0 = "SpAnimStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.name = arg_1_1.name
	defaultValue = var_2
	arg_1_0.actionName = var_2(arg_1_1.actionName, "normal")
	defaultValue = var_2
	arg_1_0.speed = var_2(arg_1_1.speed, 1)
	defaultValue = var_2
	arg_1_0.hideSkip = var_2(arg_1_1.hideSkip, false)
	defaultValue = var_2
	arg_1_0.stopTime = var_2(arg_1_1.stopTime, 0)

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_SPANIM
end

function var_0_1.GetSpineName(arg_3_0)
	return arg_3_0.name
end

function var_0_1.GetActionName(arg_4_0)
	return arg_4_0.actionName
end

function var_0_1.ShouldAdjustSpeed(arg_5_0)
	return arg_5_0:GetSpeed() ~= 1
end

function var_0_1.GetSpeed(arg_6_0)
	return arg_6_0.speed
end

function var_0_1.ShouldHideSkipBtn(arg_7_0)
	return arg_7_0.hideSkip
end

function var_0_1.HasStopTime(arg_8_0)
	return arg_8_0:GetStopTime() ~= 0
end

function var_0_1.GetStopTime(arg_9_0)
	return arg_9_0.stopTime
end

return var_0_1
