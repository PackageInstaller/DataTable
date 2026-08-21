local var_0_0 = class("AgoraView", import(".BaseAgoraView"))

var_0_0.MODE_OVERVIEW = 1
var_0_0.MODE_EDIT = 2
var_0_0.MODE_PAVE_TILE = 3

local var_0_1 = false

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	local var_1_0 = GameObject.Find("AgoraMainStage")

	arg_1_0.agoraLookAtObj = GetOrAddComponent(var_1_0.transform:Find("lookat"), "AgoraLookAtObj")
	arg_1_0.lookatBuilding = var_1_0.transform:Find("lookat_building")
	arg_1_0.furnitureRoot = var_1_0.transform:Find("furniture")

	arg_1_0:RegisterUnitList(IslandConst.UNIT_LIST_AGORA)

	arg_1_0.mouldBuilder = AgoraMouldBuilder.New(arg_1_0, IslandConst.UNIT_LIST_AGORA)

	if var_0_1 then
		arg_1_0.debugMap = AgoraDebugMap.New(arg_1_0)
	end

	arg_1_0.mode = var_0_0.MODE_OVERVIEW
	arg_1_0.decorationView = arg_1_0:CreateDecorationView()
	arg_1_0.paveTileView = AgoraPaveTileView.New(arg_1_0)
	arg_1_0.reloadingView = AgoraReloadingView.New(arg_1_0)
	arg_1_0.gridTr = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid")
	arg_1_0.trees = {
		[4356] = GameObject.Find("/[MainBlock]/[Model]/nobake/level2"),
		[6084] = GameObject.Find("/[MainBlock]/[Model]/nobake/level3")
	}
	arg_1_0.grids = {
		[1600] = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid/level1"),
		[4356] = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid/level2"),
		[6084] = GameObject.Find("/[MainBlock]/[Model]/nobake/pre_grid/level3")
	}

	for iter_1_0, iter_1_1 in pairs(arg_1_0.grids) do
		setActive(iter_1_1, false)
	end

	setActive(arg_1_0.gridTr, true)

	return
end

function var_0_0.CreateOpView(arg_2_0)
	return AgoraOpView.New(arg_2_0)
end

function var_0_0.CreateDecorationView(arg_3_0)
	return AgoraDecorationView.New(arg_3_0)
end

function var_0_0.AddAgoraListeners(arg_4_0)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.GEN_ITEM, arg_4_0.OnGenItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.REMOVE_ITEM, arg_4_0.OnRemoveItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.UNPLACE_ITEM, arg_4_0.OnUnplaceItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT, arg_4_0.OnEnterEditMode)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT_FAILED, arg_4_0.OnEnterFailed)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.EXIT_EDIT, arg_4_0.OnExitEditMode)

	if var_0_1 then
		arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.MAP_STATE_UPDATE, arg_4_0.OnMapStateUpdate)
	end

	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.SELECTED_ITEM, arg_4_0.OnSelectedItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.UNSELECTED_ITEM, arg_4_0.OnUnSelectedItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.CONFIRM_SELECTED_ITEM, arg_4_0.OnConfirmItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_BEGIN, arg_4_0.OnBeginDragItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM, arg_4_0.OnDragItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_END, arg_4_0.OnEndDragItem)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, arg_4_0.OnBoardUpdate)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.START_INTERACTION, arg_4_0.OnAgoraVirtualStartInteraction)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.END_INTERACTION, arg_4_0.OnAgoraVirtualEndInteraction)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.ITEM_OCCUPIED, arg_4_0.OnPositionOccupied)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, arg_4_0.OnClearPositionOccupied)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.SIGN_IN_CNT_UPDATE, arg_4_0.OnSignCntUpdate)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.FILL_TILE_CELL, arg_4_0.OnGenTileCell)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.CLEAR_TILE_CELL, arg_4_0.OnRemoveTileCell)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.FILL_FLOOR_CELL, arg_4_0.OnGenFloorCell)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.CLEAR_FLOOR_CELL, arg_4_0.OnRemoveFloorCell)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.THEME_UPDATE, arg_4_0.OnThemeUpdate)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.RELOADING, arg_4_0.OnReload)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.RELOADING_FINISH, arg_4_0.OnReloadFinish)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.START_LOAD_ITEMS, arg_4_0.OnStartLoadItems)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.END_LOAD_ITEMS, arg_4_0.OnEndLoadItems)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.SAVE, arg_4_0.OnSave)
	arg_4_0:AddAgoraListener(ISLAND_AGORA_EVT.TAG_CHANGE, arg_4_0.OnTagChange)
	arg_4_0:AddAgoraListener(ISLAND_EVT.GEN_UNIT, arg_4_0.OnGenUnit)
	arg_4_0:AddAgoraListener(ISLAND_EVT.RMOVE_UNIT, arg_4_0.OnRemoveUnit)
	arg_4_0:AddAgoraListener(ISLAND_EVT.RESET_UNIT_POS, arg_4_0.OnResetUnitPos)
	arg_4_0:AddAgoraListener(ISLAND_EVT.RESET_UNIT_ROT, arg_4_0.OnResetUnitRotation)

	return
end

function var_0_0.RemoveAgoraListeners(arg_5_0)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.GEN_ITEM, arg_5_0.OnGenItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.REMOVE_ITEM, arg_5_0.OnRemoveItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.UNPLACE_ITEM, arg_5_0.OnUnplaceItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT, arg_5_0.OnEnterEditMode)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.ENTER_EDIT_FAILED, arg_5_0.OnEnterFailed)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.EXIT_EDIT, arg_5_0.OnExitEditMode)

	if var_0_1 then
		arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.MAP_STATE_UPDATE, arg_5_0.OnMapStateUpdate)
	end

	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.SELECTED_ITEM, arg_5_0.OnSelectedItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.UNSELECTED_ITEM, arg_5_0.OnUnSelectedItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.CONFIRM_SELECTED_ITEM, arg_5_0.OnConfirmItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_BEGIN, arg_5_0.OnBeginDragItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM, arg_5_0.OnDragItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.DRAG_ITEM_END, arg_5_0.OnEndDragItem)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, arg_5_0.OnBoardUpdate)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.START_INTERACTION, arg_5_0.OnAgoraVirtualStartInteraction)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.END_INTERACTION, arg_5_0.OnAgoraVirtualEndInteraction)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.ITEM_OCCUPIED, arg_5_0.OnPositionOccupied)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, arg_5_0.OnClearPositionOccupied)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.SIGN_IN_CNT_UPDATE, arg_5_0.OnSignCntUpdate)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.FILL_TILE_CELL, arg_5_0.OnGenTileCell)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.CLEAR_TILE_CELL, arg_5_0.OnRemoveTileCell)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.FILL_FLOOR_CELL, arg_5_0.OnGenFloorCell)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.CLEAR_FLOOR_CELL, arg_5_0.OnRemoveFloorCell)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.THEME_UPDATE, arg_5_0.OnThemeUpdate)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.RELOADING, arg_5_0.OnReload)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.RELOADING_FINISH, arg_5_0.OnReloadFinish)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.START_LOAD_ITEMS, arg_5_0.OnStartLoadItems)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.END_LOAD_ITEMS, arg_5_0.OnEndLoadItems)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.SAVE, arg_5_0.OnSave)
	arg_5_0:RemoveAgoraListener(ISLAND_AGORA_EVT.TAG_CHANGE, arg_5_0.OnTagChange)
	arg_5_0:RemoveAgoraListener(ISLAND_EVT.GEN_UNIT, arg_5_0.OnGenUnit)
	arg_5_0:RemoveAgoraListener(ISLAND_EVT.RMOVE_UNIT, arg_5_0.OnRemoveUnit)
	arg_5_0:RemoveAgoraListener(ISLAND_EVT.RESET_UNIT_POS, arg_5_0.OnResetUnitPos)
	arg_5_0:RemoveAgoraListener(ISLAND_EVT.RESET_UNIT_ROT, arg_5_0.OnResetUnitRotation)

	return
end

function var_0_0.OnSave(arg_6_0)
	if arg_6_0.decorationView and arg_6_0.decorationView:IsLoaded() then
		arg_6_0.decorationView:Execute("FlushSaveBtn")
	end

	return
end

function var_0_0.OnStartLoadItems(arg_7_0)
	arg_7_0.startLoadItemsFlag = true

	return
end

function var_0_0.OnEndLoadItems(arg_8_0, arg_8_1)
	arg_8_0.startLoadItemsFlag = false

	if arg_8_1 then
		arg_8_0.lookatBuilding.position = AgoraCalc.MapPosition2WorldPosition(arg_8_1)
	end

	return
end

function var_0_0.OnReload(arg_9_0)
	arg_9_0.reloadingView:Execute("Show")

	return
end

function var_0_0.OnReloadFinish(arg_10_0)
	arg_10_0.reloadingView:Execute("Hide")

	return
end

function var_0_0.OnThemeUpdate(arg_11_0)
	arg_11_0.decorationView:Execute("FlushThemeList")

	return
end

function var_0_0.OnGenFloorCell(arg_12_0, arg_12_1)
	arg_12_0:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):FillFloorCell(arg_12_1)

	return
end

function var_0_0.OnRemoveFloorCell(arg_13_0, arg_13_1)
	arg_13_0:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):ClearFloorCell(arg_13_1)

	return
end

function var_0_0.OnGenTileCell(arg_14_0, arg_14_1)
	arg_14_0:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):FillTileCell(arg_14_1)

	return
end

function var_0_0.OnRemoveTileCell(arg_15_0, arg_15_1)
	arg_15_0:GetSystemModule(IslandConst.AGORA_GROUND_SYSTEM_ID):ClearTileCell(arg_15_1)

	return
end

function var_0_0.OnEnterFailed(arg_16_0)
	arg_16_0:NotifiyIsland(ISLAND_EX_EVT.PLAY_STORY, {
		name = "ISLANDSTORY101"
	})

	return
end

function var_0_0.OnClearSelectedUnit(arg_17_0)
	var_0_0.super.OnClearSelectedUnit(arg_17_0)

	if arg_17_0.selectedUnitId then
		arg_17_0:GetSubView(IslandInteractionView):HideInterActionPanel()

		local var_17_0 = arg_17_0:GetUnitModule(arg_17_0.selectedUnitId)

		if var_17_0 then
			GetOrAddComponent(var_17_0._go, typeof(HighlightController)):HighlightOff()
		end

		arg_17_0.selectedUnitId = nil
	end

	return
end

function var_0_0.OnSelectedUnit(arg_18_0, arg_18_1)
	var_0_0.super.OnSelectedUnit(arg_18_0, arg_18_1)

	if arg_18_0.selectedUnitId then
		arg_18_0:OnClearSelectedUnit()
	end

	if arg_18_1.data:IsGift() then
		GetOrAddComponent(arg_18_1._go, typeof(HighlightController)):HighlightOn()

		arg_18_0.selectedUnitId = arg_18_1.id

		arg_18_0:GetSubView(IslandInteractionView):ShowInterActionPanel({
			type = 41
		})
	end

	return
end

function var_0_0.OnSignCntUpdate(arg_19_0, arg_19_1)
	arg_19_0:GetSubView(AgoraOpView):UpdateSignInTip()

	return
end

function var_0_0.OnGenItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.mouldBuilder:Build(arg_20_1, arg_20_2)

	arg_20_0:AddUnit(var_20_0)

	if arg_20_0.mode == var_0_0.MODE_EDIT then
		arg_20_0.decorationView:Execute("FlushCard", arg_20_1.id)
		arg_20_0.decorationView:Execute("FlushCapacity")

		if not arg_20_0.startLoadItemsFlag then
			arg_20_0:LookAtItem(var_20_0)
		end
	end

	arg_20_0:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_20_1, false)

	return
end

function var_0_0.OnTagChange(arg_21_0, arg_21_1)
	local var_21_0 = arg_21_1 == AgoraFurnitureType.BUILDING

	arg_21_0:SwitchLookat(arg_21_1 == AgoraFurnitureType.BUILDING)
	arg_21_0:GetSubView(AgoraOpView):ShowMoveBtn(not var_21_0)

	return
end

function var_0_0.SwitchLookat(arg_22_0, arg_22_1)
	local var_22_0 = IslandCameraMgr.instance:GetVirtualCamera(IslandConst.AGORA_CAMERA_NAME)

	if arg_22_1 then
		var_22_0.Follow = arg_22_0.lookatBuilding
		var_22_0.LookAt = arg_22_0.lookatBuilding
	else
		var_22_0.Follow = arg_22_0.agoraLookAtObj.gameObject.transform
		var_22_0.LookAt = arg_22_0.agoraLookAtObj.gameObject.transform
	end

	arg_22_0.agoraLookAtObj.enabled = not arg_22_1

	return
end

function var_0_0.LookAtItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.data:GetPosition()

	if not arg_23_1.data:IsBuildingType() and AgoraCalc.GetCenterMapPos() ~= var_23_0 then
		arg_23_0.agoraLookAtObj:SetTargetPosition((AgoraCalc.MapPosition2WorldPosition(var_23_0)))
	end

	return
end

function var_0_0.OnRemoveItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:GetAgoraMould(arg_24_1.id)

	var_24_0:Dispose()
	arg_24_0:RemoveUnit(var_24_0)

	if arg_24_0.mode == var_0_0.MODE_EDIT then
		arg_24_0.decorationView:Execute("FlushCard", arg_24_1.id)
		arg_24_0.decorationView:Execute("FlushCapacity")
	end

	arg_24_0:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_24_1, true)

	return
end

function var_0_0.OnBoardUpdate(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.x * arg_25_1.y

	for iter_25_0, iter_25_1 in pairs(arg_25_0.trees) do
		setActive(iter_25_1, var_25_0 < iter_25_0)
	end

	if arg_25_0.mode ~= var_0_0.MODE_OVERVIEW then
		for iter_25_2, iter_25_3 in pairs(arg_25_0.grids) do
			setActive(iter_25_3, iter_25_2 <= var_25_0)
		end
	end

	arg_25_0.agoraLookAtObj:SetRange((AgoraCalc.GetSizeCoord(arg_25_1)))

	return
end

function var_0_0.OnSelectedItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:GetAgoraMould(arg_26_1)

	var_26_0:ShowOrHideArea(false, true)

	if arg_26_2 then
		arg_26_0:GetSubView(AgoraOpView):ActiveDragBtn(var_26_0)
	end

	arg_26_0.decorationView:Execute("OnSelectedItem", arg_26_1, arg_26_2, arg_26_1)

	return
end

function var_0_0.OnUnSelectedItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:GetAgoraMould(arg_27_1)

	var_27_0:ShowOrHideArea(false, false)

	if arg_27_2 then
		arg_27_0:GetSubView(AgoraOpView):InActiveDragBtn(var_27_0)
	end

	arg_27_0.decorationView:Execute("OnSelectedItem", -1, arg_27_2, arg_27_1)

	return
end

function var_0_0.OnConfirmItem(arg_28_0, arg_28_1)
	arg_28_0.decorationView:Execute("OnCreateSameItem", arg_28_1)

	return
end

function var_0_0.OnUnplaceItem(arg_29_0)
	arg_29_0.decorationView:Execute("OnSelectedItem", -1, true)

	return
end

function var_0_0.OnBeginDragItem(arg_30_0, arg_30_1)
	print("OnBeginDragItem")
	arg_30_0:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_30_1, true)

	return
end

function var_0_0.OnDragItem(arg_31_0, arg_31_1, arg_31_2)
	arg_31_0:GetAgoraMould(arg_31_1):ShowOrHideArea(not arg_31_2, true)

	return
end

function var_0_0.OnEndDragItem(arg_32_0, arg_32_1)
	print("OnEndDragItem")
	arg_32_0:GetSystemModule(IslandConst.AGORA_GRASSLAND):SetVisible(arg_32_1, false)

	return
end

function var_0_0.OnPositionOccupied(arg_33_0, arg_33_1)
	arg_33_0:GetAgoraMould(arg_33_1):ShowOrHideArea(true, true)

	return
end

function var_0_0.OnClearPositionOccupied(arg_34_0, arg_34_1)
	for iter_34_0, iter_34_1 in pairs(arg_34_0:GetUnitListByKey(IslandConst.UNIT_LIST_AGORA)) do
		if iter_34_1.id ~= arg_34_1 then
			iter_34_1:ShowOrHideArea(false, false)
		end
	end

	return
end

function var_0_0.OnAgoraVirtualStartInteraction(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2:GetHostId()
	local var_35_1 = arg_35_2:GetUserId()

	warning("start", var_35_0, var_35_1, arg_35_3, arg_35_2.id)

	local var_35_2 = arg_35_0:GetUnitModule(var_35_0)
	local var_35_3 = arg_35_0:GetPlayerUnitModule(var_35_1)
	local var_35_4 = arg_35_0.player == var_35_3

	if arg_35_0.player == var_35_3 then
		arg_35_0:GetSubView(AgoraOpView):StartInteraction()
	end

	var_35_2:StartInteract(var_35_3, arg_35_2.id, arg_35_3, arg_35_1:GetTimeline()[arg_35_3], arg_35_1:GetBlackboardParam()[arg_35_3], arg_35_1:AnySlotUsing(), var_35_4, (arg_35_1:GetPlayerParentPath(arg_35_2.id)))

	return
end

function var_0_0.OnAgoraVirtualEndInteraction(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_2:GetHostId()
	local var_36_1 = arg_36_2:GetUserId()

	warning("end", var_36_0, var_36_1, arg_36_2.id)

	local var_36_2 = arg_36_0:GetUnitModule(var_36_0)
	local var_36_3 = arg_36_0:GetPlayerUnitModule(var_36_1)
	local var_36_4 = arg_36_0.player == var_36_3

	if arg_36_0.player == var_36_3 then
		arg_36_0:GetSubView(AgoraOpView):EndInteraction()
	end

	var_36_2:EndInteract(var_36_3, arg_36_2.id, not arg_36_1:AnySlotUsing(), var_36_4)

	return
end

function var_0_0.OnMapStateUpdate(arg_37_0, arg_37_1)
	if arg_37_0.debugMap then
		arg_37_0.debugMap:UpdateItem(arg_37_1.position, arg_37_1.flag)
	end

	return
end

function var_0_0.OnEnterEditMode(arg_38_0)
	arg_38_0:EnterMode(var_0_0.MODE_EDIT)
	arg_38_0:SwitchLookat(false)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.AGORA_CAMERA_NAME)
	arg_38_0.decorationView:Execute("Show")

	for iter_38_0, iter_38_1 in ipairs(arg_38_0:GetAllUnits()) do
		iter_38_1:Disable()
	end

	for iter_38_2, iter_38_3 in pairs(arg_38_0:GetUnitListByKey(IslandConst.UNIT_LIST_AGORA)) do
		iter_38_3:Disable()
	end

	local var_38_0 = arg_38_0.agora:GetSize()
	local var_38_1 = var_38_0.x * var_38_0.y

	for iter_38_4, iter_38_5 in pairs(arg_38_0.grids) do
		setActive(iter_38_5, iter_38_4 <= var_38_1)
	end

	arg_38_0:RestLookAtPosition()

	return
end

function var_0_0.OnExitEditMode(arg_39_0)
	arg_39_0:EnterMode(var_0_0.MODE_OVERVIEW)
	arg_39_0:SwitchLookat(false)
	IslandCameraMgr.instance:ActiveVirtualCamera(IslandConst.FOLLOW_CAMERA_NAME)
	arg_39_0.decorationView:Execute("Reset")
	arg_39_0:GetSubView(AgoraOpView):InActiveDragBtn()

	for iter_39_0, iter_39_1 in ipairs(arg_39_0:GetAllUnits()) do
		iter_39_1:Enable()
	end

	for iter_39_2, iter_39_3 in pairs(arg_39_0:GetUnitListByKey(IslandConst.UNIT_LIST_AGORA)) do
		iter_39_3:Enable()
	end

	for iter_39_4, iter_39_5 in pairs(arg_39_0.grids) do
		setActive(iter_39_5, false)
	end

	return
end

function var_0_0.EnterPaveTileMode(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:EnterMode(var_0_0.MODE_PAVE_TILE)
	arg_40_0:Op("SelectedPaveItem", arg_40_1.id, arg_40_2)
	arg_40_0.decorationView:Execute("Hide")
	arg_40_0.paveTileView:Execute("Show", arg_40_1, arg_40_2)
	arg_40_0:RestLookAtPosition(1)

	return
end

function var_0_0.ExitPaveTileMode(arg_41_0)
	arg_41_0:EnterMode(var_0_0.MODE_EDIT)
	arg_41_0:Op("UnSelectedPaveItem")
	arg_41_0.decorationView:Execute("Show")
	arg_41_0.paveTileView:Execute("Hide")

	return
end

function var_0_0.EnterMode(arg_42_0, arg_42_1)
	arg_42_0.mode = arg_42_1

	arg_42_0:GetSubView(AgoraOpView):EnterMode(arg_42_1)

	return
end

function var_0_0.RestLookAtPosition(arg_43_0, arg_43_1)
	LuaHelper.SetCinemachineFreeLookXAndY(IslandCameraMgr.instance:GetVirtualCamera(IslandConst.AGORA_CAMERA_NAME), 0, arg_43_1 or 0.5)
	arg_43_0.agoraLookAtObj:SetTargetPosition((AgoraCalc.MapPosition2WorldPosition(Vector2(0, 0))))

	return
end

function var_0_0.GetAgoraMould(arg_44_0, arg_44_1)
	return arg_44_0:GetUnitModuleWithType(IslandConst.UNIT_LIST_AGORA, arg_44_1)
end

function var_0_0.OnDispose(arg_45_0)
	if arg_45_0.selectedUnitId then
		arg_45_0:OnClearSelectedUnit()

		arg_45_0.selectedUnitId = nil
	end

	var_0_0.super.OnDispose(arg_45_0)

	if arg_45_0.decorationView then
		arg_45_0.decorationView:Dispose()

		arg_45_0.decorationView = nil
	end

	if arg_45_0.paveTileView then
		arg_45_0.paveTileView:Dispose()

		arg_45_0.paveTileView = nil
	end

	if arg_45_0.reloadingView then
		arg_45_0.reloadingView:Dispose()

		arg_45_0.reloadingView = nil
	end

	arg_45_0:GetPoolMgr():ClearAograPools()

	if var_0_1 and arg_45_0.debugMap then
		arg_45_0.debugMap:Dispose()

		arg_45_0.debugMap = nil
	end

	return
end

return var_0_0
