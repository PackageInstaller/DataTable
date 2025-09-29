-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleDrawSelectTargetCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleDrawSelectTargetCommand", package.seeall)

local BattleDrawSelectTargetCommand = class("BattleDrawSelectTargetCommand", BattleTimingCommandBase)

function BattleDrawSelectTargetCommand:create(targetUnionIndex)
	local cmd = BattleDrawSelectTargetCommand:createInstance()

	cmd:setTargetUnionIndex(targetUnionIndex)

	return cmd
end

function BattleDrawSelectTargetCommand:onInit()
	self._targetUnionIndex = 0
end

function BattleDrawSelectTargetCommand:onClear()
	self._targetUnionIndex = 0
end

function BattleDrawSelectTargetCommand:execute(battleFlow)
	local pathArrow = battleFlow.pathArrow

	pathArrow:showTargetSign(self._targetUnionIndex)
	self:startTimer(0)
end

function BattleDrawSelectTargetCommand:setTargetUnionIndex(targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex

	return self
end

function BattleDrawSelectTargetCommand:toString()
	return string.format("[draw select target command targetUnionIndex = %s]", self._targetUnionIndex)
end

return BattleDrawSelectTargetCommand
