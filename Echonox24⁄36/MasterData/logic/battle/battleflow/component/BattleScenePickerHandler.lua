-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/battle/battleflow/component/BattleScenePickerHandler.lua

module("logic.battle.battleflow.component.BattleScenePickerHandler", package.seeall)

local BattleScenePickerHandler = class("BattleScenePickerHandler", IBattleFlowComp)
local kDragFactor = 40
local kUICamera = CameraTargetMgr.instance:getUICameraTarget():getCamera()
local kMainCamera = CameraTargetMgr.instance:getMainCameraTarget():getCamera()
local kPickState = {
	AdjustCamp = 3,
	Normal = 2,
	None = 1
}

function BattleScenePickerHandler:onInit()
	self._originalFollowPosition = Vector3.New()
	self._beginDragPosition = Vector3.New()
	self._dragUnit = false
	self._dragUnitOriginalUnionIndex = false
	self._isUndo = false
	self._pickState = kPickState.None
end

function BattleScenePickerHandler:onStart()
	self._isUndo = false
	self._dragUnit = false
	self._pickState = kPickState.None
	self._boardMgr = self.flow.boardMgr or false
	self._boardModel = self.flow.boardModel or false
	self._unitOperator = self.flow.unitOperator or false
	self._unitMgr = self.flow.unitMgr or false
	self._pathArrow = self.flow.pathArrow or false
	self._pathFinder = self.flow.pathFinder or false
	self._haloLinks = self.flow.haloLinks or false
end

function BattleScenePickerHandler:onClear()
	self:_setAsNormalEvent(false)
	self:_setAsCampAdjustmentEvent(false)

	self._isUndo = false
	self._dragUnit = false
	self._pickState = false
	self._lastHitUnit = false
	self._dragUnitOriginalUnionIndex = false
	self._boardMgr = false
	self._boardModel = false
	self._unitOperator = false
	self._unitMgr = false
	self._pathArrow = false
	self._pathFinder = false
	self._haloLinks = false
end

function BattleScenePickerHandler:setForCampAdjustment()
	self._pickState = kPickState.AdjustCamp

	self:_setAsNormalEvent(false)
	self:_setAsCampAdjustmentEvent(true)
end

function BattleScenePickerHandler:setForNormal()
	self._isUndo = false
	self._pickState = kPickState.Normal

	self:_setAsNormalEvent(true)
	self:_setAsCampAdjustmentEvent(false)
	self:_clearOperateUnit()
end

function BattleScenePickerHandler:setUndoEnable(isEnableUndo)
	self._isUndo = isEnableUndo
end

function BattleScenePickerHandler:_setAsNormalEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitNormal, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragNormal, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragNormal, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragNormal, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_SIMULATE_PICK_UNION_INDEX, self._onSimulatePickUnionIndex, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitNormal, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragNormal, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragNormal, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragNormal, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_SIMULATE_PICK_UNION_INDEX, self._onSimulatePickUnionIndex, self)
	end
end

function BattleScenePickerHandler:_setAsCampAdjustmentEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragCampAdjustment, self)
		GlobalDispatcher:addEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragCampAdjustment, self)
		BattleDispatcher:addEventListener(BattleEventType.Adjustment_OnClearOperateUnit, self._onClearOperateUnit, self)
		BattleDispatcher:addEventListener(BattleEventType.ON_SIMULATE_PICK_UNION_INDEX, self._onSimulatePickUnionIndexAdjustment, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_HIT, self._onSceneHitCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_BEGIN_DRAG, self._onBeginDragCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_DRAG, self._onDragCampAdjustment, self)
		GlobalDispatcher:removeEventListener(EventType.ON_SCENE_PICKER_END_DRAG, self._onEndDragCampAdjustment, self)
		BattleDispatcher:removeEventListener(BattleEventType.Adjustment_OnClearOperateUnit, self._onClearOperateUnit, self)
		BattleDispatcher:removeEventListener(BattleEventType.ON_SIMULATE_PICK_UNION_INDEX, self._onSimulatePickUnionIndexAdjustment, self)
	end
end

function BattleScenePickerHandler:_onSimulatePickUnionIndex(e, unionIndex, isDoubleClick)
	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	if cellMO and cellMO:isEnable() then
		self._unitOperator:onTouchCell(unionIndex, isDoubleClick)
	end
end

function BattleScenePickerHandler:_onSceneHitNormal(e, isHit, hitGO, hitPoint, clickCount)
	if self._isUndo then
		if BattleLog.enableLog then
			BattleLog.log("current is in undo mode")
		end

		return
	end

	local isDoubleClick = clickCount == 2
	local unionIndex = isHit and self._boardMgr:worldPosition2UnionIndex(self:_getBestHitPosition()) or -1

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

function BattleScenePickerHandler:_onBeginDragNormal(e, position)
	position.z = 10

	local followPosition = VirtualCameraMgr.instance:getFollowPosition()

	self._originalFollowPosition:Set(followPosition:Get())

	position = kUICamera:ScreenToWorldPoint(position)
	self._beginDragPosition = position
end

function BattleScenePickerHandler:_onDragNormal(e, position)
	position.z = 10
	position = kUICamera:ScreenToWorldPoint(position)

	local p = VirtualCameraMgr.instance:getFollowPosition()
	local factor = kDragFactor * Time.deltaTime
	local deltaX = (self._beginDragPosition.x - position.x) * factor
	local deltaY = (self._beginDragPosition.y - position.y) * factor

	self._beginDragPosition = position

	if not self:_canDrag() then
		return
	end

	local boardMgr = BattleMgr.instance:getBoardMgr()
	local x, y, z = TransformUtils.TransformVector(kMainCamera.transform, deltaX, 0, deltaY, 0, 0, 0)

	x, y, z = VirtualCameraMgr.instance:setFollowPosition(x + p.x, 0, z + p.z)
	y = boardMgr:interpolateWorldYOffset(x, z)

	VirtualCameraMgr.instance:setFollowPosition(x, y, z)
end

function BattleScenePickerHandler:_onEndDragNormal(e, position)
	return
end

function BattleScenePickerHandler:_switchOperateUnit(unit)
	self._focusUnit = unit

	self._haloLinks:clearAllLinkLine()
	self._focusUnit.uiProxy:setSelected(true)
	BattleMainViewFacade.instance:switchOperateUnit(unit, false, false)

	local unionIndex = BoardIndexConverter.coordinatesToUnionIndex(unit.transform:getCoordinates())
	local resultNodeArray = self._pathFinder:signDefaultStopableAndAttackableArea(unit)
	local skillId = unit.skill:getNormalSkill():getSkillId()

	self._haloLinks:drawHaloLinksForUnit(unit.property:getEntityId())
	self._boardMgr:spreadCheckerBoard(unit, skillId, true)
end

function BattleScenePickerHandler:_clearOperateUnit()
	if self._focusUnit then
		self._focusUnit.uiProxy:setSelected(false)

		self._focusUnit = false
	end

	BattleMainViewFacade.instance:clearOperateUnit()
	BattleMainViewFacade.instance:setForCampAdjustment()
	self._pathArrow:hideFocusSign()
	self._boardMgr:resetAllSign()
	self._haloLinks:clearAllLinkLine()
end

function BattleScenePickerHandler:clearOperateUnit()
	self:_clearOperateUnit()
end

function BattleScenePickerHandler:_onSceneHitCampAdjustment(e, isHit, hitGO, hitPoint, clickCount)
	BattleCampAdjustmentViewFacade.instance:cancelSelectedCharacter()

	local unionIndex = isHit and self._boardMgr:worldPosition2UnionIndex(self:_getBestHitPosition()) or -1

	if unionIndex < 0 then
		self:_clearOperateUnit()

		return
	end

	local cellMO = self._boardModel:getBoardCellMO(unionIndex)

	if not cellMO or not cellMO:isEnable() then
		self:_clearOperateUnit()

		return
	end

	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if not BattleUnitUtil.checkSelectUnit(unit) then
		self:_clearOperateUnit()
		self._pathArrow:showFocusSign(unionIndex)

		return
	end

	self:_switchOperateUnit(unit)
	self._pathArrow:showFocusSign(unionIndex)
end

function BattleScenePickerHandler:_onSimulatePickUnionIndexAdjustment(e, unionIndex, isDoubleClick)
	BattleCampAdjustmentViewFacade.instance:cancelSelectedCharacter()

	if unionIndex < 0 then
		self:_clearOperateUnit()

		return
	end

	local unit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

	if not BattleUnitUtil.checkSelectUnit(unit) then
		self:_clearOperateUnit()
		self._pathArrow:showFocusSign(unionIndex)

		return
	end

	self:_switchOperateUnit(unit)
	self._pathArrow:showFocusSign(unionIndex)
end

function BattleScenePickerHandler:_onClearOperateUnit()
	self:_clearOperateUnit()
end

function BattleScenePickerHandler:_onBeginDragCampAdjustment(e, position)
	if not BattleCampAdjustmentModel.instance:isEnableAdjustment() then
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

	if not BattleCampAdjustmentModel.instance:isValidBornUnionIndex(unionIndex) then
		self:_onBeginDragNormal(e, position)

		return
	end

	if BattleCampAdjustmentModel.instance:isDragging() then
		self:_onBeginDragNormal(e, position)

		return
	end

	self._dragUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex)
	self._dragUnitOriginalUnionIndex = unionIndex

	BattleCampAdjustmentModel.instance:setDragging(true)

	if not BattleUnitUtil.checkSelectUnit(self._dragUnit) then
		self:_clearDragUnit()
		self:_onBeginDragNormal(e, position)

		return
	end

	if not BattleCampRelationUtil.isSameOfOperateCamp(self._dragUnit) then
		self:_clearDragUnit()
		self:_onBeginDragNormal(e, position)

		return
	end

	if BattleCampAdjustmentUtil.isLockedUnit(self._dragUnit) then
		self:_clearDragUnit()
		self:_onBeginDragNormal(e, position)
		FloatWordMgr.instance:show(lang("tip_not_replace_leader"))

		return
	end

	BattleCampAdjustmentUtil.setUnitForDrag(self._dragUnit)
	self:_clearOperateUnit()
end

function BattleScenePickerHandler:_onDragCampAdjustment(e, position)
	if not self._dragUnit then
		self:_onDragNormal(e, position)

		return
	end

	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y)

	if not x then
		return
	end

	local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)

	if unionIndex < 0 then
		return
	end

	self._dragUnit.mover:setPosDirectly(x, z)

	local hideUnit = false

	if BattleCampAdjustmentUtil.canPlaceOnUnionIndex(self._dragUnit, unionIndex) then
		hideUnit = self._unitMgr:getUnitOnUnionIndex(unionIndex)

		BattleCampAdjustmentUtil.showFocusSign(unionIndex)
	else
		BattleCampAdjustmentUtil.hideFocusSign()
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

function BattleScenePickerHandler:_onEndDragCampAdjustment(e, position)
	if not self._dragUnit then
		self:_onEndDragNormal(e, position)

		return
	end

	local dragUnit = self._dragUnit
	local lastHideUnit = self._lastHideUnit
	local originalUnionIndex = self._dragUnitOriginalUnionIndex

	self:_clearDragUnit()
	self._pathArrow:hideFocusSign()

	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(position.x, position.y)

	if not x then
		BattleCampAdjustmentUtil.requestRemoveEntity(dragUnit)

		return
	end

	local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)

	if not BattleCampAdjustmentModel.instance:isValidBornUnionIndex(unionIndex) then
		BattleCampAdjustmentUtil.requestRemoveEntity(dragUnit)

		return
	end

	local unitMgr = BattleMgr.instance:getUnitMgr()
	local unit = unitMgr:getUnitOnUnionIndex(unionIndex)

	if BattleCampAdjustmentUtil.isLockedUnit(unit) then
		FloatWordMgr.instance:show(lang("tip_not_replace_leader"))
		BattleCampAdjustmentUtil.setDragUnitToUnionIndex(dragUnit, originalUnionIndex)
		self._boardMgr:setUnitToUnionIndex(dragUnit, originalUnionIndex)

		return
	end

	if lastHideUnit then
		BattleCampAdjustmentUtil.setDragUnitToUnionIndex(lastHideUnit, originalUnionIndex)
		BattleCampAdjustmentUtil.playPlaceEffect(lastHideUnit)
	end

	BattleCampAdjustmentUtil.setDragUnitToUnionIndex(dragUnit, unionIndex)
	BattleCampAdjustmentUtil.requestMoveEntity(dragUnit, unionIndex)
	BattleCampAdjustmentUtil.playPlaceEffect(dragUnit)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
end

function BattleScenePickerHandler:_clearDragUnit()
	BattleCampAdjustmentModel.instance:setDragging(false)

	if self._dragUnit then
		self._dragUnit = false
		self._dragUnitOriginalUnionIndex = false
	end

	if self._lastHideUnit then
		self._lastHideUnit:setVisible(true)

		self._lastHideUnit = false
	end
end

function BattleScenePickerHandler:_getBestHitPosition()
	local count = math.min(BattleScenePickerViewFacade.instance:getHitCount(), 2)

	for i = 1, count do
		local x, y, z = BattleScenePickerViewFacade.instance:getHitPointXYZ(i)
		local unionIndex = self._boardMgr:worldPosition2UnionIndex(x, y, z)
		local isHitTopFace = math.abs(self._boardMgr:calculateWorldYOffset(x, z) - y) <= 0.02

		if isHitTopFace and self._boardModel:isValideCoordinates(BoardIndexConverter.unionIndexToCoordinates(unionIndex)) and (self._unitMgr:getUnitOnUnionIndex(unionIndex) or self._pathFinder:isInStopableArea(unionIndex) or self._pathFinder:isInTransportableArea(unionIndex) or self._unitOperator:isSelectableSkillTarget(unionIndex)) then
			return x, y, z
		end
	end

	return BattleScenePickerViewFacade.instance:getHitPointXYZ(1)
end

function BattleScenePickerHandler:_canDrag()
	if self.flow.localLogic:isOperateCamp() then
		return true
	end

	return not self:getIsCameraFollowing()
end

function BattleScenePickerHandler:setIsCameraFollowing(status)
	self._isCameraFollowing = status
end

function BattleScenePickerHandler:getIsCameraFollowing()
	return self._isCameraFollowing
end

function BattleScenePickerHandler:onLeaveScene()
	self:_setAsNormalEvent(false)
	self:_setAsCampAdjustmentEvent(false)
end

function BattleScenePickerHandler:onReturnScene()
	if self._pickState == kPickState.AdjustCamp then
		self:_setAsCampAdjustmentEvent(true)
	elseif self._pickState == kPickState.Normal then
		self:_setAsNormalEvent(true)
	end
end

return BattleScenePickerHandler
