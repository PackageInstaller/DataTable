-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/component/behavior/UnitCompAI.lua

module("logic.scene.unit.component.behavior.UnitCompAI", package.seeall)

local M = class("UnitCompAI", UnitComponentBase)

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._ai = false
	self._forbidUpdate = false
	self._stop = false
end

function M:onInit()
	M.super.onInit(self)
end

function M:onReset()
	self:destroyCurrentAI()

	self._forbidUpdate = false
	self._stop = false
end

function M:onDestroy()
	M.super.onDestroy(self)
	self:destroyCurrentAI()

	self._forbidUpdate = false
	self._stop = false

	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
end

function M:buildAI(aiConfigName)
	self._forbidUpdate = true

	AIUtil.buildAI(self._unit, aiConfigName)

	self._forbidUpdate = false
end

function M:setAI(ai)
	if ai then
		self._ai = ai
	end
end

function M:getAI()
	return self._ai
end

function M:setStop(stop)
	self._stop = stop
end

function M:stopCurrentAI()
	self:setStop(true)

	if self._ai then
		self._ai:interrupt()
	end
end

function M:restartCurrAI()
	local aiName = self:destroyCurrentAI()

	self:buildAI(aiName)
end

function M:destroyCurrentAI()
	local aiName

	self:setStop(true)

	if self._ai then
		aiName = self._ai:getName()

		self._ai:interrupt()
	end

	AIUtil.returnUnitAI(self._unit)

	self._ai = false

	self:setStop(false)

	return aiName
end

function M:update()
	if self._ai and not self._forbidUpdate and not self._stop then
		self._ai:tick()
	end
end

function M:tryStart()
	self:setStop(true)
	self._unit:addInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
end

function M:_dealAreaChange()
	self._unit:removeInnerEventListener(UnitActionType.NavMeshAreaChange, self._dealAreaChange, self)
	self:setStop(false)
end

return M
