-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/operator/BattleCampOperator.lua

module("logic.battle.battleflow.component.operator.BattleCampOperator", package.seeall)

local BattleCampOperator = class("BattleCampOperator", IBattleFlowComp)
local kLocalSettingKey = "BattleCampOperator"

function BattleCampOperator:onInit()
	self._operateCampId = false
end

function BattleCampOperator:onStart()
	self:_setEvent(true)

	self._settingModel = self.flow.settingModel or false
	self._model = self.flow.model or false
	self._unitOperator = self.flow.unitOperator or false
	self._unitMgr = self.flow.unitMgr or false
	self._localLogic = self.flow.localLogic or false
	self._netAgent = self.flow.netAgent or false
	self._lastOperateEntityId = false
end

function BattleCampOperator:onClear()
	self:_setEvent(false)

	self._operateCampId = false
	self._settingModel = false
	self._unitOperator = false
	self._localLogic = false
	self._unitMgr = false
	self._netAgent = false
end

function BattleCampOperator:_setEvent(add)
	if add then
		BattleDispatcher:addEventListener(BattleEventType.OnBeforeEndStageRequest, self._onBeforeEndStageRequest, self)
		BattleDispatcher:addEventListener(BattleEventType.OnBattleAutoModeUpdate, self._onAutoModeUpdate, self)
		BattleDispatcher:addEventListener(BattleEventType.OnForceOperate, self._onForceOperate, self)
	else
		BattleDispatcher:removeEventListener(BattleEventType.OnBeforeEndStageRequest, self._onBeforeEndStageRequest, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnBattleAutoModeUpdate, self._onAutoModeUpdate, self)
		BattleDispatcher:removeEventListener(BattleEventType.OnForceOperate, self._onForceOperate, self)
	end
end

function BattleCampOperator:beginOperateCamp(campId)
	self._operateCampId = campId
end

function BattleCampOperator:endOperateCamp()
	self._operateCampId = false
	self._lastOperateEntityId = false
end

function BattleCampOperator:tryOperateNextUnit()
	if self._settingModel:isAutoBattle() or self._model:isProxyMode() then
		if BattleLog.enableLog then
			BattleLog.log("current is in auto or proxy mode, skip one operation.")
		end

		return
	end

	self:_operateNextUnit()
end

function BattleCampOperator:getNextOperatableUnit()
	return self:_getNextOperatableUnit()
end

function BattleCampOperator:isOperatableUnit(unit)
	if not unit then
		return false
	end

	if unit:isDestroyed() then
		return false
	end

	if unit.property:isStateActive(BattleEnum.State.DEAD) then
		return false
	end

	if unit.property:isStateActive(BattleEnum.State.STEPPED) then
		return false
	end

	if not unit.property:isFlagEnable(BattleUnitFlagMask.FlagStepable) then
		return false
	end

	if not unit.property:checkStateOperatable() then
		return false
	end

	return self._operateCampId == unit.property:getCampId()
end

function BattleCampOperator:setNextOperateEntityId(id)
	self._nextOperatableEntityId = id
end

function BattleCampOperator:_onAutoModeUpdate()
	if self._settingModel:isAutoBattle() and self._unitOperator:isOperatingUnit() then
		if BattleLog.enableLog then
			BattleLog.log("switch to auto mode,interrupt current operation.")
		end

		self._unitOperator:interruptOperateUnit()
		BattleMainViewFacade.instance:setForNotOperatable()
	end
end

function BattleCampOperator:_onForceOperate()
	if self._unitOperator:isOperatingUnit() then
		if BattleLog.enableLog then
			BattleLog.log("force standby current unit.")
		end

		self._unitOperator:onClickStandby()

		return
	end

	local unit = self:_getNextOperatableUnit()
	local entityId = unit.property:getEntityId()

	BattleAgent.instance:sendStepRequest(entityId)
end

function BattleCampOperator:_onBeforeEndStageRequest()
	local units = self._unitMgr:getUnitsByCampId(self._operateCampId)

	for _, unit in pairs(units) do
		unit.property:activeState(BattleEnum.State.SKIPPED_STEP)
	end

	self._unitOperator:interruptOperateUnit()
	BattleMainViewFacade.instance:setForNotOperatable()
end

function BattleCampOperator:_operateNextUnit()
	local nextUnit = self:_getNextOperatableUnit()

	if not nextUnit then
		if BattleLog.enableLog then
			BattleLog.log("BattleCampOperator::camp operate finish")
		end

		BattleMainViewFacade.instance:setLeftTopViewVisible(true)
		BattleMainViewFacade.instance:setForOperatable()

		if self._settingModel:isAutoFinishTurn() and not self._model:isProxyMode() then
			BattleDispatcher:dispatchEvent(BattleEventType.OnBeforeEndStageRequest)
			self._netAgent:sendEndStageRequest()
		else
			local unitOperator = self._unitOperator

			unitOperator:beginOperateUnit()
		end

		return
	end

	local unitOperator = self._unitOperator

	unitOperator:beginOperateUnit()
	unitOperator:focusOnUnit(nextUnit)
	BattleMainViewFacade.instance:setForOperatable()
	BattleDispatcher:dispatchEvent(BattleEventType.OnOperateNextUnit, nextUnit)
end

function BattleCampOperator:_getNextOperatableUnit()
	local entityId = self._nextOperatableEntityId
	local opUnit = self._unitMgr:getUnit(entityId)

	if opUnit and self:isOperatableUnit(opUnit) then
		return opUnit
	end

	local units = self._unitMgr:getUnitsByCampId(self._operateCampId)

	for _, unit in pairs(units) do
		if self:isOperatableUnit(unit) then
			return unit
		end
	end

	return false
end

function BattleCampOperator:hasOperatableUnit()
	local units = self._unitMgr:getUnitsByCampId(self._operateCampId)

	for _, unit in pairs(units) do
		if self:isOperatableUnit(unit) then
			return true
		end
	end

	return false
end

function BattleCampOperator:onReturnSceneFinished()
	local resultMO = self._model:getResultMO()

	if self._settingModel and not resultMO:isRealEnd() then
		self:tryOperateNextUnit()
	end
end

return BattleCampOperator
