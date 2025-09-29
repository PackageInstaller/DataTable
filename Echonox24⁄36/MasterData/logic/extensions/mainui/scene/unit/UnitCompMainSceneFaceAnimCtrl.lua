-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mainui/scene/unit/UnitCompMainSceneFaceAnimCtrl.lua

module("logic.extensions.mainui.scene.unit.UnitCompMainSceneFaceAnimCtrl", package.seeall)

local M = class("UnitCompMainSceneFaceAnimCtrl", UnitComponentBase)

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
end

function M:onReuse()
	self:setEvent(true)
end

function M:isDestroyed()
	if self._unit then
		return self._unit:isDestroyed()
	end

	return true
end

function M:setEvent(add)
	if add then
		self._unit:addInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleHeroAniPlay, self)
	else
		self._unit:removeInnerEventListener(UnitActionType.MainSceneHeroAniPlay, self._handleHeroAniPlay, self)
	end
end

function M:_handleHeroAniPlay(eventUid, unitActionType, animState)
	self:dealFaceAnim(animState)
end

function M:_getCurStep()
	return self._step or 0
end

function M:_setCurStep(step)
	self._step = step
end

function M:dealFaceAnim(animState)
	if self:isDestroyed() then
		return
	end

	local faceAnim = animState .. "_face"

	if not self._unit.meshModel:isEqualCurAnimState(animState) then
		self:_setCurStep(MainPerformConfig.instance:getRandomHeroFaceAnimStep(self._unit:getModelId(), faceAnim))
	end

	local orgStep = self:_getCurStep()

	self:_setCurStep(self:_getCurStep() - 1)

	if self:_getCurStep() >= 0 then
		return
	end

	self:_setCurStep(MainPerformConfig.instance:getRandomHeroFaceAnimStep(self._unit:getModelId(), faceAnim))
	self:playFaceAnim(animState)
end

function M:playFaceAnim(animState)
	local animationPlayer = self._unit.meshModel:getAnimationPlayer()

	if animationPlayer and not goutil.isNil(animationPlayer) then
		local faceAnimState = animState .. "_face"

		if animationPlayer:ContainsAnimation(faceAnimState) then
			local isLoopAnim = false

			animationPlayer:PlayFaceAnimation(faceAnimState, isLoopAnim)
		end
	end
end

return M
