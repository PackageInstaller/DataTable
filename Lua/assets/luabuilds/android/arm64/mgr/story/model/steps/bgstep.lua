local var_0_0 = class("BgStep", import(".DialogueStep"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.bgSpeed = arg_1_1.bgSpeed
	arg_1_0.blankScreenTime = arg_1_1.blankScreen
	arg_1_0.unscaleDelay = arg_1_1.unscaleDelay or 0
	arg_1_0.subBg = arg_1_1.subBgName

	return
end

function var_0_0.GetMode(arg_2_0)
	return Story.MODE_BG
end

function var_0_0.GetFadeSpeed(arg_3_0)
	return arg_3_0.bgSpeed or 0.5
end

function var_0_0.GetSubBg(arg_4_0)
	return arg_4_0.subBg
end

function var_0_0.GetPainting(arg_5_0)
	return nil
end

function var_0_0.ShouldBlackScreen(arg_6_0)
	return arg_6_0.blankScreenTime
end

function var_0_0.GetUnscaleDelay(arg_7_0)
	return arg_7_0.unscaleDelay
end

return var_0_0
