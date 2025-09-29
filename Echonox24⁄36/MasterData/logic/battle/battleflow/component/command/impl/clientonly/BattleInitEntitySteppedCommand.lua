-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleInitEntitySteppedCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleInitEntitySteppedCommand", package.seeall)

local BattleInitEntitySteppedCommand = class("BattleInitEntitySteppedCommand", BattleCommandBase)

function BattleInitEntitySteppedCommand:parseServerCommand(cmdParser, entitySteppedEventNO)
	local cmd = BattleInitEntitySteppedCommand:createInstance()

	cmd:setAttackerEntityId(entitySteppedEventNO.entity)
	cmd:setStrenthening(entitySteppedEventNO.strengthening)
	cmdParser:addCommand(cmd)
end

function BattleInitEntitySteppedCommand:onInit()
	self._attackerEntityId = false
	self._isStrenthening = false
end

function BattleInitEntitySteppedCommand:onClear(interrupt)
	self._attackerEntityId = false
	self._isStrenthening = false
end

function BattleInitEntitySteppedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._attackerEntityId)

	unit.skill:setSkillStatus(self._isStrenthening and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal)
	self:finish(true)
end

function BattleInitEntitySteppedCommand:toString()
	return string.format("[init entity stepped context,attackerEntityId = %s,isStrenthening = %s]", tostring(self._attackerEntityId), tostring(self.isStrenthening))
end

function BattleInitEntitySteppedCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleInitEntitySteppedCommand:setStrenthening(isStrenthening)
	self._isStrenthening = isStrenthening

	return self
end

return BattleInitEntitySteppedCommand
