-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/clientonly/BattleSkillPerformanceCommand.lua

module("logic.battle.battleflow.component.command.impl.clientonly.BattleSkillPerformanceCommand", package.seeall)

local BattleSkillPerformanceCommand = class("BattleSkillPerformanceCommand", BattleTimingCommandBase)

function BattleSkillPerformanceCommand:parseServerCommand(cmdParser, skillTriggeredEventNO, mainPerformanceResultCollection, continuousType, continuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
	local attackSignCmd = BattleAttackSignCommand:createInstance()

	cmdParser:addCommand(attackSignCmd)

	local cmd = BattleSkillPerformanceCommand:createInstance()

	BattleSkillPerformanceCommand:parseBaseInfo(cmdParser, cmd, skillTriggeredEventNO)
	cmdParser:addCommand(cmd)

	local resultCollection = BattlePerformanceResultCollection:createInstance()

	for _, effect in ipairs(skillTriggeredEventNO.effects) do
		resultCollection:parseEventNOList(effect.events)
	end

	self:parseResultCollection(cmd, cmdParser, resultCollection, mainPerformanceResultCollection)
	cmd:setContinuousType(continuousType)
	cmd:setContinuousCount(0)
	cmd:setContinuousIndex(continuousSkillTriggerIndex)
	cmd:setTotalContinuousCount(totalContinuousSkillTriggerCount)
	resultCollection:returnSelf()
	cmd:parseForAttackSign(cmdParser, skillTriggeredEventNO, cmd, attackSignCmd)
end

function BattleSkillPerformanceCommand:parseMergedServerCommand(cmdParser, skillTriggeredEventNOList, mainPerformanceResultCollection, continuousType, continuousSkillTriggerIndex, totalContinuousSkillTriggerCount)
	if #skillTriggeredEventNOList == 0 then
		return
	end

	local attackSignCmd = BattleAttackSignCommand:createInstance()

	cmdParser:addCommand(attackSignCmd)

	local cmd = BattleSkillPerformanceCommand:createInstance()
	local firstSkillTriggeredEvent = skillTriggeredEventNOList[1]

	BattleSkillPerformanceCommand:parseBaseInfo(cmdParser, cmd, firstSkillTriggeredEvent)
	cmdParser:addCommand(cmd)

	local resultCollection = BattlePerformanceResultCollection:createInstance()

	for i, skillTriggeredEventNO in ipairs(skillTriggeredEventNOList) do
		for _, effect in ipairs(skillTriggeredEventNO.effects) do
			resultCollection:parseEventNOList(effect.events)
		end
	end

	self:parseResultCollection(cmd, cmdParser, resultCollection, mainPerformanceResultCollection)
	cmd:setContinuousType(continuousType)
	cmd:setContinuousCount(#skillTriggeredEventNOList)
	cmd:setContinuousIndex(continuousSkillTriggerIndex)
	cmd:setTotalContinuousCount(totalContinuousSkillTriggerCount)
	resultCollection:returnSelf()
	cmd:parseForAttackSign(cmdParser, firstSkillTriggeredEvent, cmd, attackSignCmd)
end

function BattleSkillPerformanceCommand:parseBaseInfo(cmdParser, cmd, skillTriggeredEventNO)
	cmd:setEntityId(skillTriggeredEventNO.entity)
	cmd:setSkillId(skillTriggeredEventNO.code)
	cmd:setIsStrengthening(skillTriggeredEventNO.strengthen)

	local attackerId = cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId)
	local isStrenthening = skillTriggeredEventNO.strengthen
	local isCountered = attackerId ~= skillTriggeredEventNO.entity

	cmd:setAnimState(isCountered and SkillPerformanceConfig.instance:getCounteredSkillAnimState(skillTriggeredEventNO.code, isStrenthening) or SkillPerformanceConfig.instance:getMainSkillAnimState(skillTriggeredEventNO.code, isStrenthening and BattleEnum.SkillStatus.Strenthening or false))
end

function BattleSkillPerformanceCommand:parseResultCollection(cmd, cmdParser, resultCollection, mainPerformanceResultCollection)
	local normalList = resultCollection.normalList

	for _, eventNO in ipairs(normalList) do
		local attackPointHandler = SkillAttackPointHandlerUtil.parseEventNO2Handler(eventNO)

		if attackPointHandler then
			cmd:addAttackPointHandler(attackPointHandler)
		else
			BattleCmdUtil.parseServerCommand(cmdParser, eventNO)
		end
	end

	local entityDeadList = resultCollection.entityDeadList

	for _, eventNO in ipairs(entityDeadList) do
		if BattleEntityDeadCommand:isDeadByAttackEventNO(eventNO) then
			cmd:addDeadEntityId(eventNO.entityDead.entity)
		end
	end

	BattleCmdUtil.parseServerCommandBatch(cmdParser, resultCollection.hpChangedList)
	table.insertto(mainPerformanceResultCollection.tagEventList, resultCollection.tagEventList)
	table.insertto(mainPerformanceResultCollection.entityDeadList, resultCollection.entityDeadList)
	table.insertto(mainPerformanceResultCollection.triggeringList, resultCollection.triggeringList)
	table.insertto(mainPerformanceResultCollection.buffRemovedList, resultCollection.buffRemovedList)
	table.insertto(mainPerformanceResultCollection.weakPointBrokenList, resultCollection.weakPointBrokenList)
	table.insertto(mainPerformanceResultCollection.afterPerformanceList, resultCollection.afterPerformanceList)
	table.insertto(mainPerformanceResultCollection.specialPropertyModifiedList, resultCollection.specialPropertyModifiedList)

	local victimEntityId = cmdParser:getParam(BattleCmdParser.Param_VictimEntityId)

	cmd:tryAddEmptyHandler(victimEntityId)
end

function BattleSkillPerformanceCommand:parseForAttackSign(cmdParser, skillTriggeredEventNO, cmd, attackSignCmd)
	local hasPriorityCounter = false
	local attackingDirection = skillTriggeredEventNO.attackingDirection

	if attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_CHASE or attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DOUBLE then
		attackSignCmd:setEntityId(skillTriggeredEventNO.entity)
		attackSignCmd:setAttackingDirection(attackingDirection)
	elseif attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_COUNTER then
		if not cmdParser:getParam(BattleCmdParser.Param_IsMainHappened) then
			hasPriorityCounter = true
		else
			local unitMgr = BattleMgr.instance:getUnitMgr()
			local attacker = unitMgr:getUnit(self._entityId)

			if attacker.property:isStateActive(BattleEnum.State.IGNORE_DISTANCE_WHEN_COUNTER) then
				local attackPointHandlers = self._attackPointHandlers
				local entityIdList = BattleTableUtil.getTempList()

				for _, attackPointHandler in ipairs(attackPointHandlers) do
					attackPointHandler:collectEntityIds(entityIdList)

					for _, entityId in ipairs(entityIdList) do
						local victim = unitMgr:getUnit(entityId)
						local skillMO = attacker.skill:getNormalSkill()

						attackSignCmd:setEntityId(skillTriggeredEventNO.entity)
						attackSignCmd:setVictimId(entityId)
						attackSignCmd:setReleaseDistance(skillMO:getReleaseDistance())
						attackSignCmd:setAttackingDirection(BattleEnum.AttackingDirection.ATTACKING_DIRECTION_DISTANCE_COUNTER)
					end
				end

				BattleTableUtil.releaseTempList(entityIdList)
			end
		end
	elseif attackingDirection == BattleEnum.AttackingDirection.ATTACKING_DIRECTION_ATTACK then
		cmdParser:setParam(BattleCmdParser.Param_IsMainHappened, true)
	end

	cmd:setAttackingDirection(attackingDirection, hasPriorityCounter)
end

function BattleSkillPerformanceCommand:parseEmptyCommand(cmdParser)
	local isStrenthening = cmdParser:getParam(BattleCmdParser.Param_StrengthenStatus)
	local skillId = cmdParser:getParam(BattleCmdParser.Param_SkillCode)
	local cmd = BattleSkillPerformanceCommand:createInstance()

	cmd:setEntityId(cmdParser:getParam(BattleCmdParser.Param_AttackerEntityId))
	cmd:setSkillId(skillId)
	cmd:setAttackingDirection(BattleEnum.AttackingDirection.ATTACKING_DIRECTION_ATTACK)
	cmd:setIsStrengthening()
	cmd:setAnimState(SkillPerformanceConfig.instance:getMainSkillAnimState(skillId, isStrenthening and BattleEnum.SkillStatus.Strenthening or false))
	cmdParser:addCommand(cmd)
end

function BattleSkillPerformanceCommand:onInit()
	self._entityId = 0
	self._skillId = 0
	self._attackingDirection = false
	self._continuousType = 0
	self._continuousCount = 0
	self._continuousIndex = false
	self._totalContinuousCount = false
	self._isStrengthening = false
	self._hasPriorityCounter = false
	self._animState = false
	self._attackPointHandlers = {}
	self._deadEntityIds = {}
end

function BattleSkillPerformanceCommand:onClear()
	self._entityId = 0
	self._skillId = 0
	self._attackingDirection = false
	self._continuousType = 0
	self._continuousCount = 0
	self._continuousIndex = false
	self._totalContinuousCount = false
	self._isStrengthening = false
	self._hasPriorityCounter = false
	self._animState = false

	BattleTableUtil.clearTable(self._attackPointHandlers)
	BattleTableUtil.clearTable(self._deadEntityIds)
end

function BattleSkillPerformanceCommand:execute(battleFlow, runningContext)
	local unitMgr = battleFlow.unitMgr
	local attacker = unitMgr:getUnit(self._entityId)

	if not attacker then
		if BattleLog.enableError then
			BattleLog.error(string.format("Cannot find unit %s", self._entityId))
		end

		self:finish(true)

		return
	end

	local attackInfo = SkillAttackInfo:createInstance()

	attackInfo:setAttacker(attacker)

	local entityIdList = BattleTableUtil.getTempList()
	local refEntityIdList = BattleTableUtil.getTempList()
	local attackPointHandlers = self._attackPointHandlers

	for _, attackPointHandler in ipairs(attackPointHandlers) do
		attackPointHandler:collectEntityIds(entityIdList)
		attackPointHandler:collectRefEntityIds(refEntityIdList)
	end

	local mainVictimEntityId = runningContext:getParam(BattleCmdRunningContext.Param_VictimEntityId)

	self:_moveMainVictimEntityIdToFirst(entityIdList, mainVictimEntityId)

	for _, entityId in ipairs(entityIdList) do
		if entityId and entityId ~= self._entityId then
			local victim = unitMgr:getUnit(entityId)

			attackInfo:addVictim(victim)
		end
	end

	for _, entityId in ipairs(refEntityIdList) do
		if entityId then
			local refUnit = unitMgr:getUnit(entityId)

			attackInfo:addRefUnit(refUnit)
		end
	end

	BattleTableUtil.releaseTempList(entityIdList)
	BattleTableUtil.releaseTempList(refEntityIdList)

	for i = #self._deadEntityIds, 1, -1 do
		local unit = unitMgr:getUnit(self._deadEntityIds[i])
		local modelCO = ModelConfig.instance:getModelConfig(unit.property:getModelCode())

		if ModelCOUtil.isLinkedModel(modelCO) then
			table.remove(self._deadEntityIds, i)
		end
	end

	attackInfo:setSkillId(self._skillId)
	attackInfo:setDeadEntityIds(self._deadEntityIds)
	attackInfo:setAttackingDirection(self._attackingDirection, self._hasPriorityCounter)

	local isStrenthening = self._isStrengthening

	attackInfo:setIsStrengthening(isStrenthening)
	attackInfo:passAttackPointHandlers(self._attackPointHandlers)
	attackInfo:setContinuousType(self._continuousType or 0)
	attackInfo:setContinuousCount(self._continuousCount or 0)
	attackInfo:setContinuousIndex(self._continuousIndex or 0)
	attackInfo:setTotalContinuousCount(self._totalContinuousCount or 0)

	local animState = BattleSkillAssist.parseAnimState(self._animState, attackInfo)

	attackInfo:setAnimState(animState)
	SkillPerformanceMgr.instance:doAttack(attackInfo, self._onAttackFinish, self)
	attackInfo:returnSelf()
end

function BattleSkillPerformanceCommand:_moveMainVictimEntityIdToFirst(entityIdList, mainVictimEntityId)
	if #entityIdList <= 1 then
		return
	end

	for index, entityId in ipairs(entityIdList) do
		if entityId == mainVictimEntityId then
			entityIdList[index] = entityIdList[1]
			entityIdList[1] = entityId

			return
		end
	end
end

function BattleSkillPerformanceCommand:_onAttackFinish()
	self:startTimer(0)
end

function BattleSkillPerformanceCommand:toString()
	return string.format("[battle skill performance command entityId = %s,skillId = %s, continuousType = %s, continuouCount = %s, continuousIndex = %s, totalContinuousCount = %s, deadEntityIds = %s]", self._entityId, self._skillId, self._continuousType, self._continuousCount, self._continuousIndex, self._totalContinuousCount, BattleTableUtil.arrayToString(self._deadEntityIds))
end

function BattleSkillPerformanceCommand:setEntityId(entityId)
	self._entityId = entityId

	return self
end

function BattleSkillPerformanceCommand:setSkillId(skillId)
	self._skillId = skillId

	return self
end

function BattleSkillPerformanceCommand:addAttackPointHandler(handler)
	table.insert(self._attackPointHandlers, handler)

	return self
end

function BattleSkillPerformanceCommand:addDeadEntityId(entityId)
	table.insert(self._deadEntityIds, entityId)

	return self
end

function BattleSkillPerformanceCommand:setAttackingDirection(attackingDirection, hasPriorityCounter)
	self._attackingDirection = attackingDirection
	self._hasPriorityCounter = hasPriorityCounter

	return self
end

function BattleSkillPerformanceCommand:setIsStrengthening(isStrengthening)
	self._isStrengthening = isStrengthening

	return self
end

function BattleSkillPerformanceCommand:setAnimState(animState)
	self._animState = animState

	return self
end

function BattleSkillPerformanceCommand:setContinuousType(type)
	self._continuousType = type

	return self
end

function BattleSkillPerformanceCommand:setContinuousCount(count)
	self._continuousCount = count

	return self
end

function BattleSkillPerformanceCommand:setContinuousIndex(continuousIndex)
	self._continuousIndex = continuousIndex

	return self
end

function BattleSkillPerformanceCommand:setTotalContinuousCount(totalContinuousCount)
	self._totalContinuousCount = totalContinuousCount

	return self
end

function BattleSkillPerformanceCommand:tryAddEmptyHandler(entityId)
	if #self._attackPointHandlers > 0 then
		return
	end

	local attackPointHandler = EmptySkillAttackPointHandler:createInstance()

	attackPointHandler:setEntityId(entityId)
	self:addAttackPointHandler(attackPointHandler)
end

return BattleSkillPerformanceCommand
