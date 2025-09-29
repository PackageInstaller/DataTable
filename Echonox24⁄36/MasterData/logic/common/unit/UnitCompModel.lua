-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/common/unit/UnitCompModel.lua

module("logic.common.unit.UnitCompModel", package.seeall)

local M = class("UnitCompModel", UnitComponentBase)
local kDirectionRotateY = {
	[0] = 90,
	-90,
	180
}

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._url = nil
	self._prefabLoader = PrefabLoader.Get(unit.go)
	self._animator = nil
	self._defaultAnimState = "idle"
	self._curAnimState = nil
	self._isLoop = true
	self._isFlipX = false
	self._playSpeed = 1
	self._scale = nil
	self._transfigurationScale = nil
end

function M:setPlaySpeed(playSpeed)
	if self._playSpeed == playSpeed then
		return
	end

	self._playSpeed = playSpeed

	self:_updatePlaySpeed()
end

function M:getPlaySpeed()
	return self._playSpeed
end

function M:_updatePlaySpeed()
	if not self._animator then
		return
	end

	self._animator.speed = self._playSpeed
end

function M:setDefaultAnimState(animState)
	self._defaultAnimState = animState
end

function M:getDefaultAnimState()
	return self._defaultAnimState
end

function M:getAnimState()
	return self._curAnimState or self._defaultAnimState
end

function M:resetCurAnimState()
	self._curAnimState = nil
end

function M:getSkeletonAnimation()
	return nil
end

function M:setDirection(dir)
	local ry = kDirectionRotateY[dir] or kDirectionRotateY[2]

	if not goutil.isNil(self._traModel) and self._traModel then
		TransformUtils.SetEulerAngles(self._traModel, 0, ry, 0)
	end
end

function M:getDirection()
	if not self._isFlipX then
		return UnitSpineDir.Default
	elseif UnitSpineDir.Default == UnitSpineDir.Right then
		return UnitSpineDir.Left
	else
		return UnitSpineDir.Right
	end
end

function M:setScale(scale)
	if scale and self._scale ~= scale then
		self._scale = scale

		self:updateScale()
	end
end

function M:setTransfigurationScale(transfigurationScale)
	if transfigurationScale and self._transfigurationScale ~= transfigurationScale then
		self._transfigurationScale = transfigurationScale

		self:updateScale()
	end
end

function M:getTransfigurationScale()
	return self._transfigurationScale
end

function M:getRealScale()
	return self._transfigurationScale and self._transfigurationScale ~= 1 and self._transfigurationScale or self._scale
end

function M:updateScale()
	local realScale = self:getRealScale()

	if realScale and not goutil.isNil(self._unit.go) then
		Astral.TransformUtil.SetLocalScale(self._unit.go.transform, realScale, realScale, 1)
	end
end

function M:setBody(url)
	if self._url == url then
		return
	end

	self:clear()

	if not url then
		return
	end

	self._url = url

	self._prefabLoader:load(url, self._onBodyLoaded, self, true)
end

function M:getInst()
	return self._prefabLoader:getInst()
end

function M:_onBodyLoaded(loader)
	local roleGo = self._prefabLoader:getInst()
	local anim = roleGo:GetComponent(ComponentType.Animator)

	self._animator = anim
	self._traModel = roleGo.transform

	if self._curAnimState then
		local animState = self._curAnimState

		self._curAnimState = nil

		self:play(animState, self._isLoop)
	elseif self._defaultAnimState then
		self:play(self._defaultAnimState, self._isLoop)
	end

	self:_updatePlaySpeed()
	self:updateScale()
end

function M:play(animState, isLoop, isForceRestart)
	isLoop = isLoop or false

	if not animState then
		return
	end

	if self._isLoop == isLoop and isLoop == true and self._curAnimState == animState then
		return
	end

	if self._animator then
		if isForceRestart then
			self._animator:Play(animState, 0, 0)
		else
			self._animator:Play(animState)
		end
	end
end

function M:clear()
	if self._prefabLoader then
		self._prefabLoader:clear()
	end

	self._animator = nil
	self._url = nil
end

function M:onDestroy()
	self._prefabLoader = nil
	self._animator = nil
	self._url = nil
	self._scale = nil
	self._transfigurationScale = nil
end

return M
