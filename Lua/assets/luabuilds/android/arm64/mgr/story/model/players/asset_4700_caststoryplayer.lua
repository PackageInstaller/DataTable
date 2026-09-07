local CastStoryPlayer = class("CastStoryPlayer", import(".StoryPlayer"))

function CastStoryPlayer:Ctor(arg_1_1)
	CastStoryPlayer.super.Ctor(self, arg_1_1)

	self.tpls = {
		self._tf:Find("resource/text_tpl"),
		self._tf:Find("resource/image_tpl"),
		self._tf:Find("resource/list_tpl"),
		self._tf:Find("resource/cast_tpl")
	}
	self.layoutContainer = self.castPanel:Find("Image")

	return
end

function CastStoryPlayer:OnReset(arg_2_1, arg_2_2, arg_2_3)
	setActive(self.castPanel, true)
	setAnchoredPosition(self.layoutContainer, {
		x = 0,
		y = 0
	})
	arg_2_3()

	return
end

function CastStoryPlayer:OnEnter(arg_3_1, arg_3_2, arg_3_3)
	seriesAsync({
		function(arg_4_0)
			self:SetLayout(arg_3_1, arg_4_0)

			return
		end,
		function(arg_5_0)
			onNextTick(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:StartAnimation(arg_3_1, arg_6_0)

			return
		end
	}, arg_3_3)

	return
end

function CastStoryPlayer:SetLayout(arg_7_1, arg_7_2)
	removeAllChildren(self.layoutContainer)

	self.layoutContainer:GetComponent(typeof(VerticalLayoutGroup)).spacing = arg_7_1:GetSpacing()

	for iter_7_0, iter_7_1 in pairs((arg_7_1:GetLayout())) do
		local var_7_0 = cloneTplTo(self.tpls[iter_7_1.type], self.layoutContainer)

		assert(self["InitLayoutForType" .. iter_7_1.type], "need function >>>" .. "InitLayoutForType" .. iter_7_1.type)
		self["InitLayoutForType" .. iter_7_1.type](self, var_7_0, iter_7_1)
	end

	arg_7_2()

	return
end

function CastStoryPlayer:InitLayoutForType1(arg_8_1, arg_8_2)
	setText(arg_8_1, arg_8_2.text)

	return
end

function CastStoryPlayer:InitLayoutForType2(arg_9_1, arg_9_2)
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

function CastStoryPlayer:InitLayoutForType3(arg_10_1, arg_10_2)
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

			if var_10_2 then
				var_11_0.alignment = TextAnchor.MiddleCenter
			else
				if arg_11_1 % 2 == 0 then
					var_11_0.alignment = TextAnchor.MiddleRight or TextAnchor.MiddleLeft
				end

				if arg_11_1 % 2 == 0 then
					var_11_1 = arg_10_2.evenColumnColor
				end
			end

			var_11_0.text = setColorStr(var_10_0[arg_11_1 + 1], var_11_1)
		end

		return
	end)
	var_10_3:align(#arg_10_2.names)

	return
end

function CastStoryPlayer:InitLayoutForType4(arg_12_1, arg_12_2)
	return
end

function CastStoryPlayer:StartAnimation(arg_13_1, arg_13_2)
	local var_13_0 = arg_13_1:GetPlayTime()

	self:PlayAnimation(var_13_0, arg_13_2)
	onButton(self, self._tf, function()
		removeOnButton(self._tf)
		self:SpeedUp(var_13_0, arg_13_2)

		return
	end, SFX_PANEL)

	return
end

function CastStoryPlayer:PlayAnimation(arg_15_1, arg_15_2)
	self:TweenValue(self.layoutContainer, getAnchoredPosition(self.layoutContainer).y, self.castPanel.rect.height + self.layoutContainer.sizeDelta.y, arg_15_1, 0, function(arg_16_0)
		setAnchoredPosition(self.layoutContainer, {
			y = arg_16_0
		})

		return
	end, function()
		removeOnButton(self._tf)
		arg_15_2()

		return
	end)

	return
end

function CastStoryPlayer:SpeedUp(arg_18_1, arg_18_2)
	self:CancelTween(self.layoutContainer)
	self:PlayAnimation(arg_18_1 * 0.2, arg_18_2)

	return
end

function CastStoryPlayer:RegisetEvent(arg_19_1, arg_19_2)
	CastStoryPlayer.super.RegisetEvent(self, arg_19_1, arg_19_2)
	triggerButton(self._go)

	return
end

return CastStoryPlayer
