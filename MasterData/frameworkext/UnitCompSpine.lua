-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/aounity-framework/Scripts/Lua/frameworkext/unit/component/spine/UnitCompSpine.lua

module("frameworkext.unit.component.spine.UnitCompSpine", package.seeall)

local UnitCompSpine = class("UnitCompSpine", UnitComponentBase)

if Spine then
	UnitCompSpine.SkeletonAnimationType = typeof(Spine.Unity.SkeletonAnimation)
end

function UnitCompSpine:ctor(unit)
	UnitCompSpine.super.ctor(self, unit)

	self._url = nil
	self._skeletonLoader = PrefabLoader.Get(unit.go)
	self._skeletonAnimation = nil
	self._defaultAnimState = "idle"
	self._curAnimState = nil
	self._isLoop = true
	self._isFlipX = false
	self._playSpeed = 1
end

function UnitCompSpine:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function UnitCompSpine:getPlaySpeed()
	return self._playSpeed
end

function UnitCompSpine:_updatePlaySpeed()
	if not self._skeletonAnimation then
		return
	end

	self._skeletonAnimation.timeScale = self._playSpeed
end

function UnitCompSpine:setDefaultAnimState(animState)
	self._defaultAnimState = animState
end

function UnitCompSpine:getDefaultAnimState()
	return self._defaultAnimState
end

function UnitCompSpine:getAnimState()
	return self._curAnimState or self._defaultAnimState
end

function UnitCompSpine:resetCurAnimState()
	self._curAnimState = nil
	self._skeletonAnimation.AnimationName = nil
end

function UnitCompSpine:getSkeletonAnimation()
	return self._skeletonAnimation
end

function UnitCompSpine:setDirection(dir)
	local isFlipX = dir ~= UnitSpineDir.Default

	if self._isFlipX == isFlipX then
		return
	end

	self._isFlipX = isFlipX

	if self._skeletonAnimation then
		self._skeletonAnimation.Skeleton.FlipX = self._isFlipX
	end
end

function UnitCompSpine:getDirection()
	if not self._isFlipX then
		return UnitSpineDir.Default
	elseif UnitSpineDir.Default == UnitSpineDir.Right then
		return UnitSpineDir.Left
	else
		return UnitSpineDir.Right
	end
end

function UnitCompSpine:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._skeletonLoader:load(url, self._onBodyLoaded, self, true)
end

function UnitCompSpine:getInst()
	return self._skeletonLoader:getInst()
end

function UnitCompSpine:_onBodyLoaded(loader)
	local skeletonGO = self._skeletonLoader:getInst()

	self._skeletonAnimation = skeletonGO:GetComponent(UnitCompSpine.SkeletonAnimationType)

	self._skeletonAnimation:Initialize(false)

	if self._skeletonAnimation.Skeleton then
		self._skeletonAnimation.Skeleton.FlipX = self._isFlipX
	end

	if self._curAnimState then
		local animState = self._curAnimState

		self._curAnimState = nil

		self:play(animState, self._isLoop)
	elseif self._defaultAnimState then
		self:play(self._defaultAnimState, self._isLoop)
	end

	self:_updatePlaySpeed()
	self.dispatch(self, UnitNotify.SpineLoaded, self)
end

function UnitCompSpine:play(animState, isLoop, isForceRestart)
	if not animState or isLoop == true and self._curAnimState == animState then
		return
	end

	self._curAnimState = animState
	self._isLoop = isLoop or false

	if self._skeletonAnimation then
		if isForceRestart then
			self._skeletonAnimation:PlayAnimation(animState, self._isLoop, true)
		else
			self._skeletonAnimation.loop = self._isLoop
			self._skeletonAnimation.AnimationName = animState
		end
	end
end

function UnitCompSpine:clear()
	self._skeletonLoader:clear()

	self._skeletonAnimation = nil
	self._url = nil
end

function UnitCompSpine:onDestroy()
	self._skeletonLoader = nil
	self._skeletonAnimation = nil
	self._url = nil
end

return UnitCompSpine
