-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleSanity.lua

module("logic.battle.uilib.UIBattleSanity", package.seeall)

local UIBattleSanity = class("UIBattleSanity")
local kTwinkleInternal = 1

function UIBattleSanity:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function UIBattleSanity:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function UIBattleSanity:buildUI()
	self._enableState = GameObjectEnableState.New(self.mainGO)
	self._transform = self.mainGO.transform
	self._sanityAnim = goutil.addComponentOnce(self.mainGO, ComponentType.Animation)
	self._positivePanelGo = goutil.findChild(self.mainGO, "type/zheng")
	self._zeroPanelGo = goutil.findChild(self.mainGO, "type/ling")
	self._negativePanelGo = goutil.findChild(self.mainGO, "type/fu")
	self._deadMarkPanelGo = goutil.findChild(self.mainGO, "type/break")
	self._positiveAnim = goutil.addComponentOnce(self._positivePanelGo, ComponentType.Animation)
	self._zeroAnim = goutil.addComponentOnce(self._zeroPanelGo, ComponentType.Animation)
	self._negativeAnim = goutil.addComponentOnce(self._negativePanelGo, ComponentType.Animation)
	self._deadMarkAnim = goutil.addComponentOnce(self._deadMarkPanelGo, ComponentType.Animation)
	self._positiveGo = goutil.findChild(self.mainGO, "type/zheng/zheng (1)")
	self._zeroGo = goutil.findChild(self.mainGO, "type/ling/ling (1)")
	self._negativeGo = goutil.findChild(self.mainGO, "type/fu/fu (1)")
	self._deadMarkGo = goutil.findChild(self.mainGO, "type/break/break (1)")
	self._timelineTask = TimelineTask.New()
	self._enableNegative = false
	self._sanityValue = false
	self._curSanityValue = false
	self._isPreviewing = false
	self._forecastSanity = false

	self:_hideAllSanityGo()

	self._maskGoList = {
		goutil.findChild(self.mainGO, "type/zheng/zheng (1)/mask"),
		goutil.findChild(self.mainGO, "type/ling/ling (1)/mask"),
		goutil.findChild(self.mainGO, "type/fu/fu (1)/mask"),
		goutil.findChild(self.mainGO, "type/break/break (1)/mask")
	}
end

function UIBattleSanity:destroyUI()
	self:_killTween()

	self._transform = nil
	self._animation = nil
	self._timelineTask = nil
end

function UIBattleSanity:setVisible(visible, key)
	self._enableState:setEnable(key, visible)
end

function UIBattleSanity:_hideAllSanityGo()
	goutil.setActive(self._positiveGo, false)
	goutil.setActive(self._zeroGo, false)
	goutil.setActive(self._negativeGo, false)
	goutil.setActive(self._deadMarkGo, false)
end

function UIBattleSanity:setSanity(sanityValue, isInStrengthen, isImmediately)
	self._sanityValue = sanityValue
	self._isInStrengthen = isInStrengthen

	if not sanityValue then
		self:_hideAllSanityGo()

		return
	end

	if not isInStrengthen then
		isImmediately = true
	end

	if not self._isPreviewing then
		local toSanity = self._sanityValue - (isInStrengthen and 1 or 0)

		self:_doSanity(isImmediately, self._curSanityValue, toSanity)
	end
end

function UIBattleSanity:doPreview(sanityValue, isInStrengthen, forecastSanity)
	self._sanityValue = sanityValue
	self._isInStrengthen = isInStrengthen
	self._forecastSanity = forecastSanity

	if not sanityValue then
		return
	end

	self:_killTween()

	self._isPreviewing = true

	self:_doSanity(not isInStrengthen, self._curSanityValue, self._forecastSanity)
end

function UIBattleSanity:stopPreview()
	self._forecastSanity = false

	if self._isPreviewing and self._sanityValue then
		self._isPreviewing = false

		self:_killTween()

		local toSanity = self._sanityValue - (self._isInStrengthen and 1 or 0)

		self:_doSanity(true, self._curSanityValue, toSanity)
	end
end

function UIBattleSanity:_doSanity(isImmediately, fromSanity, toSanity)
	if not toSanity then
		return
	end

	if fromSanity == toSanity then
		if self._isInStrengthen then
			if toSanity == -1 then
				AnimationUtils.ResetAnimation(self._negativeAnim, "fu_normal")
			end

			self:_playLoopAnim(toSanity)
		else
			self:_stopAnim()
		end

		return
	end

	if not isImmediately and not fromSanity then
		isImmediately = true
	end

	self:_stopAnim()

	local deltaTime = 0

	if isImmediately then
		self:_appearImmediately(toSanity)
	else
		self:_playAppearAnim(fromSanity, toSanity)

		deltaTime = 0.8
	end

	if self._isInStrengthen then
		if toSanity == -1 then
			AnimationUtils.ResetAnimation(self._negativeAnim, "fu_normal")
		end

		self._timelineTask:addTask(deltaTime, self._playLoopAnim, self)
		self._timelineTask:start(toSanity)
	end

	self._curSanityValue = toSanity
end

function UIBattleSanity:_stopAnim()
	self._sanityAnim:Stop()

	if self._curSanityValue == 1 then
		self._positiveAnim:Stop()
		AnimationUtils.ResetAnimation(self._positiveAnim, "zheng_normal")
	elseif self._curSanityValue == 0 then
		self._zeroAnim:Stop()
		AnimationUtils.ResetAnimation(self._zeroAnim, "ling_normal")
	elseif self._curSanityValue == -1 then
		self._negativeAnim:Stop()
		AnimationUtils.ResetAnimation(self._negativeAnim, "fu_normal")
	else
		self._deadMarkAnim:Stop()
		AnimationUtils.ResetAnimation(self._deadMarkAnim, "normal")
	end

	self._timelineTask:clear()
end

function UIBattleSanity:_playLoopAnim(toSanity)
	if toSanity == 1 then
		goutil.setActive(self._positiveGo, true)
		self._positiveAnim:Stop()
		self._positiveAnim:Play("zheng_loop")
	elseif toSanity == 0 then
		goutil.setActive(self._zeroGo, true)
		self._zeroAnim:Stop()
		self._zeroAnim:Play("ling_loop")
	elseif toSanity == -1 then
		goutil.setActive(self._negativeGo, true)
		self._negativeAnim:Stop()
		self._negativeAnim:Play("fu_loop")
	else
		self._deadMarkAnim:Stop()
		self._deadMarkAnim:Play("break_loop")
	end
end

function UIBattleSanity:_appearImmediately(toSanity)
	goutil.setActive(self._positiveGo, false)
	goutil.setActive(self._zeroGo, false)
	goutil.setActive(self._negativeGo, false)
	goutil.setActive(self._deadMarkGo, false)
	self._sanityAnim:Stop()

	if toSanity == 1 then
		goutil.setActive(self._positiveGo, true)
		AnimationUtils.ResetAnimation(self._positiveAnim, "zheng_normal")
	elseif toSanity == 0 then
		goutil.setActive(self._zeroGo, true)
		AnimationUtils.ResetAnimation(self._zeroAnim, "ling_normal")
	elseif toSanity == -1 then
		AnimationUtils.ResetAnimation(self._sanityAnim, "sanity_break")
		goutil.setActive(self._negativeGo, true)
		AnimationUtils.ResetAnimation(self._negativeAnim, "fu_normal")
	else
		goutil.setActive(self._deadMarkGo, true)
	end
end

function UIBattleSanity:_playAppearAnim(fromSanity, toSanity)
	if fromSanity == -1 and toSanity == -2 then
		self._negativeAnim:Stop()
		self._sanityAnim:Stop()
		self._deadMarkAnim:Stop()
		self._deadMarkPanelGo.transform:SetSiblingIndex(0)
		goutil.setActive(self._deadMarkGo, true)
		self._sanityAnim:Play("sanity_break")

		return
	end

	if fromSanity == -2 and toSanity == -1 then
		self._negativeAnim:Stop()
		self._sanityAnim:Stop()
		self._deadMarkAnim:Stop()
		self._negativePanelGo.transform:SetSiblingIndex(0)
		goutil.setActive(self._negativeGo, true)

		return
	end

	if fromSanity then
		if fromSanity == 1 then
			self._positiveAnim:Stop()
			goutil.setActive(self._positiveGo, false)
		elseif fromSanity == 0 then
			self._zeroAnim:Stop()
			goutil.setActive(self._zeroGo, false)
		elseif fromSanity == -1 then
			self._negativeAnim:Stop()
			goutil.setActive(self._negativeGo, false)
		else
			self._deadMarkAnim:Stop()
			goutil.setActive(self._deadMarkGo, false)
		end
	end

	if toSanity == 1 then
		self._positivePanelGo.transform:SetSiblingIndex(0)
		goutil.setActive(self._positiveGo, true)
		self._positiveAnim:Stop()
		self._positiveAnim:Play("zheng_appear")
	elseif toSanity == 0 then
		self._zeroPanelGo.transform:SetSiblingIndex(0)
		goutil.setActive(self._zeroGo, true)
		self._zeroAnim:Stop()
		self._zeroAnim:Play("ling_appear")
	elseif toSanity == -1 then
		self._negativePanelGo.transform:SetSiblingIndex(0)
		goutil.setActive(self._negativeGo, true)
		self._negativeAnim:Stop()
		self._negativeAnim:Play("fu_appear")
	else
		self._deadMarkPanelGo.transform:SetSiblingIndex(0)
		self._deadMarkAnim:Stop()
		goutil.setActive(self._deadMarkGo, true)
	end
end

function UIBattleSanity:clearSanityView()
	self:_stopAnim()
	goutil.setActive(self._positiveGo, false)
	goutil.setActive(self._zeroGo, false)
	goutil.setActive(self._negativeGo, false)
	goutil.setActive(self._deadMarkGo, false)

	self._curSanityValue = false
	self._sanityValue = false
	self._isInStrengthen = false
	self._forecastSanity = false
	self._isPreviewing = false
end

function UIBattleSanity:_killTween()
	self._timelineTask:clear()
end

function UIBattleSanity:getSanityValue()
	return self._sanityValue
end

function UIBattleSanity:setMask(isMask)
	for i, maskGo in ipairs(self._maskGoList) do
		goutil.setActive(maskGo, isMask)
	end
end

return UIBattleSanity
