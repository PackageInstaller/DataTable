-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/forecast/BattleForecastMgr.lua

module("logic.battle.battleflow.component.forecast.BattleForecastMgr", package.seeall)

local BattleForecastMgr = class("BattleForecastMgr", IBattleFlowComp)
local kEmptyKeyPiece = "*"
local kForecastKeyPattern = "%s_%s_%s_%s_%s_%s"

function BattleForecastMgr:onInit()
	self._requestingQueue = Queue.create()
	self._forecastCaches = {}
	self._activeForecastResult = false
end

function BattleForecastMgr:onStart()
	self:_setEvent(true)

	self._unitMgr = self.flow.unitMgr or false
	self._haloLinks = self.flow.haloLinks or false
	self._aiForecastMgr = self.flow.aiForecastMgr or false

	self._requestingQueue:clear()
	self:clearCaches()
end

function BattleForecastMgr:onClear()
	self:_setEvent(false)
	self:clearCaches()
	self._requestingQueue:clear()

	self._unitMgr = false
	self._haloLinks = false
	self._aiForecastMgr = false
end

function BattleForecastMgr:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.ON_RECEIVE_FORECAST_PUSH, self._onForecastPush, self)
		BattleDispatcher:addEventListener(BattleEventType.OnConfirmUndo, self._onConfirmUndo, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.ON_RECEIVE_FORECAST_PUSH, self._onForecastPush, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnConfirmUndo, self._onConfirmUndo, self)
	end
end

function BattleForecastMgr:requestForecast(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	return self:_requestForecast(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
end

function BattleForecastMgr:activeForecast(forecastResult)
	if forecastResult then
		self:_switchActiveForecastResult(forecastResult)
		self._aiForecastMgr:setActiveForecastResult(forecastResult.forecastKey)
	else
		self:_switchActiveForecastResult(false)
	end
end

function BattleForecastMgr:getActiveForecastResult()
	return self._activeForecastResult
end

function BattleForecastMgr:clearCaches()
	self:_switchActiveForecastResult(false)
	BattleTableUtil.clearReusableTable(self._forecastCaches)
end

function BattleForecastMgr:_requestForecast(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)
	if not self:_isForecastAttack(entityId, skillId, targetUnionIndex, transportUnionIndex) then
		skillId = false
		isStrenthening = false
		targetUnionIndex = false
		transportUnionIndex = false
	end

	local forecastKey = self:_genForecastKey(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening)
	local forecastResult = self._forecastCaches[forecastKey]

	if forecastResult then
		if forecastResult.endReason == BattleEnum.EndReason.NORMAL then
			return forecastResult
		elseif self:_needForecastAgain(forecastResult.endReason) then
			local unitOperator = BattleMgr.instance:getUnitOperator()

			unitOperator:forecastAgainWithoutTarget()
		else
			if BattleLog.enableError then
				BattleLog.error("BattleForecastMgr::forecastResult failed，endReason", forecastResult.endReason)
			end

			return forecastResult
		end
	end

	if BattleLog.enableLog then
		BattleLog.log(string.format("BattleForecastMgr::create new forecast[%s]", forecastKey))
	end

	forecastResult = BattleForecastResult:createInstance()

	forecastResult:initBaseInfo(forecastKey, entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening)
	self._requestingQueue:enqueue(forecastKey)

	self._forecastCaches[forecastKey] = forecastResult

	self._aiForecastMgr:pushRequestAiForecast(forecastKey)
	BattleAgent.instance:sendForecastRequest(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening, lookAtDirection)

	return forecastResult
end

function BattleForecastMgr:_isForecastAttack(entityId, skillId, targetUnionIndex, transportUnionIndex)
	local isAttacked = skillId and targetUnionIndex

	if not isAttacked then
		return false
	end

	local unit = self.flow.unitMgr:getUnit(entityId)
	local skillCOWrapper = ActiveSkillConfig.instance:getActiveSkillCOWrapper(skillId)

	if skillCOWrapper:getSkillEffectType(unit.skill:getSkillStatus()) == BattleEnum.SkillPurpose.TRANSPORT then
		return transportUnionIndex
	end

	return true
end

function BattleForecastMgr:_genForecastKey(entityId, pathUnionIndexs, skillId, targetUnionIndex, transportUnionIndex, isStrenthening)
	return string.format(kForecastKeyPattern, entityId, pathUnionIndexs and BattleTableUtil.arrayToString(pathUnionIndexs) or kEmptyKeyPiece, skillId or kEmptyKeyPiece, targetUnionIndex or kEmptyKeyPiece, transportUnionIndex or kEmptyKeyPiece, isStrenthening and 1 or 0)
end

function BattleForecastMgr:_onConfirmUndo()
	self:clearCaches()
end

function BattleForecastMgr:_onForecastPush(evt, msg)
	local forecastKey = self._requestingQueue:dequeue()
	local forecastResult = self._forecastCaches[forecastKey]

	if msg.endReason ~= BattleEnum.EndReason.NORMAL then
		forecastResult.endReason = msg.endReason

		self:_tryForecastAgain(msg.endReason, forecastResult)
	end

	if msg.endReason == BattleEnum.EndReason.NORMAL and forecastResult then
		forecastResult:initFromForecastNO(msg)

		if self._activeForecastResult == forecastResult then
			self:_applyForecastResult(forecastResult)
		end
	end
end

function BattleForecastMgr:_tryForecastAgain(endReason, forecastResult)
	if not forecastResult then
		return
	end

	if self:_needForecastAgain(endReason) then
		local unitOperator = BattleMgr.instance:getUnitOperator()

		unitOperator:forecastAgainWithoutTarget()
	end
end

function BattleForecastMgr:_needForecastAgain(endReason)
	return endReason == BattleEnum.EndReason.CANNOT_RELEASE_NORMAL_SKILL or endReason == BattleEnum.EndReason.CANNOT_RELEASE_SPECIAL_OR_TRUMP_SKILL
end

function BattleForecastMgr:_switchActiveForecastResult(forecastResult)
	if self._activeForecastResult then
		self:_clearForecastResult(self._activeForecastResult)

		self._activeForecastResult = false
	end

	if forecastResult then
		self._activeForecastResult = forecastResult

		self:_applyForecastResult(forecastResult)
	end
end

function BattleForecastMgr:_applyForecastResult(forecastResult)
	if not forecastResult.isValid then
		return
	end

	local linkedHaloMOList = forecastResult.linkedHaloMOList
	local unlinkedHaloMOList = forecastResult.unlinkedHaloMOList

	for _, linkMO in ipairs(linkedHaloMOList) do
		self._haloLinks:addLink(linkMO.fromEntityId, linkMO.toEntityId, linkMO.fromSkill)
	end

	for _, linkMO in ipairs(unlinkedHaloMOList) do
		if not self._haloLinks:isInHaloRange(linkMO.fromEntityId, linkMO.toEntityId, linkMO.fromSkill) then
			self._haloLinks:removeLink(linkMO.fromEntityId, linkMO.toEntityId, linkMO.fromSkill)
		end
	end

	local cellsBlockedMOList = forecastResult.cellsBlockedMOList
	local cellsUnblockedMOList = forecastResult.cellsUnblockedMOList

	for _, cellsBlockMO in ipairs(cellsBlockedMOList) do
		cellsBlockMO:addToCellMO()
	end

	for _, cellsBlockMO in ipairs(cellsUnblockedMOList) do
		cellsBlockMO:removeFromCellMO()
	end

	self._haloLinks:updateHaloLinks()

	local entityInfo = forecastResult.attackerEntityInfo
	local unit = self._unitMgr:getUnit(entityInfo.entityId)

	if unit then
		unit.property:forecast(entityInfo)
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnForecastResultUpdate, forecastResult)
end

function BattleForecastMgr:_clearForecastResult(forecastResult)
	if not forecastResult.isValid then
		return
	end

	local linkedHaloMOList = forecastResult.unlinkedHaloMOList
	local unlinkedHaloMOList = forecastResult.linkedHaloMOList

	for _, linkMO in ipairs(linkedHaloMOList) do
		self._haloLinks:addLink(linkMO.fromEntityId, linkMO.toEntityId, linkMO.fromSkill)
	end

	for _, linkMO in ipairs(unlinkedHaloMOList) do
		self._haloLinks:removeLink(linkMO.fromEntityId, linkMO.toEntityId, linkMO.fromSkill)
	end

	local cellsBlockedMOList = forecastResult.cellsUnblockedMOList
	local cellsUnblockedMOList = forecastResult.cellsBlockedMOList

	for _, cellsBlockMO in ipairs(cellsBlockedMOList) do
		cellsBlockMO:addToCellMO()
	end

	for _, cellsBlockMO in ipairs(cellsUnblockedMOList) do
		cellsBlockMO:removeFromCellMO()
	end

	local entityInfo = forecastResult.attackerEntityInfo
	local unit = self._unitMgr:getUnit(entityInfo.entityId)

	if unit then
		unit.property:clearForecast()
	end
end

return BattleForecastMgr
