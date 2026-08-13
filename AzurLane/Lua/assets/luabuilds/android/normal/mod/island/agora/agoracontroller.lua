class = var_0_10000

local var_0_0 = "AgoraController"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("Mod.Island.Core.controller.IslandController"))

function var_0_1.Init(arg_1_0)
	var_0_1.super.Init(arg_1_0)

	local var_1_0, var_1_1 = arg_1_0:CreateAgora(arg_1_0.island)

	arg_1_0.agora = var_1_0
	arg_1_0.placedData = var_1_1
	arg_1_0.isEditing = false
	arg_1_0.selectedData = nil
	arg_1_0.editCdTime = 0
	arg_1_0.toUpdateTileList = {}
	AgoraDataComparator = var_3
	arg_1_0.dataComparator = var_3.New(arg_1_0.agora)
	arg_1_0.reloading = false
	pg = var_3
	arg_1_0.baseReloadingCd = var_3.island_set.agora_reloading_base_cd.key_value_int
	arg_1_0.nextReloadingEndTime = 0
	arg_1_0.isCleanLayerMode = false

	return
end

function var_0_1.GetDefaultFoundation(arg_2_0)
	pg = var_1_10001

	if var_1_10001.island_set.island_pre_placement.key_value_varchar[1] then
		local var_2_0 = var_1[1][1]

		Vector2 = var_1_10003

		local var_2_1 = var_1_10003(var_1[1][2][1], var_1[1][2][2])

		AgoraCalc = var_4

		local var_2_2 = var_4.GetUniqueId(var_2_0, 1)

		AgoraFurniture = var_5

		local var_2_3 = var_5.New({
			id = var_2_2,
			configId = var_2_0
		})

		var_5.UpdatePosition(var_2_3, var_2_1)

		return var_5
	end

	return nil
end

function var_0_1.GetDefaultBuilding(arg_3_0)
	pg = var_1_10001

	if var_1_10001.island_set.island_default_building.key_value_varchar[1] then
		local var_3_0 = var_1[1]

		AgoraCalc = var_1_10003

		local var_3_1 = var_1_10003.WorldPosition2MapPosition

		BuildVector3 = var_1_10004

		local var_3_2 = var_3_1(var_1_10004(var_1[2]))

		AgoraCalc = var_4

		local var_3_3 = var_4.GetUniqueId(var_3_0, 1)

		AgoraFurniture = var_5

		local var_3_4 = var_5.New({
			id = var_3_3,
			configId = var_3_0
		})

		var_5.UpdatePosition(var_3_4, var_3_2)

		return var_5
	end

	return nil
end

function var_0_1.Update(arg_4_0)
	var_0_1.super.Update(arg_4_0)
	arg_4_0:CheckReloadFinish()

	return
end

function var_0_1.CheckReloadFinish(arg_5_0)
	if not arg_5_0.reloading then
		return
	end

	pg = var_1

	local var_5_0 = var_1.TimeMgr.GetInstance()

	if var_1.GetServerTime(var_5_0) < arg_5_0.nextReloadingEndTime then
		return
	end

	local var_5_1 = arg_5_0:GetView()

	if var_1.IsLoaded(var_5_1) then
		local var_5_2 = arg_5_0
		local var_5_3 = arg_5_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_1_10003

		var_5_3(var_5_2, var_1_10003.RELOADING_FINISH)

		arg_5_0.reloading = false
	end

	return
end

function var_0_1.SetUp(arg_6_0)
	var_0_1.super.SetUp(arg_6_0)

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10003

	var_6_1(var_6_0, var_1_10003.START_LOAD_ITEMS)

	local var_6_2 = arg_6_0
	local var_6_3 = arg_6_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_3

	local var_6_4 = var_3.MAP_SIZE_UPDATE
	local var_6_5 = arg_6_0.agora

	var_6_3(var_6_2, var_6_4, var_4.GetSize(var_6_5))

	local var_6_6

	if not arg_6_0.placedData.foundation then
		var_6_6 = arg_6_0:GetDefaultFoundation()
	end

	local var_6_9

	if var_6_6 then
		local var_6_7 = arg_6_0
		local var_6_8 = arg_6_0.PlaceItem

		var_6_9 = var_6_6.id

		local var_6_10 = var_6_6
		local var_6_11 = var_6_6.GetPosition(var_6_10)

		Vector3 = var_6_10

		var_6_8(var_6_7, var_6_9, var_6_11, var_6_10.zero)
	end

	local var_6_12

	if not arg_6_0.placedData.building then
		var_6_12 = arg_6_0:GetDefaultBuilding()
	end

	if var_6_12 then
		var_6_9 = arg_6_0

		local var_6_13 = arg_6_0.PlaceItem
		local var_6_14 = var_6_12.id
		local var_6_15 = var_6_12
		local var_6_16 = var_6_12.GetPosition(var_6_15)

		Vector3 = var_6_15

		var_6_13(var_6_9, var_6_14, var_6_16, var_6_15.zero)
	end

	local var_6_17 = {}

	pairs = var_6_9

	for iter_6_0, iter_6_1 in var_6_9(arg_6_0.placedData.placedlist) do
		table = var_1_10009

		var_1_10009.insert(var_6_17, function(arg_7_0)
			local var_7_0 = arg_6_0
			local var_7_1 = var_1.PlaceItem
			local var_7_2 = iter_6_1.id
			local var_7_3 = iter_6_1
			local var_7_4 = var_4.GetPosition(var_7_3)
			local var_7_5 = iter_6_1

			var_7_1(var_7_0, var_7_2, var_7_4, var_5.GetRotation(var_7_5))

			if iter_6_0 % 3 == 0 then
				onNextTick = var_1

				var_1(arg_7_0)
			else
				arg_7_0()
			end

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_6_17, function()
		local var_8_0 = arg_6_0
		local var_8_1 = var_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_2_10002

		local var_8_2 = var_2_10002.END_LOAD_ITEMS
		local var_8_3 = var_6_12

		var_8_1(var_8_0, var_8_2, var_3.GetPosition(var_8_3))

		return
	end)

	return
end

function var_0_1.OnCoreInitFinish(arg_9_0)
	arg_9_0:PaveLayers(arg_9_0.placedData.placedFloor, arg_9_0.placedData.placedTile)
	var_0_1.super.OnCoreInitFinish(arg_9_0)

	return
end

function var_0_1.InitSyncMgr(arg_10_0)
	local var_10_0 = arg_10_0.islandSyncMgr
	local var_10_1 = var_1.Init
	local var_10_2 = arg_10_0.sceneData.unitList
	local var_10_3 = arg_10_0.agora

	var_10_1(var_10_0, var_10_2, var_4.GetAllVirtualInteractUnitData(var_10_3))

	return
end

function var_0_1.PaveLayers(arg_11_0, arg_11_1, arg_11_2)
	pairs = var_1_10003

	for iter_11_0, iter_11_1 in var_1_10003(arg_11_1) do
		arg_11_0:PaveFloorLayer(iter_11_1.id, iter_11_1:GetShapeId(), iter_11_1:GetPosition())
	end

	pairs = var_3

	for iter_11_2, iter_11_3 in var_3(arg_11_2) do
		arg_11_0:PaveTileLayer(iter_11_3.id, iter_11_3:GetShapeId(), iter_11_3:GetPosition())
	end

	return
end

function var_0_1.GetAgora(arg_12_0)
	return arg_12_0.agora
end

function var_0_1.CanEnterEditMode(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_13_0) >= arg_13_0.editCdTime
end

function var_0_1.AnySelected(arg_14_0)
	return arg_14_0.selectedData ~= nil
end

function var_0_1.NotifiyAgora(arg_15_0, arg_15_1, ...)
	local var_15_0 = arg_15_0.agora

	var_2.DispatchEvent(var_15_0, arg_15_1, ...)

	return
end

function var_0_1.CheckChange(arg_16_0)
	if arg_16_0:AnySelected() then
		arg_16_0:UnSelectedItem()
	end

	local var_16_0 = arg_16_0.dataComparator
	local var_16_1, var_16_2 = var_1.AnyChanged(var_16_0)

	return var_16_1
end

function var_0_1.EnterEditMode(arg_17_0)
	if not arg_17_0:CanEnterEditMode() then
		local var_17_0 = arg_17_0
		local var_17_1 = arg_17_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_1_10003

		var_17_1(var_17_0, var_1_10003.ENTER_EDIT_FAILED)

		return
	end

	local var_17_2 = arg_17_0.islandSyncMgr

	var_1.CancelAgoraInteract(var_17_2)

	arg_17_0.isEditing = true

	local var_17_3 = arg_17_0.dataComparator

	var_1.TakeSample(var_17_3)

	local var_17_4 = arg_17_0
	local var_17_5 = arg_17_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10003

	var_17_5(var_17_4, var_1_10003.ENTER_EDIT)

	local var_17_6 = arg_17_0
	local var_17_7 = arg_17_0.NotifiyIsland

	ISLAND_EX_EVT = var_3

	var_17_7(var_17_6, var_3.ENTER_EDIT_AGORA)

	return
end

function var_0_1.ExitEditMode(arg_18_0)
	arg_18_0.isEditing = false

	local var_18_0 = arg_18_0.dataComparator

	var_1.Abort(var_18_0)

	local var_18_1 = arg_18_0
	local var_18_2 = arg_18_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10003

	var_18_2(var_18_1, var_1_10003.EXIT_EDIT)

	local var_18_3 = arg_18_0
	local var_18_4 = arg_18_0.NotifiyIsland

	ISLAND_EX_EVT = var_3

	var_18_4(var_18_3, var_3.EXIT_EDIT_AGORA)
	arg_18_0:ClearAllNew()

	return
end

function var_0_1.SaveAndExit(arg_19_0)
	arg_19_0:Save(true)
	arg_19_0:ExitEditMode()

	return
end

function var_0_1.Save(arg_20_0, arg_20_1)
	if not arg_20_1 and not arg_20_0:CanEnterEditMode() then
		return
	end

	if arg_20_0:AnySelected() then
		arg_20_0:UnSelectedItem()
	end

	local var_20_0 = arg_20_0.islandSyncMgr

	var_2.ClearAgoraInteractData(var_20_0)

	local var_20_1 = arg_20_0.agora
	local var_20_2, var_20_3, var_20_4 = var_2.SerializePlacementData(var_20_1)
	local var_20_5 = arg_20_0
	local var_20_6 = arg_20_0.NotifiyMeditor

	IslandMediator = var_1_10007

	var_20_6(var_20_5, var_1_10007.SAVE_AGORA, var_20_2, var_20_3, var_20_4)

	local var_20_7 = arg_20_0.dataComparator

	var_5.TakeSample(var_20_7)

	pg = var_5

	local var_20_8 = var_5.island_set.island_build_save_time.key_value_int

	pg = var_20_7

	local var_20_9 = var_20_7.TimeMgr.GetInstance()

	arg_20_0.editCdTime = var_6.GetServerTime(var_20_9) + var_20_8

	local var_20_10 = arg_20_0
	local var_20_11 = arg_20_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_8

	var_20_11(var_20_10, var_8.SAVE)

	local var_20_12 = arg_20_0.islandSyncMgr
	local var_20_13 = var_6.InitAgora
	local var_20_14 = arg_20_0.agora

	var_20_13(var_20_12, var_8.GetAllVirtualInteractUnitData(var_20_14))

	return
end

function var_0_1.SaveTheme(arg_21_0, arg_21_1, arg_21_2)
	if arg_21_0:AnySelected() then
		arg_21_0:UnSelectedItem()
	end

	local var_21_0 = arg_21_0.agora
	local var_21_1, var_21_2, var_21_3 = var_3.SerializePlacementData(var_21_0)

	if #var_21_1 <= 0 and #var_21_2 <= 0 and #var_21_3 <= 0 then
		pg = var_6

		local var_21_4 = var_6.TipsMgr.GetInstance()
		local var_21_5 = var_6.ShowTips

		i18n = var_1_10008

		var_21_5(var_21_4, var_1_10008("island_agora_deco_empty"))

		return
	end

	local var_21_6 = arg_21_0
	local var_21_7 = arg_21_0.NotifiyMeditor

	IslandMediator = var_1_10008

	var_21_7(var_21_6, var_1_10008.SAVE_AGORA_THEME, {
		id = arg_21_1,
		name = arg_21_2,
		updateList = var_21_1,
		floorList = var_21_2,
		tileList = var_21_3
	})

	return
end

function var_0_1.ApplyTheme(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_2 then
		local var_22_0 = arg_22_0.agora
		local var_22_2

		if not var_3.GetSystemTheme(var_22_0, arg_22_1) then
			local var_22_1 = arg_22_0.agora

			var_22_2 = var_3.GetTheme(var_22_1, arg_22_1)
		end

		if not var_22_2 then
			return
		end

		arg_22_0:ClearAll()

		local var_22_3 = arg_22_0
		local var_22_4 = arg_22_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_1_10006

		var_22_4(var_22_3, var_1_10006.START_LOAD_ITEMS)

		local var_22_5 = {}
		local var_22_6 = var_22_2
		local var_22_7 = var_22_2.GetPlacedData(var_22_6)

		ipairs = var_22_6

		for iter_22_0, iter_22_1 in var_22_6(var_22_7) do
			table = var_1_10011

			var_1_10011.insert(var_22_5, function(arg_23_0)
				local var_23_0 = iter_22_1

				if var_1.IsFoundationType(var_23_0) then
					local var_23_1 = arg_22_0

					var_1.ReplaceFoundation(var_23_1, iter_22_1.id)
				else
					local var_23_2 = iter_22_1

					if var_1.IsBuildingType(var_23_2) then
						local var_23_3 = arg_22_0

						var_1.ReplaceBuilding(var_23_3, iter_22_1.id)
					else
						local var_23_4 = arg_22_0
						local var_23_5 = var_1.PlaceItem
						local var_23_6 = iter_22_1.id
						local var_23_7 = iter_22_1
						local var_23_8 = var_4.GetPosition(var_23_7)
						local var_23_9 = iter_22_1

						var_23_5(var_23_4, var_23_6, var_23_8, var_5.GetRotation(var_23_9))
					end
				end

				if iter_22_0 % 3 == 0 then
					onNextTick = var_1

					var_1(arg_23_0)
				else
					arg_23_0()
				end

				return
			end)
		end

		table = var_6

		var_6.insert(var_22_5, function(arg_24_0)
			onNextTick = var_2_10001

			var_2_10001(arg_24_0)

			return
		end)

		local var_22_8 = var_22_2
		local var_22_9 = var_22_2.GetFloorData(var_22_8)

		ipairs = var_22_8

		for iter_22_2, iter_22_3 in var_22_8(var_22_9) do
			arg_22_0:PaveFloorLayer(iter_22_3.id, iter_22_3.shapeId, iter_22_3:GetPosition())
		end

		table = var_7

		var_7.insert(var_22_5, function(arg_25_0)
			onNextTick = var_2_10001

			var_2_10001(arg_25_0)

			return
		end)

		local var_22_10 = var_22_2
		local var_22_11 = var_22_2.GetTileData(var_22_10)

		ipairs = var_22_10

		for iter_22_4, iter_22_5 in var_22_10(var_22_11) do
			arg_22_0:PaveTileLayer(iter_22_5.id, iter_22_5.shapeId, iter_22_5:GetPosition())
		end

		seriesAsync = var_8

		var_8(var_22_5, function()
			local var_26_0 = arg_22_0
			local var_26_1 = var_0.NotifiyAgora

			ISLAND_AGORA_EVT = var_2_10002

			var_26_1(var_26_0, var_2_10002.END_LOAD_ITEMS)

			return
		end)

		return
	end
end

function var_0_1.DeleteTheme(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0
	local var_27_1 = arg_27_0.NotifiyMeditor

	IslandMediator = var_1_10004

	var_27_1(var_27_0, var_1_10004.DEL_AGORA_THEME, arg_27_1)

	return
end

function var_0_1.ClearAll(arg_28_0)
	if arg_28_0:AnySelected() then
		arg_28_0:UnPlaceItem(arg_28_0.selectedData.id)

		arg_28_0.selectedData = nil
	end

	arg_28_0:ClearPlaced(false)
	arg_28_0:ClearLayers()

	return
end

function var_0_1.ClearPlaced(arg_29_0, arg_29_1)
	if arg_29_1 then
		pairs = var_1_10002

		local var_29_0 = arg_29_0.agora

		for iter_29_0, iter_29_1 in var_1_10002(var_3.GetPlacedlist(var_29_0)) do
			arg_29_0:UnPlaceItem(iter_29_1.id, true)
		end
	else
		pairs = var_1_10002

		local var_29_1 = arg_29_0.agora

		for iter_29_2, iter_29_3 in var_1_10002(var_3.GetPlacedlist(var_29_1)) do
			if iter_29_3:CanOp() then
				arg_29_0:UnPlaceItem(iter_29_3.id)
			end
		end
	end

	return
end

function var_0_1.ClearFloorLayer(arg_30_0)
	pairs = var_1_10001

	local var_30_0 = arg_30_0.agora

	for iter_30_0, iter_30_1 in var_1_10001(var_2.GetFloorLayer(var_30_0)) do
		pairs = var_1_10006

		for iter_30_2, iter_30_3 in var_1_10006(iter_30_1) do
			if not iter_30_3:IsEmpty() then
				arg_30_0:UnPaveFloorLayer(iter_30_3:GetPosition())
			end
		end
	end

	return
end

function var_0_1.ClearTileLayer(arg_31_0)
	pairs = var_1_10001

	local var_31_0 = arg_31_0.agora

	for iter_31_0, iter_31_1 in var_1_10001(var_2.GetTileLayer(var_31_0)) do
		pairs = var_1_10006

		for iter_31_2, iter_31_3 in var_1_10006(iter_31_1) do
			if not iter_31_3:IsEmpty() then
				arg_31_0:UnPaveTileLayer(iter_31_3:GetPosition())
			end
		end
	end

	return
end

function var_0_1.ClearLayers(arg_32_0)
	arg_32_0:ClearFloorLayer()
	arg_32_0:ClearTileLayer()

	return
end

function var_0_1.Revert(arg_33_0)
	local var_33_0 = arg_33_0.dataComparator
	local var_33_1, var_33_2 = var_1.AnyChanged(var_33_0)

	if not var_33_1 then
		local var_33_3 = arg_33_0.islandSyncMgr

		var_3.ResumeAgoraInteract(var_33_3)

		return
	end

	local var_33_4 = arg_33_0.dataComparator
	local var_33_5, var_33_6, var_33_7 = var_3.GetSample(var_33_4)
	local var_33_8 = {}

	bit = var_1_10007

	local var_33_9 = var_1_10007.band
	local var_33_10 = var_33_2

	AgoraDataComparator = var_1_10009

	if var_33_9(var_33_10, var_1_10009.CHANGE_TYPE_PLACED) > 0 then
		arg_33_0:ClearPlaced(true)

		pairs = var_7

		for iter_33_0, iter_33_1 in var_7(var_33_5) do
			table = var_1_10012

			var_1_10012.insert(var_33_8, function(arg_34_0)
				local var_34_0 = arg_33_0
				local var_34_1 = var_1.PlaceItem
				local var_34_2 = iter_33_1.id
				local var_34_3 = iter_33_1
				local var_34_4 = var_4.GetPosition(var_34_3)
				local var_34_5 = iter_33_1

				var_34_1(var_34_0, var_34_2, var_34_4, var_5.GetRotation(var_34_5), arg_34_0)

				return
			end)
		end
	end

	parallelAsync = var_7

	var_7(var_33_8, function()
		local var_35_0 = arg_33_0.islandSyncMgr

		var_0.ResumeAgoraInteract(var_35_0)

		return
	end)

	bit = var_7

	local var_33_11 = var_7.band
	local var_33_12 = var_33_2

	AgoraDataComparator = var_9

	if var_33_11(var_33_12, var_9.CHANGE_TYPE_FLOOR) > 0 then
		arg_33_0:ClearFloorLayer()

		pairs = var_7

		for iter_33_2, iter_33_3 in var_7(var_33_6) do
			pairs = var_1_10012

			for iter_33_4, iter_33_5 in var_1_10012(iter_33_3) do
				if not iter_33_5:IsEmpty() then
					arg_33_0:PaveFloorLayer(iter_33_5.id, iter_33_5:GetShapeId(), iter_33_5:GetPosition())
				end
			end
		end
	end

	bit = var_7

	local var_33_13 = var_7.band
	local var_33_14 = var_33_2

	AgoraDataComparator = var_9

	if var_33_13(var_33_14, var_9.CHANGE_TYPE_TILE) > 0 then
		arg_33_0:ClearTileLayer()

		pairs = var_7

		for iter_33_6, iter_33_7 in var_7(var_33_7) do
			pairs = var_1_10012

			for iter_33_8, iter_33_9 in var_1_10012(iter_33_7) do
				if not iter_33_9:IsEmpty() then
					arg_33_0:PaveTileLayer(iter_33_9.id, iter_33_9:GetShapeId(), iter_33_9:GetPosition())
				end
			end
		end
	end

	return
end

function var_0_1.RevertAndExit(arg_36_0)
	arg_36_0:Revert()
	arg_36_0:ExitEditMode()

	return
end

function var_0_1.Upgrade(arg_37_0)
	local var_37_0 = arg_37_0
	local var_37_1 = arg_37_0.NotifiyMeditor

	IslandMediator = var_1_10003

	var_37_1(var_37_0, var_1_10003.UPGRADE_AGORA)

	return
end

function var_0_1.TrySelectItemById(arg_38_0, arg_38_1)
	local var_38_0 = arg_38_0.agora
	local var_38_1 = var_2.GetPlacedItem(var_38_0, arg_38_1)

	arg_38_0:_TrySelectItem(var_38_1)

	return
end

function var_0_1.TrySelectItem(arg_39_0, arg_39_1)
	local var_39_0 = arg_39_0.agora
	local var_39_1 = var_2.GetAnyMapItemInPosition(var_39_0, arg_39_1)

	arg_39_0:_TrySelectItem(var_39_1)

	return
end

function var_0_1._TrySelectItem(arg_40_0, arg_40_1)
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

function var_0_1.SelectItem(arg_41_0, arg_41_1)
	arg_41_0.selectedData = {
		id = arg_41_1.id,
		position = arg_41_1:GetPosition(),
		dir = arg_41_1:GetRotation()
	}

	local var_41_0 = arg_41_0.agora

	var_2.RemoveItem(var_41_0, arg_41_1)

	local var_41_1 = arg_41_1:CanOp()
	local var_41_2 = arg_41_0
	local var_41_3 = arg_41_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10005

	var_41_3(var_41_2, var_1_10005.SELECTED_ITEM, arg_41_0.selectedData.id, var_41_1)

	return
end

function var_0_1.ConfirmSelectedItem(arg_42_0)
	if not arg_42_0:AnySelected() then
		return
	end

	local var_42_0 = arg_42_0.agora
	local var_42_1 = var_1.GetPlaceableItem(var_42_0, arg_42_0.selectedData.id)
	local var_42_2 = arg_42_0.agora

	if not var_2.IsEmptyArea(var_42_2, var_42_1) then
		pg = var_2

		local var_42_3 = var_2.TipsMgr.GetInstance()
		local var_42_4 = var_2.ShowTips

		i18n = var_4

		var_42_4(var_42_3, var_4("island_agora_pos_unavailability"))

		return
	end

	local var_42_5 = arg_42_0.selectedData.id

	arg_42_0:UnSelectedItem()

	local var_42_6 = arg_42_0
	local var_42_7 = arg_42_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10005

	var_42_7(var_42_6, var_1_10005.CONFIRM_SELECTED_ITEM, var_42_5)

	return
end

function var_0_1.UnSelectedItem(arg_43_0)
	if not arg_43_0:AnySelected() then
		return
	end

	local var_43_0 = arg_43_0.selectedData.id
	local var_43_1 = arg_43_0
	local var_43_2 = arg_43_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10004

	var_43_2(var_43_1, var_1_10004.ITEM_CLEAR_OCCUPIED, var_43_0)

	local var_43_3 = arg_43_0.agora
	local var_43_4 = var_2.GetPlaceableItem(var_43_3, var_43_0)
	local var_43_5 = arg_43_0.agora

	if not var_3.IsEmptyArea(var_43_5, var_43_4) then
		local var_43_6 = arg_43_0.selectedData.position
		local var_43_7 = arg_43_0.selectedData.dir

		var_43_4:UpdatePosition(var_43_6)
		var_43_4:UpdateRotation(var_43_7)
	end

	local var_43_8 = var_43_4:CanOp()
	local var_43_9 = arg_43_0.agora

	var_4.AddItem(var_43_9, var_43_4)

	arg_43_0.selectedData = nil

	local var_43_10 = arg_43_0
	local var_43_11 = arg_43_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_6

	var_43_11(var_43_10, var_6.UNSELECTED_ITEM, var_43_0, var_43_8)

	return
end

function var_0_1.BeginDragItem(arg_44_0)
	if not arg_44_0:AnySelected() then
		return
	end

	local var_44_0 = arg_44_0.agora
	local var_44_1 = var_1.GetPlaceableItem(var_44_0, arg_44_0.selectedData.id)
	local var_44_2 = arg_44_0
	local var_44_3 = arg_44_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10004

	var_44_3(var_44_2, var_1_10004.DRAG_ITEM_BEGIN, var_44_1)

	return
end

function var_0_1.DragItem(arg_45_0, arg_45_1)
	if not arg_45_0:AnySelected() then
		return
	end

	local var_45_0 = arg_45_0.agora
	local var_45_1 = var_2.GetPlaceableItem(var_45_0, arg_45_0.selectedData.id)
	local var_45_2 = var_2.UpdatePosition
	local var_45_3 = arg_45_0.agora

	var_45_2(var_45_1, var_5.ClampRange(var_45_3, arg_45_1.x, arg_45_1.y, var_2))

	local var_45_4 = var_2:GetArea()
	local var_45_5 = arg_45_0.agora
	local var_45_6 = var_4.IsEmptyArea(var_45_5, var_2)
	local var_45_7 = arg_45_0
	local var_45_8 = arg_45_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_7

	var_45_8(var_45_7, var_7.DRAG_ITEM, arg_45_0.selectedData.id, var_45_6)

	local var_45_9 = arg_45_0.agora

	if var_5.GetItemInArea(var_45_9, var_2:GetMapType(), var_45_4) then
		local var_45_10 = arg_45_0
		local var_45_11 = arg_45_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_8

		var_45_11(var_45_10, var_8.ITEM_OCCUPIED, var_5.id)
	else
		local var_45_12 = arg_45_0
		local var_45_13 = arg_45_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_8

		var_45_13(var_45_12, var_8.ITEM_CLEAR_OCCUPIED, var_2.id)
	end

	return
end

function var_0_1.EndDragItem(arg_46_0, arg_46_1)
	local var_46_0 = arg_46_0.agora
	local var_46_1 = var_2.GetPlaceableItem(var_46_0, arg_46_0.selectedData.id)

	arg_46_0:DragItem(arg_46_1)

	local var_46_2 = arg_46_0
	local var_46_3 = arg_46_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_5

	var_46_3(var_46_2, var_5.DRAG_ITEM_END, var_46_1)

	return
end

function var_0_1.RotationItem(arg_47_0)
	if not arg_47_0:AnySelected() then
		return
	end

	local var_47_0 = arg_47_0.agora
	local var_47_1 = var_1.GetPlaceableItem(var_47_0, arg_47_0.selectedData.id)

	var_1.Rotation(var_47_1)

	return
end

function var_0_1.AgoraVirtualInterAction(arg_48_0, arg_48_1, arg_48_2, arg_48_3)
	arg_48_3 = arg_48_3 or 1

	local var_48_0 = arg_48_0.agora
	local var_48_1 = var_4.GetVirtualInteractUnitData(var_48_0, arg_48_1)

	if not var_4.GetEmptySlot(var_48_1) then
		pg = var_48_1

		local var_48_2 = var_48_1.TipsMgr.GetInstance()
		local var_48_3 = var_6.ShowTips

		i18n = var_1_10008

		var_48_3(var_48_2, var_1_10008("island_agora_no_interact_point"))

		return
	end

	local function var_48_4()
		local var_49_0 = var_0

		var_0.Lock(var_49_0, arg_48_2)

		local var_49_1 = arg_48_0
		local var_49_2 = var_0.NotifiyAgora

		ISLAND_AGORA_EVT = var_2

		var_49_2(var_49_1, var_2.START_INTERACTION, var_0, var_0, arg_48_3)

		return
	end

	local var_48_5 = arg_48_0.islandSyncMgr
	local var_48_6 = var_7.TryControlUnit

	IslandConst = var_1_10009

	var_48_6(var_48_5, var_1_10009.SYNC_TYPE_AGORA, arg_48_1, var_5.id, arg_48_3, function(arg_50_0)
		if arg_50_0 then
			var_48_4()
		end

		return
	end)

	return
end

function var_0_1.AgoraVirtualInterActionSync(arg_51_0, arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if arg_51_0.isEditing then
		return
	end

	arg_51_3 = arg_51_3 or 1

	local var_51_0 = arg_51_0.agora
	local var_51_1 = var_5.GetVirtualInteractUnitData(var_51_0, arg_51_1)
	local var_51_2 = var_5.GetSlotById(var_51_1, arg_51_4)

	var_6.Lock(var_51_2, arg_51_2)

	local var_51_3 = arg_51_0
	local var_51_4 = arg_51_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_9

	var_51_4(var_51_3, var_9.START_INTERACTION, var_5, var_6, arg_51_3)

	return
end

function var_0_1.AgoraVirtualInterActionEnd(arg_52_0, arg_52_1, arg_52_2)
	local var_52_0 = arg_52_0.agora
	local var_52_1 = var_3.GetVirtualInteractUnitData(var_52_0, arg_52_1)
	local var_52_2 = var_3.GetUsingSlot(var_52_1, arg_52_2)

	local function var_52_3()
		Clone = var_2_10000

		local var_53_0 = var_2_10000(var_52_2)
		local var_53_1 = var_52_2

		var_1.Release(var_53_1)

		local var_53_2 = arg_52_0
		local var_53_3 = var_1.NotifiyAgora

		ISLAND_AGORA_EVT = var_2_10003

		var_53_3(var_53_2, var_2_10003.END_INTERACTION, var_0, var_53_0)

		return
	end

	local var_52_4 = arg_52_0.islandSyncMgr
	local var_52_5 = var_6.EndControlUnit

	IslandConst = var_1_10008

	var_52_5(var_52_4, var_1_10008.SYNC_TYPE_AGORA, arg_52_1, var_52_2.id, function(arg_54_0)
		if arg_54_0 then
			var_52_3()
		end

		return
	end)

	return
end

function var_0_1.AgoraVirtualInterActionEndSync(arg_55_0, arg_55_1, arg_55_2)
	if arg_55_0.isEditing then
		return
	end

	local var_55_0 = arg_55_0.agora
	local var_55_1 = var_3.GetVirtualInteractUnitData(var_55_0, arg_55_1)
	local var_55_2 = var_3.GetUsingSlot(var_55_1, arg_55_2)

	Clone = var_55_1

	local var_55_3 = var_55_1(var_55_2)

	var_55_2:Release()

	local var_55_4 = arg_55_0
	local var_55_5 = arg_55_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_1_10008

	var_55_5(var_55_4, var_1_10008.END_INTERACTION, var_3, var_55_3)

	return
end

function var_0_1.AgoraVirtualInitStatus(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = arg_56_0.agora

	if not var_3.GetVirtualInteractUnitData(var_56_0, arg_56_1) then
		return
	end

	local var_56_1 = arg_56_0
	local var_56_2 = arg_56_0.NotifiyCore

	ISLAND_EVT = var_1_10006

	var_56_2(var_56_1, var_1_10006.WORLD_OBJECT_INIT_STATUS, var_3, arg_56_2)

	return
end

function var_0_1.PlaceItemRandonPosition(arg_57_0, arg_57_1)
	local var_57_0 = arg_57_0.agora
	local var_57_1 = var_2.GetPlaceableItem(var_57_0, arg_57_1)
	local var_57_2 = var_2.GetCost(var_57_1)
	local var_57_3 = arg_57_0.agora
	local var_57_4

	if var_4.IsMaxCapacityWhenAdd(var_57_3, var_57_2) then
		pg = var_57_4
		var_57_3 = var_57_4.TipsMgr.GetInstance()
		var_57_4 = var_57_4.ShowTips
		i18n = var_6

		var_57_4(var_57_3, var_6("island_agora_max_capacity"))

		return
	end

	AgoraCalc = var_57_4

	if not var_57_4.GetCenterMapPos() then
		pg = var_57_3

		local var_57_5 = var_57_3.TipsMgr.GetInstance()
		local var_57_6 = var_5.ShowTips

		i18n = var_1_10007

		var_57_6(var_57_5, var_1_10007("island_agora_no_size"))

		return
	end

	if arg_57_0:AnySelected() then
		arg_57_0:UnSelectedItem()
	end

	var_2:Clear()

	local var_57_7 = arg_57_0.agora

	if not var_5.FindEmptyArea4Item(var_57_7, var_4, var_2) then
		pg = var_57_7

		local var_57_8 = var_57_7.TipsMgr.GetInstance()
		local var_57_9 = var_6.ShowTips

		i18n = var_8

		var_57_9(var_57_8, var_8("island_agora_no_size"))

		return
	end

	local var_57_10 = arg_57_0
	local var_57_11 = arg_57_0.PlaceItem
	local var_57_12 = arg_57_1
	local var_57_13 = var_5

	Vector3 = var_1_10010

	var_57_11(var_57_10, var_57_12, var_57_13, var_1_10010.zero)
	arg_57_0:SelectItem(var_2)

	return
end

function var_0_1.PlaceItem(arg_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	local var_58_0 = arg_58_0.agora

	var_5.PlaceItem(var_58_0, arg_58_1, arg_58_2, arg_58_3, arg_58_4)

	return
end

function var_0_1.RemovePlaceItem(arg_59_0, arg_59_1)
	arg_59_0:UnPlaceItem(arg_59_1)

	local var_59_0 = arg_59_0
	local var_59_1 = arg_59_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_4

	var_59_1(var_59_0, var_4.UNPLACE_ITEM)

	return
end

function var_0_1.UnPlaceItem(arg_60_0, arg_60_1, arg_60_2)
	local var_60_0

	if not arg_60_1 and arg_60_0.selectedData then
		var_60_0 = arg_60_0.selectedData.id
	end

	if not var_60_0 then
		return
	end

	local var_60_1 = arg_60_0.agora
	local var_60_2 = var_4.GetPlaceableItem(var_60_1, var_60_0)

	if arg_60_0:AnySelected() and arg_60_0.selectedData.id == var_60_0 then
		arg_60_0:UnSelectedItem()
	end

	if not var_60_2:CanOp() and not arg_60_2 then
		return
	end

	local var_60_3 = arg_60_0.agora

	var_5.UnPlaceItem(var_60_3, var_60_0)

	return
end

function var_0_1.ReplaceBuilding(arg_61_0, arg_61_1)
	if arg_61_0:AnySelected() then
		local var_61_0 = arg_61_0.agora

		if var_2.IsBuilding(var_61_0, arg_61_0.selectedData.id) then
			arg_61_0:UnSelectedItem()
		end
	end

	local var_61_1 = arg_61_0.agora
	local var_61_2 = var_2.GetBuilding(var_61_1)

	Vector2 = var_61_1

	local var_61_3 = var_61_1.zero

	if var_61_2 then
		var_61_3 = var_61_2:GetPosition()

		arg_61_0:UnPlaceItem(var_61_2.id, true)
	end

	local var_61_4 = arg_61_0
	local var_61_5 = arg_61_0.PlaceItem
	local var_61_6 = arg_61_1
	local var_61_7 = var_61_3

	Vector3 = var_1_10008

	var_61_5(var_61_4, var_61_6, var_61_7, var_1_10008.zero)

	return
end

function var_0_1.ReplaceFoundation(arg_62_0, arg_62_1)
	if arg_62_0:AnySelected() then
		local var_62_0 = arg_62_0.agora

		if var_2.IsFoundation(var_62_0, arg_62_0.selectedData.id) then
			arg_62_0:UnSelectedItem()
		end
	end

	local var_62_1 = arg_62_0.agora
	local var_62_2 = var_2.GetFoundation(var_62_1)

	Vector2 = var_62_1

	local var_62_3 = var_62_1.zero

	if var_62_2 then
		var_62_3 = var_62_2:GetPosition()

		arg_62_0:UnPlaceItem(var_62_2.id, true)
	end

	local var_62_4 = arg_62_0
	local var_62_5 = arg_62_0.PlaceItem
	local var_62_6 = arg_62_1
	local var_62_7 = var_62_3

	Vector3 = var_1_10008

	var_62_5(var_62_4, var_62_6, var_62_7, var_1_10008.zero)

	return
end

function var_0_1.SelectedPaveItem(arg_63_0, arg_63_1, arg_63_2)
	if arg_63_0:AnySelected() then
		arg_63_0:UnSelectedItem()
	end

	arg_63_0.toUpdateTileList = {}
	arg_63_0.selectedPaveItemId = arg_63_1
	arg_63_0.paveItemShapeId = arg_63_2
	arg_63_0.isCleanLayerMode = false

	return
end

function var_0_1.UnSelectedPaveItem(arg_64_0)
	arg_64_0.toUpdateTileList = {}
	arg_64_0.selectedPaveItemId = nil
	arg_64_0.paveItemShapeId = nil
	arg_64_0.isCleanLayerMode = false

	return
end

function var_0_1.ChangeSelectedShape(arg_65_0, arg_65_1)
	if not arg_65_0.selectedPaveItemId then
		return
	end

	arg_65_0.paveItemShapeId = arg_65_1

	return
end

function var_0_1.ChangePaveMode(arg_66_0, arg_66_1)
	arg_66_0.isCleanLayerMode = arg_66_1

	return
end

function var_0_1.OpLayer(arg_67_0, arg_67_1)
	if not arg_67_0.selectedPaveItemId then
		return
	end

	local var_67_0 = arg_67_0.agora

	if not var_2.GetPlaceableItem(var_67_0, arg_67_0.selectedPaveItemId) then
		return
	end

	local var_67_1 = arg_67_0.agora

	if not var_3.InRange(var_67_1, arg_67_1.x, arg_67_1.y) then
		return
	end

	if not var_2:IsOptionalShapeType() then
		return
	end

	if arg_67_0.isCleanLayerMode then
		arg_67_0:UnPaveLayer(var_2, arg_67_1)
	else
		arg_67_0:PaveLayer(var_2, arg_67_1)
	end

	return
end

function var_0_1.PaveLayer(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = arg_68_1.id
	local var_68_1 = arg_68_0.paveItemShapeId

	arg_68_0:RecordLayer(arg_68_1, arg_68_2)

	if arg_68_1:IsFloor() then
		arg_68_0:PaveFloorLayer(var_68_0, var_68_1, arg_68_2)
	elseif arg_68_1:IsTile() then
		arg_68_0:PaveTileLayer(var_68_0, var_68_1, arg_68_2)
	end

	return
end

function var_0_1.RecordLayer(arg_69_0, arg_69_1, arg_69_2)
	if not arg_69_0.toUpdateTileList[arg_69_2.x] or not arg_69_0.toUpdateTileList[arg_69_2.x][arg_69_2.y] then
		local var_69_0

		if arg_69_1:IsFloor() then
			local var_69_1 = arg_69_0.agora

			var_69_0 = var_4.GetFloorCell(var_69_1, arg_69_2)
		elseif arg_69_1:IsTile() then
			local var_69_2 = arg_69_0.agora

			var_69_0 = var_4.GetTileCell(var_69_2, arg_69_2)
		end

		if var_69_0 then
			if not arg_69_0.toUpdateTileList[arg_69_2.x] then
				arg_69_0.toUpdateTileList[arg_69_2.x] = {}
			end

			arg_69_0.toUpdateTileList[arg_69_2.x][arg_69_2.y] = var_69_0:GetShapeId()
		end
	end

	return
end

function var_0_1.UnPaveLayer(arg_70_0, arg_70_1, arg_70_2)
	if arg_70_1:IsFloor() then
		local var_70_0 = arg_70_0.agora

		if var_3.HasFloorCell(var_70_0, arg_70_2) then
			if arg_70_1:IsTile() then
				local var_70_1 = arg_70_0.agora

				if not var_3.HasTileCell(var_70_1, arg_70_2) then
					return
				end
			end

			arg_70_0:RecordLayer(arg_70_1, arg_70_2)

			if arg_70_1:IsFloor() then
				arg_70_0:UnPaveFloorLayer(arg_70_2)
			elseif arg_70_1:IsTile() then
				arg_70_0:UnPaveTileLayer(arg_70_2)
			end

			return
		end
	end
end

function var_0_1.PaveFloorLayer(arg_71_0, arg_71_1, arg_71_2, arg_71_3)
	local var_71_0 = arg_71_0.agora

	var_4.PlaceFloor(var_71_0, arg_71_1, arg_71_2, arg_71_3)

	return
end

function var_0_1.PaveTileLayer(arg_72_0, arg_72_1, arg_72_2, arg_72_3)
	local var_72_0 = arg_72_0.agora

	var_4.PlaceTile(var_72_0, arg_72_1, arg_72_2, arg_72_3)

	return
end

function var_0_1.RevertPaveLayer(arg_73_0)
	local function var_73_0(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		if arg_74_0 then
			local var_74_0 = arg_73_0

			var_4.UnPaveFloorLayer(var_74_0, arg_74_2)

			return
		end

		local var_74_1 = arg_73_0

		var_4.PaveFloorLayer(var_74_1, arg_74_1, arg_74_3, arg_74_2)

		return
	end

	local function var_73_1(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
		if arg_75_0 then
			local var_75_0 = arg_73_0

			var_4.UnPaveTileLayer(var_75_0, arg_75_2)

			return
		end

		local var_75_1 = arg_73_0

		var_4.PaveTileLayer(var_75_1, arg_75_1, arg_75_3, arg_75_2)

		return
	end

	local var_73_2 = arg_73_0.agora

	if not var_3.GetPlaceableItem(var_73_2, arg_73_0.selectedPaveItemId) then
		return
	end

	local var_73_3 = var_3.id

	pairs = var_5

	for iter_73_0, iter_73_1 in var_5(arg_73_0.toUpdateTileList) do
		pairs = var_1_10010

		for iter_73_2, iter_73_3 in var_1_10010(iter_73_1) do
			Vector2 = var_1_10015
			var_1_10015 = var_1_10015(iter_73_0, iter_73_2)

			local var_73_4 = iter_73_3 < 0

			if var_3:IsFloor() then
				var_73_0(var_73_4, var_73_3, var_1_10015, iter_73_3)
			elseif var_3:IsTile() then
				var_73_1(var_73_4, var_73_3, var_1_10015, iter_73_3)
			end
		end
	end

	arg_73_0.toUpdateTileList = {}

	return
end

function var_0_1.UnPaveFloorLayer(arg_76_0, arg_76_1)
	local var_76_0 = arg_76_0.agora

	var_2.UnPlaceFloor(var_76_0, arg_76_1)

	return
end

function var_0_1.UnPaveTileLayer(arg_77_0, arg_77_1)
	local var_77_0 = arg_77_0.agora

	var_2.UnPlaceTile(var_77_0, arg_77_1)

	return
end

function var_0_1.AddListeners(arg_78_0)
	var_0_1.super.AddListeners(arg_78_0)

	local var_78_0 = arg_78_0
	local var_78_1 = arg_78_0.AddIslandListener

	IslandAgoraAgency = var_1_10003

	var_78_1(var_78_0, var_1_10003.AGORA_UPGRADE, arg_78_0.OnAgoraUpdate)

	local var_78_2 = arg_78_0
	local var_78_3 = arg_78_0.AddIslandListener

	IslandSignInAgency = var_3

	var_78_3(var_78_2, var_3.GIFT_CNT_UPDATE, arg_78_0.OnSignInGiftCntUpdate)

	local var_78_4 = arg_78_0
	local var_78_5 = arg_78_0.AddIslandListener

	IslandSignInAgency = var_3

	var_78_5(var_78_4, var_3.SIGN_CNT_UPDATE, arg_78_0.OnSignCntUpdate)

	local var_78_6 = arg_78_0
	local var_78_7 = arg_78_0.AddIslandListener

	IslandAgoraAgency = var_3

	var_78_7(var_78_6, var_3.ADD_THEME, arg_78_0.OnThemeAdded)

	local var_78_8 = arg_78_0
	local var_78_9 = arg_78_0.AddIslandListener

	IslandAgoraAgency = var_3

	var_78_9(var_78_8, var_3.DEL_THEME, arg_78_0.OnThemeDeleted)

	local var_78_10 = arg_78_0
	local var_78_11 = arg_78_0.AddIslandListener

	IslandAgoraAgency = var_3

	var_78_11(var_78_10, var_3.PLACEMENT_UPDATE, arg_78_0.OnPlacementUpdate)

	local var_78_12 = arg_78_0
	local var_78_13 = arg_78_0.AddIslandListener

	IslandAgoraAgency = var_3

	var_78_13(var_78_12, var_3.ADD_FURNITURE, arg_78_0.OnFurnitureAdded)

	return
end

function var_0_1.RemoveListeners(arg_79_0)
	var_0_1.super.RemoveListeners(arg_79_0)

	local var_79_0 = arg_79_0
	local var_79_1 = arg_79_0.RemoveIslandListener

	IslandAgoraAgency = var_1_10003

	var_79_1(var_79_0, var_1_10003.AGORA_UPGRADE, arg_79_0.OnAgoraUpdate)

	local var_79_2 = arg_79_0
	local var_79_3 = arg_79_0.RemoveIslandListener

	IslandSignInAgency = var_3

	var_79_3(var_79_2, var_3.GIFT_CNT_UPDATE, arg_79_0.OnSignInGiftCntUpdate)

	local var_79_4 = arg_79_0
	local var_79_5 = arg_79_0.RemoveIslandListener

	IslandSignInAgency = var_3

	var_79_5(var_79_4, var_3.SIGN_CNT_UPDATE, arg_79_0.OnSignCntUpdate)

	local var_79_6 = arg_79_0
	local var_79_7 = arg_79_0.RemoveIslandListener

	IslandAgoraAgency = var_3

	var_79_7(var_79_6, var_3.ADD_THEME, arg_79_0.OnThemeAdded)

	local var_79_8 = arg_79_0
	local var_79_9 = arg_79_0.RemoveIslandListener

	IslandAgoraAgency = var_3

	var_79_9(var_79_8, var_3.DEL_THEME, arg_79_0.OnThemeDeleted)

	local var_79_10 = arg_79_0
	local var_79_11 = arg_79_0.RemoveIslandListener

	IslandAgoraAgency = var_3

	var_79_11(var_79_10, var_3.PLACEMENT_UPDATE, arg_79_0.OnPlacementUpdate)

	local var_79_12 = arg_79_0
	local var_79_13 = arg_79_0.RemoveIslandListener

	IslandAgoraAgency = var_3

	var_79_13(var_79_12, var_3.ADD_FURNITURE, arg_79_0.OnFurnitureAdded)

	return
end

function var_0_1.ClearNew(arg_80_0, arg_80_1)
	local var_80_0 = arg_80_0.agora

	if not var_2.GetPlaceableItem(var_80_0, arg_80_1) then
		return
	end

	var_2:ClearNew()

	local var_80_1 = arg_80_0:GetIsland()
	local var_80_2 = var_3.GetAgoraAgency(var_80_1)

	var_3.ClearNew(var_80_2, var_2.configId)

	return
end

function var_0_1.ClearAllNew(arg_81_0)
	local var_81_0 = arg_81_0.agora
	local var_81_1 = var_1.GetPlaceableList(var_81_0)

	pairs = var_81_0

	for iter_81_0, iter_81_1 in var_81_0(var_81_1) do
		iter_81_1:ClearNew()
	end

	local var_81_2 = arg_81_0:GetIsland()
	local var_81_3 = var_2.GetAgoraAgency(var_81_2)

	var_2.ClearAllNew(var_81_3)

	return
end

function var_0_1.OnFurnitureAdded(arg_82_0, arg_82_1)
	for iter_82_0 = 1, arg_82_1.count do
		AgoraCalc = var_1_10006
		var_1_10006 = var_1_10006.GetUniqueId(arg_82_1.id, iter_82_0)
		AgoraFurniture = var_7

		local var_82_0 = var_7.New({
			id = var_1_10006,
			configId = arg_82_1.id,
			time = arg_82_1.time,
			isNew = arg_82_1.isNew
		})
		local var_82_1 = arg_82_0.agora

		var_8.AddPlaceable(var_82_1, var_82_0)
	end

	return
end

function var_0_1.OnPlacementUpdate(arg_83_0, arg_83_1)
	local var_83_0 = arg_83_0.islandSyncMgr

	var_2.CancelAgoraInteract(var_83_0)

	local var_83_1 = arg_83_0.islandSyncMgr

	var_2.ClearAgoraInteractData(var_83_1)

	AgoraTheme = var_2

	local var_83_2 = var_2.New(arg_83_1, arg_83_0.agora.placeableList)
	local var_83_3, var_83_4, var_83_5 = var_2.GetSeparatedPlacedData(var_83_2)
	local var_83_6 = arg_83_0.agora
	local var_83_7 = var_6.GetFoundation(var_83_6)

	if var_83_4 and var_83_7.id ~= var_83_4.id then
		arg_83_0:ReplaceFoundation(var_83_4.id)
	end

	local var_83_8 = arg_83_0.agora
	local var_83_9 = var_7.GetBuilding(var_83_8)

	if var_83_5 and var_83_9.id ~= var_83_5.id then
		arg_83_0:ReplaceBuilding(var_83_5.id)
	end

	local var_83_10 = arg_83_0.agora
	local var_83_11 = var_8.GetPlacedListWithoutFoundationAndBuilding(var_83_10)

	AgoraCalc = var_83_10

	local var_83_12, var_83_13, var_83_14 = var_83_10.GetChangePlacementList(var_83_3, var_83_11)

	ipairs = var_1_10012

	for iter_83_0, iter_83_1 in var_1_10012(var_83_13) do
		local var_83_15 = arg_83_0.agora

		var_17.UnPlaceItem(var_83_15, iter_83_1.id)
	end

	ipairs = var_12

	for iter_83_2, iter_83_3 in var_12(var_83_14) do
		local var_83_16 = arg_83_0.agora

		var_17.PlaceItem(var_83_16, iter_83_3.id, iter_83_3:GetPosition(), iter_83_3:GetRotation())
	end

	ipairs = var_12

	for iter_83_4, iter_83_5 in var_12(var_83_12) do
		local var_83_17 = arg_83_0.agora

		var_17.UnPlaceItem(var_83_17, iter_83_5.id)

		local var_83_18 = arg_83_0.agora

		var_17.PlaceItem(var_83_18, iter_83_5.id, iter_83_5:GetPosition(), iter_83_5:GetRotation())
	end

	arg_83_0:ClearLayers()

	local var_83_19 = var_2:GetFloorData()
	local var_83_20 = var_2:GetTileData()

	arg_83_0:PaveLayers(var_83_19, var_83_20)

	arg_83_0.reloading = true
	pg = var_14

	local var_83_21 = var_14.TimeMgr.GetInstance()

	arg_83_0.nextReloadingEndTime = var_14.GetServerTime(var_83_21) + arg_83_0.baseReloadingCd

	local var_83_22 = arg_83_0
	local var_83_23 = arg_83_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_16

	var_83_23(var_83_22, var_16.RELOADING)

	if (#var_83_14 > 0 or #var_83_12 > 0) and not arg_83_0:IsSelfIsland() then
		arg_83_0:ResetPlayerPosition()
	end

	local var_83_24 = arg_83_0.islandSyncMgr
	local var_83_25 = var_14.InitAgora
	local var_83_26 = arg_83_0.agora

	var_83_25(var_83_24, var_16.GetAllVirtualInteractUnitData(var_83_26))

	return
end

function var_0_1.OnThemeAdded(arg_84_0, arg_84_1)
	AgoraTheme = var_1_10002

	local var_84_0 = var_1_10002.New(arg_84_1, arg_84_0.agora.placeableList)
	local var_84_1 = arg_84_0.agora

	var_3.AddTheme(var_84_1, var_84_0)

	return
end

function var_0_1.OnThemeDeleted(arg_85_0, arg_85_1)
	local var_85_0 = arg_85_0.agora

	var_2.DeleteTheme(var_85_0, arg_85_1)

	return
end

function var_0_1.OnSignCntUpdate(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_0:GetIsland()
	local var_86_1 = var_2.GetSignInAgency(var_86_0)
	local var_86_2 = arg_86_0
	local var_86_3 = arg_86_0.NotifiyCore

	ISLAND_EVT = var_1_10005

	var_86_3(var_86_2, var_1_10005.REFRESH_INTERACTION)

	local var_86_4 = arg_86_0
	local var_86_5 = arg_86_0.NotifiyAgora

	ISLAND_AGORA_EVT = var_5

	var_86_5(var_86_4, var_5.SIGN_IN_CNT_UPDATE, arg_86_1)

	return
end

function var_0_1.OnSignInGiftCntUpdate(arg_87_0, arg_87_1)
	local var_87_0 = arg_87_0.giftAllocator

	var_2.Flush(var_87_0)

	return
end

function var_0_1.OnAgoraUpdate(arg_88_0, arg_88_1, arg_88_2)
	IslandConst = var_1_10003

	local var_88_0 = var_1_10003.AGORA_LEVEL_2_SIZE[arg_88_1]
	local var_88_1 = arg_88_0.agora
	local var_88_2 = var_4.UpdateSize

	Vector2 = var_1_10006

	var_88_2(var_88_1, var_1_10006(var_88_0, var_88_0))

	local var_88_3 = arg_88_0.agora

	var_4.UpdateCapacity(var_88_3, arg_88_2)

	return
end

function var_0_1.CreateAgora(arg_89_0, arg_89_1)
	local var_89_0 = arg_89_1:GetAgoraAgency()
	local var_89_1 = {}

	ipairs = var_1_10004

	for iter_89_0, iter_89_1 in var_1_10004(var_89_0:GetFurnitures()) do
		for iter_89_2 = 1, iter_89_1.count do
			AgoraCalc = var_1_10013
			var_1_10013 = var_1_10013.GetUniqueId(iter_89_1.id, iter_89_2)
			AgoraFurniture = var_14
			var_89_1[var_14.New({
				id = var_1_10013,
				configId = iter_89_1.id,
				time = iter_89_1.time,
				isNew = iter_89_1.isNew
			}).id] = var_14
		end
	end

	AgoraTheme = var_4

	local var_89_2 = var_4.New(var_89_0:GetPlacedData(), var_89_1)
	local var_89_3, var_89_4, var_89_5 = var_4.GetSeparatedPlacedData(var_89_2)
	local var_89_6 = var_4:GetFloorData()
	local var_89_7 = var_4:GetTileData()
	local var_89_8 = {}

	ipairs = var_1_10011

	for iter_89_3, iter_89_4 in var_1_10011(var_89_0:GetThemes()) do
		AgoraTheme = var_1_10016
		var_1_10016 = var_1_10016.New(iter_89_4, var_89_1)
		table = var_1_10017

		var_1_10017.insert(var_89_8, var_1_10016)
	end

	local var_89_9 = {}

	ipairs = var_12

	for iter_89_5, iter_89_6 in var_12(var_89_0:GetSystemThemes()) do
		AgoraSystemTheme = var_1_10017
		var_1_10017 = var_1_10017.New(iter_89_6)
		table = var_1_10018

		var_1_10018.insert(var_89_9, var_1_10017)
	end

	local var_89_10 = var_89_0
	local var_89_11 = var_89_0.GetLevel(var_89_10)

	math = var_89_10

	local var_89_12 = var_89_10.clamp
	local var_89_13 = var_89_11
	local var_89_14 = 1

	IslandConst = iter_89_6

	local var_89_15 = var_89_12(var_89_13, var_89_14, #iter_89_6.AGORA_LEVEL_2_SIZE)

	IslandConst = var_89_13

	local var_89_16 = var_89_13.AGORA_LEVEL_2_SIZE[var_89_15]
	local var_89_17 = var_89_0
	local var_89_18 = var_89_0.GetCapacity(var_89_17)

	Agora = var_89_17

	local var_89_19 = var_89_17.New
	local var_89_20 = {}

	Vector2 = var_1_10018
	var_89_20.size = var_1_10018(var_89_16, var_89_16)
	var_89_20.placeableList = var_89_1
	var_89_20.capacity = var_89_18
	var_89_20.themes = var_89_8
	var_89_20.systemThemes = var_89_9

	return var_89_19(var_89_20), {
		placedlist = var_89_3,
		foundation = var_89_4,
		building = var_89_5,
		placedFloor = var_89_6,
		placedTile = var_89_7
	}
end

return var_0_1
