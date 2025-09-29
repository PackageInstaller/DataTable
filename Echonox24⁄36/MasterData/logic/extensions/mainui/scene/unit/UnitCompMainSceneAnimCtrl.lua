-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneAnimCtrl.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneAnimCtrl", package.seeall)

local M = class("UnitCompMainSceneAnimCtrl", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)
end

function M:onInit()
	self:onReset()
	self:setEvent(true)
end

function M:onDestroy()
	self:onReset()
	self:setEvent(false)
end

function M:onReset()
	self:setEvent(false)

	self._animStepLst = nil
	self._animIndex = 0
end

function M:onReuse()
	self:setEvent(true)
end

function M:getAnimStepStatusLog()
	local animState = self._animStepLst[self._animIndex] or UnitAnimState.Idle

	return string.format("[%s/%s] %s", self._animIndex, #self._animStepLst, animState)
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.AnimationEvent, self._handleAnimationEvent, self)
		GlobalDispatcher:addEventListener(EventType.MAIN_SCENE_HERO_ANIM_STEP_CTRL, self._handleMainSceneHeroAnimStepCtrl, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.AnimationEvent, self._handleAnimationEvent, self)
		GlobalDispatcher:removeEventListener(EventType.MAIN_SCENE_HERO_ANIM_STEP_CTRL, self._handleMainSceneHeroAnimStepCtrl, self)
	end
end

function M:_handleAnimationEvent(eventUid, unitActionType, eventName, animationName)
	if eventName == AnimationEventName.Complete then
		self._curPlayingState = nil

		self:_contineAnimStep()
	end
end

function M:_handleMainSceneHeroAnimStepCtrl(e, info)
	if self._unit:getHeroId() ~= info.heroId then
		return
	end

	if info.reset then
		self:resetAnimStepStr()
	else
		self:setAnimStepStr(info.animStepStr)
	end
end

function M:resetAnimStepStr()
	local point = self._unit:getPointId()
	local heroId = self._unit:getHeroId()
	local modelId = self._unit:getModelId()
	local str

	if point == MainPerformEnum.ElementPointAdjutant then
		local cfg = MainPerformConfig.instance:getLandLadyRConfig(modelId)

		str = cfg and cfg.anim or nil
	else
		local cfg = MainPerformConfig.instance:getConfigByKey(ConfigName.MainPerformHeroR, modelId)

		str = cfg and cfg.anim or nil
	end

	self:setAnimStepStr(str)
end

function M:setAnimStepStr(animStr)
	self._animStepStr = animStr
	self._animStepLst = MainScenePerformUtil.deserializeAnimStep(animStr)
end

function M:getAnimStepStr()
	return self._animStepStr
end

function M:getAnimStepLst()
	return self._animStepLst
end

function M:_contineAnimStep()
	local animState
	local len = self._animStepLst and #self._animStepLst or 0

	if len > 0 then
		self._animIndex = self._animIndex + 1

		if self._animIndex > #self._animStepLst then
			self._animIndex = 1

			self:setAnimStepStr(self._animStepStr)
		end

		animState = self._animStepLst[self._animIndex]
	end

	animState = animState or self._unit.meshModel:getAnimStateWithPrefix(UnitAnimState.MainSceneIdle)

	local isSpAniState = not string.match(animState, UnitAnimState.MainSceneIdle)

	self:playFullNameAni(animState, isSpAniState, false)
end

function M:playFullNameAni(animState, isSpAniState, isInterrupt)
	local mixDuration
	local forceRestart = true

	self._curPlayingState = animState

	self._unit.meshModel:playFullNameAni(animState, mixDuration, forceRestart)
end

function M:getCurPlayingAniStateFullName()
	return self._curPlayingState
end

return M
