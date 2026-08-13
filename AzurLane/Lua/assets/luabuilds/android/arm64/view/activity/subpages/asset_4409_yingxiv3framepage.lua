class = var_0_10000

local var_0_0 = "YingxiV3FramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnInit(arg_1_0)
	var_0_1.super.OnInit(arg_1_0)

	local var_1_0 = arg_1_0._tf

	arg_1_0.gotTag = var_1.Find(var_1_0, "AD/switcher/phase2/got")

	return
end

function var_0_1.Switch(arg_2_0, arg_2_1)
	arg_2_0.isSwitching = true

	local var_2_0
	local var_2_1

	if arg_2_1 then
		var_1_10004 = arg_2_0.phases[1]
		var_2_1 = arg_2_0.phases[2]
		var_2_0 = var_1_10004
	else
		var_1_10004 = arg_2_0.phases[2]
		var_2_1 = arg_2_0.phases[1]
		var_2_0 = var_1_10004
	end

	GetOrAddComponent = var_1_10004

	local var_2_2 = var_2_0

	typeof = var_1_10007
	CanvasGroup = var_1_10009

	local var_2_3 = var_1_10004(var_2_2, var_1_10007(var_1_10009))
	local var_2_4 = var_2_0.localPosition
	local var_2_5 = var_2_1.localPosition

	var_2_1:SetAsLastSibling()

	setActive = var_7

	var_7(var_2_0:Find("Image"), false)

	setLocalPosition = var_7
	go = var_9

	var_7(var_9(var_2_0), var_2_5)

	setActive = var_7

	var_7(var_2_0:Find("label"), true)

	LeanTween = var_7

	local var_2_6 = var_7.value

	go = var_9

	local var_2_7 = var_2_6(var_9(var_2_0), 0, 1, 0.4)
	local var_2_8 = var_7.setOnUpdate

	System = var_10

	var_2_8(var_2_7, var_10.Action_float(function(arg_3_0)
		var_2_3.alpha = arg_3_0

		return
	end))

	setActive = var_2_8

	var_2_8(var_2_1:Find("Image"), true)

	GetOrAddComponent = var_2_8

	local var_2_9 = var_2_1

	typeof = var_10
	CanvasGroup = var_12

	local var_2_10 = var_2_8(var_2_9, var_10(var_12))

	LeanTween = var_1_10008

	local var_2_11 = var_1_10008.value

	go = var_10

	local var_2_12 = var_2_11(var_10(var_2_1), 0, 1, 0.4)
	local var_2_13 = var_8.setOnUpdate

	System = var_11

	var_2_13(var_2_12, var_11.Action_float(function(arg_4_0)
		var_2_10.alpha = arg_4_0

		return
	end))

	setActive = var_2_13

	var_2_13(var_2_1:Find("label"), false)

	setLocalPosition = var_2_13
	go = var_10

	var_2_13(var_10(var_2_1), var_2_4)

	arg_2_0.isSwitching = nil

	return
end

return var_0_1
