class = var_0_10000

local var_0_0 = "StarSeaFramePage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	ipairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001(arg_1_0.phases) do
		setActive = var_1_10006

		var_1_10006(iter_1_1, true)

		GetOrAddComponent = var_1_10006

		local var_1_0 = iter_1_1

		typeof = var_9
		CanvasGroup = var_1_10011
		var_1_10006 = var_1_10006(var_1_0, var_9(var_1_10011))
		var_1_10006.alpha = 0
	end

	var_0_1.super.OnFirstFlush(arg_1_0)

	GetComponent = var_1

	local var_1_1 = arg_1_0._tf
	local var_1_2 = var_3.Find(var_1_1, "AD/switcher/phase2/Image")

	typeof = iter_1_0
	Image = var_6

	local var_1_3 = var_1(var_1_2, iter_1_0(var_6))

	var_1.SetNativeSize(var_1_3)

	GetComponent = var_1

	local var_1_4 = arg_1_0._tf
	local var_1_5 = var_3.Find(var_1_4, "AD/switcher/phase1/Image")

	typeof = var_4
	Image = var_6

	local var_1_6 = var_1(var_1_5, var_4(var_6))

	var_1.SetNativeSize(var_1_6)

	return
end

function var_0_1.Switch(arg_2_0, arg_2_1)
	arg_2_0.isSwitching = true
	setToggleEnabled = var_2

	var_2(arg_2_0.switchBtn, false)

	local var_2_0
	local var_2_1

	if arg_2_1 then
		var_2_0, var_2_1 = arg_2_0.phases[1], arg_2_0.phases[2]
	else
		var_2_0, var_2_1 = arg_2_0.phases[2], arg_2_0.phases[1]
	end

	local var_2_2 = var_2_0.localPosition
	local var_2_3 = var_2_1.localPosition

	var_2_1:SetAsLastSibling()

	local var_2_4 = {}

	table = var_1_10007

	var_1_10007.insert(var_2_4, function(arg_3_0)
		LeanTween = var_2_10001

		local var_3_0 = var_2_10001.moveLocal

		go = var_2_10003

		var_3_0(var_2_10003(var_2_0), var_2_3, 0.4)

		LeanTween = var_3_0

		local var_3_1 = var_3_0.alphaCanvas

		GetOrAddComponent = var_3

		local var_3_2 = var_2_0

		typeof = var_2_10006
		CanvasGroup = var_2_10008

		var_3_1(var_3(var_3_2, var_2_10006(var_2_10008)), 0, 0.4)

		LeanTween = var_3_1

		local var_3_3 = var_3_1.moveLocal

		go = var_3

		var_3_3(var_3(var_2_1), var_2_2, 0.4)

		LeanTween = var_3_3

		local var_3_4 = var_3_3.alphaCanvas

		GetOrAddComponent = var_3

		local var_3_5 = var_2_1

		typeof = var_6
		CanvasGroup = var_2_10008

		local var_3_6 = var_3_4(var_3(var_3_5, var_6(var_2_10008)), 1, 0.4)
		local var_3_7 = var_1.setOnComplete

		System = var_4

		var_3_7(var_3_6, var_4.Action(arg_3_0))

		return
	end)

	seriesAsync = var_7

	var_7(var_2_4, function()
		local var_4_0 = arg_2_0

		var_4_0.isSwitching = nil
		setToggleEnabled = var_4_0

		var_4_0(arg_2_0.switchBtn, true)

		return
	end)

	return
end

return var_0_1
