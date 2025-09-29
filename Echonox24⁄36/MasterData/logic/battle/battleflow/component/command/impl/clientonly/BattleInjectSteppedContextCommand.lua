-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleInjectSteppedContextCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleInjectSteppedContextCommand", package.seeall)

local BattleInjectSteppedContextCommand = class("BattleInjectSteppedContextCommand", BattleCommandBase)

function BattleInjectSteppedContextCommand:parseServerCommand(cmdParser)
	local attackerEntityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local skillId = cmdParser:getParam(BattleCmdParser.Param_SkillCode)
	local cmd = BattleInjectSteppedContextCommand:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setVictimEntityId(victimEntityId)
	cmd:setSkillId(skillId)
	cmdParser:addCommand(cmd)
end

function BattleInjectSteppedContextCommand:onInit()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
end

function BattleInjectSteppedContextCommand:onClear(interrupt)
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
end

function BattleInjectSteppedContextCommand:execute(battleFlow, runningContext)
	runningContext:setParam(BattleCmdRunningContext.Param_AttackerEntityId, self._attackerEntityId)
	runningContext:setParam(BattleCmdRunningContext.Param_VictimEntityId, self._victimEntityId)
	runningContext:setParam(BattleCmdRunningContext.Param_SkillCode, self._skillId)
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityStepped, self._attackerEntityId)
	self:finish(true)
end

function BattleInjectSteppedContextCommand:toString()
	return string.format("[inject stepped context,attackerEntityId = %s,victimEntityId = %s, skillId = %s]", tostring(self._attackerEntityId), tostring(self._victimEntityId), tostring(self._skillId))
end

function BattleInjectSteppedContextCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleInjectSteppedContextCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

function BattleInjectSteppedContextCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleInjectSteppedContextCommand
