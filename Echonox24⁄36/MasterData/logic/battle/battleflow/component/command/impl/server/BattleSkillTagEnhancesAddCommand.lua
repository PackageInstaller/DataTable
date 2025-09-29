-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleSkillTagEnhancesAddCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleSkillTagEnhancesAddCommand", package.seeall)

local M = class("BattleSkillTagEnhancesAddCommand", BattleCommandBase)

function M:parseServerCommand(cmdParser, TagEnhanceAddNO)
	local cmd = M:createInstance()

	cmd:setEnhanceEntity(TagEnhanceAddNO.entity)
	cmd:setEnhanceContexts(TagEnhanceAddNO.contexts)
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
			BattleLog.warn(string.format("BattleSkillTagEnhancesAddCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.skill:addTagEnhances(self._contexts)
	self:finish(true)
end

function M:toString()
	return string.format("[BattleSkillTagEnhancesAddCommand entityId = %s]", self._entityId)
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
