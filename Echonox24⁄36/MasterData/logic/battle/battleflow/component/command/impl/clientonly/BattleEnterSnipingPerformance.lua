-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleEnterSnipingPerformance.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleEnterSnipingPerformance", package.seeall)

local BattleEnterSnipingPerformance = class("BattleEnterSnipingPerformance", BattleCommandBase)
local kAOEID = -9999

function BattleEnterSnipingPerformance:create(attackerEntityId, victimEntityId, skillId)
	local cmd = BattleEnterSnipingPerformance:createInstance()

	cmd:setAttackerEntityId(attackerEntityId)
	cmd:setVictimEntityId(victimEntityId)
	cmd:setSkillId(skillId)

	return cmd
end

function BattleEnterSnipingPerformance:drawAOEArea(attackerEntityId, victimEntityId, skillId)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(attackerEntityId)
	local skillMO = attacker.skill:getActiveSkillById(skillId)
	local aoeType = skillMO and skillMO:getAoeType()

	if not aoeType or aoeType == BattleEnum.AOEType.NONE then
		return
	end

	local victim = unitMgr:getUnit(victimEntityId)
	local selectableTarget = skillMO:getSelectableTarget()

	if selectableTarget == BattleEnum.SkillSelectableTarget.POSITION then
		if BattleLog.enableError then
			BattleLog.error("unhandle exception!")
		end
	else
		local shape = skillMO:generateSkillRangeShape()

		attacker.skillAreaWarning:showFollowUnitSkillAreaClient(kAOEID, shape, skillId, victim)
	end
end

function BattleEnterSnipingPerformance:getSnipingAnimationName(entityId, skillId, animaStateSuffix)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)

	if not unit then
		return animaStateSuffix
	end

	if unit.property:getModelCode() == 120107 then
		local animaState = SkillPerformanceConfig.instance:getMainSkillAnimState(skillId, unit.skill:getSkillStatus())

		return string.format("%s_%s", animaState, animaStateSuffix)
	end

	return animaStateSuffix
end

function BattleEnterSnipingPerformance:onInit()
	self._timlineTask = TimelineTask.New()
	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
	self._soloPlayer = false
end

function BattleEnterSnipingPerformance:onClear()
	if self._soloPlayer then
		self._soloPlayer:returnSelf()

		self._soloPlayer = false
	end

	self._timlineTask:clear()

	self._attackerEntityId = false
	self._victimEntityId = false
	self._skillId = false
end

function BattleEnterSnipingPerformance:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local victim = unitMgr:getUnit(self._victimEntityId)
	local tx, tz = victim.mover:getPos()

	attacker.meshModel:lookAt(tx, 0, tz)

	local aimingTime = 0
	local aimPrepare = BattleEnterSnipingPerformance:getSnipingAnimationName(self._attackerEntityId, self._skillId, UnitAnimState.AimPrepare)

	if attacker.meshModel:containsAnimation(aimPrepare) then
		local timelineResPath = SkillPerformanceConfig.instance:getSimplePerformanceTimeline(attacker.property:getModelCode(), aimPrepare)
		local url = BattleSkillAssist.getNormal3dEffectSkillUrl(timelineResPath)
		local player = SkillSimpleSoloPlayer:createInstance()

		self._soloPlayer = player

		player:setUnit(attacker)
		player:setBuildResourceListener(self._onStartPlay, self)
		player:setEventListener(self._tDrawSnipingLine, self)
		player:setFinishListener(self._onTaskFinish, self)
		player:setupAudioName(SkillPerformanceAssistant:getSkillAudioName(timelineResPath))
		player:setTimelineResPath(timelineResPath)
		player:play(url)
	else
		aimingTime = 0.2

		attacker.meshModelMover:playIdle(true)
		self._timlineTask:addFinishListener(self._onTaskFinish, self)
		self._timlineTask:addTask(aimingTime, self._tDrawSnipingLine, self)
		self._timlineTask:addTask(0.8)
		self._timlineTask:setTimeScale(BattleTime.timeScale)
		self._timlineTask:start()
	end
end

function BattleEnterSnipingPerformance:_onStartPlay()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local animState = BattleEnterSnipingPerformance:getSnipingAnimationName(self._attackerEntityId, self._skillId, UnitAnimState.Aim)

	attacker.meshModelMover:mapBusinessAnimation(UnitAnimState.Idle, animState)
	attacker.meshModelMover:mapBusinessAnimation(UnitAnimState.Idle2, animState)
	attacker.meshModelMover:mapBusinessAnimation(UnitAnimState.React, animState)
	attacker.meshModelMover:mapBusinessAnimation(UnitAnimState.Hit2, animState)
	attacker.meshModelMover:mapBusinessAnimation(UnitAnimState.Hit, animState)
end

function BattleEnterSnipingPerformance:_tDrawSnipingLine()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local attacker = unitMgr:getUnit(self._attackerEntityId)
	local victim = unitMgr:getUnit(self._victimEntityId)

	attacker.meshModelMover:playIdle(true)

	local snipingDrawing = BattleMgr.instance:getSnipingDrawing()

	snipingDrawing:drawSniping(attacker, victim)
	BattleEnterSnipingPerformance:drawAOEArea(self._attackerEntityId, self._victimEntityId, self._skillId)
end

function BattleEnterSnipingPerformance:_onTaskFinish()
	self:finish(true)
end

function BattleEnterSnipingPerformance:toString()
	return string.format("[enter sniping performance command attackerEntityId = %s,victimEntityId = %s, skillId = %s]", self._attackerEntityId, self._victimEntityId, self._skillId)
end

function BattleEnterSnipingPerformance:setAttackerEntityId(attackerEntityId)
	self._attackerEntityId = attackerEntityId

	return self
end

function BattleEnterSnipingPerformance:setVictimEntityId(victimEntityId)
	self._victimEntityId = victimEntityId

	return self
end

function BattleEnterSnipingPerformance:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleEnterSnipingPerformance
