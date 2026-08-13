class = var_0_10000

local var_0_0 = "AgoraView"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseAgoraView"))

var_0_1.MODE_OVERVIEW = 1
var_0_1.MODE_EDIT = 2
var_0_1.MODE_PAVE_TILE = 3

local var_0_2 = false

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	GameObject = var_1

	local var_1_0 = var_1.Find("AgoraMainStage")

	GetOrAddComponent = var_1_10002

	local var_1_1 = var_1_0.transform

	arg_1_0.agoraLookAtObj = var_1_10002(var_4.Find(var_1_1, "lookat"), "AgoraLookAtObj")

	local var_1_2 = var_1_0.transform

	arg_1_0.lookatBuilding = var_2.Find(var_1_2, "lookat_building")

	local var_1_3 = var_1_0.transform

	arg_1_0.furnitureRoot = var_2.Find(var_1_3, "furniture")

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.RegisterUnitList

	IslandConst = var_5

	var_1_5(var_1_4, var_5.UNIT_LIST_AGORA)

	AgoraMouldBuilder = var_1_5

	local var_1_6 = var_1_5.New
	local var_1_7 = arg_1_0

	IslandConst = var_5
	arg_1_0.mouldBuilder = var_1_6(var_1_7, var_5.UNIT_LIST_AGORA)

	if var_0_2 then
		AgoraDebugMap = var_2
		arg_1_0.debugMap = var_2.New(arg_1_0)
	end

	arg_1_0.mode = var_0_1.MODE_OVERVIEW
	arg_1_0.decorationView = arg_1_0:CreateDecorationView()
	AgoraPaveTileView = var_2
	arg_1_0.paveTileView = var_2.New(arg_1_0)
	AgoraReloadingView = var_2
	arg_1_0.reloadingView = var_2.New(arg_1_0)
	GameObject = var_2
	arg_1_0.gridTr = var_2.Find("/[MainBlock]/[Model]/nobake/pre_grid")

	local var_1_8 = {}

	GameObject = var_3

	local var_1_9 = var_3.Find("/[MainBlock]/[Model]/nobake/level2")

	var_1_8[4356] = var_1_9
	GameObject = var_1_9

	local var_1_10 = var_1_9.Find("/[MainBlock]/[Model]/nobake/level3")

	var_1_8[6084] = var_1_10
	arg_1_0.trees = var_1_8

	local var_1_11 = {}

	GameObject = var_1_10

	local var_1_12 = var_1_10.Find("/[MainBlock]/[Model]/nobake/pre_grid/level1")

	var_1_11[1600] = var_1_12
	GameObject = var_1_12

	local var_1_13 = var_1_12.Find("/[MainBlock]/[Model]/nobake/pre_grid/level2")

	var_1_11[4356] = var_1_13
	GameObject = var_1_13

	local var_1_14 = var_1_13.Find("/[MainBlock]/[Model]/nobake/pre_grid/level3")

	var_1_11[6084] = var_1_14
	arg_1_0.grids = var_1_11
	pairs = var_1_11

	for iter_1_0, iter_1_1 in var_1_11(arg_1_0.grids) do
		setActive = var_7

		var_7(iter_1_1, false)
	end

	setActive = var_2

	var_2(arg_1_0.gridTr, true)

	return
end

function var_0_1.CreateOpView(arg_2_0)
	AgoraOpView = var_1_10001

	return var_1_10001.New(arg_2_0)
end

function var_0_1.CreateDecorationView(arg_3_0)
	AgoraDecorationView = var_1_10001

	return var_1_10001.New(arg_3_0)
end

function var_0_1.AddAgoraListeners(arg_4_0)
	local var_4_0 = arg_4_0
	local var_4_1 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_1_10004

	var_4_1(var_4_0, var_1_10004.GEN_ITEM, arg_4_0.OnGenItem)

	local var_4_2 = arg_4_0
	local var_4_3 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_3(var_4_2, var_4.REMOVE_ITEM, arg_4_0.OnRemoveItem)

	local var_4_4 = arg_4_0
	local var_4_5 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_5(var_4_4, var_4.UNPLACE_ITEM, arg_4_0.OnUnplaceItem)

	local var_4_6 = arg_4_0
	local var_4_7 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_7(var_4_6, var_4.ENTER_EDIT, arg_4_0.OnEnterEditMode)

	local var_4_8 = arg_4_0
	local var_4_9 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_9(var_4_8, var_4.ENTER_EDIT_FAILED, arg_4_0.OnEnterFailed)

	local var_4_10 = arg_4_0
	local var_4_11 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_11(var_4_10, var_4.EXIT_EDIT, arg_4_0.OnExitEditMode)

	if var_0_2 then
		local var_4_12 = arg_4_0
		local var_4_13 = arg_4_0.AddAgoraListener

		ISLAND_AGORA_EVT = var_4

		var_4_13(var_4_12, var_4.MAP_STATE_UPDATE, arg_4_0.OnMapStateUpdate)
	end

	local var_4_14 = arg_4_0
	local var_4_15 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_15(var_4_14, var_4.SELECTED_ITEM, arg_4_0.OnSelectedItem)

	local var_4_16 = arg_4_0
	local var_4_17 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_17(var_4_16, var_4.UNSELECTED_ITEM, arg_4_0.OnUnSelectedItem)

	local var_4_18 = arg_4_0
	local var_4_19 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_19(var_4_18, var_4.CONFIRM_SELECTED_ITEM, arg_4_0.OnConfirmItem)

	local var_4_20 = arg_4_0
	local var_4_21 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_21(var_4_20, var_4.DRAG_ITEM_BEGIN, arg_4_0.OnBeginDragItem)

	local var_4_22 = arg_4_0
	local var_4_23 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_23(var_4_22, var_4.DRAG_ITEM, arg_4_0.OnDragItem)

	local var_4_24 = arg_4_0
	local var_4_25 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_25(var_4_24, var_4.DRAG_ITEM_END, arg_4_0.OnEndDragItem)

	local var_4_26 = arg_4_0
	local var_4_27 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_27(var_4_26, var_4.MAP_SIZE_UPDATE, arg_4_0.OnBoardUpdate)

	local var_4_28 = arg_4_0
	local var_4_29 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_29(var_4_28, var_4.START_INTERACTION, arg_4_0.OnAgoraVirtualStartInteraction)

	local var_4_30 = arg_4_0
	local var_4_31 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_31(var_4_30, var_4.END_INTERACTION, arg_4_0.OnAgoraVirtualEndInteraction)

	local var_4_32 = arg_4_0
	local var_4_33 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_33(var_4_32, var_4.ITEM_OCCUPIED, arg_4_0.OnPositionOccupied)

	local var_4_34 = arg_4_0
	local var_4_35 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_35(var_4_34, var_4.ITEM_CLEAR_OCCUPIED, arg_4_0.OnClearPositionOccupied)

	local var_4_36 = arg_4_0
	local var_4_37 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_37(var_4_36, var_4.SIGN_IN_CNT_UPDATE, arg_4_0.OnSignCntUpdate)

	local var_4_38 = arg_4_0
	local var_4_39 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_39(var_4_38, var_4.FILL_TILE_CELL, arg_4_0.OnGenTileCell)

	local var_4_40 = arg_4_0
	local var_4_41 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_41(var_4_40, var_4.CLEAR_TILE_CELL, arg_4_0.OnRemoveTileCell)

	local var_4_42 = arg_4_0
	local var_4_43 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_43(var_4_42, var_4.FILL_FLOOR_CELL, arg_4_0.OnGenFloorCell)

	local var_4_44 = arg_4_0
	local var_4_45 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_45(var_4_44, var_4.CLEAR_FLOOR_CELL, arg_4_0.OnRemoveFloorCell)

	local var_4_46 = arg_4_0
	local var_4_47 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_47(var_4_46, var_4.THEME_UPDATE, arg_4_0.OnThemeUpdate)

	local var_4_48 = arg_4_0
	local var_4_49 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_49(var_4_48, var_4.RELOADING, arg_4_0.OnReload)

	local var_4_50 = arg_4_0
	local var_4_51 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_51(var_4_50, var_4.RELOADING_FINISH, arg_4_0.OnReloadFinish)

	local var_4_52 = arg_4_0
	local var_4_53 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_53(var_4_52, var_4.START_LOAD_ITEMS, arg_4_0.OnStartLoadItems)

	local var_4_54 = arg_4_0
	local var_4_55 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_55(var_4_54, var_4.END_LOAD_ITEMS, arg_4_0.OnEndLoadItems)

	local var_4_56 = arg_4_0
	local var_4_57 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_57(var_4_56, var_4.SAVE, arg_4_0.OnSave)

	local var_4_58 = arg_4_0
	local var_4_59 = arg_4_0.AddAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_4_59(var_4_58, var_4.TAG_CHANGE, arg_4_0.OnTagChange)

	local var_4_60 = arg_4_0
	local var_4_61 = arg_4_0.AddAgoraListener

	ISLAND_EVT = var_4

	var_4_61(var_4_60, var_4.GEN_UNIT, arg_4_0.OnGenUnit)

	local var_4_62 = arg_4_0
	local var_4_63 = arg_4_0.AddAgoraListener

	ISLAND_EVT = var_4

	var_4_63(var_4_62, var_4.RMOVE_UNIT, arg_4_0.OnRemoveUnit)

	local var_4_64 = arg_4_0
	local var_4_65 = arg_4_0.AddAgoraListener

	ISLAND_EVT = var_4

	var_4_65(var_4_64, var_4.RESET_UNIT_POS, arg_4_0.OnResetUnitPos)

	local var_4_66 = arg_4_0
	local var_4_67 = arg_4_0.AddAgoraListener

	ISLAND_EVT = var_4

	var_4_67(var_4_66, var_4.RESET_UNIT_ROT, arg_4_0.OnResetUnitRotation)

	return
end

function var_0_1.RemoveAgoraListeners(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_1_10004

	var_5_1(var_5_0, var_1_10004.GEN_ITEM, arg_5_0.OnGenItem)

	local var_5_2 = arg_5_0
	local var_5_3 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_3(var_5_2, var_4.REMOVE_ITEM, arg_5_0.OnRemoveItem)

	local var_5_4 = arg_5_0
	local var_5_5 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_5(var_5_4, var_4.UNPLACE_ITEM, arg_5_0.OnUnplaceItem)

	local var_5_6 = arg_5_0
	local var_5_7 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_7(var_5_6, var_4.ENTER_EDIT, arg_5_0.OnEnterEditMode)

	local var_5_8 = arg_5_0
	local var_5_9 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_9(var_5_8, var_4.ENTER_EDIT_FAILED, arg_5_0.OnEnterFailed)

	local var_5_10 = arg_5_0
	local var_5_11 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_11(var_5_10, var_4.EXIT_EDIT, arg_5_0.OnExitEditMode)

	if var_0_2 then
		local var_5_12 = arg_5_0
		local var_5_13 = arg_5_0.RemoveAgoraListener

		ISLAND_AGORA_EVT = var_4

		var_5_13(var_5_12, var_4.MAP_STATE_UPDATE, arg_5_0.OnMapStateUpdate)
	end

	local var_5_14 = arg_5_0
	local var_5_15 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_15(var_5_14, var_4.SELECTED_ITEM, arg_5_0.OnSelectedItem)

	local var_5_16 = arg_5_0
	local var_5_17 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_17(var_5_16, var_4.UNSELECTED_ITEM, arg_5_0.OnUnSelectedItem)

	local var_5_18 = arg_5_0
	local var_5_19 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_19(var_5_18, var_4.CONFIRM_SELECTED_ITEM, arg_5_0.OnConfirmItem)

	local var_5_20 = arg_5_0
	local var_5_21 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_21(var_5_20, var_4.DRAG_ITEM_BEGIN, arg_5_0.OnBeginDragItem)

	local var_5_22 = arg_5_0
	local var_5_23 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_23(var_5_22, var_4.DRAG_ITEM, arg_5_0.OnDragItem)

	local var_5_24 = arg_5_0
	local var_5_25 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_25(var_5_24, var_4.DRAG_ITEM_END, arg_5_0.OnEndDragItem)

	local var_5_26 = arg_5_0
	local var_5_27 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_27(var_5_26, var_4.MAP_SIZE_UPDATE, arg_5_0.OnBoardUpdate)

	local var_5_28 = arg_5_0
	local var_5_29 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_29(var_5_28, var_4.START_INTERACTION, arg_5_0.OnAgoraVirtualStartInteraction)

	local var_5_30 = arg_5_0
	local var_5_31 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_31(var_5_30, var_4.END_INTERACTION, arg_5_0.OnAgoraVirtualEndInteraction)

	local var_5_32 = arg_5_0
	local var_5_33 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_33(var_5_32, var_4.ITEM_OCCUPIED, arg_5_0.OnPositionOccupied)

	local var_5_34 = arg_5_0
	local var_5_35 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_35(var_5_34, var_4.ITEM_CLEAR_OCCUPIED, arg_5_0.OnClearPositionOccupied)

	local var_5_36 = arg_5_0
	local var_5_37 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_37(var_5_36, var_4.SIGN_IN_CNT_UPDATE, arg_5_0.OnSignCntUpdate)

	local var_5_38 = arg_5_0
	local var_5_39 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_39(var_5_38, var_4.FILL_TILE_CELL, arg_5_0.OnGenTileCell)

	local var_5_40 = arg_5_0
	local var_5_41 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_41(var_5_40, var_4.CLEAR_TILE_CELL, arg_5_0.OnRemoveTileCell)

	local var_5_42 = arg_5_0
	local var_5_43 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_43(var_5_42, var_4.FILL_FLOOR_CELL, arg_5_0.OnGenFloorCell)

	local var_5_44 = arg_5_0
	local var_5_45 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_45(var_5_44, var_4.CLEAR_FLOOR_CELL, arg_5_0.OnRemoveFloorCell)

	local var_5_46 = arg_5_0
	local var_5_47 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_47(var_5_46, var_4.THEME_UPDATE, arg_5_0.OnThemeUpdate)

	local var_5_48 = arg_5_0
	local var_5_49 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_49(var_5_48, var_4.RELOADING, arg_5_0.OnReload)

	local var_5_50 = arg_5_0
	local var_5_51 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_51(var_5_50, var_4.RELOADING_FINISH, arg_5_0.OnReloadFinish)

	local var_5_52 = arg_5_0
	local var_5_53 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_53(var_5_52, var_4.START_LOAD_ITEMS, arg_5_0.OnStartLoadItems)

	local var_5_54 = arg_5_0
	local var_5_55 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_55(var_5_54, var_4.END_LOAD_ITEMS, arg_5_0.OnEndLoadItems)

	local var_5_56 = arg_5_0
	local var_5_57 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_57(var_5_56, var_4.SAVE, arg_5_0.OnSave)

	local var_5_58 = arg_5_0
	local var_5_59 = arg_5_0.RemoveAgoraListener

	ISLAND_AGORA_EVT = var_4

	var_5_59(var_5_58, var_4.TAG_CHANGE, arg_5_0.OnTagChange)

	local var_5_60 = arg_5_0
	local var_5_61 = arg_5_0.RemoveAgoraListener

	ISLAND_EVT = var_4

	var_5_61(var_5_60, var_4.GEN_UNIT, arg_5_0.OnGenUnit)

	local var_5_62 = arg_5_0
	local var_5_63 = arg_5_0.RemoveAgoraListener

	ISLAND_EVT = var_4

	var_5_63(var_5_62, var_4.RMOVE_UNIT, arg_5_0.OnRemoveUnit)

	local var_5_64 = arg_5_0
	local var_5_65 = arg_5_0.RemoveAgoraListener

	ISLAND_EVT = var_4

	var_5_65(var_5_64, var_4.RESET_UNIT_POS, arg_5_0.OnResetUnitPos)

	local var_5_66 = arg_5_0
	local var_5_67 = arg_5_0.RemoveAgoraListener

	ISLAND_EVT = var_4

	var_5_67(var_5_66, var_4.RESET_UNIT_ROT, arg_5_0.OnResetUnitRotation)

	return
end

function var_0_1.OnSave(arg_6_0)
	if arg_6_0.decorationView then
		local var_6_0 = arg_6_0.decorationView

		if var_1.IsLoaded(var_6_0) then
			local var_6_1 = arg_6_0.decorationView

			var_1.Execute(var_6_1, "FlushSaveBtn")
		end
	end

	return
end

function var_0_1.OnStartLoadItems(arg_7_0)
	arg_7_0.startLoadItemsFlag = true

	return
end

function var_0_1.OnEndLoadItems(arg_8_0, arg_8_1)
	arg_8_0.startLoadItemsFlag = false

	if arg_8_1 then
		AgoraCalc = var_2

		local var_8_0 = var_2.MapPosition2WorldPosition(arg_8_1)

		arg_8_0.lookatBuilding.position = var_8_0
	end

	return
end

function var_0_1.OnReload(arg_9_0)
	local var_9_0 = arg_9_0.reloadingView

	var_1.Execute(var_9_0, "Show")

	return
end

function var_0_1.OnReloadFinish(arg_10_0)
	local var_10_0 = arg_10_0.reloadingView

	var_1.Execute(var_10_0, "Hide")

	return
end

function var_0_1.OnThemeUpdate(arg_11_0)
	local var_11_0 = arg_11_0.decorationView

	var_1.Execute(var_11_0, "FlushThemeList")

	return
end

function var_0_1.OnGenFloorCell(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_0
	local var_12_1 = arg_12_0.GetSystemModule

	IslandConst = var_1_10005

	local var_12_2 = var_12_1(var_12_0, var_1_10005.AGORA_GROUND_SYSTEM_ID)

	var_2.FillFloorCell(var_12_2, arg_12_1)

	return
end

function var_0_1.OnRemoveFloorCell(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0
	local var_13_1 = arg_13_0.GetSystemModule

	IslandConst = var_1_10005

	local var_13_2 = var_13_1(var_13_0, var_1_10005.AGORA_GROUND_SYSTEM_ID)

	var_2.ClearFloorCell(var_13_2, arg_13_1)

	return
end

function var_0_1.OnGenTileCell(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0
	local var_14_1 = arg_14_0.GetSystemModule

	IslandConst = var_1_10005

	local var_14_2 = var_14_1(var_14_0, var_1_10005.AGORA_GROUND_SYSTEM_ID)

	var_2.FillTileCell(var_14_2, arg_14_1)

	return
end

function var_0_1.OnRemoveTileCell(arg_15_0, arg_15_1)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.GetSystemModule

	IslandConst = var_1_10005

	local var_15_2 = var_15_1(var_15_0, var_1_10005.AGORA_GROUND_SYSTEM_ID)

	var_2.ClearTileCell(var_15_2, arg_15_1)

	return
end

function var_0_1.OnEnterFailed(arg_16_0)
	local var_16_0 = arg_16_0
	local var_16_1 = arg_16_0.NotifiyIsland

	ISLAND_EX_EVT = var_1_10004

	var_16_1(var_16_0, var_1_10004.PLAY_STORY, {
		name = "ISLANDSTORY101"
	})

	return
end

function var_0_1.OnClearSelectedUnit(arg_17_0)
	var_0_1.super.OnClearSelectedUnit(arg_17_0)

	if arg_17_0.selectedUnitId then
		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.GetSubView

		IslandInteractionView = var_1_10004

		local var_17_2 = var_17_1(var_17_0, var_1_10004)

		var_1.HideInterActionPanel(var_17_2)

		if arg_17_0:GetUnitModule(arg_17_0.selectedUnitId) then
			GetOrAddComponent = var_1_10002

			local var_17_3 = var_1._go

			typeof = var_1_10005
			HighlightController = var_1_10007

			local var_17_4 = var_1_10002(var_17_3, var_1_10005(var_1_10007))

			var_2.HighlightOff(var_17_4)
		end

		arg_17_0.selectedUnitId = nil
	end

	return
end

function var_0_1.OnSelectedUnit(arg_18_0, arg_18_1)
	var_0_1.super.OnSelectedUnit(arg_18_0, arg_18_1)

	if arg_18_0.selectedUnitId then
		arg_18_0:OnClearSelectedUnit()
	end

	local var_18_0 = arg_18_1.data

	if var_2.IsGift(var_18_0) then
		GetOrAddComponent = var_2

		local var_18_1 = arg_18_1._go

		typeof = var_5
		HighlightController = var_1_10007

		local var_18_2 = var_2(var_18_1, var_5(var_1_10007))

		var_2.HighlightOn(var_18_2)

		arg_18_0.selectedUnitId = arg_18_1.id

		local var_18_3 = arg_18_0
		local var_18_4 = arg_18_0.GetSubView

		IslandInteractionView = var_1_10006

		local var_18_5 = var_18_4(var_18_3, var_1_10006)

		var_3.ShowInterActionPanel(var_18_5, {
			type = 41
		})
	end

	return
end

function var_0_1.OnSignCntUpdate(arg_19_0, arg_19_1)
	local var_19_0 = arg_19_0
	local var_19_1 = arg_19_0.GetSubView

	AgoraOpView = var_1_10005

	local var_19_2 = var_19_1(var_19_0, var_1_10005)

	var_2.UpdateSignInTip(var_19_2)

	return
end

function var_0_1.OnGenItem(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0.mouldBuilder
	local var_20_1 = var_3.Build(var_20_0, arg_20_1, arg_20_2)

	arg_20_0:AddUnit(var_20_1)

	if arg_20_0.mode == var_0_1.MODE_EDIT then
		local var_20_2 = arg_20_0.decorationView

		var_4.Execute(var_20_2, "FlushCard", arg_20_1.id)

		local var_20_3 = arg_20_0.decorationView

		var_4.Execute(var_20_3, "FlushCapacity")

		if not arg_20_0.startLoadItemsFlag then
			arg_20_0:LookAtItem(var_20_1)
		end
	end

	local var_20_4 = arg_20_0
	local var_20_5 = arg_20_0.GetSystemModule

	IslandConst = var_7

	local var_20_6 = var_20_5(var_20_4, var_7.AGORA_GRASSLAND)

	var_4.SetVisible(var_20_6, arg_20_1, false)

	return
end

function var_0_1.OnTagChange(arg_21_0, arg_21_1)
	AgoraFurnitureType = var_1_10002

	local var_21_0 = arg_21_1 == var_1_10002.BUILDING

	arg_21_0:SwitchLookat(var_21_0)

	local var_21_1 = arg_21_0
	local var_21_2 = arg_21_0.GetSubView

	AgoraOpView = var_6

	local var_21_3 = var_21_2(var_21_1, var_6)

	var_3.ShowMoveBtn(var_21_3, not var_21_0)

	return
end

function var_0_1.SwitchLookat(arg_22_0, arg_22_1)
	IslandCameraMgr = var_1_10002

	local var_22_0 = var_1_10002.instance
	local var_22_1 = var_2.GetVirtualCamera

	IslandConst = var_1_10005

	local var_22_2 = var_22_1(var_22_0, var_1_10005.AGORA_CAMERA_NAME)

	if arg_22_1 then
		var_22_2.Follow = arg_22_0.lookatBuilding
		var_22_2.LookAt = arg_22_0.lookatBuilding
	else
		var_22_2.Follow = arg_22_0.agoraLookAtObj.gameObject.transform
		var_22_2.LookAt = arg_22_0.agoraLookAtObj.gameObject.transform
	end

	arg_22_0.agoraLookAtObj.enabled = not arg_22_1

	return
end

function var_0_1.LookAtItem(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1.data

	AgoraCalc = var_1_10003

	local var_23_1 = var_1_10003.GetCenterMapPos()
	local var_23_2 = var_23_0:GetPosition()

	if not var_23_0:IsBuildingType() and var_23_1 ~= var_23_2 then
		AgoraCalc = var_5

		local var_23_3 = var_5.MapPosition2WorldPosition(var_23_2)
		local var_23_4 = arg_23_0.agoraLookAtObj

		var_6.SetTargetPosition(var_23_4, var_23_3)
	end

	return
end

function var_0_1.OnRemoveItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0:GetAgoraMould(arg_24_1.id)

	var_2.Dispose(var_24_0)
	arg_24_0:RemoveUnit(var_2)

	if arg_24_0.mode == var_0_1.MODE_EDIT then
		local var_24_1 = arg_24_0.decorationView

		var_3.Execute(var_24_1, "FlushCard", arg_24_1.id)

		local var_24_2 = arg_24_0.decorationView

		var_3.Execute(var_24_2, "FlushCapacity")
	end

	local var_24_3 = arg_24_0
	local var_24_4 = arg_24_0.GetSystemModule

	IslandConst = var_6

	local var_24_5 = var_24_4(var_24_3, var_6.AGORA_GRASSLAND)

	var_3.SetVisible(var_24_5, arg_24_1, true)

	return
end

function var_0_1.OnBoardUpdate(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_1.x * arg_25_1.y

	pairs = var_3

	for iter_25_0, iter_25_1 in var_3(arg_25_0.trees) do
		setActive = var_1_10008

		var_1_10008(iter_25_1, var_25_0 < iter_25_0)
	end

	if arg_25_0.mode ~= var_0_1.MODE_OVERVIEW then
		pairs = var_3

		for iter_25_2, iter_25_3 in var_3(arg_25_0.grids) do
			setActive = var_1_10008

			var_1_10008(iter_25_3, iter_25_2 <= var_25_0)
		end
	end

	AgoraCalc = var_3

	local var_25_1 = var_3.GetSizeCoord(arg_25_1)
	local var_25_2 = arg_25_0.agoraLookAtObj

	var_4.SetRange(var_25_2, var_25_1)

	return
end

function var_0_1.OnSelectedItem(arg_26_0, arg_26_1, arg_26_2)
	local var_26_0 = arg_26_0:GetAgoraMould(arg_26_1)

	var_3.ShowOrHideArea(var_26_0, false, true)

	if arg_26_2 then
		local var_26_1 = arg_26_0
		local var_26_2 = arg_26_0.GetSubView

		AgoraOpView = var_7

		local var_26_3 = var_26_2(var_26_1, var_7)

		var_4.ActiveDragBtn(var_26_3, var_3)
	end

	local var_26_4 = arg_26_0.decorationView

	var_4.Execute(var_26_4, "OnSelectedItem", arg_26_1, arg_26_2, arg_26_1)

	return
end

function var_0_1.OnUnSelectedItem(arg_27_0, arg_27_1, arg_27_2)
	local var_27_0 = arg_27_0:GetAgoraMould(arg_27_1)

	var_3.ShowOrHideArea(var_27_0, false, false)

	if arg_27_2 then
		local var_27_1 = arg_27_0
		local var_27_2 = arg_27_0.GetSubView

		AgoraOpView = var_7

		local var_27_3 = var_27_2(var_27_1, var_7)

		var_4.InActiveDragBtn(var_27_3, var_3)
	end

	local var_27_4 = arg_27_0.decorationView

	var_4.Execute(var_27_4, "OnSelectedItem", -1, arg_27_2, arg_27_1)

	return
end

function var_0_1.OnConfirmItem(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0.decorationView

	var_2.Execute(var_28_0, "OnCreateSameItem", arg_28_1)

	return
end

function var_0_1.OnUnplaceItem(arg_29_0)
	local var_29_0 = arg_29_0.decorationView

	var_1.Execute(var_29_0, "OnSelectedItem", -1, true)

	return
end

function var_0_1.OnBeginDragItem(arg_30_0, arg_30_1)
	print = var_1_10002

	var_1_10002("OnBeginDragItem")

	local var_30_0 = arg_30_0
	local var_30_1 = arg_30_0.GetSystemModule

	IslandConst = var_1_10005

	local var_30_2 = var_30_1(var_30_0, var_1_10005.AGORA_GRASSLAND)

	var_2.SetVisible(var_30_2, arg_30_1, true)

	return
end

function var_0_1.OnDragItem(arg_31_0, arg_31_1, arg_31_2)
	local var_31_0 = arg_31_0:GetAgoraMould(arg_31_1)

	var_3.ShowOrHideArea(var_31_0, not arg_31_2, true)

	return
end

function var_0_1.OnEndDragItem(arg_32_0, arg_32_1)
	print = var_1_10002

	var_1_10002("OnEndDragItem")

	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.GetSystemModule

	IslandConst = var_1_10005

	local var_32_2 = var_32_1(var_32_0, var_1_10005.AGORA_GRASSLAND)

	var_2.SetVisible(var_32_2, arg_32_1, false)

	return
end

function var_0_1.OnPositionOccupied(arg_33_0, arg_33_1)
	local var_33_0 = arg_33_0:GetAgoraMould(arg_33_1)

	var_2.ShowOrHideArea(var_33_0, true, true)

	return
end

function var_0_1.OnClearPositionOccupied(arg_34_0, arg_34_1)
	pairs = var_1_10002

	local var_34_0 = arg_34_0
	local var_34_1 = arg_34_0.GetUnitListByKey

	IslandConst = var_1_10007

	for iter_34_0, iter_34_1 in var_1_10002(var_34_1(var_34_0, var_1_10007.UNIT_LIST_AGORA)) do
		if iter_34_1.id ~= arg_34_1 then
			iter_34_1:ShowOrHideArea(false, false)
		end
	end

	return
end

function var_0_1.OnAgoraVirtualStartInteraction(arg_35_0, arg_35_1, arg_35_2, arg_35_3)
	local var_35_0 = arg_35_2
	local var_35_1 = arg_35_2.GetHostId(var_35_0)
	local var_35_2 = arg_35_2:GetUserId()

	warning = var_35_0

	var_35_0("start", var_35_1, var_35_2, arg_35_3, arg_35_2.id)

	local var_35_3 = arg_35_0:GetUnitModule(var_35_1)
	local var_35_4 = arg_35_0:GetPlayerUnitModule(var_35_2)

	if arg_35_0.player == var_35_4 then
		local var_35_5 = arg_35_0
		local var_35_6 = arg_35_0.GetSubView

		AgoraOpView = var_12

		local var_35_7 = var_35_6(var_35_5, var_12)

		var_9.StartInteraction(var_35_7)
	end

	local var_35_8 = arg_35_1:GetTimeline()[arg_35_3]
	local var_35_9 = arg_35_1:GetBlackboardParam()[arg_35_3]
	local var_35_10 = arg_35_1:GetPlayerParentPath(arg_35_2.id)

	var_35_3:StartInteract(var_35_4, arg_35_2.id, arg_35_3, var_35_8, var_35_9, arg_35_1:AnySlotUsing(), var_8, var_35_10)

	return
end

function var_0_1.OnAgoraVirtualEndInteraction(arg_36_0, arg_36_1, arg_36_2)
	local var_36_0 = arg_36_2
	local var_36_1 = arg_36_2.GetHostId(var_36_0)
	local var_36_2 = arg_36_2:GetUserId()

	warning = var_36_0

	var_36_0("end", var_36_1, var_36_2, arg_36_2.id)

	local var_36_3 = arg_36_0:GetUnitModule(var_36_1)
	local var_36_4 = arg_36_0:GetPlayerUnitModule(var_36_2)

	if arg_36_0.player == var_36_4 then
		local var_36_5 = arg_36_0
		local var_36_6 = arg_36_0.GetSubView

		AgoraOpView = var_1_10011

		local var_36_7 = var_36_6(var_36_5, var_1_10011)

		var_8.EndInteraction(var_36_7)
	end

	var_36_3:EndInteract(var_36_4, arg_36_2.id, not arg_36_1:AnySlotUsing(), var_7)

	return
end

function var_0_1.OnMapStateUpdate(arg_37_0, arg_37_1)
	if arg_37_0.debugMap then
		local var_37_0 = arg_37_0.debugMap

		var_2.UpdateItem(var_37_0, arg_37_1.position, arg_37_1.flag)
	end

	return
end

function var_0_1.OnEnterEditMode(arg_38_0)
	arg_38_0:EnterMode(var_0_1.MODE_EDIT)
	arg_38_0:SwitchLookat(false)

	IslandCameraMgr = var_1

	local var_38_0 = var_1.instance
	local var_38_1 = var_1.ActiveVirtualCamera

	IslandConst = var_4

	var_38_1(var_38_0, var_4.AGORA_CAMERA_NAME)

	local var_38_2 = arg_38_0.decorationView

	var_1.Execute(var_38_2, "Show")

	ipairs = var_1

	for iter_38_0, iter_38_1 in var_1(arg_38_0:GetAllUnits()) do
		var_1_10008 = iter_38_1

		iter_38_1.Disable(var_1_10008)
	end

	pairs = var_1

	local var_38_3 = arg_38_0
	local var_38_4 = arg_38_0.GetUnitListByKey

	IslandConst = var_1_10006

	for iter_38_2, iter_38_3 in var_1(var_38_4(var_38_3, var_1_10006.UNIT_LIST_AGORA)) do
		var_1_10008 = iter_38_3

		iter_38_3.Disable(var_1_10008)
	end

	local var_38_5 = arg_38_0.agora
	local var_38_6 = var_1.GetSize(var_38_5).x * var_1.y

	pairs = var_3

	for iter_38_4, iter_38_5 in var_3(arg_38_0.grids) do
		setActive = var_1_10008

		var_1_10008(iter_38_5, iter_38_4 <= var_38_6)
	end

	arg_38_0:RestLookAtPosition()

	return
end

function var_0_1.OnExitEditMode(arg_39_0)
	arg_39_0:EnterMode(var_0_1.MODE_OVERVIEW)
	arg_39_0:SwitchLookat(false)

	IslandCameraMgr = var_1

	local var_39_0 = var_1.instance
	local var_39_1 = var_1.ActiveVirtualCamera

	IslandConst = var_4

	var_39_1(var_39_0, var_4.FOLLOW_CAMERA_NAME)

	local var_39_2 = arg_39_0.decorationView

	var_1.Execute(var_39_2, "Reset")

	local var_39_3 = arg_39_0
	local var_39_4 = arg_39_0.GetSubView

	AgoraOpView = var_4

	local var_39_5 = var_39_4(var_39_3, var_4)

	var_1.InActiveDragBtn(var_39_5)

	ipairs = var_1

	for iter_39_0, iter_39_1 in var_1(arg_39_0:GetAllUnits()) do
		iter_39_1:Enable()
	end

	pairs = var_1

	local var_39_6 = arg_39_0
	local var_39_7 = arg_39_0.GetUnitListByKey

	IslandConst = var_1_10006

	for iter_39_2, iter_39_3 in var_1(var_39_7(var_39_6, var_1_10006.UNIT_LIST_AGORA)) do
		iter_39_3:Enable()
	end

	pairs = var_1

	for iter_39_4, iter_39_5 in var_1(arg_39_0.grids) do
		setActive = var_6

		var_6(iter_39_5, false)
	end

	return
end

function var_0_1.EnterPaveTileMode(arg_40_0, arg_40_1, arg_40_2)
	arg_40_0:EnterMode(var_0_1.MODE_PAVE_TILE)
	arg_40_0:Op("SelectedPaveItem", arg_40_1.id, arg_40_2)

	local var_40_0 = arg_40_0.decorationView

	var_3.Execute(var_40_0, "Hide")

	local var_40_1 = arg_40_0.paveTileView

	var_3.Execute(var_40_1, "Show", arg_40_1, arg_40_2)
	arg_40_0:RestLookAtPosition(1)

	return
end

function var_0_1.ExitPaveTileMode(arg_41_0)
	arg_41_0:EnterMode(var_0_1.MODE_EDIT)
	arg_41_0:Op("UnSelectedPaveItem")

	local var_41_0 = arg_41_0.decorationView

	var_1.Execute(var_41_0, "Show")

	local var_41_1 = arg_41_0.paveTileView

	var_1.Execute(var_41_1, "Hide")

	return
end

function var_0_1.EnterMode(arg_42_0, arg_42_1)
	arg_42_0.mode = arg_42_1

	local var_42_0 = arg_42_0
	local var_42_1 = arg_42_0.GetSubView

	AgoraOpView = var_1_10005

	local var_42_2 = var_42_1(var_42_0, var_1_10005)

	var_2.EnterMode(var_42_2, arg_42_1)

	return
end

function var_0_1.RestLookAtPosition(arg_43_0, arg_43_1)
	IslandCameraMgr = var_1_10002

	local var_43_0 = var_1_10002.instance
	local var_43_1 = var_2.GetVirtualCamera

	IslandConst = var_1_10005

	local var_43_2 = var_43_1(var_43_0, var_1_10005.AGORA_CAMERA_NAME)

	LuaHelper = var_1_10003

	var_1_10003.SetCinemachineFreeLookXAndY(var_43_2, 0, arg_43_1 or 0.5)

	AgoraCalc = var_3

	local var_43_3 = var_3.MapPosition2WorldPosition

	Vector2 = var_5

	local var_43_4 = var_43_3(var_5(0, 0))
	local var_43_5 = arg_43_0.agoraLookAtObj

	var_4.SetTargetPosition(var_43_5, var_43_4)

	return
end

function var_0_1.GetAgoraMould(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0
	local var_44_1 = arg_44_0.GetUnitModuleWithType

	IslandConst = var_1_10005

	return var_44_1(var_44_0, var_1_10005.UNIT_LIST_AGORA, arg_44_1)
end

function var_0_1.OnDispose(arg_45_0)
	if arg_45_0.selectedUnitId then
		arg_45_0:OnClearSelectedUnit()

		arg_45_0.selectedUnitId = nil
	end

	var_0_1.super.OnDispose(arg_45_0)

	if arg_45_0.decorationView then
		local var_45_0 = arg_45_0.decorationView

		var_1.Dispose(var_45_0)

		arg_45_0.decorationView = nil
	end

	if arg_45_0.paveTileView then
		local var_45_1 = arg_45_0.paveTileView

		var_1.Dispose(var_45_1)

		arg_45_0.paveTileView = nil
	end

	if arg_45_0.reloadingView then
		local var_45_2 = arg_45_0.reloadingView

		var_1.Dispose(var_45_2)

		arg_45_0.reloadingView = nil
	end

	local var_45_3 = arg_45_0:GetPoolMgr()

	var_1.ClearAograPools(var_45_3)

	if var_0_2 and arg_45_0.debugMap then
		local var_45_4 = arg_45_0.debugMap

		var_1.Dispose(var_45_4)

		arg_45_0.debugMap = nil
	end

	return
end

return var_0_1
