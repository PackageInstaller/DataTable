-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/uilib/UIBattleSkillSanity.lua

module("logic.battle.uilib.UIBattleSkillSanity", package.seeall)

local M = class("UIBattleSkillSanity")
local kRotationZ = {
	45,
	0,
	-45
}
local kTwinkleInternal = 1
local kRotation = Vector3.New(0, 0, 0)

function M:ctor(mainGO)
	self.mainGO = mainGO

	self:buildUI()
end

function M:destroy()
	self:destroyUI()

	self.mainGO = nil
end

function M:buildUI()
	self._transform = self.mainGO.transform
	self._positiveGo = goutil.findChild(self.mainGO, "zheng")
	self._zeroGo = goutil.findChild(self.mainGO, "ling")
	self._negativeGo = goutil.findChild(self.mainGO, "fu")
	self._deadMarkGo = goutil.findChild(self.mainGO, "break")
	self._sanityValue = false
	self._isStrengthen = false
	self._positiveEffect1Go = goutil.findChild(self.mainGO, "zheng/huan/default")
	self._positiveEffectBoomGo = goutil.findChild(self.mainGO, "jihuo/zheng")
	self._zeroEffect1Go = goutil.findChild(self.mainGO, "ling/huan/default")
	self._zeroEffect2Go = goutil.findChild(self.mainGO, "ling/huan/strength1")
	self._zeroEffectBoomGo = goutil.findChild(self.mainGO, "jihuo/ling")
	self._negativeEffect1Go = goutil.findChild(self.mainGO, "fu/huan/default")
	self._negativeEffect2Go = goutil.findChild(self.mainGO, "fu/huan/strength1")
	self._negativeEffectBoomGo = goutil.findChild(self.mainGO, "jihuo/fu")
	self._breakEffect2Go = goutil.findChild(self.mainGO, "break/huan/strength1")
	self._positiveEffectGo = goutil.findChild(self.mainGO, "zheng/huan")
	self._zeroEffectGo = goutil.findChild(self.mainGO, "ling/huan")
	self._negativeEffectGo = goutil.findChild(self.mainGO, "fu/huan")
	self._breakEffectGo = goutil.findChild(self.mainGO, "break/huan")
	self._txtSanityDes = goutil.findChildTextComponent(self.mainGO, "txtSan")
	self._sanityAnimList = {
		[40] = goutil.addComponentOnce(self._positiveEffect1Go, ComponentType.Animation),
		[30] = goutil.addComponentOnce(self._zeroEffect1Go, ComponentType.Animation),
		[20] = goutil.addComponentOnce(self._negativeEffect1Go, ComponentType.Animation),
		[31] = goutil.addComponentOnce(self._zeroEffect2Go, ComponentType.Animation),
		[21] = goutil.addComponentOnce(self._negativeEffect2Go, ComponentType.Animation),
		[11] = goutil.addComponentOnce(self._breakEffect2Go, ComponentType.Animation)
	}
	self._sanityIconAnimList = {
		goutil.addComponentOnce(goutil.findChild(self.mainGO, "zheng/icon"), ComponentType.Animation),
		[0] = goutil.addComponentOnce(goutil.findChild(self.mainGO, "ling/icon"), ComponentType.Animation),
		[-1] = goutil.addComponentOnce(goutil.findChild(self.mainGO, "fu/icon"), ComponentType.Animation),
		[-2] = goutil.addComponentOnce(goutil.findChild(self.mainGO, "break/icon"), ComponentType.Animation)
	}
	self._sanityAnimDescList = {
		"zheng",
		"ling",
		"fu",
		"break"
	}
	self._timelineTask = TimelineTask.New()
end

function M:destroyUI()
	self._timelineTask:clear()
	self._positiveEffectGo.transform:DOKill()
	self._zeroEffectGo.transform:DOKill()
	self._negativeEffectGo.transform:DOKill()
	self._breakEffectGo.transform:DOKill()
end

function M:setVisible(visible)
	goutil.setActive(self.mainGO, visible)
end

function M:setSanityAndStrengthen(sanityValue, isStrengthen)
	self._sanityValue = sanityValue
	self._isStrengthen = isStrengthen

	self:_setSanityView(sanityValue, isStrengthen)
end

function M:_setSanityView(sanityValue, isStrengthen)
	goutil.setActive(self._zeroEffect1Go, false)
	goutil.setActive(self._zeroEffect2Go, false)
	goutil.setActive(self._negativeEffect1Go, false)
	goutil.setActive(self._negativeEffect2Go, false)
	goutil.setActive(self._positiveGo, false)
	goutil.setActive(self._zeroGo, false)
	goutil.setActive(self._negativeGo, false)
	goutil.setActive(self._deadMarkGo, false)

	self._txtSanityDes.text = ""

	if not sanityValue then
		return
	end

	if isStrengthen then
		sanityValue = sanityValue - 1
	end

	if self._curEffectGo then
		self._curEffectGo.transform:DOKill(false)
	end

	if sanityValue == 1 then
		self._curEffectGo = self._positiveEffectGo
		self._txtSanityDes.text = lang("t_battle_skill_sanity_positive")

		goutil.setActive(self._positiveGo, true)
	elseif sanityValue == 0 then
		self._curEffectGo = self._zeroEffectGo
		self._txtSanityDes.text = lang("t_battle_skill_sanity_normal")

		goutil.setActive(self._zeroGo, true)
		goutil.setActive(self._zeroEffect1Go, not isStrengthen)
		goutil.setActive(self._zeroEffect2Go, isStrengthen)

		if isStrengthen then
			-- block empty
		end
	elseif sanityValue == -1 then
		self._txtSanityDes.text = lang("t_battle_skill_sanity_negative")
		self._curEffectGo = self._negativeEffectGo

		goutil.setActive(self._negativeGo, true)
		goutil.setActive(self._negativeEffect1Go, not isStrengthen)
		goutil.setActive(self._negativeEffect2Go, isStrengthen)

		if isStrengthen then
			-- block empty
		end
	else
		self._curEffectGo = self._breakEffectGo
		self._txtSanityDes.text = lang("t_battle_skill_sanity_leave")

		goutil.setActive(self._deadMarkGo, true)

		if isStrengthen then
			-- block empty
		end
	end

	self:_onSanityUpdate(sanityValue, isStrengthen)
end

function M:_onSanityUpdate(sanityValue, isStrengthen)
	self._curSkillIndex = self._curSkillIndex or 1

	self:_rotateSanity()

	if sanityValue > 1 or sanityValue < -2 then
		sanityValue = 1
	end

	local sanityDesc = self._sanityAnimDescList[2 - sanityValue]
	local animName

	if isStrengthen then
		animName = string.format("lizhi_%s_strength1_1", sanityDesc)
	else
		animName = string.format("lizhi_%s_default_1", sanityDesc)
	end

	local animation = self._sanityAnimList[30 + sanityValue * 10 + (isStrengthen and 1 or 0)]

	AnimationUtils.ResetAnimation(animation, animName)

	self._curAnim = animation

	if isStrengthen then
		self._sanityIconAnimList[sanityValue]:Play("battle_strenthsanity_loop")
	else
		self._sanityIconAnimList[sanityValue]:Stop()
		AnimationUtils.ResetAnimation(self._sanityIconAnimList[sanityValue], "battle_strenthsanity_loop")
	end
end

function M:_rotateSanity()
	local rotationZ = kRotationZ[self._curSkillIndex]

	Astral.TransformUtil.SetLocalRotation(self._curEffectGo.transform, 0, 0, rotationZ)
end

function M:onSkillChange(idx)
	self._timelineTask:clear()

	if not self._sanityValue then
		return
	end

	self._curSkillIndex = idx

	self._timelineTask:addTask(0, self._doSkillChangeStage1, self)
	self._timelineTask:addTask(0.27, self._doSkillChangeStage2, self)
	self._timelineTask:addFinishListener(self._onFadeFinish, self)
	self._timelineTask:start()
end

function M:_doSkillChangeStage1()
	local sanityValue = self._sanityValue
	local isStrengthen = self._isStrengthen

	if sanityValue > 1 or sanityValue < -2 then
		sanityValue = 1
	end

	local sanityDesc = self._sanityAnimDescList[2 - sanityValue]
	local animName

	if isStrengthen then
		animName = string.format("lizhi_%s_strength1_1", sanityDesc)
	else
		animName = string.format("lizhi_%s_default_1", sanityDesc)
	end

	self._curAnim:Stop()
	self._curAnim:Play(animName)
end

function M:_doSkillChangeStage2()
	self:_rotateSanity()

	local sanityValue = self._sanityValue
	local isStrengthen = self._isStrengthen

	if sanityValue > 1 or sanityValue < -2 then
		sanityValue = 1
	end

	local sanityDesc = self._sanityAnimDescList[2 - sanityValue]
	local animName

	if isStrengthen then
		animName = string.format("lizhi_%s_strength1_2", sanityDesc)
	else
		animName = string.format("lizhi_%s_default_2", sanityDesc)
	end

	self._curAnim:Stop()
	self._curAnim:Play(animName)
end

function M:_showBoomEffect(sanity)
	goutil.setActive(self._positiveEffectBoomGo, false)
	goutil.setActive(self._zeroEffectBoomGo, false)
	goutil.setActive(self._negativeEffectBoomGo, false)

	if sanity == 1 then
		goutil.setActive(self._positiveEffectBoomGo, true)
	elseif sanity == 0 then
		goutil.setActive(self._zeroEffectBoomGo, true)
	elseif sanity == -1 then
		goutil.setActive(self._negativeEffectBoomGo, true)
	end
end

function M:hideBoomEffect()
	self:_showBoomEffect(-99)
end

function M:getSanityValue()
	return self._sanityValue
end

return M
