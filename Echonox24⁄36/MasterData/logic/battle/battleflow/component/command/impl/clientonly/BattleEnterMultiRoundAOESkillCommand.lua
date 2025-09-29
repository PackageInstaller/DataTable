-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleEnterMultiRoundAOESkillCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleEnterMultiRoundAOESkillCommand", package.seeall)

local BattleEnterMultiRoundAOESkillCommand = class("BattleEnterMultiRoundAOESkillCommand", BattleTimingCommandBase)

function BattleEnterMultiRoundAOESkillCommand:parseServerCommand(cmdParser, entitySteppedEventNO)
	local cmd = BattleEnterMultiRoundAOESkillCommand:createInstance()

	cmd:setEntityId(entitySteppedEventNO.entity)
	cmd:setSkillCode(entitySteppedEventNO.releasingSkill)
	cmd:setTargetEntityId(cmdParser:getParam(BattleCmdParser.Param_VictimEntityId))
	cmd:setTargetUnionIndex(cmdParser:getParam(BattleCmdParser.Param_TargetUnionIndex))

	local multiRoundAoeAdd = BattlePerformanceResultCollection:parseEventNOListForMultiRoundAoe(entitySteppedEventNO.beforeMain)

	if multiRoundAoeAdd then
		cmd:setAoeShape(multiRoundAoeAdd.aoe.shape[1])
		cmd:setAoeId(multiRoundAoeAdd.aoe.id)
	elseif enableErrorLog then
		printError("BattleEnterMultiRoundAOESkillCommand:no multiRoundAoeAdd in beforeMain")
	end

	local skillTriggeredEventNO = BattlePerformanceResultCollection:parseEventNOListForSkillTriggered(entitySteppedEventNO.beforeMain)

	if skillTriggeredEventNO then
		local multiRoundHold = BattlePerformanceResultCollection:parseEffectNOListForMultiRoundHold(skillTriggeredEventNO.effects)

		if multiRoundHold then
			for i, entityHoldNO in ipairs(multiRoundHold.entities) do
				cmd:addHoldEntity(entityHoldNO.entity, entityHoldNO.effectTimeline)
			end
		end
	end

	cmdParser:addCommand(cmd)
end

function BattleEnterMultiRoundAOESkillCommand:onInit()
	self._entityId = 0
	self._skillCode = 0
	self._targetEntityId = 0
	self._targetUnionIndex = 0
	self._shapeWithRoot = false
	self._aoeId = 0
	self._holdEntityAndTimeline = {}
end

function BattleEnterMultiRoundAOESkillCommand:onClear()
	self._entityId = 0
	self._skillCode = 0
	self._targetEntityId = 0
	self._targetUnionIndex = 0
	self._shapeWithRoot = false
	self._aoeId = 0

	BattleTableUtil.clearTable(self._holdEntityAndTimeline)
end

function BattleEnterMultiRoundAOESkillCommand:execute(battleFlow)
	local unitMgr = battleFlow.unitMgr
	local unit = unitMgr:getUnit(self._entityId)

	if not unit then
		if BattleLog.enableWarn then
			BattleLog.warn(string.format("BattleEnterMultiRoundAOESkillCommand::cannot find unit[%s]", self._entityId))
		end

		self:finish(true)

		return
	end

	local targetUnit = unitMgr:getUnit(self._targetEntityId)

	if BattleSkillTriggeredCommand:needPlayCastAnimation(unit) then
		unit.meshModel:playAndAutoIdleIfExists(UnitAnimState.Cast)
	end

	local bubbleSkillId = BattleUnitUtil.getPerformSkillId(unit, self._skillCode)

	unit.bubble:showBubble(BattleEnum.BubbleType.SKILL_TRIGGER_HINT, bubbleSkillId, BattleConst.DelayOne)

	local skillVSInfo = SkillVSInfo:createInstance()

	skillVSInfo:setAttacker(unit)
	skillVSInfo:setVictim(targetUnit)
	skillVSInfo:setSkillId(self._skillCode)
	skillVSInfo:setTargetUnionIndex(self._targetUnionIndex)
	skillVSInfo:setMultiRoundHold(self._holdEntityAndTimeline)

	local hasPerformance = SkillPerformanceMgr.instance:doPreprocessSkill(skillVSInfo, self._onPerformanceFinish, self)

	skillVSInfo:returnSelf()

	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(self._skillCode)
	local selectableTarget = skillCOWrapper:getSelectableTarget(unit.skill:getSkillStatus())

	if selectableTarget == BattleEnum.SkillSelectableTarget.POSITION then
		unit.skillAreaWarning:showFixedSkillArea(self._aoeId, self._shapeWithRoot, self._skillCode)
	else
		unit.skillAreaWarning:showFollowUnitSkillArea(self._aoeId, self._shapeWithRoot, self._skillCode, targetUnit)
	end

	if not hasPerformance then
		self:startTimer(BattleConst.DelayOne)
	end
end

function BattleEnterMultiRoundAOESkillCommand:_onPerformanceFinish()
	self:finish(true)
end

function BattleEnterMultiRoundAOESkillCommand:toString()
	return string.format("[enter multi round aoe skill command entityId = %s,skillCode = %s, targetEntityId = %s,targetUnionIndex = %s]", self._entityId, self._skillCode, tostring(self._targetEntityId), tostring(self._targetUnionIndex))
end

function BattleEnterMultiRoundAOESkillCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEnterMultiRoundAOESkillCommand:setSkillCode(skillCode)
	self._skillCode = skillCode

	return self
end

function BattleEnterMultiRoundAOESkillCommand:setTargetUnionIndex(targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex

	return self
end

function BattleEnterMultiRoundAOESkillCommand:setTargetEntityId(targetEntityId)
	self._targetEntityId = targetEntityId

	return self
end

function BattleEnterMultiRoundAOESkillCommand:setAoeShape(shapeWithRoot)
	self._shapeWithRoot = shapeWithRoot
end

function BattleEnterMultiRoundAOESkillCommand:setAoeId(aoeId)
	self._aoeId = aoeId
end

function BattleEnterMultiRoundAOESkillCommand:addHoldEntity(entityId, effectTimeline)
	self._holdEntityAndTimeline[entityId] = effectTimeline
end

return BattleEnterMultiRoundAOESkillCommand
