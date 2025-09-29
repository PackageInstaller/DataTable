-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/model/BattleForecastResult.lua

module("logic.battle.battleflow.component.forecast.model.BattleForecastResult", package.seeall)

local BattleForecastResult = class("BattleForecastResult", AbstractGlobalReusable)

function BattleForecastResult:initFromForecastNO(forecastNO)
	self.isValid = true
	self.endReason = forecastNO.endReason
	self.attackerEntityInfo = self:_entityNO2EntityInfo(forecastNO.myEntity)
	self.victimEntityInfo = self:_entityNO2EntityInfo(forecastNO.targetEntity)
	self.isCritical = forecastNO.critical
	self.isImmunized = forecastNO.immunized
	self.isNear = forecastNO.near
	self.counteredNear = forecastNO.counteredNear
	self.counteredCritically = forecastNO.counteredCritically
	self.counterBeforeAttack = forecastNO.counterBeforeAttack
	self.tags = forecastNO.tags

	local secondaryTargetEntities = forecastNO.secondaryTargetEntities

	for _, entityNO in ipairs(secondaryTargetEntities) do
		table.insert(self.secondaryTargetEntityInfoList, self:_entityNO2EntityInfo(entityNO))
	end

	self:_fillForecastDefaultIfNil()

	self.isDamage = forecastNO:HasField("myDamagedValue") or forecastNO:HasField("targetDamagedValue")
	self.attackerOutputValue = forecastNO:HasField("myDamagedValue") and forecastNO.myDamagedValue or self:_getForecastEntityDeltaHp(self.victimEntityInfo)
	self.victimOutputValue = forecastNO:HasField("targetDamagedValue") and forecastNO.targetDamagedValue or self:_getForecastEntityDeltaHp(self.attackerEntityInfo)

	local haloLinkedList = forecastNO.haloLinked

	for _, haloLinkedNO in ipairs(haloLinkedList) do
		table.insert(self.linkedHaloMOList, BattleForecastHaloMO:parseFromHaloLinkedNO(haloLinkedNO))
	end

	local haloUnlinkedList = forecastNO.haloUnlinked

	for _, haloLinkedNO in ipairs(haloUnlinkedList) do
		table.insert(self.unlinkedHaloMOList, BattleForecastHaloMO:parseFromHaloLinkedNO(haloLinkedNO))
	end

	local cellsBlockedList = forecastNO.cellsBlocked

	for _, cellsBlockedEventNO in ipairs(cellsBlockedList) do
		table.insert(self.cellsBlockedMOList, BattleForecastCellsBlockMO:parseFromCellsBlockedEventNO(cellsBlockedEventNO))
	end

	local cellsUnblockedList = forecastNO.cellsUnblocked

	for _, cellsBlockedEventNO in ipairs(cellsUnblockedList) do
		table.insert(self.cellsUnblockedMOList, BattleForecastCellsBlockMO:parseFromCellsBlockedEventNO(cellsBlockedEventNO))
	end

	self.isCountered = forecastNO.countered or self.victimOutputValue > 0

	if BattleLog.enableLog then
		BattleLog.log(self:toString())
	end
end

function BattleForecastResult:initBaseInfo(forecastKey, entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening)
	self.forecastKey = forecastKey
	self.entityId = entityId
	self.pathUnionIndexs = pathUnionIndexs
	self.skillId = skillId
	self.targetUnionIndex = targetUnionIndex
	self.transportUnionIndex = transportUnionIndex
	self.isStrenthening = isStrenthening
	self.endReason = BattleEnum.EndReason.NORMAL
end

function BattleForecastResult:getForecastBaseInfo()
	return self.entityId, self.pathUnionIndexs, self.skillId, self.targetUnionIndex, self.transportUnionIndex, self.isStrenthening
end

function BattleForecastResult:hasReleaseSkill()
	return self.skillId and self.skillId > 0
end

function BattleForecastResult:_entityNO2EntityInfo(entityNO)
	local entityInfo = BattleNOConverter:entityNO2EntityInfo(entityNO)

	entityInfo:removeState(BattleEnum.State.STEPPED)

	return entityInfo
end

function BattleForecastResult:_getForecastEntityDeltaHp(entityInfo)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityInfo.entityId)

	if not unit then
		return 0
	end

	local hpCurrent = unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)
	local hpForecast = entityInfo:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP)

	return hpForecast - hpCurrent
end

function BattleForecastResult:_fillForecastDefaultIfNil()
	self:_fillForecastEntityIfNil(self.attackerEntityInfo)
	self:_fillForecastEntityIfNil(self.victimEntityInfo)

	for _, entityInfo in ipairs(self.secondaryTargetEntityInfoList) do
		self:_fillForecastEntityIfNil(entityInfo)
	end
end

function BattleForecastResult:_fillForecastEntityIfNil(entityInfo)
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnit(entityInfo.entityId)

	if not unit then
		return
	end

	entityInfo:setAttributeIfNil(BattleExtension_pb.Attribute.CURRENT_HP, unit.property:getAttribute(BattleExtension_pb.Attribute.CURRENT_HP))
	entityInfo:setAttributeIfNil(BattleExtension_pb.Attribute.MAX_HP, unit.property:getAttribute(BattleExtension_pb.Attribute.MAX_HP))
end

function BattleForecastResult:ctor()
	self.isValid = false
	self.forecastKey = false
	self.attackerEntityInfo = false
	self.victimEntityInfo = false
	self.secondaryTargetEntityInfoList = {}
	self.linkedHaloMOList = {}
	self.unlinkedHaloMOList = {}
	self.cellsBlockedMOList = {}
	self.cellsUnblockedMOList = {}
	self.skillId = false
	self.isCritical = false
	self.isImmunized = false
	self.isNear = false
	self.isCountered = false
	self.counteredNear = false
	self.counteredCritically = false
	self.counterBeforeAttack = false

	self:reuse()
end

function BattleForecastResult:reset()
	if self.attackerEntityInfo then
		self.attackerEntityInfo:returnSelf()

		self.attackerEntityInfo = false
	end

	if self.victimEntityInfo then
		self.victimEntityInfo:returnSelf()

		self.victimEntityInfo = false
	end

	BattleTableUtil.clearReusableTable(self.secondaryTargetEntityInfoList)
	BattleTableUtil.clearReusableTable(self.linkedHaloMOList)
	BattleTableUtil.clearReusableTable(self.unlinkedHaloMOList)
	BattleTableUtil.clearReusableTable(self.cellsBlockedMOList)
	BattleTableUtil.clearReusableTable(self.cellsUnblockedMOList)

	self.isValid = false
	self.forecastKey = false
	self.skillId = false
	self.isCritical = false
	self.isImmunized = false
	self.isNear = false
	self.isCountered = false
	self.counteredNear = false
	self.counteredCritically = false
	self.counterBeforeAttack = false
end

function BattleForecastResult:destroy()
	self:reset()
end

function BattleForecastResult:toString()
	local sb = StringBuffer.New()

	sb:append("forecast result::"):appendLine()
	sb:append("attacker:"):append(self.attackerEntityInfo.entityId):appendLine()
	sb:append("victim:"):append(self.victimEntityInfo.entityId):appendLine()
	sb:append("linked haloes:"):appendLine()

	for _, haloMO in pairs(self.linkedHaloMOList) do
		sb:append(haloMO:toString()):appendLine()
	end

	sb:append("unlinked haloes:"):appendLine()

	for _, haloMO in pairs(self.unlinkedHaloMOList) do
		sb:append(haloMO:toString()):appendLine()
	end

	return sb:toString()
end

return BattleForecastResult
