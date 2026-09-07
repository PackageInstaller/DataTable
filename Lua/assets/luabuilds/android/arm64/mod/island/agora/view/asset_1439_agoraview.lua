local AgoraView = class("AgoraView", import(".BaseAgoraView"))

AgoraView.MODE_OVERVIEW = 1
AgoraView.MODE_EDIT = 2
AgoraView.MODE_PAVE_TILE = 3

local var_0_1 = false

function AgoraView:Init()
	AgoraView.super.Init(self)

	local var_1_0 = GameObject.Find("AgoraMainStage")

	self.agoraLookAtObj = GetOrAddComponent(var_1_0.transform:Find("lookat"), "AgoraLookAtObj")
	self.lookatBuilding = var_1_0.transform:Find("lookat_building")
	self.furnitureRoot = var_1_0.transform:Find("furniture")

	self:RegisterUnitList(IslandConst.UNIT_LIST_AGORA)

	self.mouldBuilder = AgoraMouldBuilder.New(self, IslandConst.UNIT_LIST_AGORA)

	if var_0_1 then
		self.debugMap = AgoraDebugMap.New(self)
	end

	self.mode = AgoraView.MODE_OVERVIEW
	self.decorationView = self:CreateDecorationView()
	self.paveTileView = AgoraPaveTileView.New(self)
	self.reloadingView = AgoraReloadingView.New(self)
	self.gridTr = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid")
	self.trees = {
		[4356] = GameObject.Find("/[MainBlock]/[Model]/nobake/level2"),
		[6084] = GameObject.Find("/[MainBlock]/[Model]/nobake/level3")
	}
	self.grids = {
		[1600] = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid/level1"),
		[4356] = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid/level2"),
		[6084] = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid/level3")
	}

	for iter_1_0, iter_1_1 in pairs(self.grids) do
		setActive(iter_1_1, false)
	end

	setActive(self.gridTr, true)

	return
end

function AgoraView:CreateOpView()
	return AgoraOpView.New(self)
end

function AgoraView:CreateDecorationView()
	return AgoraDecorationView.New(self)
end

function AgoraView:AddAgoraListeners()
	self:AddAgoraListener(ISLAND_AGORA_EVT.GEN_ITEM, self.OnGenItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.REMOVE_ITEM, self.OnRemoveItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.UNPLACE_ITEM, self.OnUnplaceItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT, self.OnEnterEditMode)
	self:AddAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT_FAILED, self.OnEnterFailed)
	self:AddAgoraListener(ISLAND_AGORA_EVT.EXIT_EDIT, self.OnExitEditMode)

	if var_0_1 then
		self:AddAgoraListener(ISLAND_AGORA_EVT.MAP_STATE_UPDATE, self.OnMapStateUpdate)
	end

	self:AddAgoraListener(ISLAND_AGORA_EVT.SELECTED_ITEM, self.OnSelectedItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.UNSELECTED_ITEM, self.OnUnSelectedItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.CONFIRM_SELECTED_ITEM, self.OnConfirmItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_BEGIN, self.OnBeginDragItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM, self.OnDragItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_END, self.OnEndDragItem)
	self:AddAgoraListener(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, self.OnBoardUpdate)
	self:AddAgoraListener(ISLAND_AGORA_EVT.START_INTERACTION, self.OnAgoraVirtualStartInteraction)
	self:AddAgoraListener(ISLAND_AGORA_EVT.END_INTERACTION, self.OnAgoraVirtualEndInteraction)
	self:AddAgoraListener(ISLAND_AGORA_EVT.ITEM_OCCUPIED, self.OnPositionOccupied)
	self:AddAgoraListener(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, self.OnClearPositionOccupied)
	self:AddAgoraListener(ISLAND_AGORA_EVT.SIGN_IN_CNT_UPDATE, self.OnSignCntUpdate)
	self:AddAgoraListener(ISLAND_AGORA_EVT.FILL_TILE_CELL, self.OnGenTileCell)
	self:AddAgoraListener(ISLAND_AGORA_EVT.CLEAR_TILE_CELL, self.OnRemoveTileCell)
	self:AddAgoraListener(ISLAND_AGORA_EVT.FILL_FLOOR_CELL, self.OnGenFloorCell)
	self:AddAgoraListener(ISLAND_AGORA_EVT.CLEAR_FLOOR_CELL, self.OnRemoveFloorCell)
	self:AddAgoraListener(ISLAND_AGORA_EVT.THEME_UPDATE, self.OnThemeUpdate)
	self:AddAgoraListener(ISLAND_AGORA_EVT.RELOADING, self.OnReload)
	self:AddAgoraListener(ISLAND_AGORA_EVT.RELOADING_FINISH, self.OnReloadFinish)
	self:AddAgoraListener(ISLAND_AGORA_EVT.START_LOAD_ITEMS, self.OnStartLoadItems)
	self:AddAgoraListener(ISLAND_AGORA_EVT.END_LOAD_ITEMS, self.OnEndLoadItems)
	self:AddAgoraListener(ISLAND_AGORA_EVT.SAVE, self.OnSave)
	self:AddAgoraListener(ISLAND_AGORA_EVT.TAG_CHANGE, self.OnTagChange)
	self:AddAgoraListener(ISLAND_EVT.GEN_UNIT, self.OnGenUnit)
	self:AddAgoraListener(ISLAND_EVT.RMOVE_UNIT, self.OnRemoveUnit)
	self:AddAgoraListener(ISLAND_EVT.RESET_UNIT_POS, self.OnResetUnitPos)
	self:AddAgoraListener(ISLAND_EVT.RESET_UNIT_ROT, self.OnResetUnitRotation)

	return
end

function AgoraView:RemoveAgoraListeners()
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.GEN_ITEM, self.OnGenItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.REMOVE_ITEM, self.OnRemoveItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.UNPLACE_ITEM, self.OnUnplaceItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT, self.OnEnterEditMode)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT_FAILED, self.OnEnterFailed)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.EXIT_EDIT, self.OnExitEditMode)

	if var_0_1 then
		self:RemoveAgoraListener(ISLAND_AGORA_EVT.MAP_STATE_UPDATE, self.OnMapStateUpdate)
	end

	self:RemoveAgoraListener(ISLAND_AGORA_EVT.SELECTED_ITEM, self.OnSelectedItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.UNSELECTED_ITEM, self.OnUnSelectedItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.CONFIRM_SELECTED_ITEM, self.OnConfirmItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_BEGIN, self.OnBeginDragItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM, self.OnDragItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_END, self.OnEndDragItem)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, self.OnBoardUpdate)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.START_INTERACTION, self.OnAgoraVirtualStartInteraction)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.END_INTERACTION, self.OnAgoraVirtualEndInteraction)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.ITEM_OCCUPIED, self.OnPositionOccupied)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, self.OnClearPositionOccupied)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.SIGN_IN_CNT_UPDATE, self.OnSignCntUpdate)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.FILL_TILE_CELL, self.OnGenTileCell)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.CLEAR_TILE_CELL, self.OnRemoveTileCell)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.FILL_FLOOR_CELL, self.OnGenFloorCell)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.CLEAR_FLOOR_CELL, self.OnRemoveFloorCell)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.THEME_UPDATE, self.OnThemeUpdate)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.RELOADING, self.OnReload)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.RELOADING_FINISH, self.OnReloadFinish)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.START_LOAD_ITEMS, self.OnStartLoadItems)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.END_LOAD_ITEMS, self.OnEndLoadItems)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.SAVE, self.OnSave)
	self:RemoveAgoraListener(ISLAND_AGORA_EVT.TAG_CHANGE, self.OnTagChange)
	self:RemoveAgoraListener(ISLAND_EVT.GEN_UNIT, self.OnGenUnit)
	self:RemoveAgoraListener(ISLAND_EVT.RMOVE_UNIT, self.OnRemoveUnit)
	self:RemoveAgoraListener(ISLAND_EVT.RESET_UNIT_POS, self.OnResetUnitPos)
	self:RemoveAgoraListener(ISLAND_EVT.RESET_UNIT_ROT, self.OnResetUnitRotation)

	return
end

function AgoraView:OnSave()
	if self.decorationView and self.decorationView:IsLoaded() then
		self.decorationView:Execute("FlushSaveBtn")
	end

	return
end

function AgoraView:OnStartLoadItems()
	self.startLoadItemsFlag = true

	return
end

function AgoraView:OnEndLoadItems(arg_8_1)
	self.startLoadItemsFlag = false

	if arg_8_1 then
		self.lookatBuilding.position = AgoraCalc.MapPosition2WorldPosition(arg_8_1)
	end

	return
end

function AgoraView:OnReload()
	self.reloadingView:Execute("Show")

	return
end

function AgoraView:OnReloadFinish()
	self.reloadingView:Execute("Hide")

	return
end

function AgoraView:OnThemeUpdate()
	self.decorationView:Execute("FlushThemeList")

	return
end

function AgoraView:OnGenFloorCell(arg_12_1)
	self:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):FillFloorCell(arg_12_1)

	return
end

function AgoraView:OnRemoveFloorCell(arg_13_1)
	self:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):ClearFloorCell(arg_13_1)

	return
end

function AgoraView:OnGenTileCell(arg_14_1)
	self:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):FillTileCell(arg_14_1)

	return
end

function AgoraView:OnRemoveTileCell(arg_15_1)
	self:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):ClearTileCell(arg_15_1)

	return
end

function AgoraView:OnEnterFailed()
	self:NotifiyIsland(ISLAND_EX_EVT.PLAY_STORY, {
		name = "ISLANDSTORY101"
	})

	return
end

function AgoraView:OnClearSelectedUnit()
	AgoraView.super.OnClearSelectedUnit(self)

	if self.selectedUnitId then
		self:GetSubView(IslandInteractionView):HideInterActionPanel()

		local var_17_0 = self:GetUnitModule(self.selectedUnitId)

		if var_17_0 then
			GetOrAddComponent(var_17_0._go, typeof(HighlightController)):HighlightOff()
		end

		self.selectedUnitId = nil
	end

	return
end

function AgoraView:OnSelectedUnit(arg_18_1)
	AgoraView.super.OnSelectedUnit(self, arg_18_1)

	if self.selectedUnitId then
		self:OnClearSelectedUnit()
	end

	if arg_18_1.data:IsGift() then
		GetOrAddComponent(arg_18_1._go, typeof(HighlightController)):HighlightOn()

		self.selectedUnitId = arg_18_1.id

		self:GetSubView(IslandInteractionView):ShowInterActionPanel({
			type = 41
		})
	end

	return
end

function AgoraView:OnSignCntUpdate(arg_19_1)
	self:GetSubView(AgoraOpView):UpdateSignInTip()

	return
end

function AgoraView:OnGenItem(arg_20_1, arg_20_2)
	local var_20_0 = self.mouldBuilder:Build(arg_20_1, arg_20_2)

	self:AddUnit(var_20_0)

	if self.mode == AgoraView.MODE_EDIT then
		self.decorationView:Execute("FlushCard", arg_20_1.id)
		self.decorationView:Execute("FlushCapacity")

		if not self.startLoadItemsFlag then
			self:LookAtItem(var_20_0)
		end
	end

	self:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_20_1, false)

	return
end

function AgoraView:OnTagChange(arg_21_1)
	local var_21_0 = arg_21_1 == AgoraFurnitureType.BUILDING

	self:SwitchLookat(arg_21_1 == AgoraFurnitureType.BUILDING)
	self:GetSubView(AgoraOpView):ShowMoveBtn(not var_21_0)

	return
end

function AgoraView:SwitchLookat(arg_22_1)
	local var_22_0 = IslandCameraMgr.instance:GetVirtualCamera(IslandConst.AGORA_CAMERA_NAME)

	if arg_22_1 then
		var_22_0.Follow = self.lookatBuilding
		var_22_0.LookAt = self.lookatBuilding
	else
		var_22_0.Follow = self.agoraLookAtObj.gameObject.transform
		var_22_0.LookAt = self.agoraLookAtObj.gameObject.transform
	end

	self.agoraLookAtObj.enabled = not arg_22_1

	return
end

function AgoraView:LookAtItem(arg_23_1)
	local var_23_0 = arg_23_1.data:GetPosition()

	if not arg_23_1.data:IsBuildingType() and AgoraCalc.GetCenterMapPos() ~= var_23_0 then
		self.agoraLookAtObj:SetTargetPosition((AgoraCalc.MapPosition2WorldPosition(var_23_0)))
	end

	return
end

function AgoraView:OnRemoveItem(arg_24_1)
	local var_24_0 = self:GetAgoraMould(arg_24_1.id)

	var_24_0:Dispose()
	self:RemoveUnit(var_24_0)

	if self.mode == AgoraView.MODE_EDIT then
		self.decorationView:Execute("FlushCard", arg_24_1.id)
		self.decorationView:Execute("FlushCapacity")
	end

	self:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_24_1, true)

	return
end

function AgoraView:OnBoardUpdate(arg_25_1)
	local var_25_0 = arg_25_1.x * arg_25_1.y

	for iter_25_0, iter_25_1 in pairs(self.trees) do
		setActive(iter_25_1, var_25_0 < iter_25_0)
	end

	if self.mode ~= AgoraView.MODE_OVERVIEW then
		for iter_25_2, iter_25_3 in pairs(self.grids) do
			setActive(iter_25_3, iter_25_2 <= var_25_0)
		end
	end

	self.agoraLookAtObj:SetRange((AgoraCalc.GetSizeCoord(arg_25_1)))

	return
end

function AgoraView:OnSelectedItem(arg_26_1, arg_26_2)
	local var_26_0 = self:GetAgoraMould(arg_26_1)

	var_26_0:ShowOrHideArea(false, true)

	if arg_26_2 then
		self:GetSubView(AgoraOpView):ActiveDragBtn(var_26_0)
	end

	self.decorationView:Execute("OnSelectedItem", arg_26_1, arg_26_2, arg_26_1)

	return
end

function AgoraView:OnUnSelectedItem(arg_27_1, arg_27_2)
	local var_27_0 = self:GetAgoraMould(arg_27_1)

	var_27_0:ShowOrHideArea(false, false)

	if arg_27_2 then
		self:GetSubView(AgoraOpView):InActiveDragBtn(var_27_0)
	end

	self.decorationView:Execute("OnSelectedItem", -1, arg_27_2, arg_27_1)

	return
end

function AgoraView:OnConfirmItem(arg_28_1)
	self.decorationView:Execute("OnCreateSameItem", arg_28_1)

	return
end

function AgoraView:OnUnplaceItem()
	self.decorationView:Execute("OnSelectedItem", -1, true)

	return
end

function AgoraView:OnBeginDragItem(arg_30_1)
	print("OnBeginDragItem")
	self:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_30_1, true)

	return
end

function AgoraView:OnDragItem(arg_31_1, arg_31_2)
	self:GetAgoraMould(arg_31_1):ShowOrHideArea(not arg_31_2, true)

	return
end

function AgoraView:OnEndDragItem(arg_32_1)
	print("OnEndDragItem")
	self:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_32_1, false)

	return
end

function AgoraView:OnPositionOccupied(arg_33_1)
	self:GetAgoraMould(arg_33_1):ShowOrHideArea(true, true)

	return
end

function AgoraView:OnClearPositionOccupied(arg_34_1)
	for iter_34_0, iter_34_1 in pairs(self:GetUnitListByKey(IslandConst.UNIT_LIST_AGORA)) do
		if iter_34_1.id ~= arg_34_1 then
			iter_34_1:ShowOrHideArea(false, false)
		end
	end

	return
end

function AgoraView:OnAgoraVirtualStartInteraction(arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2:GetHostId()
	local var_35_1 = arg_35_2:GetUserId()

	warning("start", var_35_0, var_35_1, arg_35_3, arg_35_2.id)

	local var_35_2 = self:GetUnitModule(var_35_0)
	local var_35_3 = self:GetPlayerUnitModule(var_35_1)
	local var_35_4 = self.player == var_35_3

	if self.player == var_35_3 then
		self:GetSubView(AgoraOpView):StartInteraction()
	end

	var_35_2:StartInteract(var_35_3, arg_35_2.id, arg_35_3, arg_35_1:GetTimeline()[arg_35_3], arg_35_1:GetBlackboardParam()[arg_35_3], arg_35_1:AnySlotUsing(), var_35_4, (arg_35_1:GetPlayerParentPath(arg_35_2.id)))

	return
end

function AgoraView:OnAgoraVirtualEndInteraction(arg_36_1, arg_36_2)
	local var_36_0 = arg_36_2:GetHostId()
	local var_36_1 = arg_36_2:GetUserId()

	warning("end", var_36_0, var_36_1, arg_36_2.id)

	local var_36_2 = self:GetUnitModule(var_36_0)
	local var_36_3 = self:GetPlayerUnitModule(var_36_1)
	local var_36_4 = self.player == var_36_3

	if self.player == var_36_3 then
		self:GetSubView(AgoraOpView):EndInteraction()
	end

	var_36_2:EndInteract(var_36_3, arg_36_2.id, not arg_36_1:AnySlotUsing(), var_36_4)

	return
end

function AgoraView:OnMapStateUpdate(arg_37_1)
	if self.debugMap then
		self.debugMap:UpdateItem(arg_37_1.position, arg_37_1.flag)
	end

	return
end

function AgoraView:OnEnterEditMode()
	self:EnterMode(AgoraView.MODE_EDIT)
	self:SwitchLookat(false)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.AGORA_CAMERA_NAME)
	self.decorationView:Execute("Show")

	for iter_38_0, iter_38_1 in ipairs(self:GetAllUnits()) do
		iter_38_1:Disable()
	end

	for iter_38_2, iter_38_3 in pairs(self:GetUnitListByKey(IslandConst.UNIT_LIST_AGORA)) do
		iter_38_3:Disable()
	end

	local var_38_0 = self.agora:GetSize()
	local var_38_1 = var_38_0.x * var_38_0.y

	for iter_38_4, iter_38_5 in pairs(self.grids) do
		setActive(iter_38_5, iter_38_4 <= var_38_1)
	end

	self:RestLookAtPosition()

	return
end

function AgoraView:OnExitEditMode()
	self:EnterMode(AgoraView.MODE_OVERVIEW)
	self:SwitchLookat(false)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)
	self.decorationView:Execute("Reset")
	self:GetSubView(AgoraOpView):InActiveDragBtn()

	for iter_39_0, iter_39_1 in ipairs(self:GetAllUnits()) do
		iter_39_1:Enable()
	end

	for iter_39_2, iter_39_3 in pairs(self:GetUnitListByKey(IslandConst.UNIT_LIST_AGORA)) do
		iter_39_3:Enable()
	end

	for iter_39_4, iter_39_5 in pairs(self.grids) do
		setActive(iter_39_5, false)
	end

	return
end

function AgoraView:EnterPaveTileMode(arg_40_1, arg_40_2)
	self:EnterMode(AgoraView.MODE_PAVE_TILE)
	self:Op("SelectedPaveItem", arg_40_1.id, arg_40_2)
	self.decorationView:Execute("Hide")
	self.paveTileView:Execute("Show", arg_40_1, arg_40_2)
	self:RestLookAtPosition(1)

	return
end

function AgoraView:ExitPaveTileMode()
	self:EnterMode(AgoraView.MODE_EDIT)
	self:Op("UnSelectedPaveItem")
	self.decorationView:Execute("Show")
	self.paveTileView:Execute("Hide")

	return
end

function AgoraView:EnterMode(arg_42_1)
	self.mode = arg_42_1

	self:GetSubView(AgoraOpView):EnterMode(arg_42_1)

	return
end

function AgoraView:RestLookAtPosition(arg_43_1)
	LuaHelper.SetCinemachineFreeLookXAndY(IslandCameraMgr.instance:GetVirtualCamera(IslandConst.AGORA_CAMERA_NAME), 0, arg_43_1 or 0.5)
	self.agoraLookAtObj:SetTargetPosition((AgoraCalc.MapPosition2WorldPosition(Vector2(0, 0))))

	return
end

function AgoraView:GetAgoraMould(arg_44_1)
	return self:GetUnitModuleWithType(IslandConst.UNIT_LIST_AGORA, arg_44_1)
end

function AgoraView:OnDispose()
	if self.selectedUnitId then
		self:OnClearSelectedUnit()

		self.selectedUnitId = nil
	end

	AgoraView.super.OnDispose(self)

	if self.decorationView then
		self.decorationView:Dispose()

		self.decorationView = nil
	end

	if self.paveTileView then
		self.paveTileView:Dispose()

		self.paveTileView = nil
	end

	if self.reloadingView then
		self.reloadingView:Dispose()

		self.reloadingView = nil
	end

	self:GetPoolMgr():ClearAograPools()

	if var_0_1 and self.debugMap then
		self.debugMap:Dispose()

		self.debugMap = nil
	end

	return
end

return AgoraView
