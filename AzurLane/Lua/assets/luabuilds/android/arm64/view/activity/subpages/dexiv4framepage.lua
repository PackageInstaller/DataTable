class = var_0_10000

local var_0_0 = "DexiV4FramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.FrameTemplatePage"))

function var_0_1.Switch(arg_1_0, arg_1_1)
	arg_1_0.isSwitching = true
	GetOrAddComponent = var_2

	local var_1_0 = arg_1_0.phases[1]

	typeof = var_1_10005
	CanvasGroup = var_1_10007

	local var_1_1 = var_2(var_1_0, var_1_10005(var_1_10007))
	local var_1_2 = arg_1_0.phases[1].localPosition
	local var_1_3 = arg_1_0.phases[2].localPosition
	local var_1_4 = arg_1_0.phases[2]

	var_5.SetAsLastSibling(var_1_4)

	setActive = var_5

	local var_1_5 = arg_1_0.phases[1]

	var_5(var_7.Find(var_1_5, "Image"), false)

	setLocalPosition = var_5
	go = var_7

	var_5(var_7(arg_1_0.phases[1]), var_1_3)

	setActive = var_5

	local var_1_6 = arg_1_0.phases[1]

	var_5(var_7.Find(var_1_6, "label"), true)

	LeanTween = var_5

	local var_1_7 = var_5.value

	go = var_7

	local var_1_8 = var_1_7(var_7(arg_1_0.phases[1]), 0, 1, 0.4)
	local var_1_9 = var_5.setOnUpdate

	System = var_8

	var_1_9(var_1_8, var_8.Action_float(function(arg_2_0)
		var_1_1.alpha = arg_2_0

		return
	end))

	setActive = var_1_9

	local var_1_10 = arg_1_0.phases[2]

	var_1_9(var_7.Find(var_1_10, "Image"), true)

	GetOrAddComponent = var_1_9

	local var_1_11 = arg_1_0.phases[2]

	typeof = var_8
	CanvasGroup = var_10

	local var_1_12 = var_1_9(var_1_11, var_8(var_10))

	LeanTween = var_1_10006

	local var_1_13 = var_1_10006.value

	go = var_8

	local var_1_14 = var_1_13(var_8(arg_1_0.phases[2]), 0, 1, 0.4)
	local var_1_15 = var_6.setOnUpdate

	System = var_9

	var_1_15(var_1_14, var_9.Action_float(function(arg_3_0)
		var_1_12.alpha = arg_3_0

		return
	end))

	setActive = var_1_15

	local var_1_16 = arg_1_0.phases[2]

	var_1_15(var_8.Find(var_1_16, "label"), false)

	setLocalPosition = var_1_15
	go = var_8

	var_1_15(var_8(arg_1_0.phases[2]), var_1_2)

	arg_1_0.isSwitching = nil
	arg_1_0.phases[1], arg_1_0.phases[2] = arg_1_0.phases[2], arg_1_0.phases[1]

	arg_1_0:UpdateAwardGot()

	return
end

return var_0_1
