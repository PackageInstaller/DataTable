class = var_0_10000

local var_0_0 = "BgStep"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".DialogueStep"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.bgSpeed = arg_1_1.bgSpeed
	arg_1_0.blankScreenTime = arg_1_1.blankScreen

	local var_1_0

	if not arg_1_1.unscaleDelay then
		var_1_0 = 0
	end

	arg_1_0.unscaleDelay = var_1_0
	arg_1_0.subBg = arg_1_1.subBgName

	return
end

function var_0_1.GetMode(arg_2_0)
	Story = var_1_10001

	return var_1_10001.MODE_BG
end

function var_0_1.GetFadeSpeed(arg_3_0)
	local var_3_0

	if not arg_3_0.bgSpeed then
		var_3_0 = 0.5
	end

	return var_3_0
end

function var_0_1.GetSubBg(arg_4_0)
	return arg_4_0.subBg
end

function var_0_1.GetPainting(arg_5_0)
	return nil
end

function var_0_1.ShouldBlackScreen(arg_6_0)
	return arg_6_0.blankScreenTime
end

function var_0_1.GetUnscaleDelay(arg_7_0)
	return arg_7_0.unscaleDelay
end

return var_0_1
