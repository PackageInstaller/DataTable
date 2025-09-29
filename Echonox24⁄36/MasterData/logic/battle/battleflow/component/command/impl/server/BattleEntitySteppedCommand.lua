-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEntitySteppedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEntitySteppedCommand", package.seeall)

local BattleEntitySteppedCommand = class("BattleEntitySteppedCommand", BattleTimingCommandBase)

function BattleEntitySteppedCommand:parseServerCommand(cmdParser, entitySteppedEventNO)
	local isAttacked = entitySteppedEventNO:HasField("target")
	local entityId = entitySteppedEventNO.entity
	local skillId = entitySteppedEventNO.releasingSkill
	local targetUnionIndex = BoardIndexConverter.cellNOToUnionIndex(entitySteppedEventNO.target)
	local isStrengthening = entitySteppedEventNO.strengthening
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)
	local targetUnit = unitMgr:getUnitOnUnionIndex(targetUnionIndex)
	local victimEntityId = targetUnit and targetUnit.property:getEntityId() or -1
	local undoMgr = BattleMgr.instance:getUndoMgr()

	undoMgr:recordEntitySteppedEvent(entitySteppedEventNO)
	cmdParser:turnOnFlag(BattleCmdParser.Flag_EntityStep)
	cmdParser:setParam(BattleCmdParser.Param_SkillCode, skillId)
	cmdParser:setParam(BattleCmdParser.Param_AttackerEntityId, entityId)

	if skillId and not BattleSkillAssist.isPositionTargetSkill(skillId, isStrengthening) then
		cmdParser:setParam(BattleCmdParser.Param_VictimEntityId, victimEntityId)
	end

	cmdParser:setParam(BattleCmdParser.Param_TargetUnionIndex, targetUnionIndex)
	cmdParser:setParam(BattleCmdParser.Param_StrengthenStatus, isStrengthening)
	cmdParser:setParam(BattleCmdParser.Param_IsMultiRound, entitySteppedEventNO:HasField("round"))
	BattleInjectSteppedContextCommand:parseServerCommand(cmdParser)
	BattleInitEntitySteppedCommand:parseServerCommand(cmdParser, entitySteppedEventNO)
	BattleEntitySteppedCommand:processEntityMove(cmdParser, entitySteppedEventNO)

	if isAttacked then
		cmdParser:addCommand(BattleSkillCdUpdateCommand:create(entityId, skillId, entitySteppedEventNO.skillCd))
	end

	if entitySteppedEventNO:HasField("round") then
		BattleEntitySteppedCommand:processMultiRoundSkill(cmdParser, entitySteppedEventNO)
	else
		local isNeedPerformance = isAttacked and #entitySteppedEventNO.main > 0
		local isVictimSkipPerformance = targetUnit and targetUnit.property:isStateActive(BattleEnum.State.SKIPPED_PERFORMANCE_FOR_VICITM)

		if isNeedPerformance and not isVictimSkipPerformance then
			BattleEntitySteppedCommand:processEntityGeneralSkillPerformance(cmdParser, entitySteppedEventNO, true)
		else
			BattleEntitySteppedCommand:processEntitySkippedSkillPerformance(cmdParser, entitySteppedEventNO)
		end
	end

	cmdParser:addCommand(BattleEntityStepEndedCommand:create(entityId, victimEntityId))

	local afterStepEndedCommand = cmdParser:getParam(BattleCmdParser.Param_AfterStepEndedCommand)

	if afterStepEndedCommand then
		cmdParser:addCommand(afterStepEndedCommand)
	end

	cmdParser:addCommand(BattleClearAllDeadUnitCommand:createInstance())
	cmdParser:turnOffFlag(BattleCmdParser.Flag_EntityStep)
	cmdParser:turnOffFlag(BattleCmdParser.Flag_AfterMain)
	cmdParser:clearParam(BattleCmdParser.Param_SkillCode)
	cmdParser:clearParam(BattleCmdParser.Param_AttackerEntityId)
	cmdParser:clearParam(BattleCmdParser.Param_VictimEntityId)
	cmdParser:clearParam(BattleCmdParser.Param_TargetUnionIndex)
	cmdParser:clearParam(BattleCmdParser.Param_AfterStepEndedCommand)
	cmdParser:clearParam(BattleCmdParser.Param_IsMultiRound)
	cmdParser:clearReusableParam(BattleCmdParser.Param_AttackerResultInfo)
	cmdParser:clearReusableParam(BattleCmdParser.Param_VictimResultInfo)
end

function BattleEntitySteppedCommand:processMultiRoundSkill(cmdParser, entitySteppedEventNO)
	local entityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local skillId = cmdParser:getParam(BattleCmdParser.Param_SkillCode)
	local isStrengthening = cmdParser:getParam(BattleCmdParser.Param_StrengthenStatus)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityId)
	local round = entitySteppedEventNO.round
	local status = entitySteppedEventNO.strengthening and BattleEnum.SkillStatus.Strenthening or BattleEnum.SkillStatus.Normal

	if round == 1 then
		BattleStrengthenPerformanceCommand:parseClientCommand(cmdParser, entityId, skillId, isStrengthening)

		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

		if ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, status) then
			cmdParser:addCommand(BattleEnterSnipingPerformance:create(entityId, victimEntityId, skillId))
			BattleEntitySteppedCommand:processEntitySkippedSkillPerformance(cmdParser, entitySteppedEventNO)
		elseif ActiveSkillCOUtil.isSkillPurposeMultiRoundAOE(skillCOWrapper, status) then
			BattleCmdUtil.processEnterForSpecialSkill(cmdParser, entityId, skillId)
			BattleEntitySteppedCommand:processEntitySkippedSkillPerformance(cmdParser, entitySteppedEventNO)
			BattleEnterMultiRoundAOESkillCommand:parseServerCommand(cmdParser, entitySteppedEventNO)
			BattleCmdUtil.processExitForSpecialSkill(cmdParser, entityId, skillId)
		else
			if BattleLog.enableError then
				BattleLog.error(string.format("unhandle type skillId = %s", skillId))
			end

			BattleEntitySteppedCommand:processEntitySkippedSkillPerformance(cmdParser, entitySteppedEventNO)
		end
	else
		local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

		if ActiveSkillCOUtil.isReleaseTypeSniping(skillCOWrapper, status) then
			BattleEntitySteppedCommand:processEntityGeneralSkillPerformance(cmdParser, entitySteppedEventNO)
			cmdParser:addCommand(BattleExitSnipingPerformance:create(entityId, victimEntityId, skillId))
		elseif ActiveSkillCOUtil.isSkillPurposeMultiRoundAOE(skillCOWrapper, status) then
			cmdParser:addCommand(BattleExitMultiRoundAOESkillCommand:create(entityId))
			BattleEntitySteppedCommand:processEntityGeneralSkillPerformance(cmdParser, entitySteppedEventNO)
		else
			if BattleLog.enableError then
				BattleLog.error(string.format("unhandle type skillId = %s", skillId))
			end

			BattleEntitySteppedCommand:processEntityGeneralSkillPerformance(cmdParser, entitySteppedEventNO)
		end
	end
end

function BattleEntitySteppedCommand:calculateEntitiesResultStatus(cmdParser, entitySteppedEventNO)
	local attackerEntityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local attackerEntityInfo = BattleEntityInfo:createInstance()
	local victimEntityInfo = BattleEntityInfo:createInstance()

	attackerEntityInfo.entityId = attackerEntityId
	victimEntityInfo.entityId = victimEntityId

	self:parseResult2EntityInfo(entitySteppedEventNO.beforeMain, attackerEntityInfo, victimEntityInfo)
	self:parseResult2EntityInfo(entitySteppedEventNO.main, attackerEntityInfo, victimEntityInfo)
	self:parseResult2EntityInfo(entitySteppedEventNO.afterMain, attackerEntityInfo, victimEntityInfo)
	cmdParser:setParam(BattleCmdParser.Param_AttackerResultInfo, attackerEntityInfo)
	cmdParser:setParam(BattleCmdParser.Param_VictimResultInfo, victimEntityInfo)
end

function BattleEntitySteppedCommand:parseResult2EntityInfo(eventNOList, attackerEntityInfo, victimEntityInfo)
	for _, entityNO in ipairs(eventNOList) do
		if entityNO:HasField(BattleCmdUtil.cmd_attributeModified) then
			local attributeNO = entityNO.attributeModified

			if attributeNO.entity == attackerEntityInfo.entityId then
				attackerEntityInfo:addAttribute(attributeNO.attr, BattleMathUtil.removePrecision(attributeNO.value))
			elseif attributeNO.entity == victimEntityInfo.entityId then
				victimEntityInfo:addAttribute(attributeNO.attr, BattleMathUtil.removePrecision(attributeNO.value))
			end
		end
	end
end

function BattleEntitySteppedCommand:processEntityMove(cmdParser, entitySteppedEventNO)
	local isMoved = BattleMoveCommand:isMoved(entitySteppedEventNO.moved)
	local isAttacked = entitySteppedEventNO:HasField("target")
	local entityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local skillId = cmdParser:getParam(BattleCmdParser.Param_SkillCode)
	local targetUnionIndex = entitySteppedEventNO:HasField("target") and BoardIndexConverter.cellNOToUnionIndex(entitySteppedEventNO.target)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entitySteppedEventNO.entity)
	local isManual = unit.property:isStateActive(BattleEnum.State.MANUAL)

	if isManual then
		cmdParser:addCommand(BattleClearEntityStepSignsCommand:create(entityId))

		if isMoved then
			BattleMoveCommand:parseServerCommand(cmdParser, entitySteppedEventNO.moved)
		end

		if isAttacked then
			BattleAdjustUnitDirectionCommand:parseServerCommand(cmdParser, entitySteppedEventNO.turn)
		end
	else
		local cmd = BattleEntitySteppedCommand:createInstance()

		cmd:setEntityId(entityId)
		cmd:setSkillId(skillId)
		cmd:setTargetUnionIndex(targetUnionIndex)
		cmdParser:addCommand(cmd)
		cmdParser:addCommand(BattleCheckFrozenCommand:create(entityId))
		cmdParser:addCommand(BattleAdjustCameraInMoveAndAttackCommand:createByCommand(entitySteppedEventNO.moved, targetUnionIndex, entityId))

		if isMoved then
			BattleMoveCommand:parseServerCommand(cmdParser, entitySteppedEventNO.moved, targetUnionIndex)
		end

		if isAttacked then
			BattleAdjustUnitDirectionCommand:parseServerCommand(cmdParser, entitySteppedEventNO.turn)
		end

		cmdParser:addCommand(BattleClearEntityStepSignsCommand:create(entityId))
	end
end

function BattleEntitySteppedCommand:processEntityGeneralSkillPerformance(cmdParser, entitySteppedEventNO, notMultiRound)
	local entityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)
	local targetUnionIndex = cmdParser:getParam(BattleCmdParser.Param_TargetUnionIndex)
	local skillId = cmdParser:getParam(BattleCmdParser.Param_SkillCode)
	local isStrengthening = cmdParser:getParam(BattleCmdParser.Param_StrengthenStatus)

	if not victimEntityId and not BattleSkillAssist.isPositionTargetSkill(skillId, isStrengthening) then
		if BattleLog.enableError then
			BattleLog.error(string.format("Cannot find victimEntityId on cell [%s]", victimEntityId))
		end

		return
	end

	if not BattleUnitUtil.isSameOfOperateCamp(entityId) then
		cmdParser:addCommand(BattleAdjustFollowCenterCommand:create(entityId, victimEntityId))
	end

	local damageCountCommand = BattleStepDamageCountCommand:create()

	BattleCmdUtil.parseServerCommandBatch(cmdParser, entitySteppedEventNO.beforeMain)

	if notMultiRound then
		BattleStrengthenPerformanceCommand:parseClientCommand(cmdParser, entityId, skillId, isStrengthening)
	end

	local mainSkillTriggeredEventNOList = BattleTableUtil.getTempList()
	local mainTriggeringEventNOList = BattleTableUtil.getTempList()

	BattleEntitySteppedCommand:_splitMainSkillTriggerAndTriggering(entitySteppedEventNO.main, mainSkillTriggeredEventNOList, mainTriggeringEventNOList)

	local mainPerformanceResultCollection = BattlePerformanceResultCollection:createInstance()

	BattleEnterPerformanceCommand:parseClientCommand(cmdParser, mainSkillTriggeredEventNOList, entitySteppedEventNO.entity, victimEntityId, skillId, targetUnionIndex, entitySteppedEventNO.strengthening)
	BattleEntitySteppedCommand:parseServerSteppedMain(cmdParser, mainSkillTriggeredEventNOList, mainPerformanceResultCollection)
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, mainPerformanceResultCollection.hpChangedList))
	cmdParser:addCommand(BattleExitPerformanceCommand:createInstance())
	BattleTotalChangedHpCommand:parseServerCommand(cmdParser, mainSkillTriggeredEventNOList)
	cmdParser:turnOnFlag(BattleCmdParser.Flag_AfterMain)

	local afterMainPerformanceResultCollection = BattlePerformanceResultCollection:createInstance()

	afterMainPerformanceResultCollection:parseEventNOList(entitySteppedEventNO.afterMain)
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, mainPerformanceResultCollection.specialPropertyModifiedList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, afterMainPerformanceResultCollection.hpChangedList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, afterMainPerformanceResultCollection.specialPropertyModifiedList))
	BattleCmdUtil.parseServerCommandBatch(cmdParser, mainPerformanceResultCollection.weakPointBrokenList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, mainPerformanceResultCollection.normalList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, mainPerformanceResultCollection.tagEventList)
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, mainPerformanceResultCollection.buffRemovedList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, mainPerformanceResultCollection.triggeringList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, mainPerformanceResultCollection.entityDeadList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, mainTriggeringEventNOList))
	BattleCmdUtil.parseServerCommandBatch(cmdParser, afterMainPerformanceResultCollection.weakPointBrokenList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, afterMainPerformanceResultCollection.normalList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, afterMainPerformanceResultCollection.tagEventList)
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, afterMainPerformanceResultCollection.buffRemovedList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, afterMainPerformanceResultCollection.entityDeadList))
	cmdParser:addCommand(BattleParallelCommand:create(cmdParser, afterMainPerformanceResultCollection.triggeringList))
	BattleCmdUtil.parseServerCommandBatch(cmdParser, mainPerformanceResultCollection.afterPerformanceList)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, afterMainPerformanceResultCollection.afterPerformanceList)
	cmdParser:addCommand(damageCountCommand)
	BattleTableUtil.releaseTempList(mainSkillTriggeredEventNOList)
	BattleTableUtil.releaseTempList(mainTriggeringEventNOList)
	mainPerformanceResultCollection:returnSelf()
	afterMainPerformanceResultCollection:returnSelf()
end

function BattleEntitySteppedCommand:_splitMainSkillTriggerAndTriggering(mainEventNOList, outSkillTriggeredList, outTriggeringList)
	for _, eventNO in ipairs(mainEventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_skillTriggered) then
			table.insert(outSkillTriggeredList, eventNO)
		elseif BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_triggering) then
			table.insert(outTriggeringList, eventNO)
		elseif BattleLog.enableError then
			BattleLog.error("unhandle main event")
		end
	end
end

function BattleEntitySteppedCommand:processEntitySkippedSkillPerformance(cmdParser, entitySteppedEventNO)
	local entityId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)

	if BattleCmdUtil.containsTriggerEffect(entitySteppedEventNO.beforeMain) or BattleCmdUtil.containsTriggerEffect(entitySteppedEventNO.main) or BattleCmdUtil.containsTriggerEffect(entitySteppedEventNO.afterMain) then
		cmdParser:addCommand(BattleAdjustFollowCenterCommand:create(entityId, victimEntityId))
	end

	BattleCmdUtil.parseServerCommandBatch(cmdParser, entitySteppedEventNO.beforeMain)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, entitySteppedEventNO.main)
	cmdParser:turnOnFlag(BattleCmdParser.Flag_AfterMain)
	BattleCmdUtil.parseServerCommandBatch(cmdParser, entitySteppedEventNO.afterMain)
end

function BattleEntitySteppedCommand:parseServerSteppedMain(cmdParser, eventNOList, mainPerformanceResultCollection)
	cmdParser:setParam(BattleCmdParser.Param_IsMainHappened, false)

	local isMultiRoundAOE = cmdParser:getParam(BattleCmdParser.Param_IsMultiRound)

	if isMultiRoundAOE and #eventNOList <= 0 then
		BattleSkillPerformanceCommand:parseEmptyCommand(cmdParser)

		return
	end

	local continuousSkillTriggerEvents = BattleTableUtil.getTempList()
	local lastSkillTriggeredEvent = false

	for _, eventNO in ipairs(eventNOList) do
		if BattleCmdUtil.hasField(eventNO, BattleCmdUtil.cmd_skillTriggered) then
			local newSkillTriggeredEvent = eventNO.skillTriggered

			if BattleEntitySteppedCommand:_checkStartContinuousSkillTrigger(newSkillTriggeredEvent, lastSkillTriggeredEvent) then
				BattleEntitySteppedCommand:_processContinuousSkillTriggerEvents(cmdParser, continuousSkillTriggerEvents, mainPerformanceResultCollection)

				lastSkillTriggeredEvent = newSkillTriggeredEvent

				BattleTableUtil.clearTable(continuousSkillTriggerEvents)
			end

			table.insert(continuousSkillTriggerEvents, newSkillTriggeredEvent)
		elseif BattleLog.enableError then
			BattleLog.error(string.format("unexpected EventNO[%s]", tostring(eventNO)))
		end
	end

	if #continuousSkillTriggerEvents > 0 then
		BattleEntitySteppedCommand:_processContinuousSkillTriggerEvents(cmdParser, continuousSkillTriggerEvents, mainPerformanceResultCollection)
		BattleTableUtil.clearTable(continuousSkillTriggerEvents)
	end

	BattleTableUtil.releaseTempList(continuousSkillTriggerEvents)
end

function BattleEntitySteppedCommand:_processContinuousSkillTriggerEvents(cmdParser, skillTriggeredEventList, mainPerformanceResultCollection)
	local totalContinuousSkillTriggerCount = #skillTriggeredEventList

	if totalContinuousSkillTriggerCount <= 0 then
		return
	end

	local firstSkillTriggeredEvent = skillTriggeredEventList[1]
	local continuousType, maxContinuousCount = BattleEntitySteppedCommand:_calculateContinuousTypeAndMaxContinuousCount(firstSkillTriggeredEvent)

	if continuousType == BattleEnum.SkillContinuousType.NORMAL then
		for index, skillTriggeredEvent in ipairs(skillTriggeredEventList) do
			BattleEntitySteppedCommand:_parseNormalSkillTrigger(cmdParser, skillTriggeredEvent, mainPerformanceResultCollection, continuousType, index, totalContinuousSkillTriggerCount)
		end
	elseif continuousType == BattleEnum.SkillContinuousType.MUTI_TIMELINE then
		local mergedSkillTriggerEvents = BattleTableUtil.getTempList()
		local currentProcessIndex = 0

		while currentProcessIndex < totalContinuousSkillTriggerCount do
			currentProcessIndex = currentProcessIndex + 1

			table.insert(mergedSkillTriggerEvents, skillTriggeredEventList[currentProcessIndex])

			if maxContinuousCount <= #mergedSkillTriggerEvents then
				BattleEntitySteppedCommand:_mergeContinuousSkillTrigger(cmdParser, mergedSkillTriggerEvents, mainPerformanceResultCollection, continuousType, currentProcessIndex, totalContinuousSkillTriggerCount)
				BattleTableUtil.clearTable(mergedSkillTriggerEvents)
			end
		end

		if #mergedSkillTriggerEvents > 0 then
			BattleEntitySteppedCommand:_mergeContinuousSkillTrigger(cmdParser, mergedSkillTriggerEvents, mainPerformanceResultCollection, continuousType, currentProcessIndex, totalContinuousSkillTriggerCount)
		end

		BattleTableUtil.releaseTempList(mergedSkillTriggerEvents)
	elseif continuousType == BattleEnum.SkillContinuousType.LOOP_TIMELINE then
		local fromContinuousSkillTriggerIndex = totalContinuousSkillTriggerCount

		BattleEntitySteppedCommand:_mergeContinuousSkillTrigger(cmdParser, skillTriggeredEventList, mainPerformanceResultCollection, continuousType, fromContinuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
	else
		if BattleLog.enableError then
			BattleLog.error("unhandle continuousType", continuousType)
		end

		for index, skillTriggeredEvent in ipairs(skillTriggeredEventList) do
			BattleEntitySteppedCommand:_parseNormalSkillTrigger(cmdParser, skillTriggeredEvent, mainPerformanceResultCollection, continuousType, index, totalContinuousSkillTriggerCount)
		end
	end
end

function BattleEntitySteppedCommand:_calculateContinuousTypeAndMaxContinuousCount(skillTriggeredEvent)
	if skillTriggeredEvent.attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE then
		return BattleUnitUtil.getChaseStageTypeAndCount(skillTriggeredEvent.entity)
	end

	return 0, 0
end

function BattleEntitySteppedCommand:_checkStartContinuousSkillTrigger(newSkillTriggeredEvent, lastSkillTriggeredEvent)
	if not lastSkillTriggeredEvent then
		return true
	end

	if newSkillTriggeredEvent.attackingDirection ~= lastSkillTriggeredEvent.attackingDirection or newSkillTriggeredEvent.entity ~= lastSkillTriggeredEvent.entity then
		return true
	end

	return false
end

function BattleEntitySteppedCommand:_mergeContinuousSkillTrigger(cmdParser, skillTriggeredEventList, mainPerformanceResultCollection, continuousType, continuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
	BattleSkillPerformanceCommand:parseMergedServerCommand(cmdParser, skillTriggeredEventList, mainPerformanceResultCollection, continuousType, continuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
end

function BattleEntitySteppedCommand:_parseNormalSkillTrigger(cmdParser, skillTriggeredEvent, mainPerformanceResultCollection, continuousType, continuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
	BattleSkillPerformanceCommand:parseServerCommand(cmdParser, skillTriggeredEvent, mainPerformanceResultCollection, continuousType, continuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
end

function BattleEntitySteppedCommand:onInit()
	self._entityId = false
	self._skillId = false
	self._targetUnionIndex = false
end

function BattleEntitySteppedCommand:onClear()
	self._entityId = false
	self._skillId = false
	self._targetUnionIndex = false
end

function BattleEntitySteppedCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local pathFinder = battleFlow.pathFinder
	local pathArrow = battleFlow.pathArrow
	local boardMgr = battleFlow.boardMgr
	local unit = unitMgr:getUnit(self._entityId)
	local isSkippedStep = unit.property:isStateActive(BattleEnum.State.SKIPPED_STEP)

	if isSkippedStep then
		local position = BattleUnitUtil.getBattleFocusPos(unit)
		local cameraFocusDuration = BattleConst.judgeCameraFocusTime(position.x, position.y, position.z)

		BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, cameraFocusDuration)
		self:startTimer(cameraFocusDuration * BattleTime.timeScale + 0.1)

		return
	end

	unit.meshModelMover:playMappedAnimationIfExists(UnitAnimState.React)

	local position = BattleUnitUtil.getBattleFocusPos(unit)
	local cameraFocusDuration = BattleConst.judgeCameraFocusTime(position.x, position.y, position.z)

	BattleCameraUtil.doFollowPosition(position.x, position.y, position.z, cameraFocusDuration)
	self:startTimer(cameraFocusDuration * BattleTime.timeScale + 0.1)
end

function BattleEntitySteppedCommand:startTimer(duration)
	BattleEntitySteppedCommand.super.startTimer(self, duration)

	local scenePicker = BattleMgr.instance:getScenePicker()

	scenePicker:setIsCameraFollowing(true)
end

function BattleEntitySteppedCommand:_internalOnTimerDone()
	local scenePicker = BattleMgr.instance:getScenePicker()

	scenePicker:setIsCameraFollowing(false)
	self:finish(true)
end

function BattleEntitySteppedCommand:toString()
	return string.format("[entity step command entityId = %s,skillId = %s,targetUnionIndex = %s]", self._entityId, self._skillId, self._targetUnionIndex)
end

function BattleEntitySteppedCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleEntitySteppedCommand:setTargetUnionIndex(targetUnionIndex)
	self._targetUnionIndex = targetUnionIndex

	return self
end

function BattleEntitySteppedCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

return BattleEntitySteppedCommand
