local AgoraController = class("AgoraController", import("Mod.Island.Core.controller.IslandController"))

function AgoraController:Init()
	AgoraController.super.Init(self)

	local var_1_0, var_1_1 = self:CreateAgora(self.island)

	self.agora = var_1_0
	self.placedData = var_1_1
	self.isEditing = false
	self.selectedData = nil
	self.editCdTime = 0
	self.toUpdateTileList = {}
	self.dataComparator = AgoraDataComparator.New(self.agora)
	self.reloading = false
	self.baseReloadingCd = pg.island_set.agora_reloading_base_cd.key_value_int
	self.nextReloadingEndTime = 0
	self.isCleanLayerMode = false

	return
end

function AgoraController:GetDefaultFoundation()
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

function AgoraController:GetDefaultBuilding()
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

function AgoraController:Update()
	AgoraController.super.Update(self)
	self:CheckReloadFinish()

	return
end

function AgoraController:CheckReloadFinish()
	if not self.reloading then
		return
	end

	if pg.TimeMgr.GetInstance():GetServerTime() < self.nextReloadingEndTime then
		return
	end

	if self:GetView():IsLoaded() then
		self:NotifiyAgora(ISLAND_AGORA_EVT.RELOADING_FINISH)

		self.reloading = false
	end

	return
end

function AgoraController:SetUp()
	AgoraController.super.SetUp(self)
	self:NotifiyAgora(ISLAND_AGORA_EVT.START_LOAD_ITEMS)
	self:NotifiyAgora(ISLAND_AGORA_EVT.MAP_SIZE_UPDATE, self.agora:GetSize())

	local var_6_0 = self.placedData.foundation or self:GetDefaultFoundation()

	if var_6_0 then
		self:PlaceItem(var_6_0.id, var_6_0:GetPosition(), Vector3.zero)
	end

	local var_6_1 = self.placedData.building or self:GetDefaultBuilding()

	if var_6_1 then
		self:PlaceItem(var_6_1.id, var_6_1:GetPosition(), Vector3.zero)
	end

	local var_6_2 = {}

	for iter_6_0, iter_6_1 in pairs(self.placedData.placedlist) do
		table.insert(var_6_2, function(arg_7_0)
			self:PlaceItem(iter_6_1.id, iter_6_1:GetPosition(), iter_6_1:GetRotation())

			if iter_6_0 % 3 == 0 then
				onNextTick(arg_7_0)
			else
				arg_7_0()
			end

			return
		end)
	end

	seriesAsync(var_6_2, function()
		self:NotifiyAgora(ISLAND_AGORA_EVT.END_LOAD_ITEMS, var_6_1:GetPosition())

		return
	end)

	return
end

function AgoraController:OnCoreInitFinish()
	self:PaveLayers(self.placedData.placedFloor, self.placedData.placedTile)
	AgoraController.super.OnCoreInitFinish(self)

	return
end

function AgoraController:InitSyncMgr()
	self.islandSyncMgr:Init(self.sceneData.unitList, self.agora:GetAllVirtualInteractUnitData())

	return
end

function AgoraController:PaveLayers(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in pairs(arg_11_1) do
		self:PaveFloorLayer(iter_11_1.id, iter_11_1:GetShapeId(), iter_11_1:GetPosition())
	end

	for iter_11_2, iter_11_3 in pairs(arg_11_2) do
		self:PaveTileLayer(iter_11_3.id, iter_11_3:GetShapeId(), iter_11_3:GetPosition())
	end

	return
end

function AgoraController:GetAgora()
	return self.agora
end

function AgoraController:CanEnterEditMode()
	return pg.TimeMgr.GetInstance():GetServerTime() >= self.editCdTime
end

function AgoraController:AnySelected()
	return self.selectedData ~= nil
end

function AgoraController:NotifiyAgora(arg_15_1, ...)
	self.agora:DispatchEvent(arg_15_1, ...)

	return
end

function AgoraController:CheckChange()
	if self:AnySelected() then
		self:UnSelectedItem()
	end

	local var_16_0, var_16_1 = self.dataComparator:AnyChanged()

	return var_16_0
end

function AgoraController:EnterEditMode()
	if not self:CanEnterEditMode() then
		self:NotifiyAgora(ISLAND_AGORA_EVT.ENTER_EDIT_FAILED)

		return
	end

	self.islandSyncMgr:CancelAgoraInteract()

	self.isEditing = true

	self.dataComparator:TakeSample()
	self:NotifiyAgora(ISLAND_AGORA_EVT.ENTER_EDIT)
	self:NotifiyIsland(ISLAND_EX_EVT.ENTER_EDIT_AGORA)

	return
end

function AgoraController:ExitEditMode()
	self.isEditing = false

	self.dataComparator:Abort()
	self:NotifiyAgora(ISLAND_AGORA_EVT.EXIT_EDIT)
	self:NotifiyIsland(ISLAND_EX_EVT.EXIT_EDIT_AGORA)
	self:ClearAllNew()

	return
end

function AgoraController:SaveAndExit()
	self:Save(true)
	self:ExitEditMode()

	return
end

function AgoraController:Save(arg_20_1)
	if not arg_20_1 and not self:CanEnterEditMode() then
		return
	end

	if self:AnySelected() then
		self:UnSelectedItem()
	end

	self.islandSyncMgr:ClearAgoraInteractData()

	local var_20_0, var_20_1, var_20_2 = self.agora:SerializePlacementData()

	self:NotifiyMeditor(IslandMediator.SAVE_AGORA, var_20_0, var_20_1, var_20_2)
	self.dataComparator:TakeSample()

	self.editCdTime = pg.TimeMgr.GetInstance():GetServerTime() + pg.island_set.island_build_save_time.key_value_int

	self:NotifiyAgora(ISLAND_AGORA_EVT.SAVE)
	self.islandSyncMgr:InitAgora(self.agora:GetAllVirtualInteractUnitData())

	return
end

function AgoraController:SaveTheme(arg_21_1, arg_21_2)
	if self:AnySelected() then
		self:UnSelectedItem()
	end

	local var_21_0, var_21_1, var_21_2 = self.agora:SerializePlacementData()

	if #var_21_0 <= 0 and #var_21_1 <= 0 and #var_21_2 <= 0 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_deco_empty"))

		return
	end

	self:NotifiyMeditor(IslandMediator.SAVE_AGORA_THEME, {
		id = arg_21_1,
		name = arg_21_2,
		updateList = var_21_0,
		floorList = var_21_1,
		tileList = var_21_2
	})

	return
end

function AgoraController:ApplyTheme(arg_22_1, arg_22_2)
	local var_22_0

	if arg_22_2 then
		var_22_0 = self.agora:GetSystemTheme(arg_22_1) or self.agora:GetTheme(arg_22_1)

		if not var_22_0 then
			return
		end
	end

	self:ClearAll()
	self:NotifiyAgora(ISLAND_AGORA_EVT.START_LOAD_ITEMS)

	local var_22_1 = {}

	for iter_22_0, iter_22_1 in ipairs((var_22_0:GetPlacedData())) do
		table.insert(var_22_1, function(arg_23_0)
			if iter_22_1:IsFoundationType() then
				self:ReplaceFoundation(iter_22_1.id)
			elseif iter_22_1:IsBuildingType() then
				self:ReplaceBuilding(iter_22_1.id)
			else
				self:PlaceItem(iter_22_1.id, iter_22_1:GetPosition(), iter_22_1:GetRotation())
			end

			if iter_22_0 % 3 == 0 then
				onNextTick(arg_23_0)
			else
				arg_23_0()
			end

			return
		end)
	end

	table.insert(var_22_1, function(arg_24_0)
		onNextTick(arg_24_0)

		return
	end)

	for iter_22_2, iter_22_3 in ipairs((var_22_0:GetFloorData())) do
		self:PaveFloorLayer(iter_22_3.id, iter_22_3.shapeId, iter_22_3:GetPosition())
	end

	table.insert(var_22_1, function(arg_25_0)
		onNextTick(arg_25_0)

		return
	end)

	for iter_22_4, iter_22_5 in ipairs((var_22_0:GetTileData())) do
		self:PaveTileLayer(iter_22_5.id, iter_22_5.shapeId, iter_22_5:GetPosition())
	end

	seriesAsync(var_22_1, function()
		self:NotifiyAgora(ISLAND_AGORA_EVT.END_LOAD_ITEMS)

		return
	end)

	return
end

function AgoraController:DeleteTheme(arg_27_1)
	self:NotifiyMeditor(IslandMediator.DEL_AGORA_THEME, arg_27_1)

	return
end

function AgoraController:ClearAll()
	if self:AnySelected() then
		self:UnPlaceItem(self.selectedData.id)

		self.selectedData = nil
	end

	self:ClearPlaced(false)
	self:ClearLayers()

	return
end

function AgoraController:ClearPlaced(arg_29_1)
	if arg_29_1 then
		for iter_29_0, iter_29_1 in pairs(self.agora:GetPlacedlist()) do
			self:UnPlaceItem(iter_29_1.id, true)
		end
	else
		for iter_29_2, iter_29_3 in pairs(self.agora:GetPlacedlist()) do
			if iter_29_3:CanOp() then
				self:UnPlaceItem(iter_29_3.id)
			end
		end
	end

	return
end

function AgoraController:ClearFloorLayer()
	for iter_30_0, iter_30_1 in pairs(self.agora:GetFloorLayer()) do
		for iter_30_2, iter_30_3 in pairs(iter_30_1) do
			if not iter_30_3:IsEmpty() then
				self:UnPaveFloorLayer(iter_30_3:GetPosition())
			end
		end
	end

	return
end

function AgoraController:ClearTileLayer()
	for iter_31_0, iter_31_1 in pairs(self.agora:GetTileLayer()) do
		for iter_31_2, iter_31_3 in pairs(iter_31_1) do
			if not iter_31_3:IsEmpty() then
				self:UnPaveTileLayer(iter_31_3:GetPosition())
			end
		end
	end

	return
end

function AgoraController:ClearLayers()
	self:ClearFloorLayer()
	self:ClearTileLayer()

	return
end

function AgoraController:Revert()
	local var_33_0, var_33_1 = self.dataComparator:AnyChanged()

	if not var_33_0 then
		self.islandSyncMgr:ResumeAgoraInteract()

		return
	end

	local var_33_2, var_33_3, var_33_4 = self.dataComparator:GetSample()
	local var_33_5 = {}

	if bit.band(var_33_1, AgoraDataComparator.CHANGE_TYPE_PLACED) > 0 then
		self:ClearPlaced(true)

		for iter_33_0, iter_33_1 in pairs(var_33_2) do
			table.insert(var_33_5, function(arg_34_0)
				self:PlaceItem(iter_33_1.id, iter_33_1:GetPosition(), iter_33_1:GetRotation(), arg_34_0)

				return
			end)
		end
	end

	parallelAsync(var_33_5, function()
		self.islandSyncMgr:ResumeAgoraInteract()

		return
	end)

	if bit.band(var_33_1, AgoraDataComparator.CHANGE_TYPE_FLOOR) > 0 then
		self:ClearFloorLayer()

		for iter_33_2, iter_33_3 in pairs(var_33_3) do
			for iter_33_4, iter_33_5 in pairs(iter_33_3) do
				if not iter_33_5:IsEmpty() then
					self:PaveFloorLayer(iter_33_5.id, iter_33_5:GetShapeId(), iter_33_5:GetPosition())
				end
			end
		end
	end

	if bit.band(var_33_1, AgoraDataComparator.CHANGE_TYPE_TILE) > 0 then
		self:ClearTileLayer()

		for iter_33_6, iter_33_7 in pairs(var_33_4) do
			for iter_33_8, iter_33_9 in pairs(iter_33_7) do
				if not iter_33_9:IsEmpty() then
					self:PaveTileLayer(iter_33_9.id, iter_33_9:GetShapeId(), iter_33_9:GetPosition())
				end
			end
		end
	end

	return
end

function AgoraController:RevertAndExit()
	self:Revert()
	self:ExitEditMode()

	return
end

function AgoraController:Upgrade()
	self:NotifiyMeditor(IslandMediator.UPGRADE_AGORA)

	return
end

function AgoraController:TrySelectItemById(arg_38_1)
	self:_TrySelectItem((self.agora:GetPlacedItem(arg_38_1)))

	return
end

function AgoraController:TrySelectItem(arg_39_1)
	self:_TrySelectItem((self.agora:GetAnyMapItemInPosition(arg_39_1)))

	return
end

function AgoraController:_TrySelectItem(arg_40_1)
	if not arg_40_1 then
		return
	end

	if not arg_40_1:CanSelect() then
		return
	end

	if self:AnySelected() then
		self:UnSelectedItem()
	end

	self:SelectItem(arg_40_1)

	return
end

function AgoraController:SelectItem(arg_41_1)
	self.selectedData = {
		id = arg_41_1.id,
		position = arg_41_1:GetPosition(),
		dir = arg_41_1:GetRotation()
	}

	self.agora:RemoveItem(arg_41_1)
	self:NotifiyAgora(ISLAND_AGORA_EVT.SELECTED_ITEM, self.selectedData.id, (arg_41_1:CanOp()))

	return
end

function AgoraController:ConfirmSelectedItem()
	if not self:AnySelected() then
		return
	end

	if not self.agora:IsEmptyArea((self.agora:GetPlaceableItem(self.selectedData.id))) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_pos_unavailability"))

		return
	end

	local var_42_0 = self.selectedData.id

	self:UnSelectedItem()
	self:NotifiyAgora(ISLAND_AGORA_EVT.CONFIRM_SELECTED_ITEM, var_42_0)

	return
end

function AgoraController:UnSelectedItem()
	if not self:AnySelected() then
		return
	end

	local var_43_0 = self.selectedData.id

	self:NotifiyAgora(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, self.selectedData.id)

	local var_43_1 = self.agora:GetPlaceableItem(var_43_0)

	if not self.agora:IsEmptyArea(var_43_1) then
		var_43_1:UpdatePosition(self.selectedData.position)
		var_43_1:UpdateRotation(self.selectedData.dir)
	end

	local var_43_2 = var_43_1:CanOp()

	self.agora:AddItem(var_43_1)

	self.selectedData = nil

	self:NotifiyAgora(ISLAND_AGORA_EVT.UNSELECTED_ITEM, var_43_0, var_43_2)

	return
end

function AgoraController:BeginDragItem()
	if not self:AnySelected() then
		return
	end

	self:NotifiyAgora(ISLAND_AGORA_EVT.DRAG_ITEM_BEGIN, (self.agora:GetPlaceableItem(self.selectedData.id)))

	return
end

function AgoraController:DragItem(arg_45_1)
	if not self:AnySelected() then
		return
	end

	local var_45_0 = self.agora:GetPlaceableItem(self.selectedData.id)

	var_45_0:UpdatePosition(self.agora:ClampRange(arg_45_1.x, arg_45_1.y, var_45_0))
	self:NotifiyAgora(ISLAND_AGORA_EVT.DRAG_ITEM, self.selectedData.id, (self.agora:IsEmptyArea(var_45_0)))

	local var_45_1 = self.agora:GetItemInArea(var_45_0:GetMapType(), (var_45_0:GetArea()))

	if var_45_1 then
		self:NotifiyAgora(ISLAND_AGORA_EVT.ITEM_OCCUPIED, var_45_1.id)
	else
		self:NotifiyAgora(ISLAND_AGORA_EVT.ITEM_CLEAR_OCCUPIED, var_45_0.id)
	end

	return
end

function AgoraController:EndDragItem(arg_46_1)
	self:DragItem(arg_46_1)
	self:NotifiyAgora(ISLAND_AGORA_EVT.DRAG_ITEM_END, (self.agora:GetPlaceableItem(self.selectedData.id)))

	return
end

function AgoraController:RotationItem()
	if not self:AnySelected() then
		return
	end

	self.agora:GetPlaceableItem(self.selectedData.id):Rotation()

	return
end

function AgoraController:AgoraVirtualInterAction(arg_48_1, arg_48_2, arg_48_3)
	arg_48_3 = arg_48_3 or 1

	local var_48_0 = self.agora:GetVirtualInteractUnitData(arg_48_1)
	local var_48_1 = var_48_0:GetEmptySlot()

	if not var_48_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_interact_point"))

		return
	end

	local function var_48_2()
		var_48_1:Lock(arg_48_2)
		self:NotifiyAgora(ISLAND_AGORA_EVT.START_INTERACTION, var_48_0, var_48_1, arg_48_3)

		return
	end

	self.islandSyncMgr:TryControlUnit(IslandConst.SYNC_TYPE_AGORA, arg_48_1, var_48_1.id, arg_48_3, function(arg_50_0)
		if arg_50_0 then
			var_48_2()
		end

		return
	end)

	return
end

function AgoraController:AgoraVirtualInterActionSync(arg_51_1, arg_51_2, arg_51_3, arg_51_4)
	if self.isEditing then
		return
	end

	arg_51_3 = arg_51_3 or 1

	local var_51_0 = self.agora:GetVirtualInteractUnitData(arg_51_1)
	local var_51_1 = var_51_0:GetSlotById(arg_51_4)

	var_51_1:Lock(arg_51_2)
	self:NotifiyAgora(ISLAND_AGORA_EVT.START_INTERACTION, var_51_0, var_51_1, arg_51_3)

	return
end

function AgoraController:AgoraVirtualInterActionEnd(arg_52_1, arg_52_2)
	local var_52_0 = self.agora:GetVirtualInteractUnitData(arg_52_1)
	local var_52_1 = var_52_0:GetUsingSlot(arg_52_2)

	local function var_52_2()
		var_52_1:Release()
		self:NotifiyAgora(ISLAND_AGORA_EVT.END_INTERACTION, var_52_0, (Clone(var_52_1)))

		return
	end

	self.islandSyncMgr:EndControlUnit(IslandConst.SYNC_TYPE_AGORA, arg_52_1, var_52_1.id, function(arg_54_0)
		if arg_54_0 then
			var_52_2()
		end

		return
	end)

	return
end

function AgoraController:AgoraVirtualInterActionEndSync(arg_55_1, arg_55_2)
	if self.isEditing then
		return
	end

	local var_55_0 = self.agora:GetVirtualInteractUnitData(arg_55_1)
	local var_55_1 = var_55_0:GetUsingSlot(arg_55_2)

	var_55_1:Release()
	self:NotifiyAgora(ISLAND_AGORA_EVT.END_INTERACTION, var_55_0, (Clone(var_55_1)))

	return
end

function AgoraController:AgoraVirtualInitStatus(arg_56_1, arg_56_2)
	local var_56_0 = self.agora:GetVirtualInteractUnitData(arg_56_1)

	if not var_56_0 then
		return
	end

	self:NotifiyCore(ISLAND_EVT.WORLD_OBJECT_INIT_STATUS, var_56_0, arg_56_2)

	return
end

function AgoraController:PlaceItemRandonPosition(arg_57_1)
	local var_57_0 = self.agora:GetPlaceableItem(arg_57_1)

	if self.agora:IsMaxCapacityWhenAdd((var_57_0:GetCost())) then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_max_capacity"))

		return
	end

	local var_57_1 = AgoraCalc.GetCenterMapPos()

	if not var_57_1 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_size"))

		return
	end

	if self:AnySelected() then
		self:UnSelectedItem()
	end

	var_57_0:Clear()

	local var_57_2 = self.agora:FindEmptyArea4Item(var_57_1, var_57_0)

	if not var_57_2 then
		pg.TipsMgr.GetInstance():ShowTips(i18n("island_agora_no_size"))

		return
	end

	self:PlaceItem(arg_57_1, var_57_2, Vector3.zero)
	self:SelectItem(var_57_0)

	return
end

function AgoraController:PlaceItem(arg_58_1, arg_58_2, arg_58_3, arg_58_4)
	self.agora:PlaceItem(arg_58_1, arg_58_2, arg_58_3, arg_58_4)

	return
end

function AgoraController:RemovePlaceItem(arg_59_1)
	self:UnPlaceItem(arg_59_1)
	self:NotifiyAgora(ISLAND_AGORA_EVT.UNPLACE_ITEM)

	return
end

function AgoraController:UnPlaceItem(arg_60_1, arg_60_2)
	local var_60_0

	if not arg_60_1 then
		::label_60_0::

		var_60_0 = self.selectedData and self.selectedData.id
	end

	if not var_60_0 then
		return
	end

	local var_60_1 = self.agora:GetPlaceableItem(var_60_0)

	if self:AnySelected() and self.selectedData.id == var_60_0 then
		self:UnSelectedItem()
	end

	if not var_60_1:CanOp() and not arg_60_2 then
		return
	end

	self.agora:UnPlaceItem(var_60_0)

	return
end

function AgoraController:ReplaceBuilding(arg_61_1)
	if self:AnySelected() and self.agora:IsBuilding(self.selectedData.id) then
		self:UnSelectedItem()
	end

	local var_61_0 = self.agora:GetBuilding()
	local var_61_1 = Vector2.zero

	if var_61_0 then
		var_61_1 = var_61_0:GetPosition()

		self:UnPlaceItem(var_61_0.id, true)
	end

	self:PlaceItem(arg_61_1, var_61_1, Vector3.zero)

	return
end

function AgoraController:ReplaceFoundation(arg_62_1)
	if self:AnySelected() and self.agora:IsFoundation(self.selectedData.id) then
		self:UnSelectedItem()
	end

	local var_62_0 = self.agora:GetFoundation()
	local var_62_1 = Vector2.zero

	if var_62_0 then
		var_62_1 = var_62_0:GetPosition()

		self:UnPlaceItem(var_62_0.id, true)
	end

	self:PlaceItem(arg_62_1, var_62_1, Vector3.zero)

	return
end

function AgoraController:SelectedPaveItem(arg_63_1, arg_63_2)
	if self:AnySelected() then
		self:UnSelectedItem()
	end

	self.toUpdateTileList = {}
	self.selectedPaveItemId = arg_63_1
	self.paveItemShapeId = arg_63_2
	self.isCleanLayerMode = false

	return
end

function AgoraController:UnSelectedPaveItem()
	self.toUpdateTileList = {}
	self.selectedPaveItemId = nil
	self.paveItemShapeId = nil
	self.isCleanLayerMode = false

	return
end

function AgoraController:ChangeSelectedShape(arg_65_1)
	if not self.selectedPaveItemId then
		return
	end

	self.paveItemShapeId = arg_65_1

	return
end

function AgoraController:ChangePaveMode(arg_66_1)
	self.isCleanLayerMode = arg_66_1

	return
end

function AgoraController:OpLayer(arg_67_1)
	if not self.selectedPaveItemId then
		return
	end

	local var_67_0 = self.agora:GetPlaceableItem(self.selectedPaveItemId)

	if not var_67_0 then
		return
	end

	if not self.agora:InRange(arg_67_1.x, arg_67_1.y) then
		return
	end

	if not var_67_0:IsOptionalShapeType() then
		return
	end

	if self.isCleanLayerMode then
		self:UnPaveLayer(var_67_0, arg_67_1)
	else
		self:PaveLayer(var_67_0, arg_67_1)
	end

	return
end

function AgoraController:PaveLayer(arg_68_1, arg_68_2)
	self:RecordLayer(arg_68_1, arg_68_2)

	if arg_68_1:IsFloor() then
		self:PaveFloorLayer(arg_68_1.id, self.paveItemShapeId, arg_68_2)
	elseif arg_68_1:IsTile() then
		self:PaveTileLayer(arg_68_1.id, self.paveItemShapeId, arg_68_2)
	end

	return
end

function AgoraController:RecordLayer(arg_69_1, arg_69_2)
	if not self.toUpdateTileList[arg_69_2.x] or not self.toUpdateTileList[arg_69_2.x][arg_69_2.y] then
		local var_69_0

		if arg_69_1:IsFloor() then
			var_69_0 = self.agora:GetFloorCell(arg_69_2)
		elseif arg_69_1:IsTile() then
			var_69_0 = self.agora:GetTileCell(arg_69_2)
		end

		if var_69_0 then
			self.toUpdateTileList[arg_69_2.x] = self.toUpdateTileList[arg_69_2.x] or {}
			self.toUpdateTileList[arg_69_2.x][arg_69_2.y] = var_69_0:GetShapeId()
		end
	end

	return
end

function AgoraController:UnPaveLayer(arg_70_1, arg_70_2)
	if arg_70_1:IsFloor() and not self.agora:HasFloorCell(arg_70_2) or arg_70_1:IsTile() and not self.agora:HasTileCell(arg_70_2) then
		return
	end

	self:RecordLayer(arg_70_1, arg_70_2)

	if arg_70_1:IsFloor() then
		self:UnPaveFloorLayer(arg_70_2)
	elseif arg_70_1:IsTile() then
		self:UnPaveTileLayer(arg_70_2)
	end

	return
end

function AgoraController:PaveFloorLayer(arg_71_1, arg_71_2, arg_71_3)
	self.agora:PlaceFloor(arg_71_1, arg_71_2, arg_71_3)

	return
end

function AgoraController:PaveTileLayer(arg_72_1, arg_72_2, arg_72_3)
	self.agora:PlaceTile(arg_72_1, arg_72_2, arg_72_3)

	return
end

function AgoraController:RevertPaveLayer()
	local function var_73_0(arg_74_0, arg_74_1, arg_74_2, arg_74_3)
		if arg_74_0 then
			self:UnPaveFloorLayer(arg_74_2)

			return
		end

		self:PaveFloorLayer(arg_74_1, arg_74_3, arg_74_2)

		return
	end

	local function var_73_1(arg_75_0, arg_75_1, arg_75_2, arg_75_3)
		if arg_75_0 then
			self:UnPaveTileLayer(arg_75_2)

			return
		end

		self:PaveTileLayer(arg_75_1, arg_75_3, arg_75_2)

		return
	end

	local var_73_2 = self.agora:GetPlaceableItem(self.selectedPaveItemId)

	if not var_73_2 then
		return
	end

	local var_73_3 = var_73_2.id

	for iter_73_0, iter_73_1 in pairs(self.toUpdateTileList) do
		for iter_73_2, iter_73_3 in pairs(iter_73_1) do
			local var_73_4 = Vector2(iter_73_0, iter_73_2)
			local var_73_5 = iter_73_3 < 0

			if var_73_2:IsFloor() then
				var_73_0(var_73_5, var_73_3, var_73_4, iter_73_3)
			elseif var_73_2:IsTile() then
				var_73_1(var_73_5, var_73_3, var_73_4, iter_73_3)
			end
		end
	end

	self.toUpdateTileList = {}

	return
end

function AgoraController:UnPaveFloorLayer(arg_76_1)
	self.agora:UnPlaceFloor(arg_76_1)

	return
end

function AgoraController:UnPaveTileLayer(arg_77_1)
	self.agora:UnPlaceTile(arg_77_1)

	return
end

function AgoraController:AddListeners()
	AgoraController.super.AddListeners(self)
	self:AddIslandListener(IslandAgoraAgency.AGORA_UPGRADE, self.OnAgoraUpdate)
	self:AddIslandListener(IslandSignInAgency.GIFT_CNT_UPDATE, self.OnSignInGiftCntUpdate)
	self:AddIslandListener(IslandSignInAgency.SIGN_CNT_UPDATE, self.OnSignCntUpdate)
	self:AddIslandListener(IslandAgoraAgency.ADD_THEME, self.OnThemeAdded)
	self:AddIslandListener(IslandAgoraAgency.DEL_THEME, self.OnThemeDeleted)
	self:AddIslandListener(IslandAgoraAgency.PLACEMENT_UPDATE, self.OnPlacementUpdate)
	self:AddIslandListener(IslandAgoraAgency.ADD_FURNITURE, self.OnFurnitureAdded)

	return
end

function AgoraController:RemoveListeners()
	AgoraController.super.RemoveListeners(self)
	self:RemoveIslandListener(IslandAgoraAgency.AGORA_UPGRADE, self.OnAgoraUpdate)
	self:RemoveIslandListener(IslandSignInAgency.GIFT_CNT_UPDATE, self.OnSignInGiftCntUpdate)
	self:RemoveIslandListener(IslandSignInAgency.SIGN_CNT_UPDATE, self.OnSignCntUpdate)
	self:RemoveIslandListener(IslandAgoraAgency.ADD_THEME, self.OnThemeAdded)
	self:RemoveIslandListener(IslandAgoraAgency.DEL_THEME, self.OnThemeDeleted)
	self:RemoveIslandListener(IslandAgoraAgency.PLACEMENT_UPDATE, self.OnPlacementUpdate)
	self:RemoveIslandListener(IslandAgoraAgency.ADD_FURNITURE, self.OnFurnitureAdded)

	return
end

function AgoraController:ClearNew(arg_80_1)
	local var_80_0 = self.agora:GetPlaceableItem(arg_80_1)

	if not var_80_0 then
		return
	end

	var_80_0:ClearNew()
	self:GetIsland():GetAgoraAgency():ClearNew(var_80_0.configId)

	return
end

function AgoraController:ClearAllNew()
	for iter_81_0, iter_81_1 in pairs((self.agora:GetPlaceableList())) do
		iter_81_1:ClearNew()
	end

	self:GetIsland():GetAgoraAgency():ClearAllNew()

	return
end

function AgoraController:OnFurnitureAdded(arg_82_1)
	for iter_82_0 = 1, arg_82_1.count do
		self.agora:AddPlaceable((AgoraFurniture.New({
			id = AgoraCalc.GetUniqueId(arg_82_1.id, iter_82_0),
			configId = arg_82_1.id,
			time = arg_82_1.time,
			isNew = arg_82_1.isNew
		})))
	end

	return
end

function AgoraController:OnPlacementUpdate(arg_83_1)
	self.islandSyncMgr:CancelAgoraInteract()
	self.islandSyncMgr:ClearAgoraInteractData()

	local var_83_0 = AgoraTheme.New(arg_83_1, self.agora.placeableList)
	local var_83_1, var_83_2, var_83_3 = var_83_0:GetSeparatedPlacedData()

	if var_83_2 and self.agora:GetFoundation().id ~= var_83_2.id then
		self:ReplaceFoundation(var_83_2.id)
	end

	if var_83_3 and self.agora:GetBuilding().id ~= var_83_3.id then
		self:ReplaceBuilding(var_83_3.id)
	end

	local var_83_4, var_83_5, var_83_6 = AgoraCalc.GetChangePlacementList(var_83_1, (self.agora:GetPlacedListWithoutFoundationAndBuilding()))

	for iter_83_0, iter_83_1 in ipairs(var_83_5) do
		self.agora:UnPlaceItem(iter_83_1.id)
	end

	for iter_83_2, iter_83_3 in ipairs(var_83_6) do
		self.agora:PlaceItem(iter_83_3.id, iter_83_3:GetPosition(), iter_83_3:GetRotation())
	end

	for iter_83_4, iter_83_5 in ipairs(var_83_4) do
		self.agora:UnPlaceItem(iter_83_5.id)
		self.agora:PlaceItem(iter_83_5.id, iter_83_5:GetPosition(), iter_83_5:GetRotation())
	end

	self:ClearLayers()
	self:PaveLayers(var_83_0:GetFloorData(), (var_83_0:GetTileData()))

	self.reloading = true
	self.nextReloadingEndTime = pg.TimeMgr.GetInstance():GetServerTime() + self.baseReloadingCd

	self:NotifiyAgora(ISLAND_AGORA_EVT.RELOADING)

	if (#var_83_6 > 0 or #var_83_4 > 0) and not self:IsSelfIsland() then
		self:ResetPlayerPosition()
	end

	self.islandSyncMgr:InitAgora(self.agora:GetAllVirtualInteractUnitData())

	return
end

function AgoraController:OnThemeAdded(arg_84_1)
	self.agora:AddTheme((AgoraTheme.New(arg_84_1, self.agora.placeableList)))

	return
end

function AgoraController:OnThemeDeleted(arg_85_1)
	self.agora:DeleteTheme(arg_85_1)

	return
end

function AgoraController:OnSignCntUpdate(arg_86_1)
	local var_86_0 = self:GetIsland():GetSignInAgency()

	self:NotifiyCore(ISLAND_EVT.REFRESH_INTERACTION)
	self:NotifiyAgora(ISLAND_AGORA_EVT.SIGN_IN_CNT_UPDATE, arg_86_1)

	return
end

function AgoraController:OnSignInGiftCntUpdate(arg_87_1)
	self.giftAllocator:Flush()

	return
end

function AgoraController:OnAgoraUpdate(arg_88_1, arg_88_2)
	self.agora:UpdateSize(Vector2(IslandConst.AGORA_LEVEL_2_SIZE[arg_88_1], IslandConst.AGORA_LEVEL_2_SIZE[arg_88_1]))
	self.agora:UpdateCapacity(arg_88_2)

	return
end

function AgoraController:CreateAgora(arg_89_1)
	local var_89_0 = arg_89_1:GetAgoraAgency()
	local var_89_1 = {}

	for iter_89_0, iter_89_1 in ipairs(var_89_0:GetFurnitures()) do
		for iter_89_2 = 1, iter_89_1.count do
			local var_89_2 = AgoraFurniture.New({
				id = AgoraCalc.GetUniqueId(iter_89_1.id, iter_89_2),
				configId = iter_89_1.id,
				time = iter_89_1.time,
				isNew = iter_89_1.isNew
			})

			var_89_1[var_89_2.id] = var_89_2
		end
	end

	local var_89_3 = AgoraTheme.New(var_89_0:GetPlacedData(), var_89_1)
	local var_89_4, var_89_5, var_89_6 = var_89_3:GetSeparatedPlacedData()
	local var_89_7 = {}

	for iter_89_3, iter_89_4 in ipairs(var_89_0:GetThemes()) do
		table.insert(var_89_7, (AgoraTheme.New(iter_89_4, var_89_1)))
	end

	local var_89_8 = {}

	for iter_89_5, iter_89_6 in ipairs(var_89_0:GetSystemThemes()) do
		table.insert(var_89_8, (AgoraSystemTheme.New(iter_89_6)))
	end

	local var_89_9 = IslandConst.AGORA_LEVEL_2_SIZE[math.clamp(var_89_0:GetLevel(), 1, #IslandConst.AGORA_LEVEL_2_SIZE)]

	return Agora.New({
		size = Vector2(var_89_9, var_89_9),
		placeableList = var_89_1,
		capacity = var_89_0:GetCapacity(),
		themes = var_89_7,
		systemThemes = var_89_8
	}), {
		placedlist = var_89_4,
		foundation = var_89_5,
		building = var_89_6,
		placedFloor = var_89_3:GetFloorData(),
		placedTile = var_89_3:GetTileData()
	}
end

return AgoraController
