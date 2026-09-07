local BossRushPassedLayer = class("BossRushPassedLayer", import("view.challenge.ChallengePassedLayer"))

BossRushPassedLayer.GROW_TIME = 0.55

function BossRushPassedLayer:getUIName()
	return "BossRushPassedUI"
end

function BossRushPassedLayer:didEnter()
	self.tweenObjs = {}

	pg.UIMgr.GetInstance():OverlayPanel(self._tf)
	self:updateSlider(self.curIndex)
	self:moveSlider(self.curIndex)
	onButton(self, self._tf, function()
		self:emit(BossRushPassedLayer.ON_CLOSE)

		return
	end)
	self._tf:GetComponent("DftAniEvent"):SetEndEvent(function(arg_4_0)
		self:emit(BossRushPassedLayer.ON_CLOSE)

		return
	end)

	return
end

function BossRushPassedLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)
	LeanTween.cancel(go(self.slider))

	for iter_5_0, iter_5_1 in ipairs(self.tweenObjs) do
		LeanTween.cancel(iter_5_1)
	end

	self.tweenObjs = {}

	return
end

function BossRushPassedLayer:onBackPressed()
	triggerButton(self._tf)

	return
end

function BossRushPassedLayer:initData()
	self.curIndex = self.contextData.curIndex

	return
end

function BossRushPassedLayer:updateSlider(arg_8_1)
	local var_8_0 = arg_8_1 or self.curIndex
	local var_8_1 = self.contextData.maxIndex

	if self.contextData.maxIndex < (arg_8_1 or self.curIndex) then
		var_8_0 = var_8_0 % var_8_1 == 0 and var_8_1 or var_8_0 % var_8_1
	end

	local var_8_2 = 1 / (var_8_1 - 1)

	self.sliderSC.value = (var_8_0 - 1) * (1 / (var_8_1 - 1))

	local var_8_3 = GetComponent(self.squareTpl, typeof(LayoutElement)).preferredWidth
	local var_8_4 = var_8_3 * 0.5
	local var_8_5 = (self.squareContainer.rect.width - var_8_3) * var_8_2

	self.squareList:make(function(arg_9_0, arg_9_1, arg_9_2)
		local var_9_0 = arg_9_2:Find("UnFinished")
		local var_9_1 = arg_9_2:Find("Finished")
		local var_9_2 = arg_9_2:Find("Challengeing")
		local var_9_3 = arg_9_2:Find("Arrow")

		if arg_9_0 == UIItemList.EventUpdate then
			if arg_9_1 + 1 < var_8_0 then
				setActive(var_9_3, false)
				;(function()
					setActive(var_9_1, true)
					setActive(var_9_0, false)
					setActive(var_9_2, false)

					return
				end)()
			elseif arg_9_1 + 1 == var_8_0 then
				setActive(var_9_3, true)
				;(function()
					setActive(var_9_1, false)
					setActive(var_9_0, false)
					setActive(var_9_2, true)

					return
				end)()
			elseif arg_9_1 + 1 > var_8_0 then
				setActive(var_9_3, false)
				;(function()
					setActive(var_9_1, false)
					setActive(var_9_0, true)
					setActive(var_9_2, false)

					return
				end)()
			end

			setAnchoredPosition(arg_9_2, {
				y = 0,
				x = var_8_4 + var_8_5 * arg_9_1
			})
		end

		return
	end)
	self.squareList:align(var_8_1)

	return
end

function BossRushPassedLayer:moveSlider(arg_13_1)
	local var_13_0 = arg_13_1 or self.curIndex
	local var_13_1 = self.contextData.maxIndex

	if self.contextData.maxIndex < (arg_13_1 or self.curIndex) and (var_13_0 % var_13_1 ~= 0 or not var_13_1) then
		::label_13_0::

		var_13_0 = var_13_0 % var_13_1

		local var_13_2, var_13_3 = (var_13_0 - 1) * (1 / (var_13_1 - 1)), go(self.slider)
	end

	LeanTween.value(var_13_3, var_13_2, var_13_0 * (1 / (var_13_1 - 1)), BossRushPassedLayer.GROW_TIME):setDelay(1.4):setOnUpdate(System.Action_float(function(arg_14_0)
		self.sliderSC.value = arg_14_0

		return
	end)):setOnComplete(System.Action(function()
		self:updateSlider(var_13_0 + 1)

		return
	end))

	return
end

return BossRushPassedLayer
