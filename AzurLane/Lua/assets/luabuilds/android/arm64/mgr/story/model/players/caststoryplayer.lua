local var_0_0 = class("CastStoryPlayer", import(".StoryPlayer"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	arg_1_0.tpls = {
		arg_1_0._tf:Find("resource/text_tpl"),
		arg_1_0._tf:Find("resource/image_tpl"),
		arg_1_0._tf:Find("resource/list_tpl"),
		arg_1_0._tf:Find("resource/cast_tpl")
	}
	arg_1_0.layoutContainer = arg_1_0.castPanel:Find("Image")

	return
end

function var_0_0.OnReset(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
	setActive(arg_2_0.castPanel, true)
	setAnchoredPosition(arg_2_0.layoutContainer, {
		x = 0,
		y = 0
	})
	arg_2_3()

	return
end

function var_0_0.OnEnter(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	seriesAsync({
		function(arg_4_0)
			arg_3_0:SetLayout(arg_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_3_0:StartAnimation(arg_3_1, arg_6_0)

			return
		end
	}, arg_3_3)

	return
end

function var_0_0.SetLayout(arg_7_0, arg_7_1, arg_7_2)
	removeAllChildren(arg_7_0.layoutContainer)

	arg_7_0.layoutContainer:GetComponent(typeof(VerticalLayoutGroup)).spacing = arg_7_1:GetSpacing()

	for iter_7_0, iter_7_1 in pairs((arg_7_1:GetLayout())) do
		local var_7_0 = cloneTplTo(arg_7_0.tpls[iter_7_1.type], arg_7_0.layoutContainer)

		assert(arg_7_0["InitLayoutForType" .. iter_7_1.type], "need function >>>" .. "InitLayoutForType" .. iter_7_1.type)
		arg_7_0["InitLayoutForType" .. iter_7_1.type](arg_7_0, var_7_0, iter_7_1)
	end

	arg_7_2()

	return
end

function var_0_0.InitLayoutForType1(arg_8_0, arg_8_1, arg_8_2)
	setText(arg_8_1, arg_8_2.text)

	return
end

function var_0_0.InitLayoutForType2(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = arg_9_1:Find("image"):GetComponent(typeof(Image))
	local var_9_1 = arg_9_1:GetComponent(typeof(LayoutElement))

	var_9_0.sprite = LoadSprite("bg/" .. arg_9_2.path)

	if arg_9_2.size == Vector2.zero then
		var_9_0:SetNativeSize()

		var_9_1.preferredHeight = var_9_0.gameObject.transform.sizeDelta.y
	else
		var_9_0.gameObject.transform.sizeDelta = arg_9_2.size
		var_9_1.preferredHeight = arg_9_2.size.y
	end

	return
end

function var_0_0.InitLayoutForType3(arg_10_0, arg_10_1, arg_10_2)
	local var_10_0 = arg_10_2.names
	local var_10_1 = arg_10_1:GetComponent(typeof(GridLayoutGroup))

	var_10_1.constraintCount = arg_10_2.column
	var_10_1.cellSize = Vector2(0 / arg_10_2.column - var_10_1.spacing.x * (arg_10_2.column - 1), 30)

	local var_10_2 = arg_10_2.column % 2 ~= 0
	local var_10_3 = UIItemList.New(arg_10_1, arg_10_1:Find("1"))

	var_10_3:make(function(arg_11_0, arg_11_1, arg_11_2)
		if arg_11_0 == UIItemList.EventUpdate then
			local var_11_0 = arg_11_2:GetComponent(typeof(Text))
			local var_11_1 = COLOR_WHITE
			local var_11_2 = arg_11_1 % 2 == 0

			if var_10_2 then
				var_11_0.alignment = TextAnchor.MiddleCenter

				goto label_11_0
			end

			::label_11_0::

			if arg_11_1 % 2 == 0 then
				var_11_0.alignment = TextAnchor.MiddleRight or TextAnchor.MiddleLeft

				if var_11_2 then
					var_11_1 = arg_10_2.evenColumnColor
				end

				var_11_0.text = setColorStr(var_10_0[arg_11_1 + 1], var_11_1)

				return
			end
		end
	end)
	var_10_3:align(#arg_10_2.names)

	return
end

function var_0_0.InitLayoutForType4(arg_12_0, arg_12_1, arg_12_2)
	return
end

function var_0_0.StartAnimation(arg_13_0, arg_13_1, arg_13_2)
	arg_13_0:PlayAnimation(arg_13_1:GetPlayTime(), arg_13_2)
	onButton(arg_13_0, arg_13_0._tf, function()
		removeOnButton(arg_13_0._tf)
		arg_13_0:SpeedUp(var_0, arg_13_2)

		return
	end, SFX_PANEL)

	return
end

function var_0_0.PlayAnimation(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0:TweenValue(arg_15_0.layoutContainer, getAnchoredPosition(arg_15_0.layoutContainer).y, arg_15_0.castPanel.rect.height + arg_15_0.layoutContainer.sizeDelta.y, arg_15_1, 0, function(arg_16_0)
		setAnchoredPosition(arg_15_0.layoutContainer, {
			y = arg_16_0
		})

		return
	end, function()
		removeOnButton(arg_15_0._tf)
		arg_15_2()

		return
	end)

	return
end

function var_0_0.SpeedUp(arg_18_0, arg_18_1, arg_18_2)
	arg_18_0:CancelTween(arg_18_0.layoutContainer)
	arg_18_0:PlayAnimation(arg_18_1 * 0.2, arg_18_2)

	return
end

function var_0_0.RegisetEvent(arg_19_0, arg_19_1, arg_19_2)
	var_0_0.super.RegisetEvent(arg_19_0, arg_19_1, arg_19_2)
	triggerButton(arg_19_0._go)

	return
end

return var_0_0
