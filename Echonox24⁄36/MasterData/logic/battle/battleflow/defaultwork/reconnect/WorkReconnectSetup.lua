-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/defaultwork/reconnect/WorkReconnectSetup.lua

module("logic.battle.battleflow.defaultwork.reconnect.WorkReconnectSetup", package.seeall)

local M = class("WorkReconnectSetup", WorkBase)

function M:onEnter(context)
	local boardMgr = context.boardMgr
	local focusIndex = self:_getDefaultFocusUnitUnionIndex()
	local position = boardMgr:getCellPosition(focusIndex)

	VirtualCameraMgr.instance:setFollowPosition(position.x, position.y, position.z)
	self:_initCameraRotation(context)
	BattleDispatcher:dispatchEvent(BattleEventType.OnEnableCullingChanged, true)
	BattleMainViewFacade.instance:setUIElementVisible(BattleUIElement.Main, true)

	local scenePickerHandler = context.scenePickerHandler

	scenePickerHandler:setForNormal()

	local model = context.model

	model:setPhase(BattleEnum.Phase.NORMAL)
	WorkTriggerEnterDone:setUIPropertiesVisible(true)
	self:onDone(WorkResult.Succeed)
end

function M:_initCameraRotation(context)
	local flow = BattleMgr.instance:getActiveBattleFlow()
	local virtualCamera = VirtualCameraMgr.instance:getActiveCamera()
	local rotation = virtualCamera:getRotation()

	if OOPUtil.isInstanceOf(flow, LevelBattleFlowBase) then
		local levelCOWrapper = DungeonBattleInfoConfig.instance:getDungeonBattleInfoCOWrapper(flow:getBattleLevelCode())
		local levelCO = levelCOWrapper:getDungeonBattleInfoCO()

		rotation.y = rotation.y - levelCO.initRotationOffSet

		context.model:recordCameraRotation(rotation.y)
		virtualCamera:setRotation(rotation.x, rotation.y, rotation.z)
	else
		context.model:recordCameraRotation(rotation.y)
	end

	GlobalDispatcher:dispatchEvent(EventType.ON_CAMERA_ROTATION_UPDATE, 0)
end

function M:onExit(isInterrupt)
	return
end

function M:_getDefaultFocusUnitUnionIndex()
	local campOperator = self.context.campOperator
	local unit = campOperator:getNextOperatableUnit()

	if unit then
		return BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	end

	local unitMgr = self.context.unitMgr
	local units = unitMgr:getAllUnits()

	for _, unit in pairs(units) do
		if not unit.property:isStateActive(BattleEnum.State.STEPPED) and unit.property:checkStateOperatable() then
			return BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
		end
	end

	for _, unit in pairs(units) do
		return BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	end

	return 0
end

return M
