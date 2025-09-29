-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEntityDeadCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEntityDeadCommand", package.seeall)

local BattleEntityDeadCommand = class("BattleEntityDeadCommand", BattleTimingCommandBase)

function BattleEntityDeadCommand:parseServerCommand(cmdParser, entityDeadEventNO)
	local cmd = BattleEntityDeadCommand:createInstance()

	cmd:setEntityId(entityDeadEventNO.entity)
	cmd:setDeadReason(entityDeadEventNO.reason)
	cmdParser:addCommand(cmd)
end

function BattleEntityDeadCommand:onInit()
	self._entityId = false
	self._deadReason = false
end

function BattleEntityDeadCommand:onClear()
	self._entityId = false
	self._deadReason = false
end

function BattleEntityDeadCommand:notifyEntityDead(entityId)
	BattleDispatcher:dispatchEvent(BattleEventType.OnEntityDead, entityId)
end

function BattleEntityDeadCommand:isDeadByAttackEventNO(eventNO)
	if not eventNO:HasField("entityDead") then
		return false
	end

	return self:_isDeadByAttack(eventNO.entityDead.reason)
end

function BattleEntityDeadCommand:interruptMultiSkill(unit)
	local skillId = unit.skillAreaWarning:getSkillId()

	unit.skillAreaWarning:clearSkillArea()

	if skillId and skillId ~= 1100221 then
		local entityId = unit.property:getEntityId()

		SkillPerformanceMgr.instance:interruptSpecificPerfromance(entityId, skillId)
	end
end

function BattleEntityDeadCommand:_isDeadByAttack(reason)
	return reason == BattleExtension_pb.DeadReason.HP_0_BY_ATTACK or reason == BattleExtension_pb.DeadReason.HP_0_BY_SKILL or reason == BattleExtension_pb.DeadReason.HP_0_BY_BUFF
end

function BattleEntityDeadCommand:_isDeadBySanity(reason)
	return reason == BattleExtension_pb.DeadReason.SANITY_LOW
end

function BattleEntityDeadCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("entity[%s] already dead", self._entityId))
		end

		self:finish(true)

		return
	end

	BattleEntityDeadCommand:interruptMultiSkill(unit)

	if unit.property:isStateActive(BattleEnum.State.SANITY_BROKEN) then
		self._deadReason = BattleExtension_pb.DeadReason.SANITY_LOW
	end

	BattleEntityDeadCommand:notifyEntityDead(unit.property:getEntityId())

	if unit.property:isStateActive(BattleEnum.State.DEAD_PERFORMANCED) then
		BattleUnitGenerator.removeUnit(unit)
		self:finish(true)
	elseif unit.property:isStateActive(BattleEnum.State.DEAD) then
		BattleUnitDieUtil.handleDie(unit, BattleEnum.PerformanceDeadType.FrozenDeath)
		BattleUnitGenerator.removeUnit(unit)
		self:finish(true)
	elseif self:_isDeadBySanity(self._deadReason) then
		self:_handleDieWithAnim(unit)
	elseif self:_isDeadByAttack(self._deadReason) then
		self:_handleDieWithAnim(unit)
	else
		BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_death)
		BattleUnitDieUtil.handleDie(unit, BattleEnum.PerformanceDeadType.EffectOnly)
		BattleUnitGenerator.removeUnit(unit)
		self:startTimer(BattleConst.DelayOne)
	end
end

function BattleEntityDeadCommand:_fadeUnitUI(unit)
	unit.uiProxy:doFade(true, BattleConst.DelayZeroPointFive / BattleTime.timeScale)
	unit.sceneProxy:setVisible(false)
end

function BattleEntityDeadCommand:_playSanityBreak(unit)
	unit.uiProxy:playSanityBreakAnim()
end

function BattleEntityDeadCommand:_handleDieWithAnim(unit)
	BattleAudioUtil.playVoice(unit, BattleAudioUtil.VoiceEnum.speech_death)
	BattleUnitDieUtil.handleDie(unit, BattleEnum.PerformanceDeadType.Animation, self:_isDeadBySanity(self._deadReason))
	BattleUnitGenerator.removeUnit(unit)
	self:startTimer(BattleConst.DelayTwo)
end

function BattleEntityDeadCommand:toString()
	return string.format("[entity dead command entityId = %s,deadReason = %s]", self._entityId, self._deadReason)
end

function BattleEntityDeadCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEntityDeadCommand:setDeadReason(deadReason)
	self._deadReason = deadReason

	return self
end

return BattleEntityDeadCommand
