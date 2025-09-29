-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/component/AirWorkShopScenePickerHandler.lua

module("logic.extensions.airworkshop.flow.defflow.component.AirWorkShopScenePickerHandler", package.seeall)

local M = class("AirWorkShopScenePickerHandler", IAirWorkShopFlowComp)
local kDragFactor = 40
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()

function M:onInit()
	self._originalFollowPosition = Vector3.New()
	self._beginDragPosition = Vector3.New()
	self._dragUnit = false
	self._dragUnitOriginalUnionIndex = false
	self._isCameraFollowing = false
end

function M:onStart()
	self._dragUnit = false
	self._boardMgr = self.flow.boardMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitOperator = self.flow.unitOperator or false
	self._unitMgr = self.flow.unitMgr or false
	self._pathArrow = self.flow.pathArrow or false
	self._isCameraFollowing = false
	self._highlandUnit = false
end

function M:onResourceLoaded()
	self:_setAsCampAdjustmentEvent(true)
end

function M:onBeforeClear()
	if self._highlandUnit then
		self:destroyHighland()
	end
end

function M:onClear()
	self:_setAsCampAdjustmentEvent(false)
end

function M:_setAsCampAdjustmentEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragCampAdjustment, self)
		AirWorkDispatcher:addEventListener(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._onEditModeUpdate, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragCampAdjustment, self)
		AirWorkDispatcher:removeEventListener(AirWorkShopEventType.ON_EDIT_MODE_UPDATE, self._onEditModeUpdate, self)
	end
end

function M:_onEditModeUpdate()
	return
end

function M:_onSceneHitCampAdjustment(e, isHit, hitGO, hitPoint, clickCount)
	local curState = AirWorkShopDefSceneModel.instance:getCurState()
	local unionIndex = isHit and self._boardMgr:worldPosition2UnionIndex(self:_getBestHitPosition()) or -1

	if not unionIndex then
		return
	end

	if curState == AirWorkShopEnum.DefState.Edit then
		if self._highlandUnit and self:_tryCoverModeClick(unionIndex) then
			return
		end

		local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

		if unit and AirWorkShopDefSceneUtil.isPosUnit(unit) then
			return
		end

		self:_onSceneHitNormal(unionIndex, clickCount)
	elseif curState == AirWorkShopEnum.DefState.Clear then
		self:_tryRemoveUnitOnUnionIndex(unionIndex)
	elseif curState == AirWorkShopEnum.DefState.BornPosSet then
		local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex, AirWorkShopEnum.TabEnum.BornPoint)

		if unit then
			self:_onSceneHitNormal(unionIndex, clickCount)
		else
			local isSucess = self:_tryAddBornUnit(unionIndex)

			if isSucess then
				AirWorkShopDefOperateUtil.closeToastTips()
			end

			AirWorkShopDefOperateUtil.clearSceneFocusUnit()
		end
	elseif curState == AirWorkShopEnum.DefState.LeavePosSet then
		local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex, AirWorkShopEnum.TabEnum.ExitPoint)

		if unit then
			self:_onSceneHitNormal(unionIndex, clickCount)
		else
			local isSucess = self:_tryAddLeaveUnit(unionIndex)

			if isSucess then
				AirWorkShopDefOperateUtil.closeToastTips()
			end

			AirWorkShopDefOperateUtil.clearSceneFocusUnit()
		end
	end
end

function M:_onSceneHitNormal(unionIndex, clickCount)
	local isDoubleClick = clickCount == 2

	if unionIndex < 0 then
		self._unitOperator:onTouchEmpty(isDoubleClick)

		return
	end

	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	if not cellMO or not cellMO:isEnable() then
		self._unitOperator:onTouchEmpty(isDoubleClick)

		return
	end

	self._unitOperator:onTouchCell(unionIndex, isDoubleClick)
end

function M:_onBeginDragNormal(e, position)
	self._dragType = AirWorkShopEnum.DragState.Normal
	position.z = 10

	local followPosition = VirtualCameraMgr.instance:getFollowPosition()

	self._originalFollowPosition:Set(followPosition:Get())

	position = kUICamera:ScreenToWorldPoint(position)
	self._beginDragPosition = position
end

function M:_onDragNormal(e, position)
	if not self:_canDrag() then
		return
	end

	position.z = 10
	position = kUICamera:ScreenToWorldPoint(position)

	local p = VirtualCameraMgr.instance:getFollowPosition()
	local factor = kDragFactor * Time.deltaTime
	local deltaX = (self._beginDragPosition.x - position.x) * factor
	local deltaY = (self._beginDragPosition.y - position.y) * factor

	self._beginDragPosition = position

	local boardMgr = self.flow.boardMgr
	local x, y, z = TransformUtils.TransformVector(kMainCamera.transform, deltaX, 0, deltaY, 0, 0, 0)

	x, y, z = VirtualCameraMgr.instance:setFollowPosition(x + p.x, 0, z + p.z)
	y = boardMgr:interpolateWorldYOffset(x, z)

	VirtualCameraMgr.instance:setFollowPosition(x, y, z)
end

function M:_onEndDragNormal(e, position)
	return
end

function M:createHighland()
	local coverHighlandId = AirWorkShopDefSceneModel.instance:getCoverHighlandId()

	if coverHighlandId then
		self._highlandUnit = AirWorkShopDefSceneUtil.onlyCreateHighland(coverHighlandId)

		self._highlandUnit:setVisible(false)
	end
end

function M:destroyHighland()
	if self._highlandUnit then
		self._highlandUnit.meshModelMover:setOffsetXYZ(0, 0, 0)
		AirWorkShopDefSceneUtil.onlyRemoveUnit(self._highlandUnit)

		self._highlandUnit = false
	end
end

function M:_tryRemoveUnit(unit)
	local curState = AirWorkShopDefSceneModel.instance:getCurState()

	if curState == AirWorkShopEnum.DefState.Clear and AirWorkShopDefSceneUtil.isPosUnit(unit) then
		return
	end

	if not AirWorkShopDefOperateUtil.isUnitVisible(unit) then
		return
	end

	local backState = AirWorkShopDefOperateUtil.removeUnitWithDoubleCheck(unit, true)

	if self._dragType ~= AirWorkShopEnum.DragState.None and backState == AirWorkShopEnum.CallBackState.Stop then
		self:_onEndDragCampAdjustment()
	end
end

function M:_tryRemoveUnitOnUnionIndex(unionIndex)
	if unionIndex < 0 then
		return
	end

	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if unit then
		self:_tryRemoveUnit(unit)
	end
end

function M:_tryDragUnit(unionIndex, x, z)
	self._dragUnit.mover:setPosDirectly(x, z)

	local hideUnit = false

	if AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex) then
		hideUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex, self._dragUnit.property:getTabType())

		if hideUnit and hideUnit.property:getTabType() ~= AirWorkShopDefSceneModel.instance:getCurTabType() then
			hideUnit = false
		end

		AirWorkShopDefSceneUtil.showFocusSign(unionIndex)
	else
		AirWorkShopDefSceneUtil.hideFocusSign()
	end

	if hideUnit ~= self._lastHideUnit then
		if self._lastHideUnit then
			self._lastHideUnit:setVisible(true)
		end

		if hideUnit and hideUnit ~= self._dragUnit then
			hideUnit:setVisible(false)

			self._lastHideUnit = hideUnit
		else
			self._lastHideUnit = false
		end
	end
end

function M:_tryCoverModeClick(unionIndex)
	if unionIndex < 0 then
		return false
	end

	if not AirWorkShopDefOperateUtil.canSetToUnionIndex(self._highlandUnit, unionIndex) then
		return false
	end

	self:_tryAddHighlandByUnionIndex(unionIndex)

	return true
end

function M:_tryAddHighlandByUnionIndex(unionIndex)
	if unionIndex < 0 then
		return
	end

	if AirWorkShopDefOperateUtil.isUnitReachLimit(AirWorkShopEnum.TabEnum.Highland) then
		FloatWordMgr.instance:show(lang("tip_airwork_highland_upto_limit"))

		return
	end

	local coverHighlandId = AirWorkShopDefSceneModel.instance:getCoverHighlandId()

	if coverHighlandId then
		if not AirWorkShopDefOperateUtil.canSetToUnionIndex(self._highlandUnit, unionIndex) then
			return
		end

		local unit = AirWorkShopDefSceneUtil.createHighland(coverHighlandId)

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
		AirWorkShopDefSceneUtil.requestPlaceBuilding(coverHighlandId, unionIndex, unit)
		AirWorkShopDefOperateUtil.tryCombineHighland(unit, unionIndex)

		if not AirWorkShopDefOperateUtil.isUnitVisible(unit) then
			AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, unit.property:getTabType())
		end
	end
end

function M:_tryAddHighland(position)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y)

	if not x then
		return
	end

	local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)

	self:_tryAddHighlandByUnionIndex(unionIndex)
end

function M:_onBeginDragCampAdjustment(e, position)
	self._dragType = AirWorkShopEnum.DragState.None

	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	if not AirWorkShopDefSceneModel.instance:isEnableAdjustment() then
		self:_onBeginDragNormal(e, position)

		return
	end

	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y)

	if not x then
		self:_onBeginDragNormal(e, position)

		return
	end

	local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)

	if unionIndex < 0 then
		self:_onBeginDragNormal(e, position)

		return
	end

	if self._highlandUnit and AirWorkShopDefOperateUtil.canSetToUnionIndex(self._highlandUnit, unionIndex) then
		self._dragType = AirWorkShopEnum.DragState.Highland

		self:_tryAddHighland(position)
		AirWorkShopDefSceneModel.instance:setDragging(true)

		return
	end

	if AirWorkShopDefSceneModel.instance:isDragging() then
		self:_onBeginDragNormal(e, position)

		return
	end

	local dragUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if not dragUnit then
		self:_onBeginDragNormal(e, position)

		return
	end

	if not AirWorkShopDefOperateUtil.isUnitVisible(dragUnit) then
		self:_onBeginDragNormal(e, position)

		return
	end

	local curState = AirWorkShopDefSceneModel.instance:getCurState()

	if curState == AirWorkShopEnum.DefState.Clear then
		AirWorkShopDefSceneModel.instance:setDragging(true)

		self._dragType = AirWorkShopEnum.DragState.Clear

		self:_tryRemoveUnit(dragUnit)

		return
	end

	if curState == AirWorkShopEnum.DefState.BornPosSet and dragUnit.property:getUnitType() ~= AirWorkShopEnum.UnitType.BornPoint then
		self:_onBeginDragNormal(e, position)

		return
	end

	if curState == AirWorkShopEnum.DefState.LeavePosSet and dragUnit.property:getUnitType() ~= AirWorkShopEnum.UnitType.ExitPoint then
		self:_onBeginDragNormal(e, position)

		return
	end

	if curState == AirWorkShopEnum.DefState.Edit and AirWorkShopDefSceneUtil.isPosUnit(dragUnit) then
		self:_onBeginDragNormal(e, position)

		return
	end

	self._dragUnit = dragUnit
	self._dragUnitOriginalUnionIndex = unionIndex

	AirWorkShopDefSceneModel.instance:setDragging(true)

	if not self._dragUnit then
		self:_onBeginDragNormal(e, position)

		return
	end

	if not AirWorkShopDefOperateUtil.isUnitVisible(self._dragUnit) then
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, self._dragUnit.property:getTabType())
	end

	self._dragType = AirWorkShopEnum.DragState.DragUnit

	AirWorkShopDefSceneUtil.setUnitForDrag(self._dragUnit)
end

function M:_onDragCampAdjustment(e, position)
	if self._dragType == AirWorkShopEnum.DragState.Normal then
		self:_onDragNormal(e, position)
	end

	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y)

	if not x then
		return
	end

	local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)

	if unionIndex < 0 then
		return
	end

	if self._dragType == AirWorkShopEnum.DragState.Highland then
		self:_tryAddHighland(position)
	end

	if self._dragType == AirWorkShopEnum.DragState.Clear then
		self:_tryRemoveUnitOnUnionIndex(unionIndex)
	end

	if self._dragType == AirWorkShopEnum.DragState.DragUnit then
		self:_tryDragUnit(unionIndex, x, z)
	end
end

function M:_onEndDragCampAdjustment(e, position)
	if self._dragType == AirWorkShopEnum.DragState.Highland then
		self:_tryAddHighland(position)
		self:_clearDragUnit()

		return
	end

	if self._dragType ~= AirWorkShopEnum.DragState.DragUnit then
		self:_clearDragUnit()
		self:_onEndDragNormal(e, position)

		return
	else
		local dragUnit = self._dragUnit
		local lastHideUnit = self._lastHideUnit
		local originalUnionIndex = self._dragUnitOriginalUnionIndex

		self:_clearDragUnit()
		self._pathArrow:hideFocusSign()

		local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y)

		if not x then
			AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(dragUnit, originalUnionIndex)

			return
		end

		local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)

		if not AirWorkShopDefOperateUtil.canSetToUnionIndex(dragUnit, unionIndex) then
			AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(dragUnit, originalUnionIndex)

			return
		end

		if lastHideUnit then
			AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(lastHideUnit, originalUnionIndex)
			AirWorkShopDefSceneUtil.playPlaceEffect(lastHideUnit)
		end

		AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(dragUnit, unionIndex)
		AirWorkShopDefSceneUtil.requestMoveEntity(dragUnit, unionIndex)

		if dragUnit.property:getTabType() == AirWorkShopEnum.TabEnum.Highland then
			AirWorkShopDefOperateUtil.tryCombineHighland(dragUnit, unionIndex)
		else
			AirWorkShopDefSceneUtil.playPlaceEffect(dragUnit)
		end

		CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
	end
end

function M:_clearDragUnit()
	AirWorkShopDefSceneModel.instance:setDragging(false)

	if self._dragUnit then
		self._dragUnit = false
	end

	self._dragUnitOriginalUnionIndex = false

	if self._lastHideUnit then
		self._lastHideUnit:setVisible(true)

		self._lastHideUnit = false
	end

	self._dragType = AirWorkShopEnum.DragState.None
end

function M:_getBestHitPosition()
	local count = math.min(ScenePickerViewFacade.instance:getHitCount(), 2)

	for i = 1, count do
		local x, y, z = ScenePickerViewFacade.instance:getHitPointXYZ(i)
		local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)
		local isHitTopFace = math.abs(self._boardMgr:calculateWorldYOffset(x, z) - y) <= 0.02

		if isHitTopFace and self._boardModel:isValideCoordinates(BoardIndexConverter.unionIndexToCoordinates(unionIndex)) and self._unitMgr:getUnitOnUnionIndex(unionIndex) then
			return x, y, z
		end
	end

	return ScenePickerViewFacade.instance:getHitPointXYZ(1)
end

function M:_canDrag()
	return not self:getIsCameraFollowing()
end

function M:setIsCameraFollowing(status)
	self._isCameraFollowing = status
end

function M:getIsCameraFollowing()
	return self._isCameraFollowing
end

function M:_tryAddBornUnit(unionIndex)
	if AirWorkShopDefOperateUtil.canBornOrLeaveSetToUnionIndex(unionIndex) then
		AirWorkShopDefSceneUtil.createBornUnitAndSetPos(unionIndex)

		return true
	end
end

function M:_tryAddLeaveUnit(unionIndex)
	if AirWorkShopDefOperateUtil.canBornOrLeaveSetToUnionIndex(unionIndex) then
		AirWorkShopDefSceneUtil.createLeaveUnitAndSetPos(unionIndex)

		return true
	end
end

return M
