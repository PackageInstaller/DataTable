-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleAdjustFollowCenterCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleAdjustFollowCenterCommand", package.seeall)

local BattleAdjustFollowCenterCommand = class("BattleAdjustFollowCenterCommand", BattleTimingCommandBase)

function BattleAdjustFollowCenterCommand:create(attackerEntityId, victimEntityId)
	local cmd = BattleAdjustFollowCenterCommand:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setVictimEntityId(victimEntityId)

	return cmd
end

function BattleAdjustFollowCenterCommand:calculateCenterPositionXYZ(unitA, unitB)
	local x1, y1, z1 = BattleUnitUtil.getBattleFocusPos(unitA):Get()
	local x2, y2, z2 = BattleUnitUtil.getBattleFocusPos(unitB):Get()
	local weightA = unitA.property:getMonsterType() == BattleEnum.MonsterType.BOSS and unitA.transform:isComposite() and 6 or 4
	local weightB = unitB.property:getMonsterType() == BattleEnum.MonsterType.BOSS and unitB.transform:isComposite() and 6 or 4

	return (x1 * weightA + x2 * weightB) / (weightA + weightB), (y1 * weightA + y2 * weightB) / (weightA + weightB), (z1 * weightA + z2 * weightB) / (weightA + weightB)
end

function BattleAdjustFollowCenterCommand:onInit()
	self._attackerEntityId = false
	self._victimEntityId = false
end

function BattleAdjustFollowCenterCommand:onClear()
	self._attackerEntityId = false
	self._victimEntityId = false
end

function BattleAdjustFollowCenterCommand:execute(battleFlow, runningContext)
	if runningContext:getParam(BattleCmdRunningContext.Param_CameraLocked) then
		self:finish(true)

		return
	end

	local unitMgr = battleFlow.unitMgr
	local boardMgr = battleFlow.boardMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local victim = unitMgr:getUnit(self._victimEntityId)

	attacker = attacker or victim
	victim = victim or attacker

	if not attacker or not victim then
		self:finish(true)

		return
	end

	local tox, toy, toz = BattleAdjustFollowCenterCommand:calculateCenterPositionXYZ(attacker, victim)
	local cameraFocusDuration = BattleConst.judgeCameraFocusTime(tox, toy, toz)

	cameraFocusDuration = BattleTime.getScaledTime(cameraFocusDuration)

	runningContext:setParam(BattleCmdRunningContext.Param_AdjustFollowCenterTime, cameraFocusDuration)
	BattleCameraUtil.doFollowPosition(tox, toy, toz, cameraFocusDuration)
	self:startTimer(cameraFocusDuration)
end

function BattleAdjustFollowCenterCommand:toString()
	return string.format("[adjust follow center command attackerEntityId = %s,victimEntityId = %s]", self._attackerEntityId, self._victimEntityId)
end

function BattleAdjustFollowCenterCommand:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleAdjustFollowCenterCommand:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

return BattleAdjustFollowCenterCommand
