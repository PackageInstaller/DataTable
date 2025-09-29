-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleWeakPointHpChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleWeakPointHpChangedCommand", package.seeall)

local BattleWeakPointHpChangedCommand = class("BattleWeakPointHpChangedCommand", BattleCommandBase)
local kEmptyTable = {}

function BattleWeakPointHpChangedCommand:parseServerCommand(cmdParser, weakPointHpChangedNO)
	local cmd = BattleWeakPointHpChangedCommand:createInstance()

	cmd:setEntityId(weakPointHpChangedNO.entity)
	cmd:setWeakPointHp(weakPointHpChangedNO.hp)
	cmdParser:addCommand(cmd)
end

function BattleWeakPointHpChangedCommand:onInit()
	self._entityId = false
	self._weakPointHp = false
end

function BattleWeakPointHpChangedCommand:onClear(interrupt)
	self._entityId = false
	self._weakPointHp = false
end

function BattleWeakPointHpChangedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleWeakPointHpChangedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:setWeakPointHp(self._weakPointHp)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	self:finish(true)
end

function BattleWeakPointHpChangedCommand:toString()
	return string.format("[weak point hp changed command entityId = %s,weakPointHp = %s]", self._entityId, self._weakPointHp)
end

function BattleWeakPointHpChangedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleWeakPointHpChangedCommand:setWeakPointHp(weakPointHp)
	self._weakPointHp = weakPointHp

	return self
end

return BattleWeakPointHpChangedCommand
