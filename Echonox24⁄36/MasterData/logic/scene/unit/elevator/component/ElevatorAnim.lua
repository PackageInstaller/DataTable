-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/component/ElevatorAnim.lua

module("logic.scene.unit.elevator.component.ElevatorAnim", package.seeall)

local M = class("ElevatorAnim", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._animation = nil
	self._curAnim = nil
	self._animaTimer = nil
	self._isOpen = false
	self._animCallback = nil
	self._animTarget = nil
end

function M:onInit()
	self._animation = goutil.findChildComponent(self._unit.go, "door_anim", ComponentType.Animation)
	self._animaTimer = SchedulerCtrl.New(self._onAnimationEnd, self)
end

function M:clear()
	self._animaTimer:clear()

	self._animaTimer = nil
	self._animation = nil
	self._curAnim = nil
	self._isOpen = false
	self._animCallback = nil
	self._animTarget = nil
end

function M:isOpen()
	if self._curAnim then
		return false
	end

	return self._isOpen
end

function M:isClose()
	if self._curAnim then
		return false
	end

	return not self._isOpen
end

function M:setAnimCallback(callback, target)
	self._animCallback = callback
	self._animTarget = target
end

function M:play(animState, callback, target)
	self:setAnimCallback(callback or self._animCallback, target or self._animTarget)

	if self._curAnim then
		return
	end

	if not animState then
		return
	end

	self._curAnim = animState

	self._animation:Stop()
	self._animation:Play(animState)
	self._animaTimer:restart(1, false)
end

function M:_onAnimationEnd()
	local anim = self._curAnim

	self._isOpen = anim == SceneEnum.ElevatorAnim.Open
	self._curAnim = nil

	if self._animCallback then
		self._animCallback(self._animTarget, self._unit, anim)
	end
end

return M
