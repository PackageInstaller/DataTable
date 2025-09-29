-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/airworkshop/flow/defflow/view/AirWorkShopDefSceneScrollBuildingBase.lua

module("logic.extensions.airworkshop.flow.defflow.view.AirWorkShopDefSceneScrollBuildingBase", package.seeall)

local M = class("AirWorkShopDefSceneScrollBuildingBase")

function M:ctor(gameObject)
	self.mainGO = gameObject

	self:buildUI()
end

function M:buildUI()
	self._headItemCollection = ViewlibCollection:create(ViewlibResPath.AirAdjustmentBuildingItem, 10)
	self._buildingCOList = {}
	self._curBuildingCOList = {}
	self._goScrollRect = goutil.findChild(self.mainGO, "scrollView")
	self._scrollRect = Astral.ScrollRectLoop.Get(self._goScrollRect)

	self._scrollRect:InitFix(kScrollDirH, 120, 120, 4, 0, 1, self._onCellUpdate, self)
	self._scrollRect:SetCellsUpdateFinishHandler(self._onCellUpdateFinish, self)

	self._scrollRect.enableSeparateFrameUpdate = true
	self._scrollRect.frameUpdateCellCount = 1
	self._scrollRect.frameUpdateRate = 1

	self:_initData()
end

function M:destroy()
	self._headItemCollection:clear()

	self._headItemCollection = nil

	self:_setEvents(false)
end

function M:_setEvents(add)
	if add then
		-- block empty
	end
end

function M:_initData()
	self:_setEvents(true)

	self._isDraging = false

	table.insertto(self._buildingCOList, self:_getAllBuildingList())
	self:_updateCurBuildings()
end

function M:_updateCurBuildings()
	return
end

function M:setVisibleAndUpdate(isVisible)
	goutil.setActive(self.mainGO, isVisible)

	if isVisible then
		self:_updateScrollView()
	else
		self:cancelSelectedId()
	end
end

function M:_onCellUpdateFinish()
	return
end

function M:_updateScrollView()
	self._scrollRect.TotalCellNum = #self._curBuildingCOList
end

function M:_onCellUpdate(cellTransform, cellIndex, prevIndex)
	if not self._headItemCollection then
		return
	end

	cellIndex = cellIndex + 1

	local itemGO = goutil.findChild(cellTransform.gameObject, "AirAdjustmentBuildingItem")
	local cellBehavior

	if itemGO then
		cellBehavior = Astral.SimpleLuaComponentContainer.Get(itemGO, AirAdjustmentBuildingItem)
	else
		cellBehavior = self._headItemCollection:createInstance(cellTransform.gameObject)

		cellBehavior:setHandler(self)
		cellBehavior:setPassToGameObject(self._goScrollRect)

		itemGO = cellBehavior.mainGO
		itemGO.name = "AirAdjustmentBuildingItem"

		Astral.TransformUtil.SetLocalPos(itemGO.transform, 0, 0, 0)
	end

	local buildCO = self._curBuildingCOList[cellIndex]

	cellBehavior:setBuildingCO(buildCO)
	cellBehavior:setSelected(buildCO.id == self._selectBuildingId)
	cellBehavior:setEnable(true)

	if self._selectedAnimation and buildCO.id == self._selectBuildingId then
		self._selectedAnimation = false
	end
end

function M:_getAllBuildingList()
	return
end

function M:onClickHeadItem(headItem)
	if self._isDraging then
		return
	end

	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	self._selectedAnimation = true

	local buildingId = headItem:getBuildingId()

	if self._selectBuildingId == buildingId then
		self:cancelSelectedId()
	else
		self:setSelectedId(buildingId)
	end
end

function M:onLongClickHeadItem(headItem)
	AirWorkShopDefOperateUtil.openBuildingTips(headItem:getBuildingId(), headItem.mainGO)
end

function M:onBeginDragHeadItem(headItem, screenX, screenY)
	AirWorkShopDefOperateUtil.clearSceneFocusUnit()

	if not AirWorkShopDefSceneModel.instance:isEnableAdjustment() then
		return
	end

	if self._isDraging then
		return
	end

	if AirWorkShopDefSceneModel.instance:isDragging() then
		return
	end

	if AirWorkShopDefOperateUtil.isUnitReachLimit(self:_getUnitTagType()) then
		FloatWordMgr.instance:show(lang("tip_airwork_reach_limit"))

		return
	end

	self._isDraging = true
	self._selectedAnimation = true

	self:_setSceneDragEnable(false)

	self._dragUnit = self:_createDragUnit(headItem:getBuildingId())

	AirWorkShopDefSceneModel.instance:setDragging(true)
	self:onDragHeadItem(headItem, screenX, screenY)

	if not AirWorkShopDefOperateUtil.isUnitVisible(self._dragUnit) then
		AirWorkDispatcher:dispatchEvent(AirWorkShopEventType.ON_UNIT_VISIBLE_UPDATE, self._dragUnit.property:getTabType())
	end
end

function M:onDragHeadItem(headItem, screenX, screenY)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)

	if not x then
		return
	end

	if not self._isDraging then
		return
	end

	self._dragUnit.mover:setPosDirectly(x, z)

	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, y, z)
	local hideUnit = false

	if AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex) then
		AirWorkShopDefSceneUtil.showFocusSign(unionIndex)

		local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()

		hideUnit = unitMgr:getUnitOnUnionIndex(unionIndex, AirWorkShopDefSceneModel.instance:getCurTabType())
	else
		AirWorkShopDefSceneUtil.hideFocusSign()
	end

	if hideUnit ~= self._lastHideUnit then
		if self._lastHideUnit then
			self._lastHideUnit:setVisible(true)
		end

		if hideUnit then
			hideUnit:setVisible(false)
		end

		self._lastHideUnit = hideUnit
	end
end

function M:onEndDragHeadItem(headItem, screenX, screenY)
	if not self._isDraging then
		return
	end

	self._isDraging = false

	self:_setSceneDragEnable(true)
	AirWorkShopDefSceneUtil.hideFocusSign()

	local buildId = headItem:getBuildingId()
	local unionIndex = self:_getPlaceUnionIndex(screenX, screenY)

	if not unionIndex then
		self:_destroyDragUnit()
		self:cancelSelectedId()

		return
	end

	if not AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex) then
		self:_destroyDragUnit()
		self:cancelSelectedCharacter()

		return
	end

	local dragUnit = self._dragUnit

	self:_placeDragUnit(unionIndex)
	self:cancelSelectedId(false)
	CriwareAudioFacade.instance:playSEById(CriwareAudioEnum.ui_battle_renwuputdown)
	AirWorkShopDefSceneUtil.requestPlaceBuilding(buildId, unionIndex, dragUnit)
	self:_afterEndDrag(dragUnit, unionIndex)

	return true
end

function M:_afterEndDrag(dragUnit, unionIndex)
	return
end

function M:onTriggerDisable(headItem)
	return
end

function M:_placeDragUnit(unionIndex)
	local unit = self._dragUnit

	self._dragUnit = false
	self._lastHideUnit = false

	AirWorkShopDefSceneModel.instance:setDragging(false)
	AirWorkShopDefSceneUtil.setDragUnitToUnionIndex(unit, unionIndex)
end

function M:_getPlaceUnionIndex(screenX, screenY)
	local x, y, z = BattleScenePickerViewFacade.instance:testHitScreenPoint(screenX, screenY)

	if not x then
		return
	end

	local boardMgr = AirWorkShopDefMgr.instance:getBoardMgr()
	local unionIndex = boardMgr:worldPosition2UnionIndex(x, y, z)
	local isCanPlaceOnUnionIndex = AirWorkShopDefOperateUtil.canSetToUnionIndex(self._dragUnit, unionIndex, true)

	if not isCanPlaceOnUnionIndex then
		return
	end

	local unitMgr = AirWorkShopDefMgr.instance:getUnitMgr()
	local oldUnit = unitMgr:getUnitOnUnionIndex(unionIndex, AirWorkShopDefSceneModel.instance:getCurTabType())

	if oldUnit then
		AirWorkShopDefSceneUtil.requestRemoveEntity(oldUnit)
	end

	return unionIndex
end

function M:_getUnitTagType()
	return
end

function M:cancelSelectedId()
	if self._selectBuildingId == -1 then
		return
	end

	self._lastSelectedCharacterId = self._selectBuildingId
	self._selectBuildingId = -1

	self:_updateScrollView()
	self:_onSelectItem()
end

function M:setSelectedId(characterId)
	if self._selectBuildingId == characterId then
		return
	end

	self._lastSelectedCharacterId = self._selectBuildingId
	self._selectBuildingId = characterId

	self:_updateScrollView()
	self:_onSelectItem()
end

function M:_onSelectItem()
	return
end

function M:_setSceneDragEnable(enable)
	local scenePicker = AirWorkShopDefMgr.instance:getScenePicker()

	scenePicker:setIsCameraFollowing(not enable)
end

function M:_createDragUnit(buildingId)
	local unit = AirWorkShopDefSceneUtil.createHighland(buildingId)

	AirWorkShopDefSceneUtil.setUnitForDrag(unit)

	return unit
end

function M:_destroyDragUnit()
	if self._dragUnit then
		self._dragUnit.meshModelMover:setOffsetXYZ(0, 0, 0)
		AirWorkShopDefSceneUtil.requestRemoveEntity(self._dragUnit)
		AirWorkShopDefSceneModel.instance:setDragging(false)

		self._dragUnit = false
	end

	if self._lastHideUnit then
		self._lastHideUnit:setVisible(true)

		self._lastHideUnit = false
	end
end

return M
