local var_0_0 = class("AgoraController", import("Mod.Island.Core.controller.IslandController"))

function var_0_0.Init(arg_1_0)
	var_0_0.super.Init(arg_1_0)

	local var_1_0, var_1_1 = arg_1_0:CreateAgora(arg_1_0.island)

	arg_1_0.agora = var_1_0
	arg_1_0.placedData = var_1_1
	arg_1_0.isEditing = false
	arg_1_0.selectedData = nil
	arg_1_0.editCdTime = 0
	arg_1_0.toUpdateTileList = {}
	arg_1_0.dataComparator = AgoraDataComparator.New(arg_1_0.agora)
	arg_1_0.reloading = false
	arg_1_0.baseReloadingCd = pg.island_set.agora_reloading_base_cd.key_value_int
	arg_1_0.nextReloadingEndTime = 0
	arg_1_0.isCleanLayerMode = false

	return
end

function var_0_0.GetDefaultFoundation(arg_2_0)
	if pg.island_set.island_pre_placement.key_value_varchar[1] then
		local var_2_0 = AgoraFurniture.New({
			id = AgoraCalc.GetUniqueId(pg.island_set.island_pre_placement.key_value_varchar[1][1], 1),
			configId = pg.island_set.island_pre_placement.key_value_varchar[1][1]
		})

		var_2_0:UpdatePosition((Vector2(pg.island_set.island_pre_placement.key_value_varchar[1][2][1], pg.island_set.island_pre_placement.key_value_varchar[1][2][2])))

		return var_2_0
	end

	return nil
end

function var_0_0.GetDefaultBuilding(arg_3_0)
	if pg.island_set.island_default_building.key_value_varchar[1] then
		local var_3_0 = AgoraFurniture.New({
			id = AgoraCalc.GetUniqueId(pg.island_set.island_default_building.key_value_varchar[1], 1),
			configId = pg.island_set.island_default_building.key_value_varchar[1]
		})

		var_3_0:UpdatePosition((AgoraCalc.WorldPosition2MapPosition(BuildVector3(pg.island_set.island_default_building.key_value_varchar[2]))))

		return var_3_0
	end

	return nil
end

function var_0_0.Update(arg_4_0)
	var_0_0.super.Update(arg_4_0)
	arg_4_0:CheckReloadFinish()

	return
end

function var_0_0.CheckReloadFinish(arg_5_0)
	if not arg_5_0.reloading then
		return
	end

	local var_5_0 = pg.TimeMgr.GetInstance()

	if var_5_0:GetServerTime() < arg_5_0.nextReloadingEndTime then
		return
	end

	local var_5_1 = arg_5_0:GetView()

	if var_5_1:IsLoaded() then
		arg_5_0:NotifiyAgora(ISLAND_AGORA_EVT.RELOADING_FINISH)

		arg_5_0.reloading = false
	end

	return
end

function var_0_0.SetUp(arg_6_0)
	var_0_0.super.SetUp(arg_6_0)
	arg_6_0:NotifiyAgora(ISLAND_AGORA_EVT.START_LOAD_ITEMS)
	arg_6_0:NotifiyAgora(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, arg_6_0.agora:GetSize())

	local var_6_0 = arg_6_0.placedData.foundation or arg_6_0:GetDefaultFoundation()

	if var_6_0 then
		arg_6_0:PlaceItem(var_6_0.id, var_6_0:GetPosition(), Vector3.zero)
	end

	local var_6_1 = arg_6_0.placedData.building or arg_6_0:GetDefaultBuilding()

	if var_6_1 then
		arg_6_0:PlaceItem(var_6_1.id, var_6_1:GetPosition(), Vector3.zero)
	end

	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(arg_6_0.placedData.placedlist) do
		table.insert(var_6_2, function(arg_7_0)
			arg_6_0:PlaceItem(iter_6_1.id, iter_6_1:GetPosition(), iter_6_1:GetRotation())

			if iter_6_0 % 3 == 0 then
				onNextTick(arg_7_0)
			else
				arg_7_0()
			end

			return
		end)
	end

	seriesAsync(var_6_2, function()
		arg_6_0:NotifiyAgora(ISLAND_AGORA_EVT.END_LOAD_ITEMS, var_6_1:GetPosition())

		return
	end)

	return
end

function var_0_0.OnCoreInitFinish(arg_9_0)
	arg_9_0:PaveLayers(arg_9_0.placedData.placedFloor, arg_9_0.placedData.placedTile)
	var_0_0.super.OnCoreInitFinish(arg_9_0)

	return
end

function var_0_0.InitSyncMgr(arg_10_0)
	arg_10_0.islandSyncMgr:Init(arg_10_0.sceneData.unitList, arg_10_0.agora:GetAllVirtualInteractUnitData())

	return
end

function var_0_0.PaveLayers(arg_11_0, arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		arg_11_0:PaveFloorLayer(iter_11_1.id, iter_11_1:GetShapeId(), iter_11_1:GetPosition())
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_2) do
		arg_11_0:PaveTileLayer(iter_11_3.id, iter_11_3:GetShapeId(), iter_11_3:GetPosition())
	end

	return
end

function var_0_0.GetAgora(arg_12_0)
	return arg_12_0.agora
end

function var_0_0.CanEnterEditMode(arg_13_0)
	local var_13_0 = pg.TimeMgr.GetInstance()

	return var_13_0:GetServerTime() >= arg_13_0.editCdTime
end

function var_0_0.AnySelected(arg_14_0)
	return arg_14_0.selectedData ~= nil
end

function var_0_0.NotifiyAgora(arg_15_0, arg_15_1, ...)
	arg_15_0.agora:DispatchEvent(arg_15_1, ...)

	return
end

function var_0_0.CheckChange(arg_16_0)
	if arg_16_0:AnySelected() then
		arg_16_0:UnSelectedItem()
	end

	local var_16_0, var_16_1 = arg_16_0.dataComparator:AnyChanged()

	return var_16_0
end

function var_0_0.EnterEditMode(arg_17_0)
	if not arg_17_0:CanEnterEditMode() then
		arg_17_0:NotifiyAgora(ISLAND_AGORA_EVT.ENTER_EDIT_FAILED)

		return
	end

	arg_17_0.islandSyncMgr:CancelAgoraInteract()

	arg_17_0.isEditing = true

	arg_17_0.dataComparator:TakeSample()
	arg_17_0:NotifiyAgora(ISLAND_AGORA_EVT.ENTER_EDIT)
	arg_17_0:NotifiyIsland(ISLAND_EX_EVT.ENTER_EDIT_AGORA)

	return
end

function var_0_0.ExitEditMode(arg_18_0)
	arg_18_0.isEditing = false

	arg_18_0.dataComparator:Abort()
	arg_18_0:NotifiyAgora(ISLAND_AGORA_EVT.EXIT_EDIT)
	arg_18_0:NotifiyIsland(ISLAND_EX_EVT.EXIT_EDIT_AGORA)
	arg_18_0:ClearAllNew()

	return
end

function var_0_0.SaveAndExit(arg_19_0)
	arg_19_0:Save(true)
	arg_19_0:ExitEditMode()

	return
end

function var_0_0.Save(arg_20_0, arg_20_1)
	if not arg_20_1 and not arg_20_0:CanEnterEditMode() then
		return
	end

	if arg_20_0:AnySelected() then
		arg_20_0:UnSelectedItem()
	end

	arg_20_0.islandSyncMgr:ClearAgoraInteractData()

	local var_20_0, var_20_1, var_20_2 = arg_20_0.agora:SerializePlacementData()

	arg_20_0:NotifiyMeditor(IslandMediator.SAVE_AGORA, var_20_0, var_20_1, var_20_2)
	arg_20_0.dataComparator:TakeSample()

	arg_20_0.editCdTime = pg.TimeMgr.GetInstance():GetServerTime() + pg.island_set.island_build_save_time.key_value_int

	arg_20_0:NotifiyAgora(ISLAND_AGORA_EVT.SAVE)
	arg_20_0.islandSyncMgr:InitAgora(arg_20_0.agora:GetAllVirtualInteractUnitData())

	return
end

function var_0_0.SaveTheme(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0:AnySelected() then
		arg_21_0:UnSelectedItem()
	end

	local var_21_0, var_21_1, var_21_2 = arg_21_0.agora:SerializePlacementData()

	if #var_21_0 <= 0 and #var_21_1 <= 0 and #var_21_2 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_deco_empty"))

		return
	end

	arg_21_0:NotifiyMeditor(IslandMediator.SAVE_AGORA_THEME, {
		id = arg_21_1,
		name = arg_21_2,
		updateList = var_21_0,
		floorList = var_21_1,
		tileList = var_21_2
	})

	return
end

function var_0_0.ApplyTheme(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 then
		local var_22_0 = arg_22_0.agora:GetSystemTheme(arg_22_1) or arg_22_0.agora:GetTheme(arg_22_1)

		if not var_22_0 then
			return
		end

		arg_22_0:ClearAll()
		arg_22_0:NotifiyAgora(ISLAND_AGORA_EVT.START_LOAD_ITEMS)

		for iter_22_0, iter_22_1 in ipairs((var_22_0:GetPlacedData())) do
			table.insert({}, function(arg_23_0)
				if iter_22_1:IsFoundationType() then
					arg_22_0:ReplaceFoundation(iter_22_1.id)
				elseif iter_22_1:IsBuildingType() then
					arg_22_0:ReplaceBuilding(iter_22_1.id)
				else
					arg_22_0:PlaceItem(iter_22_1.id, iter_22_1:GetPosition(), iter_22_1:GetRotation())
				end

				if iter_22_0 % 3 == 0 then
					onNextTick(arg_23_0)
				else
					arg_23_0()
				end

				return
			end)
		end

		table.insert({}, function(arg_24_0)
			onNextTick(arg_24_0)

			return
		end)

		for iter_22_2, iter_22_3 in ipairs((var_22_0:GetFloorData())) do
			arg_22_0:PaveFloorLayer(iter_22_3.id, iter_22_3.shapeId, iter_22_3:GetPosition())
		end

		table.insert({}, function(arg_25_0)
			onNextTick(arg_25_0)

			return
		end)

		for iter_22_4, iter_22_5 in ipairs((var_22_0:GetTileData())) do
			arg_22_0:PaveTileLayer(iter_22_5.id, iter_22_5.shapeId, iter_22_5:GetPosition())
		end

		seriesAsync({}, function()
			arg_22_0:NotifiyAgora(ISLAND_AGORA_EVT.END_LOAD_ITEMS)

			return
		end)

		return
	end
end

function var_0_0.DeleteTheme(arg_27_0, arg_27_1)
	arg_27_0:NotifiyMeditor(IslandMediator.DEL_AGORA_THEME, arg_27_1)

	return
end

function var_0_0.ClearAll(arg_28_0)
	if arg_28_0:AnySelected() then
		arg_28_0:UnPlaceItem(arg_28_0.selectedData.id)

		arg_28_0.selectedData = nil
	end

	arg_28_0:ClearPlaced(false)
	arg_28_0:ClearLayers()

	return
end

function var_0_0.ClearPlaced(arg_29_0, arg_29_1)
	if arg_29_1 then
		for iter_29_0, iter_29_1 in pairs(arg_29_0.agora:GetPlacedlist()) do
			arg_29_0:UnPlaceItem(iter_29_1.id, true)
		end
	else
		for iter_29_2, iter_29_3 in pairs(arg_29_0.agora:GetPlacedlist()) do
			if iter_29_3:CanOp() then
				arg_29_0:UnPlaceItem(iter_29_3.id)
			end
		end
	end

	return
end

function var_0_0.ClearFloorLayer(arg_30_0)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.agora:GetFloorLayer()) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			if not iter_30_3:IsEmpty() then
				arg_30_0:UnPaveFloorLayer(iter_30_3:GetPosition())
			end
		end
	end

	return
end

function var_0_0.ClearTileLayer(arg_31_0)
	for iter_31_0, iter_31_1 in pairs(arg_31_0.agora:GetTileLayer()) do
		for iter_31_2, iter_31_3 in pairs(iter_31_1) do
			if not iter_31_3:IsEmpty() then
				arg_31_0:UnPaveTileLayer(iter_31_3:GetPosition())
			end
		end
	end

	return
end

function var_0_0.ClearLayers(arg_32_0)
	arg_32_0:ClearFloorLayer()
	arg_32_0:ClearTileLayer()

	return
end

function var_0_0.Revert(arg_33_0)
	local var_33_0, var_33_1 = arg_33_0.dataComparator:AnyChanged()

	if not var_33_0 then
		arg_33_0.islandSyncMgr:ResumeAgoraInteract()

		return
	end

	local var_33_2, var_33_3, var_33_4 = arg_33_0.dataComparator:GetSample()

	if bit.band(var_33_1, AgoraDataComparator.CHANGE_TYPE_PLACED) > 0 then
		arg_33_0:ClearPlaced(true)

		for iter_33_0, iter_33_1 in pairs(var_33_2) do
			table.insert({}, function(arg_34_0)
				arg_33_0:PlaceItem(iter_33_1.id, iter_33_1:GetPosition(), iter_33_1:GetRotation(), arg_34_0)

				return
			end)
		end
	end

	parallelAsync({}, function()
		arg_33_0.islandSyncMgr:ResumeAgoraInteract()

		return
	end)

	if bit.band(var_33_1, AgoraDataComparator.CHANGE_TYPE_FLOOR) > 0 then
		arg_33_0:ClearFloorLayer()

		for iter_33_2, iter_33_3 in pairs(var_33_3) do
			for iter_33_4, iter_33_5 in pairs(iter_33_3) do
				if not iter_33_5:IsEmpty() then
					arg_33_0:PaveFloorLayer(iter_33_5.id, iter_33_5:GetShapeId(), iter_33_5:GetPosition())
				end
			end
		end
	end

	if bit.band(var_33_1, AgoraDataComparator.CHANGE_TYPE_TILE) > 0 then
		arg_33_0:ClearTileLayer()

		for iter_33_6, iter_33_7 in pairs(var_33_4) do
			for iter_33_8, iter_33_9 in pairs(iter_33_7) do
				if not iter_33_9:IsEmpty() then
					arg_33_0:PaveTileLayer(iter_33_9.id, iter_33_9:GetShapeId(), iter_33_9:GetPosition())
				end
			end
		end
	end

	return
end

function var_0_0.RevertAndExit(arg_36_0)
	arg_36_0:Revert()
	arg_36_0:ExitEditMode()

	return
end

function var_0_0.Upgrade(arg_37_0)
	arg_37_0:NotifiyMeditor(IslandMediator.UPGRADE_AGORA)

	return
end

function var_0_0.TrySelectItemById(arg_38_0, arg_38_1)
	arg_38_0:_TrySelectItem((arg_38_0.agora:GetPlacedItem(arg_38_1)))

	return
end

function var_0_0.TrySelectItem(arg_39_0, arg_39_1)
	arg_39_0:_TrySelectItem((arg_39_0.agora:GetAnyMapItemInPosition(arg_39_1)))

	return
end

function var_0_0._TrySelectItem(arg_40_0, arg_40_1)
	if not arg_40_1 then
		return
	end

	if not arg_40_1:CanSelect() then
		return
	end

	if arg_40_0:AnySelected() then
		arg_40_0:UnSelectedItem()
	end

	arg_40_0:SelectItem(arg_40_1)

	return
end

function var_0_0.SelectItem(arg_41_0, arg_41_1)
	arg_41_0.selectedData = {
		id = arg_41_1.id,
		position = arg_41_1:GetPosition(),
		dir = arg_41_1:GetRotation()
	}

	arg_41_0.agora:RemoveItem(arg_41_1)
	arg_41_0:NotifiyAgora(ISLAND_AGORA_EVT.SELECTED_ITEM, arg_41_0.selectedData.id, (arg_41_1:CanOp()))

	return
end

function var_0_0.ConfirmSelectedItem(arg_42_0)
	if not arg_42_0:AnySelected() then
		return
	end

	if not arg_42_0.agora:IsEmptyArea((arg_42_0.agora:GetPlaceableItem(arg_42_0.selectedData.id))) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_pos_unavailability"))

		return
	end

	local var_42_0 = arg_42_0.selectedData.id

	arg_42_0:UnSelectedItem()
	arg_42_0:NotifiyAgora(ISLAND_AGORA_EVT.CONFIRM_SELECTED_ITEM, var_42_0)

	return
end

function var_0_0.UnSelectedItem(arg_43_0)
	if not arg_43_0:AnySelected() then
		return
	end

	local var_43_0 = arg_43_0.selectedData.id

	arg_43_0:NotifiyAgora(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, arg_43_0.selectedData.id)

	local var_43_1 = arg_43_0.agora:GetPlaceableItem(var_43_0)

	if not arg_43_0.agora:IsEmptyArea(var_43_1) then
		var_43_1:UpdatePosition(arg_43_0.selectedData.position)
		var_43_1:UpdateRotation(arg_43_0.selectedData.dir)
	end

	local var_43_2 = var_43_1:CanOp()

	arg_43_0.agora:AddItem(var_43_1)

	arg_43_0.selectedData = nil

	arg_43_0:NotifiyAgora(ISLAND_AGORA_EVT.UNSELECTED_ITEM, var_43_0, var_43_2)

	return
end

function var_0_0.BeginDragItem(arg_44_0)
	if not arg_44_0:AnySelected() then
		return
	end

	arg_44_0:NotifiyAgora(ISLAND_AGORA_EVT.DRAG_ITEM_BEGIN, (arg_44_0.agora:GetPlaceableItem(arg_44_0.selectedData.id)))

	return
end

function var_0_0.DragItem(arg_45_0, arg_45_1)
	if not arg_45_0:AnySelected() then
		return
	end

	local var_45_0 = arg_45_0.agora:GetPlaceableItem(arg_45_0.selectedData.id)

	var_45_0:UpdatePosition(arg_45_0.agora:ClampRange(arg_45_1.x, arg_45_1.y, var_45_0))
	arg_45_0:NotifiyAgora(ISLAND_AGORA_EVT.DRAG_ITEM, arg_45_0.selectedData.id, (arg_45_0.agora:IsEmptyArea(var_45_0)))

	local var_45_1 = arg_45_0.agora:GetItemInArea(var_45_0:GetMapType(), (var_45_0:GetArea()))

	if var_45_1 then
		arg_45_0:NotifiyAgora(ISLAND_AGORA_EVT.ITEM_OCCUPIED, var_45_1.id)
	else
		arg_45_0:NotifiyAgora(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, var_45_0.id)
	end

	return
end

function var_0_0.EndDragItem(arg_46_0, arg_46_1)
	arg_46_0:DragItem(arg_46_1)
	arg_46_0:NotifiyAgora(ISLAND_AGORA_EVT.DRAG_ITEM_END, (arg_46_0.agora:GetPlaceableItem(arg_46_0.selectedData.id)))

	return
end

function var_0_0.RotationItem(arg_47_0)
	if not arg_47_0:AnySelected() then
		return
	end

	arg_47_0.agora:GetPlaceableItem(arg_47_0.selectedData.id):Rotation()

	return
end

function var_0_0.AgoraVirtualInterAction(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	arg_48_3 = arg_48_3 or 1

	local var_48_0 = arg_48_0.agora:GetVirtualInteractUnitData(arg_48_1)
	local var_48_1 = var_48_0:GetEmptySlot()

	if not var_48_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_interact_point"))

		return
	end

	local function var_48_2()
		var_48_1:Lock(arg_48_2)
		arg_48_0:NotifiyAgora(ISLAND_AGORA_EVT.START_INTERACTION, var_48_0, var_48_1, arg_48_3)

		return
	end

	arg_48_0.islandSyncMgr:TryControlUnit(IslandConst.SYNC_TYPE_AGORA, arg_48_1, var_48_1.id, arg_48_3, function(arg_50_0)
		if arg_50_0 then
			var_48_2()
		end

		return
	end)

	return
end

function var_0_0.AgoraVirtualInterActionSync(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if arg_51_0.isEditing then
		return
	end

	arg_51_3 = arg_51_3 or 1

	local var_51_0 = arg_51_0.agora:GetVirtualInteractUnitData(arg_51_1)
	local var_51_1 = var_51_0:GetSlotById(arg_51_4)

	var_51_1:Lock(arg_51_2)
	arg_51_0:NotifiyAgora(ISLAND_AGORA_EVT.START_INTERACTION, var_51_0, var_51_1, arg_51_3)

	return
end

function var_0_0.AgoraVirtualInterActionEnd(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0.agora:GetVirtualInteractUnitData(arg_52_1)

	local function var_52_1()
		var_0:Release()
		arg_52_0:NotifiyAgora(ISLAND_AGORA_EVT.END_INTERACTION, var_52_0, (Clone(var_0)))

		return
	end

	arg_52_0.islandSyncMgr:EndControlUnit(IslandConst.SYNC_TYPE_AGORA, arg_52_1, arg_52_0.agora:GetVirtualInteractUnitData(arg_52_1):GetUsingSlot(arg_52_2).id, function(arg_54_0)
		if arg_54_0 then
			var_52_1()
		end

		return
	end)

	return
end

function var_0_0.AgoraVirtualInterActionEndSync(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_0.isEditing then
		return
	end

	local var_55_0 = arg_55_0.agora:GetVirtualInteractUnitData(arg_55_1)
	local var_55_1 = var_55_0:GetUsingSlot(arg_55_2)

	var_55_1:Release()
	arg_55_0:NotifiyAgora(ISLAND_AGORA_EVT.END_INTERACTION, var_55_0, (Clone(var_55_1)))

	return
end

function var_0_0.AgoraVirtualInitStatus(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0.agora:GetVirtualInteractUnitData(arg_56_1)

	if not var_56_0 then
		return
	end

	arg_56_0:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, var_56_0, arg_56_2)

	return
end

function var_0_0.PlaceItemRandonPosition(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.agora:GetPlaceableItem(arg_57_1)

	if arg_57_0.agora:IsMaxCapacityWhenAdd((var_57_0:GetCost())) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_max_capacity"))

		return
	end

	local var_57_1 = AgoraCalc.GetCenterMapPos()

	if not var_57_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_size"))

		return
	end

	if arg_57_0:AnySelected() then
		arg_57_0:UnSelectedItem()
	end

	var_57_0:Clear()

	local var_57_2 = arg_57_0.agora:FindEmptyArea4Item(var_57_1, var_57_0)

	if not var_57_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_size"))

		return
	end

	arg_57_0:PlaceItem(arg_57_1, var_57_2, Vector3.zero)
	arg_57_0:SelectItem(var_57_0)

	return
end

function var_0_0.PlaceItem(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	arg_58_0.agora:PlaceItem(arg_58_1, arg_58_2, arg_58_3, arg_58_4)

	return
end

function var_0_0.RemovePlaceItem(arg_59_0, arg_59_1)
	arg_59_0:UnPlaceItem(arg_59_1)
	arg_59_0:NotifiyAgora(ISLAND_AGORA_EVT.UNPLACE_ITEM)

	return
end

function var_0_0.UnPlaceItem(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0

	if not arg_60_1 then
		::label_60_0::

		var_60_0 = arg_60_0.selectedData and arg_60_0.selectedData.id
	end

	if not var_60_0 then
		return
	end

	local var_60_1 = arg_60_0.agora:GetPlaceableItem(var_60_0)

	if arg_60_0:AnySelected() and arg_60_0.selectedData.id == var_60_0 then
		arg_60_0:UnSelectedItem()
	end

	if not var_60_1:CanOp() and not arg_60_2 then
		return
	end

	arg_60_0.agora:UnPlaceItem(var_60_0)

	return
end

function var_0_0.ReplaceBuilding(arg_61_0, arg_61_1)
	if arg_61_0:AnySelected() and arg_61_0.agora:IsBuilding(arg_61_0.selectedData.id) then
		arg_61_0:UnSelectedItem()
	end

	local var_61_0 = arg_61_0.agora:GetBuilding()
	local var_61_1 = Vector2.zero

	if var_61_0 then
		var_61_1 = var_61_0:GetPosition()

		arg_61_0:UnPlaceItem(var_61_0.id, true)
	end

	arg_61_0:PlaceItem(arg_61_1, var_61_1, Vector3.zero)

	return
end

function var_0_0.ReplaceFoundation(arg_62_0, arg_62_1)
	if arg_62_0:AnySelected() and arg_62_0.agora:IsFoundation(arg_62_0.selectedData.id) then
		arg_62_0:UnSelectedItem()
	end

	local var_62_0 = arg_62_0.agora:GetFoundation()
	local var_62_1 = Vector2.zero

	if var_62_0 then
		var_62_1 = var_62_0:GetPosition()

		arg_62_0:UnPlaceItem(var_62_0.id, true)
	end

	arg_62_0:PlaceItem(arg_62_1, var_62_1, Vector3.zero)

	return
end

function var_0_0.SelectedPaveItem(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_0:AnySelected() then
		arg_63_0:UnSelectedItem()
	end

	arg_63_0.toUpdateTileList = {}
	arg_63_0.selectedPaveItemId = arg_63_1
	arg_63_0.paveItemShapeId = arg_63_2
	arg_63_0.isCleanLayerMode = false

	return
end

function var_0_0.UnSelectedPaveItem(arg_64_0)
	arg_64_0.toUpdateTileList = {}
	arg_64_0.selectedPaveItemId = nil
	arg_64_0.paveItemShapeId = nil
	arg_64_0.isCleanLayerMode = false

	return
end

function var_0_0.ChangeSelectedShape(arg_65_0, arg_65_1)
	if not arg_65_0.selectedPaveItemId then
		return
	end

	arg_65_0.paveItemShapeId = arg_65_1

	return
end

function var_0_0.ChangePaveMode(arg_66_0, arg_66_1)
	arg_66_0.isCleanLayerMode = arg_66_1

	return
end

function var_0_0.OpLayer(arg_67_0, arg_67_1)
	if not arg_67_0.selectedPaveItemId then
		return
	end

	local var_67_0 = arg_67_0.agora:GetPlaceableItem(arg_67_0.selectedPaveItemId)

	if not var_67_0 then
		return
	end

	if not arg_67_0.agora:InRange(arg_67_1.x, arg_67_1.y) then
		return
	end

	if not var_67_0:IsOptionalShapeType() then
		return
	end

	if arg_67_0.isCleanLayerMode then
		arg_67_0:UnPaveLayer(var_67_0, arg_67_1)
	else
		arg_67_0:PaveLayer(var_67_0, arg_67_1)
	end

	return
end

function var_0_0.PaveLayer(arg_68_0, arg_68_1, arg_68_2)
	arg_68_0:RecordLayer(arg_68_1, arg_68_2)

	if arg_68_1:IsFloor() then
		arg_68_0:PaveFloorLayer(arg_68_1.id, arg_68_0.paveItemShapeId, arg_68_2)
	elseif arg_68_1:IsTile() then
		arg_68_0:PaveTileLayer(arg_68_1.id, arg_68_0.paveItemShapeId, arg_68_2)
	end

	return
end

function var_0_0.RecordLayer(arg_69_0, arg_69_1, arg_69_2)
	if not arg_69_0.toUpdateTileList[arg_69_2.x] or not arg_69_0.toUpdateTileList[arg_69_2.x][arg_69_2.y] then
		local var_69_0

		if arg_69_1:IsFloor() then
			var_69_0 = arg_69_0.agora:GetFloorCell(arg_69_2)
		elseif arg_69_1:IsTile() then
			var_69_0 = arg_69_0.agora:GetTileCell(arg_69_2)
		end

		if var_69_0 then
			arg_69_0.toUpdateTileList[arg_69_2.x] = arg_69_0.toUpdateTileList[arg_69_2.x] or {}
			arg_69_0.toUpdateTileList[arg_69_2.x][arg_69_2.y] = var_69_0:GetShapeId()
		end
	end

	return
end

function var_0_0.UnPaveLayer(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1:IsFloor() and not arg_70_0.agora:HasFloorCell(arg_70_2) or arg_70_1:IsTile() and not arg_70_0.agora:HasTileCell(arg_70_2) then
		return
	end

	arg_70_0:RecordLayer(arg_70_1, arg_70_2)

	if arg_70_1:IsFloor() then
		arg_70_0:UnPaveFloorLayer(arg_70_2)
	elseif arg_70_1:IsTile() then
		arg_70_0:UnPaveTileLayer(arg_70_2)
	end

	return
end

function var_0_0.PaveFloorLayer(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	arg_71_0.agora:PlaceFloor(arg_71_1, arg_71_2, arg_71_3)

	return
end

function var_0_0.PaveTileLayer(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	arg_72_0.agora:PlaceTile(arg_72_1, arg_72_2, arg_72_3)

	return
end

function var_0_0.RevertPaveLayer(arg_73_0)
	local var_73_1 = arg_73_0.agora:GetPlaceableItem(arg_73_0.selectedPaveItemId)

	if not var_73_1 then
		return
	end

	local var_73_2 = var_73_1.id

	for iter_73_0, iter_73_1 in pairs(arg_73_0.toUpdateTileList) do
		for iter_73_2, iter_73_3 in pairs(iter_73_1) do
			local var_73_3 = Vector2(iter_73_0, iter_73_2)
			local var_73_4 = iter_73_3 < 0

			if var_73_1:IsFloor() then
				(function(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
					if arg_74_0 then
						arg_73_0:UnPaveFloorLayer(arg_74_2)

						return
					end

					arg_73_0:PaveFloorLayer(arg_74_1, arg_74_3, arg_74_2)

					return
				end)(var_73_4, var_73_2, var_73_3, iter_73_3)
			elseif var_73_1:IsTile() then
				var_73_0(var_73_4, var_73_2, var_73_3, iter_73_3)
			end
		end
	end

	arg_73_0.toUpdateTileList = {}

	return
end

function var_0_0.UnPaveFloorLayer(arg_76_0, arg_76_1)
	arg_76_0.agora:UnPlaceFloor(arg_76_1)

	return
end

function var_0_0.UnPaveTileLayer(arg_77_0, arg_77_1)
	arg_77_0.agora:UnPlaceTile(arg_77_1)

	return
end

function var_0_0.AddListeners(arg_78_0)
	var_0_0.super.AddListeners(arg_78_0)
	arg_78_0:AddIslandListener(IslandAgoraAgency.AGORA_UPGRADE, arg_78_0.OnAgoraUpdate)
	arg_78_0:AddIslandListener(IslandSignInAgency.GIFT_CNT_UPDATE, arg_78_0.OnSignInGiftCntUpdate)
	arg_78_0:AddIslandListener(IslandSignInAgency.SIGN_CNT_UPDATE, arg_78_0.OnSignCntUpdate)
	arg_78_0:AddIslandListener(IslandAgoraAgency.ADD_THEME, arg_78_0.OnThemeAdded)
	arg_78_0:AddIslandListener(IslandAgoraAgency.DEL_THEME, arg_78_0.OnThemeDeleted)
	arg_78_0:AddIslandListener(IslandAgoraAgency.PLACEMENT_UPDATE, arg_78_0.OnPlacementUpdate)
	arg_78_0:AddIslandListener(IslandAgoraAgency.ADD_FURNITURE, arg_78_0.OnFurnitureAdded)

	return
end

function var_0_0.RemoveListeners(arg_79_0)
	var_0_0.super.RemoveListeners(arg_79_0)
	arg_79_0:RemoveIslandListener(IslandAgoraAgency.AGORA_UPGRADE, arg_79_0.OnAgoraUpdate)
	arg_79_0:RemoveIslandListener(IslandSignInAgency.GIFT_CNT_UPDATE, arg_79_0.OnSignInGiftCntUpdate)
	arg_79_0:RemoveIslandListener(IslandSignInAgency.SIGN_CNT_UPDATE, arg_79_0.OnSignCntUpdate)
	arg_79_0:RemoveIslandListener(IslandAgoraAgency.ADD_THEME, arg_79_0.OnThemeAdded)
	arg_79_0:RemoveIslandListener(IslandAgoraAgency.DEL_THEME, arg_79_0.OnThemeDeleted)
	arg_79_0:RemoveIslandListener(IslandAgoraAgency.PLACEMENT_UPDATE, arg_79_0.OnPlacementUpdate)
	arg_79_0:RemoveIslandListener(IslandAgoraAgency.ADD_FURNITURE, arg_79_0.OnFurnitureAdded)

	return
end

function var_0_0.ClearNew(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0.agora:GetPlaceableItem(arg_80_1)

	if not var_80_0 then
		return
	end

	var_80_0:ClearNew()
	arg_80_0:GetIsland():GetAgoraAgency():ClearNew(var_80_0.configId)

	return
end

function var_0_0.ClearAllNew(arg_81_0)
	for iter_81_0, iter_81_1 in pairs((arg_81_0.agora:GetPlaceableList())) do
		iter_81_1:ClearNew()
	end

	arg_81_0:GetIsland():GetAgoraAgency():ClearAllNew()

	return
end

function var_0_0.OnFurnitureAdded(arg_82_0, arg_82_1)
	for iter_82_0 = 1, arg_82_1.count do
		arg_82_0.agora:AddPlaceable((AgoraFurniture.New({
			id = AgoraCalc.GetUniqueId(arg_82_1.id, iter_82_0),
			configId = arg_82_1.id,
			time = arg_82_1.time,
			isNew = arg_82_1.isNew
		})))
	end

	return
end

function var_0_0.OnPlacementUpdate(arg_83_0, arg_83_1)
	arg_83_0.islandSyncMgr:CancelAgoraInteract()
	arg_83_0.islandSyncMgr:ClearAgoraInteractData()

	local var_83_0 = AgoraTheme.New(arg_83_1, arg_83_0.agora.placeableList)
	local var_83_1, var_83_2, var_83_3 = var_83_0:GetSeparatedPlacedData()

	if var_83_2 and arg_83_0.agora:GetFoundation().id ~= var_83_2.id then
		arg_83_0:ReplaceFoundation(var_83_2.id)
	end

	local var_83_4 = arg_83_0.agora:GetBuilding()

	if var_83_3 and var_83_4.id ~= var_83_3.id then
		arg_83_0:ReplaceBuilding(var_83_3.id)
	end

	local var_83_5, var_83_6, var_83_7 = AgoraCalc.GetChangePlacementList(var_83_1, (arg_83_0.agora:GetPlacedListWithoutFoundationAndBuilding()))

	for iter_83_0, iter_83_1 in ipairs(var_83_6) do
		arg_83_0.agora:UnPlaceItem(iter_83_1.id)
	end

	for iter_83_2, iter_83_3 in ipairs(var_83_7) do
		arg_83_0.agora:PlaceItem(iter_83_3.id, iter_83_3:GetPosition(), iter_83_3:GetRotation())
	end

	for iter_83_4, iter_83_5 in ipairs(var_83_5) do
		arg_83_0.agora:UnPlaceItem(iter_83_5.id)
		arg_83_0.agora:PlaceItem(iter_83_5.id, iter_83_5:GetPosition(), iter_83_5:GetRotation())
	end

	arg_83_0:ClearLayers()
	arg_83_0:PaveLayers(var_83_0:GetFloorData(), (var_83_0:GetTileData()))

	arg_83_0.reloading = true
	arg_83_0.nextReloadingEndTime = pg.TimeMgr.GetInstance():GetServerTime() + arg_83_0.baseReloadingCd

	arg_83_0:NotifiyAgora(ISLAND_AGORA_EVT.RELOADING)

	if (#var_83_7 > 0 or #var_83_5 > 0) and not arg_83_0:IsSelfIsland() then
		arg_83_0:ResetPlayerPosition()
	end

	arg_83_0.islandSyncMgr:InitAgora(arg_83_0.agora:GetAllVirtualInteractUnitData())

	return
end

function var_0_0.OnThemeAdded(arg_84_0, arg_84_1)
	arg_84_0.agora:AddTheme((AgoraTheme.New(arg_84_1, arg_84_0.agora.placeableList)))

	return
end

function var_0_0.OnThemeDeleted(arg_85_0, arg_85_1)
	arg_85_0.agora:DeleteTheme(arg_85_1)

	return
end

function var_0_0.OnSignCntUpdate(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0:GetIsland():GetSignInAgency()

	arg_86_0:NotifiyCore(ISLAND_EVT.REFRESH_INTERACTION)
	arg_86_0:NotifiyAgora(ISLAND_AGORA_EVT.SIGN_IN_CNT_UPDATE, arg_86_1)

	return
end

function var_0_0.OnSignInGiftCntUpdate(arg_87_0, arg_87_1)
	arg_87_0.giftAllocator:Flush()

	return
end

function var_0_0.OnAgoraUpdate(arg_88_0, arg_88_1, arg_88_2)
	arg_88_0.agora:UpdateSize(Vector2(IslandConst.AGORA_LEVEL_2_SIZE[arg_88_1], IslandConst.AGORA_LEVEL_2_SIZE[arg_88_1]))
	arg_88_0.agora:UpdateCapacity(arg_88_2)

	return
end

function var_0_0.CreateAgora(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_1:GetAgoraAgency()

	for iter_89_0, iter_89_1 in ipairs(var_89_0:GetFurnitures()) do
		for iter_89_2 = 1, iter_89_1.count do
			local var_89_1 = AgoraFurniture.New({
				id = AgoraCalc.GetUniqueId(iter_89_1.id, iter_89_2),
				configId = iter_89_1.id,
				time = iter_89_1.time,
				isNew = iter_89_1.isNew
			})

			;({})[var_89_1.id] = var_89_1
		end
	end

	local var_89_2 = AgoraTheme.New(var_89_0:GetPlacedData(), {})
	local var_89_3, var_89_4, var_89_5 = var_89_2:GetSeparatedPlacedData()

	for iter_89_3, iter_89_4 in ipairs(var_89_0:GetThemes()) do
		table.insert({}, (AgoraTheme.New(iter_89_4, {})))
	end

	for iter_89_5, iter_89_6 in ipairs(var_89_0:GetSystemThemes()) do
		table.insert({}, (AgoraSystemTheme.New(iter_89_6)))
	end

	local var_89_6 = IslandConst.AGORA_LEVEL_2_SIZE[math.clamp(var_89_0:GetLevel(), 1, #IslandConst.AGORA_LEVEL_2_SIZE)]

	return Agora.New({
		size = Vector2(var_89_6, var_89_6),
		placeableList = {},
		capacity = var_89_0:GetCapacity(),
		themes = {},
		systemThemes = {}
	}), {
		placedlist = var_89_3,
		foundation = var_89_4,
		building = var_89_5,
		placedFloor = var_89_2:GetFloorData(),
		placedTile = var_89_2:GetTileData()
	}
end

return var_0_0
