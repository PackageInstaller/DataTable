-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/command/impl/server/BattleEntitiesAddedCommand.lua

module("logic.battle.battleflow.component.command.impl.server.BattleEntitiesAddedCommand", package.seeall)

local BattleEntitiesAddedCommand = class("BattleEntitiesAddedCommand", BattleCommandBase)

function BattleEntitiesAddedCommand:parseServerCommand(cmdParser, entities)
	local model = BattleMgr.instance:getModel()
	local cmd = BattleEntitiesAddedCommand:createInstance()

	for _, entityNO in ipairs(entities) do
		cmd:addEntityInfo(BattleNOConverter:entityNO2EntityInfo(entityNO))
	end

	local isNormalPhase = model:getPhase() == BattleEnum.Phase.NORMAL

	cmd:setPerformanceEnable(BattleCmdUtil.isEnablePerformance(cmdParser, isNormalPhase))
	cmdParser:addCommand(cmd)
end

function BattleEntitiesAddedCommand:onInit()
	self._multiLoader = MultiResLoader.New()
	self._isEnablePerformance = false
	self._entityInfos = {}
	self._timelineTask = false
end

function BattleEntitiesAddedCommand:onClear()
	if self._timelineTask then
		self._timelineTask:clear()
	end

	self._multiLoader:clear()

	self._isEnablePerformance = false

	BattleTableUtil.clearTable(self._entityInfos)
end

function BattleEntitiesAddedCommand:execute(battleFlow)
	for _, entityInfo in ipairs(self._entityInfos) do
		local entityCO = BattleEntityCOAdapter:getSharedEntityCOAdapter(entityInfo.entityCode, entityInfo.entityType)
		local modelCO = ModelConfig.instance:getModelConfig(entityCO:getModelCode())

		ModelCOUtil.addResourceUrlToLoader(modelCO, self._multiLoader)
	end

	self._multiLoader:load(self._doExecute, nil, self)
end

function BattleEntitiesAddedCommand:_doExecute()
	if self._isEnablePerformance then
		self._timelineTask = self._timelineTask or TimelineTask.New()

		self._timelineTask:clear()
		self._timelineTask:addTask(0, self._tFocusUnit, self)
		self._timelineTask:addTask(0.5, self._tCreateUnit, self)
		self._timelineTask:addTask(0.5)
		self._timelineTask:addFinishListener(self._notifyFinish, self)
		self._timelineTask:setTimeScale(BattleTime.timeScale)
		self._timelineTask:start()
	else
		self:_processAsDefault()
	end
end

function BattleEntitiesAddedCommand:_tFocusUnit()
	local boardMgr = BattleMgr.instance:getBoardMgr()
	local entityInfo = self._entityInfos[1]
	local x, y, z = boardMgr:getCellPositionXYZ(entityInfo.bornUnionIndex)

	BattleCameraUtil.doFollowPosition(x, y, z, BattleConst.DelayZeroPointFive)
end

function BattleEntitiesAddedCommand:_tCreateUnit()
	self:_createUnits()
	self:_playCreateEffects()
end

function BattleEntitiesAddedCommand:_notifyFinish()
	self:finish(true)
end

function BattleEntitiesAddedCommand:_processAsDefault()
	self:_createUnits()

	if BattleCampAdjustmentModel.instance:isPrePlayedEffect() then
		BattleCampAdjustmentModel.instance:setPrePlayedEffect(false)
		self:finish(true)

		return
	end

	local activeCampChanged = BattleCampAdjustmentModel.instance:isSameActiveCampChanged()

	if not activeCampChanged then
		self:_playCreateEffects()
		self:finish(true)

		return
	end

	if not self:_containsNotifySignalCharacterCode() then
		self:finish(true)

		return
	end

	self:finish(true)
end

function BattleEntitiesAddedCommand:_createUnits()
	local model = BattleMgr.instance:getModel()
	local unitMgr = BattleMgr.instance:getUnitMgr()
	local battleFieldInfo = model:getBattleFieldInfo()

	for _, entityInfo in ipairs(self._entityInfos) do
		battleFieldInfo:addEntityInfo(entityInfo)

		if not self:_tryAddUnitFromTemp(entityInfo) then
			unitMgr:createUnit(entityInfo)
		end
	end

	BattleDispatcher:dispatchEvent(BattleEventType.OnEntitiesAdded)
end

function BattleEntitiesAddedCommand:_tryAddUnitFromTemp(entityInfo)
	local unionIndex = entityInfo.bornUnionIndex
	local unit = BattleCampAdjustmentModel.instance:popTempUnit(unionIndex)

	if unit then
		local boardMgr = BattleMgr.instance:getBoardMgr()
		local unitMgr = BattleMgr.instance:getUnitMgr()

		BattleUnitGenerator.setUnitInfo(unit, entityInfo)
		unitMgr:addUnit(unit)
		boardMgr:setUnitToUnionIndex(unit, unionIndex)

		return unit
	end

	return false
end

function BattleEntitiesAddedCommand:_playCreateEffects()
	local unitMgr = BattleMgr.instance:getUnitMgr()

	for _, entityInfo in ipairs(self._entityInfos) do
		local unit = unitMgr:getUnit(entityInfo.entityId)

		unit.effectPlayer:playEffect(BattleCampAdjustmentUtil.getPlaceEffectId(unit))
	end
end

function BattleEntitiesAddedCommand:_containsNotifySignalCharacterCode()
	for _, entityInfo in ipairs(self._entityInfos) do
		if BattleCampAdjustmentModel.instance:isNotifySignalCharacterCode(entityInfo.entityCode) then
			return true
		end
	end

	return false
end

function BattleEntitiesAddedCommand:toString()
	return string.format("[battle entities added command] isEnablePerformance = %s", tostring(self._isEnablePerformance))
end

function BattleEntitiesAddedCommand:addEntityInfo(entityInfo)
	table.insert(self._entityInfos, entityInfo)

	return self
end

function BattleEntitiesAddedCommand:setPerformanceEnable(isEnable)
	self._isEnablePerformance = isEnable

	return self
end

return BattleEntitiesAddedCommand
