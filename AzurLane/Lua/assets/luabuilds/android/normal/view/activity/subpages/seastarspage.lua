class = var_0_10000

local var_0_0 = "SeaStarsPage"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".TemplatePage.NewFrameTemplatePage"))

function var_0_1.OnFirstFlush(arg_1_0)
	SetActive = var_1_10001

	var_1_10001(arg_1_0.switchBtn, false)

	ipairs = var_1_10001

	for iter_1_0, iter_1_1 in var_1_10001(arg_1_0.phases) do
		setActive = var_1_10006

		var_1_10006(iter_1_1, true)

		GetOrAddComponent = var_1_10006

		local var_1_0 = iter_1_1

		typeof = var_8
		CanvasGroup = var_1_10009
		var_1_10006 = var_1_10006(var_1_0, var_8(var_1_10009))
		var_1_10006.alpha = 0
	end

	var_0_1.super.OnFirstFlush(arg_1_0)

	return
end

function var_0_1.Switch(arg_2_0, arg_2_1)
	local var_2_0
	local var_2_1
	local var_2_2 = arg_2_0.phases[1]
	local var_2_3 = arg_2_0.phases[2]
	local var_2_4 = var_2_2.localPosition
	local var_2_5 = var_2_3.localPosition
	local var_2_6 = var_2_3

	var_2_3.SetAsLastSibling(var_2_6)

	local var_2_7 = {}

	table = var_2_6

	var_2_6.insert(var_2_7, function(arg_3_0)
		LeanTween = var_2_10001

		local var_3_0 = var_2_10001.moveLocal

		go = var_2_10002

		var_3_0(var_2_10002(var_0), var_2_5, 0.4)

		LeanTween = var_3_0

		local var_3_1 = var_3_0.alphaCanvas

		GetOrAddComponent = var_2

		local var_3_2 = var_0

		typeof = var_4
		CanvasGroup = var_2_10005

		var_3_1(var_2(var_3_2, var_4(var_2_10005)), 0, 0.4)

		LeanTween = var_3_1

		local var_3_3 = var_3_1.moveLocal

		go = var_2

		var_3_3(var_2(var_2_3), var_2_4, 0.4)

		LeanTween = var_3_3

		local var_3_4 = var_3_3.alphaCanvas

		GetOrAddComponent = var_2

		local var_3_5 = var_2_3

		typeof = var_4
		CanvasGroup = var_2_10005

		local var_3_6 = var_3_4(var_2(var_3_5, var_4(var_2_10005)), 1, 0.4)
		local var_3_7 = var_1.setOnComplete

		System = var_3

		var_3_7(var_3_6, var_3.Action(arg_3_0))

		return
	end)

	seriesAsync = var_7

	var_7(var_2_7, function()
		setToggleEnabled = var_2_10000

		var_2_10000(arg_2_0.switchBtn, true)

		return
	end)

	return
end

return var_0_1
