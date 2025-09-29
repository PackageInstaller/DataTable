-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleSnipingDrawLineCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleSnipingDrawLineCommand", package.seeall)

local BattleSnipingDrawLineCommand = class("BattleSnipingDrawLineCommand", BattleCommandBase)

function BattleSnipingDrawLineCommand:create(attackerEntityId, victimEntityId)
	local cmd = BattleSnipingDrawLineCommand:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setVictimEntityId(victimEntityId)

	return cmd
end

function BattleSnipingDrawLineCommand:onInit()
	self._attackerEntityId = false
	self._victimEntityId = false
end

function BattleSnipingDrawLineCommand:onClear()
	self._attackerEntityId = false
	self._victimEntityId = false
end

function BattleSnipingDrawLineCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local victim = unitMgr:getUnit(self._victimEntityId)
	local tx, tz = victim.mover:getPos()

	attacker.meshModel:lookAt(tx, 0, tz)
	self:_tDrawSnipingLine()
	self:finish(true)
end

function BattleSnipingDrawLineCommand:_tDrawSnipingLine()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local victim = unitMgr:getUnit(self._victimEntityId)
	local snipingDrawing = BattleMgr.instance:getSnipingDrawing()

	snipingDrawing:drawSniping(attacker, victim)
end

function BattleSnipingDrawLineCommand:toString()
	return string.format("[sniping draw line command attackerEntityId = %s,victimEntityId = %s]", self._attackerEntityId, self._victimEntityId)
end

function BattleSnipingDrawLineCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleSnipingDrawLineCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

return BattleSnipingDrawLineCommand
