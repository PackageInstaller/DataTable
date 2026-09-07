local Agora = class("Agora", import(".AgoraPlaceableArea"))

function Agora:Ctor(arg_1_1)
	Agora.super.Ctor(self, arg_1_1.size)

	self.placeableList = arg_1_1.placeableList
	self.themes = arg_1_1.themes
	self.systemThemes = arg_1_1.systemThemes
	self.capacity = arg_1_1.capacity
	self.maxCustomThemeCnt = pg.island_set.build_self_theme_num.key_value_int
	self.virtualInteractUnitData = {}

	return
end

function Agora:GetSystemThemes()
	return self.systemThemes
end

function Agora:GetSystemTheme(arg_3_1)
	return _.detect(self.systemThemes, function(arg_4_0)
		return arg_4_0.id == arg_3_1
	end)
end

function Agora:GetMaxCustomThemeCnt()
	return self.maxCustomThemeCnt
end

function Agora:GetThemes()
	return self.themes
end

function Agora:AddTheme(arg_7_1)
	table.insert(self.themes, arg_7_1)
	self:DispatchEvent(ISLAND_AGORA_EVT.THEME_UPDATE)

	return
end

function Agora:DeleteTheme(arg_8_1)
	local var_8_0 = _.detect(self.themes, function(arg_9_0)
		return arg_9_0.id == arg_8_1
	end)

	if var_8_0 then
		table.removebyvalue(self.themes, var_8_0)
		self:DispatchEvent(ISLAND_AGORA_EVT.THEME_UPDATE)
	end

	return
end

function Agora:GetTheme(arg_10_1)
	return _.detect(self.themes, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function Agora:GetUseableThemeId()
	local function var_12_0(arg_13_0)
		for iter_13_0, iter_13_1 in ipairs(self.themes) do
			if iter_13_1.id == arg_13_0 then
				return true
			end
		end

		return false
	end

	for iter_12_0 = 1, self.maxCustomThemeCnt do
		if not var_12_0(iter_12_0) then
			return iter_12_0
		end
	end

	return nil
end

function Agora:UpdateCapacity(arg_14_1)
	self.capacity = arg_14_1

	return
end

function Agora:GetMaxCapacity()
	return self.capacity
end

function Agora:GetCapacity()
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(self.placedlist) do
		var_16_0 = var_16_0 + iter_16_1:GetCost()
	end

	return var_16_0
end

function Agora:IsMaxCapacity()
	return self:GetCapacity() >= self:GetMaxCapacity()
end

function Agora:IsMaxCapacityWhenAdd(arg_18_1)
	return self:GetCapacity() + arg_18_1 > self:GetMaxCapacity()
end

function Agora:AddPlaceable(arg_19_1)
	if self.placeableList[arg_19_1.id] then
		return
	end

	self.placeableList[arg_19_1.id] = arg_19_1

	return
end

function Agora:AddPlaceableList(arg_20_1)
	self.placeableList[arg_20_1.id] = arg_20_1

	return
end

function Agora:GetPlaceableList()
	return self.placeableList
end

function Agora:GetPlaceableItem(arg_22_1)
	return self.placeableList[arg_22_1]
end

function Agora:PlaceItem(arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	self.placeableList[arg_23_1]:UpdatePosition(arg_23_2)
	self.placeableList[arg_23_1]:UpdateRotation(arg_23_3)
	self:AddItem(self.placeableList[arg_23_1])
	self:DispatchEvent(ISLAND_AGORA_EVT.GEN_ITEM, self.placeableList[arg_23_1], arg_23_4)
	self:AddVirtualInteractUnitData(arg_23_1, self.placeableList[arg_23_1])

	return
end

function Agora:UnPlaceItem(arg_24_1)
	self:RemoveVirtualInteractUnitData(arg_24_1, self.placeableList[arg_24_1])
	self:RemoveItem(self.placeableList[arg_24_1])
	self:DispatchEvent(ISLAND_AGORA_EVT.REMOVE_ITEM, self.placeableList[arg_24_1])

	return
end

function Agora:GetBuilding()
	for iter_25_0, iter_25_1 in pairs(self.placedlist) do
		if iter_25_1:IsBuildingType() then
			return iter_25_1
		end
	end

	return nil
end

function Agora:GetFoundation()
	for iter_26_0, iter_26_1 in pairs(self.placedlist) do
		if iter_26_1:IsFoundationType() then
			return iter_26_1
		end
	end

	return nil
end

function Agora:GetPlacedListWithoutFoundationAndBuilding()
	local var_27_0 = {}

	for iter_27_0, iter_27_1 in pairs(self.placedlist) do
		if iter_27_1:IsBuildingType() or iter_27_1:IsFoundationType() then
			-- block empty
		else
			table.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function Agora:HasTileCell(arg_28_1)
	return not self:GetTileCell(arg_28_1):IsEmpty()
end

function Agora:IsSameTile(arg_29_1, arg_29_2, arg_29_3)
	return self:GetTileCell(arg_29_3):IsSameValue(arg_29_1, arg_29_2)
end

function Agora:PlaceTile(arg_30_1, arg_30_2, arg_30_3)
	if self:IsSameTile(arg_30_1, arg_30_2, arg_30_3) then
		return
	end

	self:FillTileLayer(arg_30_1, arg_30_2, arg_30_3)
	self:DispatchEvent(ISLAND_AGORA_EVT.FILL_TILE_CELL, (self:GetTileCell(arg_30_3)))

	return
end

function Agora:UnPlaceTile(arg_31_1)
	if not self:HasTileCell(arg_31_1) then
		return
	end

	self:ClearTileLayer(arg_31_1)
	self:DispatchEvent(ISLAND_AGORA_EVT.CLEAR_TILE_CELL, arg_31_1)

	return
end

function Agora:HasFloorCell(arg_32_1)
	return not self:GetFloorCell(arg_32_1):IsEmpty()
end

function Agora:IsSameFloor(arg_33_1, arg_33_2, arg_33_3)
	return self:GetFloorCell(arg_33_3):IsSameValue(arg_33_1, arg_33_2)
end

function Agora:PlaceFloor(arg_34_1, arg_34_2, arg_34_3)
	if self:IsSameFloor(arg_34_1, arg_34_2, arg_34_3) then
		return
	end

	self:FillFloorLayer(arg_34_1, arg_34_2, arg_34_3)
	self:DispatchEvent(ISLAND_AGORA_EVT.FILL_FLOOR_CELL, (self:GetFloorCell(arg_34_3)))

	return
end

function Agora:UnPlaceFloor(arg_35_1)
	if not self:HasFloorCell(arg_35_1) then
		return
	end

	self:ClearFloorLayer(arg_35_1)
	self:DispatchEvent(ISLAND_AGORA_EVT.CLEAR_FLOOR_CELL, arg_35_1)

	return
end

function Agora:AddVirtualInteractUnitData(arg_36_1, arg_36_2)
	if arg_36_2:CanInteraction() then
		for iter_36_0, iter_36_1 in ipairs(arg_36_2:GetInteractionPoints()) do
			local var_36_0 = AgoraCalc.GetVirtualInteractUnitId(arg_36_1, iter_36_0)
			local var_36_1 = pg.island_interact_point[iter_36_1]
			local var_36_2 = arg_36_2:GetRotation()
			local var_36_3 = AgoraCalc.GetAreaCenterPos(arg_36_2:GetArea()) + Vector3(unpack(pg.island_interact_point[iter_36_1].offset)) * Quaternion.Euler(0, var_36_2.y, 0) + IslandConst.AGORA_POSITION_OFFSET
			local var_36_4 = IslandDataConvertor.GenInteractUnitByAgoraFurniture({
				id = var_36_0,
				pointId = iter_36_1,
				position = {
					var_36_3.x,
					var_36_3.y,
					var_36_3.z
				},
				rotation = {
					var_36_2.x,
					var_36_2.y,
					var_36_2.z
				}
			})

			self.virtualInteractUnitData[var_36_0] = var_36_4

			arg_36_2:AddListener(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, function(arg_37_0, arg_37_1)
				self:DispatchEvent(ISLAND_EVT.RESET_UNIT_POS, var_36_4.id, IslandConst.UNIT_LIST_OBJ, AgoraCalc.GetAreaCenterPos(arg_37_1) + Vector3(unpack(var_36_1.offset)) * Quaternion.Euler(0, arg_36_2:GetRotation().y, 0) + IslandConst.AGORA_POSITION_OFFSET)

				return
			end)
			arg_36_2:AddListener(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, function(arg_38_0, arg_38_1)
				self:DispatchEvent(ISLAND_EVT.RESET_UNIT_ROT, var_36_4.id, IslandConst.UNIT_LIST_OBJ, arg_38_1)

				return
			end)
			self:DispatchEvent(ISLAND_EVT.GEN_UNIT, var_36_4)
		end
	end

	return
end

function Agora:RemoveVirtualInteractUnitData(arg_39_1, arg_39_2)
	if arg_39_2:CanInteraction() then
		for iter_39_0, iter_39_1 in ipairs(arg_39_2:GetInteractionPoints()) do
			local var_39_0 = AgoraCalc.GetVirtualInteractUnitId(arg_39_1, iter_39_0)

			self.virtualInteractUnitData[var_39_0] = nil

			self:DispatchEvent(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, var_39_0)
		end
	end

	return
end

function Agora:GetVirtualInteractUnitData(arg_40_1)
	return self.virtualInteractUnitData[arg_40_1]
end

function Agora:GetAllVirtualInteractUnitData()
	return self.virtualInteractUnitData
end

function Agora:GetPlacedInfoList()
	local var_42_0 = {}

	for iter_42_0, iter_42_1 in pairs(self.placedlist) do
		table.insert(var_42_0, {
			count = 1,
			icon = iter_42_1:GetIcon(),
			name = iter_42_1:GetName(),
			capacity = iter_42_1:GetCost()
		})
	end

	return var_42_0
end

function Agora:IsBuilding(arg_43_1)
	return self:GetPlaceableItem(arg_43_1):IsBuildingType()
end

function Agora:IsFoundation(arg_44_1)
	return self:GetPlaceableItem(arg_44_1):IsFoundationType()
end

return Agora
