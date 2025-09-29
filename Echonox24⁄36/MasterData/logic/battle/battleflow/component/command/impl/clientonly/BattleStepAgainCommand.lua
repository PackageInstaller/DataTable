-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleStepAgainCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleStepAgainCommand", package.seeall)

local BattleStepAgainCommand = class("BattleStepAgainCommand", BattleCommandBase)

function BattleStepAgainCommand:create(entityId)
	local cmd = BattleStepAgainCommand:createInstance()

	cmd:setEntityId(entityId)

	return cmd
end

function BattleStepAgainCommand:onInit()
	self._entityId = 0
end

function BattleStepAgainCommand:onClear()
	self._entityId = 0
end

function BattleStepAgainCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local campOperator = battleFlow.campOperator
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleStepAgainCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	unit.property:inactiveState(BattleEnum.State.STEPPED)
	unit.stateEffect:refreshStateEffect()

	if campOperator:isOperatableUnit(unit) then
		unit.sign:setOperatableSignVisible(true)
		campOperator:setNextOperateEntityId(self._entityId)
	end

	self:finish(true)
end

function BattleStepAgainCommand:toString()
	return string.format("[step agin command entityId = %s]", self._entityId)
end

function BattleStepAgainCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

return BattleStepAgainCommand
