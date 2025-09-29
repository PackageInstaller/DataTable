-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSkillTagEnhancesRemoveCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSkillTagEnhancesRemoveCommand", package.seeall)

local M = class("BattleSkillTagEnhancesRemoveCommand", BattleCommandBase)

function M:parseServerCommand(cmdParser, TagEnhanceRemoveNO)
	local cmd = M:createInstance()

	cmd:setEnhanceEntity(TagEnhanceRemoveNO.entity)
	cmd:setEnhanceContexts(TagEnhanceRemoveNO.contexts)
	cmdParser:addCommand(cmd)
end

function M:onInit()
	self._entityId = 0
	self._contexts = false
end

function M:onClear()
	self._entityId = 0
	self._contexts = false
end

function M:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleSkillTagEnhancesRemoveCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.skill:removeTagEnhances(self._contexts)
	self:finish(true)
end

function M:toString()
	return string.format("[BattleSkillTagEnhancesRemoveCommand entityId = %s]", self._entityId)
end

function M:setEnhanceEntity(entityId)
	self._entityId = entityId

	return self
end

function M:setEnhanceContexts(contexts)
	self._contexts = contexts

	return self
end

return M
