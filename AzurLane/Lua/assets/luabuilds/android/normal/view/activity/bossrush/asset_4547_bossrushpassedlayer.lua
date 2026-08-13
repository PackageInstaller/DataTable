class = var_0_10000

local var_0_0 = "BossRushPassedLayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.challenge.ChallengePassedLayer"))

var_0_1.GROW_TIME = 0.55

function var_0_1.getUIName(arg_1_0)
	return "BossRushPassedUI"
end

function var_0_1.didEnter(arg_2_0)
	arg_2_0.tweenObjs = {}
	pg = var_1

	local var_2_0 = var_1.UIMgr.GetInstance()

	var_1.OverlayPanel(var_2_0, arg_2_0._tf)
	arg_2_0:updateSlider(arg_2_0.curIndex)
	arg_2_0:moveSlider(arg_2_0.curIndex)

	onButton = var_1

	var_1(arg_2_0, arg_2_0._tf, function()
		local var_3_0 = arg_2_0

		var_0.emit(var_3_0, var_0_1.ON_CLOSE)

		return
	end)

	local var_2_1 = arg_2_0._tf
	local var_2_2 = var_1.GetComponent(var_2_1, "DftAniEvent")

	var_1.SetEndEvent(var_2_2, function(arg_4_0)
		local var_4_0 = arg_2_0

		var_1.emit(var_4_0, var_0_1.ON_CLOSE)

		return
	end)

	return
end

function var_0_1.willExit(arg_5_0)
	pg = var_1_10001

	local var_5_0 = var_1_10001.UIMgr.GetInstance()

	var_1.UnOverlayPanel(var_5_0, arg_5_0._tf)

	LeanTween = var_1

	local var_5_1 = var_1.cancel

	go = var_5_0

	var_5_1(var_5_0(arg_5_0.slider))

	ipairs = var_5_1

	for iter_5_0, iter_5_1 in var_5_1(arg_5_0.tweenObjs) do
		LeanTween = var_1_10006

		var_1_10006.cancel(iter_5_1)
	end

	arg_5_0.tweenObjs = {}

	return
end

function var_0_1.onBackPressed(arg_6_0)
	triggerButton = var_1_10001

	var_1_10001(arg_6_0._tf)

	return
end

function var_0_1.initData(arg_7_0)
	arg_7_0.curIndex = arg_7_0.contextData.curIndex

	return
end

function var_0_1.updateSlider(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or arg_8_0.curIndex

	if arg_8_0.contextData.maxIndex < var_8_0 then
		var_8_0 = var_8_0 % var_3 == 0 and var_3 or var_8_0 % var_3
	end

	local var_8_1 = 1 / (var_3 - 1)
	local var_8_2

	var_8_2.value, var_8_2 = (var_8_0 - 1) * var_8_1, arg_8_0.sliderSC
	GetComponent = var_8_2

	local var_8_3 = arg_8_0.squareTpl

	typeof = var_1_10008
	LayoutElement = var_1_10009

	local var_8_4 = var_8_2(var_8_3, var_1_10008(var_1_10009)).preferredWidth * 0.5
	local var_8_5 = (arg_8_0.squareContainer.rect.width - var_6) * var_8_1
	local var_8_6 = arg_8_0.squareList

	var_9.make(var_8_6, function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_9_2:Find("UnFinished")
		local var_9_1 = arg_9_2:Find("Finished")
		local var_9_2 = arg_9_2:Find("Challengeing")
		local var_9_3 = arg_9_2:Find("Arrow")

		local function var_9_4()
			setActive = var_3_10000

			var_3_10000(var_9_1, true)

			setActive = var_3_10000

			var_3_10000(var_9_0, false)

			setActive = var_3_10000

			var_3_10000(var_9_2, false)

			return
		end

		local function var_9_5()
			setActive = var_3_10000

			var_3_10000(var_9_1, false)

			setActive = var_3_10000

			var_3_10000(var_9_0, true)

			setActive = var_3_10000

			var_3_10000(var_9_2, false)

			return
		end

		local function var_9_6()
			setActive = var_3_10000

			var_3_10000(var_9_1, false)

			setActive = var_3_10000

			var_3_10000(var_9_0, false)

			setActive = var_3_10000

			var_3_10000(var_9_2, true)

			return
		end

		UIItemList = var_2_10010

		if arg_9_0 == var_2_10010.EventUpdate then
			if arg_9_1 + 1 < var_8_0 then
				setActive = var_10

				var_10(var_9_3, false)
				var_9_4()
			elseif arg_9_1 + 1 == var_8_0 then
				setActive = var_10

				var_10(var_9_3, true)
				var_9_6()
			elseif arg_9_1 + 1 > var_8_0 then
				setActive = var_10

				var_10(var_9_3, false)
				var_9_5()
			end

			setAnchoredPosition = var_10

			var_10(arg_9_2, {
				y = 0,
				x = var_8_4 + var_8_5 * arg_9_1
			})
		end

		return
	end)

	local var_8_7 = arg_8_0.squareList

	var_9.align(var_8_7, var_3)

	return
end

function var_0_1.moveSlider(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 or arg_13_0.curIndex

	if arg_13_0.contextData.maxIndex < var_13_0 then
		var_13_0 = var_13_0 % var_3 == 0 and var_3 or var_13_0 % var_3
	end

	local var_13_1 = 1 / (var_3 - 1)
	local var_13_2 = (var_13_0 - 1) * var_13_1
	local var_13_3 = var_13_0 * var_13_1

	LeanTween = var_1_10007

	local var_13_4 = var_1_10007.value

	go = var_1_10008

	local var_13_5 = var_13_4(var_1_10008(arg_13_0.slider), var_13_2, var_13_3, var_0_1.GROW_TIME)
	local var_13_6 = var_7.setDelay(var_13_5, 1.4)
	local var_13_7 = var_7.setOnUpdate

	System = var_9

	local var_13_8 = var_13_7(var_13_6, var_9.Action_float(function(arg_14_0)
		arg_13_0.sliderSC.value = arg_14_0

		return
	end))
	local var_13_9 = var_7.setOnComplete

	System = var_9

	var_13_9(var_13_8, var_9.Action(function()
		local var_15_0 = arg_13_0

		var_0.updateSlider(var_15_0, var_13_0 + 1)

		return
	end))

	return
end

return var_0_1
