-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEnitityConfigChangedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEnitityConfigChangedCommand", package.seeall)

local BattleEnitityConfigChangedCommand = class("BattleEnitityConfigChangedCommand", BattleCommandBase)

function BattleEnitityConfigChangedCommand:parseServerCommand(cmdParser, entityConfigChangedEventNO)
	local cmd = BattleEnitityConfigChangedCommand:createInstance()

	cmd:setEntityId(entityConfigChangedEventNO.id)
	cmd:setCareer(entityConfigChangedEventNO.career)
	cmd:setColor(entityConfigChangedEventNO.color)
	cmd:setCamp(entityConfigChangedEventNO.camp)
	cmd:setMonsterType(entityConfigChangedEventNO.monsterType)
	cmdParser:addCommand(cmd)
end

function BattleEnitityConfigChangedCommand:onInit()
	self._entityId = 0
	self._career = 0
	self._color = 0
	self._camp = 0
	self._monsterType = 0
end

function BattleEnitityConfigChangedCommand:onClear()
	self._entityId = 0
	self._career = 0
	self._color = 0
	self._camp = 0
	self._monsterType = 0
end

function BattleEnitityConfigChangedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleEnitityConfigChangedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:setCareer(self._career)
	unit.property:setColorType(self._color)
	unit.property:setFaction(self._camp)
	unit.property:setMonsterType(self._monsterType)
	unit:dispatchInnerEvent(UnitActionType.BattleAttributeUpdate)
	self:finish(true)
end

function BattleEnitityConfigChangedCommand:toString()
	return string.format("[entity config changed command entityId = %s]", self._entityId)
end

function BattleEnitityConfigChangedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEnitityConfigChangedCommand:setCareer(career)
	self._career = career

	return self
end

function BattleEnitityConfigChangedCommand:setColor(color)
	self._color = color

	return self
end

function BattleEnitityConfigChangedCommand:setCamp(camp)
	self._camp = camp

	return self
end

function BattleEnitityConfigChangedCommand:setMonsterType(monsterType)
	self._monsterType = monsterType

	return self
end

return BattleEnitityConfigChangedCommand
