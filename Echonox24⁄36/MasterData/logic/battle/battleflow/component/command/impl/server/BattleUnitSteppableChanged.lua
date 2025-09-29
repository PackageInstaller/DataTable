-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleUnitSteppableChanged.lua

module("logic.battle.battleflow.component.command.impl.server.BattleUnitSteppableChanged", package.seeall)

local M = class("BattleUnitSteppableChanged", BattleCommandBase)

function M:parseServerCommand(cmdParser, eventNO)
	local cmd = M:createInstance()

	cmd:setEntityId(eventNO.entity)
	cmd:setSteppable(eventNO.steppable)
	cmdParser:addCommand(cmd)
end

function M:onInit()
	self._entityId = false
	self._steppable = false
end

function M:onClear()
	self._entityId = false
	self._steppable = false
end

function M:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("cannot find entity[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	if self._steppable then
		unit.property:inactiveState(BattleEnum.State.STEPPED)
	else
		unit.property:activeState(BattleEnum.State.STEPPED)
	end

	unit.sign:setOperatableSignVisible(self._steppable)
	unit.stateEffect:refreshStateEffect()
	self:finish(true)
end

function M:toString()
	return string.format("[BattleUnitSteppableChanged entityId = %s,steppable = %s]", self._entityId, self._steppable)
end

function M:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function M:setSteppable(steppable)
	self._steppable = steppable

	return self
end

return M
