class = var_0_10000

local var_0_0 = "CastStoryPlayer"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".StoryPlayer"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	local var_1_0 = {}
	local var_1_1 = arg_1_0._tf

	var_1_0[1] = var_3.Find(var_1_1, "resource/text_tpl")

	local var_1_2 = arg_1_0._tf

	var_1_0[2] = var_3.Find(var_1_2, "resource/image_tpl")

	local var_1_3 = arg_1_0._tf

	var_1_0[3] = var_3.Find(var_1_3, "resource/list_tpl")

	local var_1_4 = arg_1_0._tf

	var_1_0[4] = var_3.Find(var_1_4, "resource/cast_tpl")
	arg_1_0.tpls = var_1_0

	local var_1_5 = arg_1_0.castPanel

	arg_1_0.layoutContainer = var_2.Find(var_1_5, "Image")

	return
end

function var_0_1.OnReset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive = var_1_10004

	var_1_10004(arg_2_0.castPanel, true)

	setAnchoredPosition = var_1_10004

	var_1_10004(arg_2_0.layoutContainer, {
		x = 0,
		y = 0
	})
	arg_2_3()

	return
end

function var_0_1.OnEnter(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	seriesAsync = var_1_10004

	var_1_10004({
		function(arg_4_0)
			local var_4_0 = arg_3_0

			var_1.SetLayout(var_4_0, arg_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick = var_2_10001

			var_2_10001(arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_3_0

			var_1.StartAnimation(var_6_0, arg_3_1, arg_6_0)

			return
		end
	}, arg_3_3)

	return
end

function var_0_1.SetLayout(arg_7_0, arg_7_1, arg_7_2)
	removeAllChildren = var_1_10003

	var_1_10003(arg_7_0.layoutContainer)

	local var_7_0 = arg_7_1:GetSpacing()
	local var_7_1 = arg_7_0.layoutContainer
	local var_7_2 = var_4.GetComponent

	typeof = var_1_10006
	VerticalLayoutGroup = var_1_10007
	var_7_2(var_7_1, var_1_10006(var_1_10007)).spacing = var_7_0

	local var_7_3 = arg_7_1
	local var_7_4 = arg_7_1.GetLayout(var_7_3)

	pairs = var_7_3

	for iter_7_0, iter_7_1 in var_7_3(var_7_4) do
		local var_7_5 = arg_7_0.tpls[iter_7_1.type]

		cloneTplTo = var_12

		local var_7_6 = var_12(var_7_5, arg_7_0.layoutContainer)
		local var_7_7 = "InitLayoutForType" .. iter_7_1.type

		assert = var_14

		var_14(arg_7_0[var_7_7], "need function >>>" .. var_7_7)
		arg_7_0[var_7_7](arg_7_0, var_7_6, iter_7_1)
	end

	arg_7_2()

	return
end

function var_0_1.InitLayoutForType1(arg_8_0, arg_8_1, arg_8_2)
	setText = var_1_10003

	var_1_10003(arg_8_1, arg_8_2.text)

	return
end

function var_0_1.InitLayoutForType2(arg_9_0, arg_9_1, arg_9_2)
	LoadSprite = var_1_10003

	local var_9_0 = var_1_10003("bg/" .. arg_9_2.path)
	local var_9_1 = arg_9_1:Find("image")
	local var_9_2 = var_4.GetComponent

	typeof = var_6
	Image = var_1_10007

	local var_9_3 = var_9_2(var_9_1, var_6(var_1_10007))
	local var_9_4 = arg_9_1
	local var_9_5 = arg_9_1.GetComponent

	typeof = var_1_10007
	LayoutElement = var_1_10008

	local var_9_6 = var_9_5(var_9_4, var_1_10007(var_1_10008))

	var_9_3.sprite = var_9_0

	local var_9_7 = arg_9_2.size

	Vector2 = var_7

	if var_9_7 == var_7.zero then
		var_9_3:SetNativeSize()

		var_9_6.preferredHeight = var_9_3.gameObject.transform.sizeDelta.y
	else
		var_9_3.gameObject.transform.sizeDelta = arg_9_2.size
		var_9_6.preferredHeight = arg_9_2.size.y
	end

	return
end

function var_0_1.InitLayoutForType3(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.names
	local var_10_1 = arg_10_2.column
	local var_10_2 = arg_10_1
	local var_10_3 = arg_10_1.GetComponent

	typeof = var_1_10007
	GridLayoutGroup = var_1_10008

	local var_10_4 = var_10_3(var_10_2, var_1_10007(var_1_10008))

	var_10_4.constraintCount = var_10_1

	local var_10_5 = var_10_4.spacing.x
	local var_10_6 = 0 / var_10_1 - var_10_5 * (var_10_1 - 1)

	Vector2 = var_8
	var_10_4.cellSize = var_8(var_10_6, 30)

	local var_10_7 = var_10_1 % 2 ~= 0

	UIItemList = var_9

	local var_10_8 = var_9.New(arg_10_1, arg_10_1:Find("1"))

	var_9.make(var_10_8, function(arg_11_0, arg_11_1, arg_11_2)
		UIItemList = var_2_10003

		if arg_11_0 == var_2_10003.EventUpdate then
			local var_11_0 = arg_11_2
			local var_11_1 = arg_11_2.GetComponent

			typeof = var_2_10005
			Text = var_2_10006

			local var_11_2 = var_11_1(var_11_0, var_2_10005(var_2_10006))

			COLOR_WHITE = var_11_0

			if var_10_7 then
				TextAnchor = var_11_3
				var_11_2.alignment = var_11_3.MiddleCenter

				goto label_11_0
			end

			local var_11_3 = arg_11_1 % 2 == 0

			if var_11_3 then
				TextAnchor = var_2_10006

				if not var_2_10006.MiddleRight then
					TextAnchor = var_2_10006
					var_2_10006 = var_2_10006.MiddleLeft
				end

				var_11_2.alignment = var_2_10006

				if var_11_3 then
					var_11_0 = arg_10_2.evenColumnColor
				end

				::label_11_0::

				setColorStr = var_11_3
				var_11_2.text = var_11_3(var_10_0[arg_11_1 + 1], var_11_0)

				return
			end
		end
	end)
	var_9:align(#var_10_0)

	return
end

function var_0_1.InitLayoutForType4(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_1.StartAnimation(arg_13_0, arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:GetPlayTime()

	arg_13_0:PlayAnimation(var_13_0, arg_13_2)

	onButton = var_4

	local var_13_1 = arg_13_0
	local var_13_2 = arg_13_0._tf

	local function var_13_3()
		removeOnButton = var_2_10000

		var_2_10000(arg_13_0._tf)

		local var_14_0 = arg_13_0

		var_0.SpeedUp(var_14_0, var_13_0, arg_13_2)

		return
	end

	SFX_PANEL = var_1_10008

	var_4(var_13_1, var_13_2, var_13_3, var_1_10008)

	return
end

function var_0_1.PlayAnimation(arg_15_0, arg_15_1, arg_15_2)
	local var_15_0 = arg_15_0.castPanel.rect.height + arg_15_0.layoutContainer.sizeDelta.y

	getAnchoredPosition = var_1_10006

	local var_15_1 = var_1_10006(arg_15_0.layoutContainer).y

	arg_15_0:TweenValue(arg_15_0.layoutContainer, var_15_1, var_15_0, arg_15_1, 0, function(arg_16_0)
		setAnchoredPosition = var_2_10001

		var_2_10001(arg_15_0.layoutContainer, {
			y = arg_16_0
		})

		return
	end, function()
		removeOnButton = var_2_10000

		var_2_10000(arg_15_0._tf)
		arg_15_2()

		return
	end)

	return
end

function var_0_1.SpeedUp(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:CancelTween(arg_18_0.layoutContainer)
	arg_18_0:PlayAnimation(arg_18_1 * 0.2, arg_18_2)

	return
end

function var_0_1.RegisetEvent(arg_19_0, arg_19_1, arg_19_2)
	var_0_1.super.RegisetEvent(arg_19_0, arg_19_1, arg_19_2)

	triggerButton = var_3

	var_3(arg_19_0._go)

	return
end

return var_0_1
