-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSkillAddedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSkillAddedCommand", package.seeall)

local BattleSkillAddedCommand = class("BattleSkillAddedCommand", BattleCommandBase)

function BattleSkillAddedCommand:parseServerCommand(cmdParser, skillChangedEventNO)
	local cmd = BattleSkillAddedCommand:createInstance()

	cmd:setEntityId(skillChangedEventNO.entity)
	cmd:addFromSkillNO(skillChangedEventNO.skill)
	cmdParser:addCommand(cmd)
end

function BattleSkillAddedCommand:onInit()
	self._entityId = 0
	self._skillInfoList = {}
end

function BattleSkillAddedCommand:onClear()
	self._entityId = 0

	BattleTableUtil.clearReusableTable(self._skillInfoList)
end

function BattleSkillAddedCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleSkillAddedCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	for _, skillInfo in ipairs(self._skillInfoList) do
		unit.skill:addSkillFromSkillInfo(skillInfo)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_BATTLE_UNIT_SKILL_MODIFY, unit.property:getEntityCode())
	self:finish(true)
end

function BattleSkillAddedCommand:toString()
	return string.format("[skill added command entityId = %s,skillInfoList = %s]", self._entityId, BattleTableUtil.arrayToString(self._skillInfoList))
end

function BattleSkillAddedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSkillAddedCommand:addFromSkillNO(skillNO)
	local skillInfo = BattleEntityInfo.Skill:createFromSkillNO(skillNO)

	table.insert(self._skillInfoList, skillInfo)

	return self
end

return BattleSkillAddedCommand
