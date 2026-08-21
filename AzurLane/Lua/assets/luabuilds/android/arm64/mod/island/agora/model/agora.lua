local var_0_0 = class("Agora", import(".AgoraPlaceableArea"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1.size)

	arg_1_0.placeableList = arg_1_1.placeableList
	arg_1_0.themes = arg_1_1.themes
	arg_1_0.systemThemes = arg_1_1.systemThemes
	arg_1_0.capacity = arg_1_1.capacity
	arg_1_0.maxCustomThemeCnt = pg.island_set.build_self_theme_num.key_value_int
	arg_1_0.virtualInteractUnitData = {}

	return
end

function var_0_0.GetSystemThemes(arg_2_0)
	return arg_2_0.systemThemes
end

function var_0_0.GetSystemTheme(arg_3_0, arg_3_1)
	return _.detect(arg_3_0.systemThemes, function(arg_4_0)
		return arg_4_0.id == arg_3_1
	end)
end

function var_0_0.GetMaxCustomThemeCnt(arg_5_0)
	return arg_5_0.maxCustomThemeCnt
end

function var_0_0.GetThemes(arg_6_0)
	return arg_6_0.themes
end

function var_0_0.AddTheme(arg_7_0, arg_7_1)
	table.insert(arg_7_0.themes, arg_7_1)
	arg_7_0:DispatchEvent(ISLAND_AGORA_EVT.THEME_UPDATE)

	return
end

function var_0_0.DeleteTheme(arg_8_0, arg_8_1)
	local var_8_0 = _.detect(arg_8_0.themes, function(arg_9_0)
		return arg_9_0.id == arg_8_1
	end)

	if var_8_0 then
		table.removebyvalue(arg_8_0.themes, var_8_0)
		arg_8_0:DispatchEvent(ISLAND_AGORA_EVT.THEME_UPDATE)
	end

	return
end

function var_0_0.GetTheme(arg_10_0, arg_10_1)
	return _.detect(arg_10_0.themes, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function var_0_0.GetUseableThemeId(arg_12_0)
	for iter_12_0 = 1, arg_12_0.maxCustomThemeCnt do
		if not (function(arg_13_0)
			for iter_13_0, iter_13_1 in ipairs(arg_12_0.themes) do
				if iter_13_1.id == arg_13_0 then
					return true
				end
			end

			return false
		end)(iter_12_0) then
			return iter_12_0
		end
	end

	return nil
end

function var_0_0.UpdateCapacity(arg_14_0, arg_14_1)
	arg_14_0.capacity = arg_14_1

	return
end

function var_0_0.GetMaxCapacity(arg_15_0)
	return arg_15_0.capacity
end

function var_0_0.GetCapacity(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0.placedlist) do
		var_16_0 = var_16_0 + iter_16_1:GetCost()
	end

	return var_16_0
end

function var_0_0.IsMaxCapacity(arg_17_0)
	return arg_17_0:GetCapacity() >= arg_17_0:GetMaxCapacity()
end

function var_0_0.IsMaxCapacityWhenAdd(arg_18_0, arg_18_1)
	return arg_18_0:GetCapacity() + arg_18_1 > arg_18_0:GetMaxCapacity()
end

function var_0_0.AddPlaceable(arg_19_0, arg_19_1)
	if arg_19_0.placeableList[arg_19_1.id] then
		return
	end

	arg_19_0.placeableList[arg_19_1.id] = arg_19_1

	return
end

function var_0_0.AddPlaceableList(arg_20_0, arg_20_1)
	arg_20_0.placeableList[arg_20_1.id] = arg_20_1

	return
end

function var_0_0.GetPlaceableList(arg_21_0)
	return arg_21_0.placeableList
end

function var_0_0.GetPlaceableItem(arg_22_0, arg_22_1)
	return arg_22_0.placeableList[arg_22_1]
end

function var_0_0.PlaceItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	arg_23_0.placeableList[arg_23_1]:UpdatePosition(arg_23_2)
	arg_23_0.placeableList[arg_23_1]:UpdateRotation(arg_23_3)
	arg_23_0:AddItem(arg_23_0.placeableList[arg_23_1])
	arg_23_0:DispatchEvent(ISLAND_AGORA_EVT.GEN_ITEM, arg_23_0.placeableList[arg_23_1], arg_23_4)
	arg_23_0:AddVirtualInteractUnitData(arg_23_1, arg_23_0.placeableList[arg_23_1])

	return
end

function var_0_0.UnPlaceItem(arg_24_0, arg_24_1)
	arg_24_0:RemoveVirtualInteractUnitData(arg_24_1, arg_24_0.placeableList[arg_24_1])
	arg_24_0:RemoveItem(arg_24_0.placeableList[arg_24_1])
	arg_24_0:DispatchEvent(ISLAND_AGORA_EVT.REMOVE_ITEM, arg_24_0.placeableList[arg_24_1])

	return
end

function var_0_0.GetBuilding(arg_25_0)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.placedlist) do
		if iter_25_1:IsBuildingType() then
			return iter_25_1
		end
	end

	return nil
end

function var_0_0.GetFoundation(arg_26_0)
	for iter_26_0, iter_26_1 in pairs(arg_26_0.placedlist) do
		if iter_26_1:IsFoundationType() then
			return iter_26_1
		end
	end

	return nil
end

function var_0_0.GetPlacedListWithoutFoundationAndBuilding(arg_27_0)
	for iter_27_0, iter_27_1 in pairs(arg_27_0.placedlist) do
		if iter_27_1:IsBuildingType() or iter_27_1:IsFoundationType() then
			-- block empty
		else
			table.insert({}, iter_27_1)
		end
	end

	return {}
end

function var_0_0.HasTileCell(arg_28_0, arg_28_1)
	return not arg_28_0:GetTileCell(arg_28_1):IsEmpty()
end

function var_0_0.IsSameTile(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	return arg_29_0:GetTileCell(arg_29_3):IsSameValue(arg_29_1, arg_29_2)
end

function var_0_0.PlaceTile(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0:IsSameTile(arg_30_1, arg_30_2, arg_30_3) then
		return
	end

	arg_30_0:FillTileLayer(arg_30_1, arg_30_2, arg_30_3)
	arg_30_0:DispatchEvent(ISLAND_AGORA_EVT.FILL_TILE_CELL, (arg_30_0:GetTileCell(arg_30_3)))

	return
end

function var_0_0.UnPlaceTile(arg_31_0, arg_31_1)
	if not arg_31_0:HasTileCell(arg_31_1) then
		return
	end

	arg_31_0:ClearTileLayer(arg_31_1)
	arg_31_0:DispatchEvent(ISLAND_AGORA_EVT.CLEAR_TILE_CELL, arg_31_1)

	return
end

function var_0_0.HasFloorCell(arg_32_0, arg_32_1)
	return not arg_32_0:GetFloorCell(arg_32_1):IsEmpty()
end

function var_0_0.IsSameFloor(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	return arg_33_0:GetFloorCell(arg_33_3):IsSameValue(arg_33_1, arg_33_2)
end

function var_0_0.PlaceFloor(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_0:IsSameFloor(arg_34_1, arg_34_2, arg_34_3) then
		return
	end

	arg_34_0:FillFloorLayer(arg_34_1, arg_34_2, arg_34_3)
	arg_34_0:DispatchEvent(ISLAND_AGORA_EVT.FILL_FLOOR_CELL, (arg_34_0:GetFloorCell(arg_34_3)))

	return
end

function var_0_0.UnPlaceFloor(arg_35_0, arg_35_1)
	if not arg_35_0:HasFloorCell(arg_35_1) then
		return
	end

	arg_35_0:ClearFloorLayer(arg_35_1)
	arg_35_0:DispatchEvent(ISLAND_AGORA_EVT.CLEAR_FLOOR_CELL, arg_35_1)

	return
end

function var_0_0.AddVirtualInteractUnitData(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_2:CanInteraction() then
		for iter_36_0, iter_36_1 in ipairs(arg_36_2:GetInteractionPoints()) do
			local var_36_0 = AgoraCalc.GetVirtualInteractUnitId(arg_36_1, iter_36_0)
			local var_36_1 = arg_36_2:GetRotation()
			local var_36_2 = AgoraCalc.GetAreaCenterPos(arg_36_2:GetArea()) + Vector3(unpack(pg.island_interact_point[iter_36_1].offset)) * Quaternion.Euler(0, var_36_1.y, 0) + IslandConst.AGORA_POSITION_OFFSET
			local var_36_3 = IslandDataConvertor.GenInteractUnitByAgoraFurniture({
				id = var_36_0,
				pointId = iter_36_1,
				position = {
					var_36_2.x,
					var_36_2.y,
					var_36_2.z
				},
				rotation = {
					var_36_1.x,
					var_36_1.y,
					var_36_1.z
				}
			})

			arg_36_0.virtualInteractUnitData[var_36_0] = var_36_3

			arg_36_2:AddListener(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, function(arg_37_0, arg_37_1)
				arg_36_0:DispatchEvent(ISLAND_EVT.RESET_UNIT_POS, var_36_3.id, IslandConst.UNIT_LIST_OBJ, AgoraCalc.GetAreaCenterPos(arg_37_1) + Vector3(unpack(var_0.offset)) * Quaternion.Euler(0, arg_36_2:GetRotation().y, 0) + IslandConst.AGORA_POSITION_OFFSET)

				return
			end)
			arg_36_2:AddListener(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, function(arg_38_0, arg_38_1)
				arg_36_0:DispatchEvent(ISLAND_EVT.RESET_UNIT_ROT, var_36_3.id, IslandConst.UNIT_LIST_OBJ, arg_38_1)

				return
			end)
			arg_36_0:DispatchEvent(ISLAND_EVT.GEN_UNIT, var_36_3)
		end
	end

	return
end

function var_0_0.RemoveVirtualInteractUnitData(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_2:CanInteraction() then
		for iter_39_0, iter_39_1 in ipairs(arg_39_2:GetInteractionPoints()) do
			local var_39_0 = AgoraCalc.GetVirtualInteractUnitId(arg_39_1, iter_39_0)

			arg_39_0.virtualInteractUnitData[var_39_0] = nil

			arg_39_0:DispatchEvent(ISLAND_EVT.RMOVE_UNIT, IslandConst.UNIT_LIST_OBJ, var_39_0)
		end
	end

	return
end

function var_0_0.GetVirtualInteractUnitData(arg_40_0, arg_40_1)
	return arg_40_0.virtualInteractUnitData[arg_40_1]
end

function var_0_0.GetAllVirtualInteractUnitData(arg_41_0)
	return arg_41_0.virtualInteractUnitData
end

function var_0_0.GetPlacedInfoList(arg_42_0)
	for iter_42_0, iter_42_1 in pairs(arg_42_0.placedlist) do
		table.insert({}, {
			count = 1,
			icon = iter_42_1:GetIcon(),
			name = iter_42_1:GetName(),
			capacity = iter_42_1:GetCost()
		})
	end

	return {}
end

function var_0_0.IsBuilding(arg_43_0, arg_43_1)
	return arg_43_0:GetPlaceableItem(arg_43_1):IsBuildingType()
end

function var_0_0.IsFoundation(arg_44_0, arg_44_1)
	return arg_44_0:GetPlaceableItem(arg_44_1):IsFoundationType()
end

return var_0_0
