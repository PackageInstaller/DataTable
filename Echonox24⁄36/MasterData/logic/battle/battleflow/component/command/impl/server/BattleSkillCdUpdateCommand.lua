-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSkillCdUpdateCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSkillCdUpdateCommand", package.seeall)

local BattleSkillCdUpdateCommand = class("BattleSkillCdUpdateCommand", BattleCommandBase)

function BattleSkillCdUpdateCommand:parseServerCommand(cmdParser, skillCdUpdateEventNO)
	local cmd = BattleSkillCdUpdateCommand:createInstance()

	cmd:setEntityId(skillCdUpdateEventNO.entity)

	for _, skillCdNO in ipairs(skillCdUpdateEventNO.skills) do
		cmd:addFromSkillCdNO(skillCdNO)
	end

	cmdParser:addCommand(cmd)
end

function BattleSkillCdUpdateCommand:create(entityId, skillCode, cd)
	local cmd = BattleSkillCdUpdateCommand:createInstance()

	cmd:setEntityId(entityId)
	cmd:addSkillCdInfo(skillCode, cd)

	return cmd
end

function BattleSkillCdUpdateCommand:onInit()
	self._entityId = 0
	self._skillCodeList = {}
	self._skillCdList = {}
end

function BattleSkillCdUpdateCommand:onClear()
	self._entityId = 0

	BattleTableUtil.clearTable(self._skillCodeList)
	BattleTableUtil.clearTable(self._skillCdList)
end

function BattleSkillCdUpdateCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleSkillCdUpdateCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	for index, skillCode in ipairs(self._skillCodeList) do
		local skillMO = unit.skill:getActiveSkillById(skillCode)

		skillMO:setCd(self._skillCdList[index])
	end

	self:finish(true)
end

function BattleSkillCdUpdateCommand:toString()
	return string.format("[skill cd update command entityId = %s,skillCodeList = %s,cdList = %s]", self._entityId, BattleTableUtil.arrayToString(self._skillCodeList), BattleTableUtil.arrayToString(self._skillCdList))
end

function BattleSkillCdUpdateCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSkillCdUpdateCommand:addFromSkillCdNO(skillCdNO)
	table.insert(self._skillCodeList, skillCdNO.skill)
	table.insert(self._skillCdList, skillCdNO.cd)

	return self
end

function BattleSkillCdUpdateCommand:addSkillCdInfo(skillCode, cd)
	table.insert(self._skillCodeList, skillCode)
	table.insert(self._skillCdList, cd)

	return self
end

return BattleSkillCdUpdateCommand
