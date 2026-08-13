class = var_0_10000

local var_0_0 = "Agora"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".AgoraPlaceableArea"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1.size)

	arg_1_0.placeableList = arg_1_1.placeableList
	arg_1_0.themes = arg_1_1.themes
	arg_1_0.systemThemes = arg_1_1.systemThemes
	arg_1_0.capacity = arg_1_1.capacity
	pg = var_2
	arg_1_0.maxCustomThemeCnt = var_2.island_set.build_self_theme_num.key_value_int
	arg_1_0.virtualInteractUnitData = {}

	return
end

function var_0_1.GetSystemThemes(arg_2_0)
	return arg_2_0.systemThemes
end

function var_0_1.GetSystemTheme(arg_3_0, arg_3_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_3_0.systemThemes, function(arg_4_0)
		return arg_4_0.id == arg_3_1
	end)
end

function var_0_1.GetMaxCustomThemeCnt(arg_5_0)
	return arg_5_0.maxCustomThemeCnt
end

function var_0_1.GetThemes(arg_6_0)
	return arg_6_0.themes
end

function var_0_1.AddTheme(arg_7_0, arg_7_1)
	table = var_1_10002

	var_1_10002.insert(arg_7_0.themes, arg_7_1)

	local var_7_0 = arg_7_0
	local var_7_1 = arg_7_0.DispatchEvent

	ISLAND_AGORA_EVT = var_4

	var_7_1(var_7_0, var_4.THEME_UPDATE)

	return
end

function var_0_1.DeleteTheme(arg_8_0, arg_8_1)
	_ = var_1_10002

	if var_1_10002.detect(arg_8_0.themes, function(arg_9_0)
		return arg_9_0.id == arg_8_1
	end) then
		table = var_3

		var_3.removebyvalue(arg_8_0.themes, var_2)

		local var_8_0 = arg_8_0
		local var_8_1 = arg_8_0.DispatchEvent

		ISLAND_AGORA_EVT = var_5

		var_8_1(var_8_0, var_5.THEME_UPDATE)
	end

	return
end

function var_0_1.GetTheme(arg_10_0, arg_10_1)
	_ = var_1_10002

	return var_1_10002.detect(arg_10_0.themes, function(arg_11_0)
		return arg_11_0.id == arg_10_1
	end)
end

function var_0_1.GetUseableThemeId(arg_12_0)
	local function var_12_0(arg_13_0)
		ipairs = var_2_10001

		for iter_13_0, iter_13_1 in var_2_10001(arg_12_0.themes) do
			if iter_13_1.id == arg_13_0 then
				return true
			end
		end

		return false
	end

	for iter_12_0 = 1, arg_12_0.maxCustomThemeCnt do
		if not var_12_0(iter_12_0) then
			return iter_12_0
		end
	end

	return nil
end

function var_0_1.UpdateCapacity(arg_14_0, arg_14_1)
	arg_14_0.capacity = arg_14_1

	return
end

function var_0_1.GetMaxCapacity(arg_15_0)
	return arg_15_0.capacity
end

function var_0_1.GetCapacity(arg_16_0)
	local var_16_0 = 0

	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.placedlist) do
		var_16_0 = var_16_0 + iter_16_1:GetCost()
	end

	return var_16_0
end

function var_0_1.IsMaxCapacity(arg_17_0)
	return arg_17_0:GetCapacity() >= arg_17_0:GetMaxCapacity()
end

function var_0_1.IsMaxCapacityWhenAdd(arg_18_0, arg_18_1)
	return arg_18_0:GetCapacity() + arg_18_1 > arg_18_0:GetMaxCapacity()
end

function var_0_1.AddPlaceable(arg_19_0, arg_19_1)
	if arg_19_0.placeableList[arg_19_1.id] then
		return
	end

	arg_19_0.placeableList[arg_19_1.id] = arg_19_1

	return
end

function var_0_1.AddPlaceableList(arg_20_0, arg_20_1)
	arg_20_0.placeableList[arg_20_1.id] = arg_20_1

	return
end

function var_0_1.GetPlaceableList(arg_21_0)
	return arg_21_0.placeableList
end

function var_0_1.GetPlaceableItem(arg_22_0, arg_22_1)
	return arg_22_0.placeableList[arg_22_1]
end

function var_0_1.PlaceItem(arg_23_0, arg_23_1, arg_23_2, arg_23_3, arg_23_4)
	local var_23_0 = arg_23_0.placeableList[arg_23_1]

	var_5.UpdatePosition(var_23_0, arg_23_2)
	var_5:UpdateRotation(arg_23_3)
	arg_23_0:AddItem(var_5)

	local var_23_1 = arg_23_0
	local var_23_2 = arg_23_0.DispatchEvent

	ISLAND_AGORA_EVT = var_8

	var_23_2(var_23_1, var_8.GEN_ITEM, var_5, arg_23_4)
	arg_23_0:AddVirtualInteractUnitData(arg_23_1, var_5)

	return
end

function var_0_1.UnPlaceItem(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0.placeableList[arg_24_1]

	arg_24_0:RemoveVirtualInteractUnitData(arg_24_1, var_24_0)
	arg_24_0:RemoveItem(var_24_0)

	local var_24_1 = arg_24_0
	local var_24_2 = arg_24_0.DispatchEvent

	ISLAND_AGORA_EVT = var_5

	var_24_2(var_24_1, var_5.REMOVE_ITEM, var_24_0)

	return
end

function var_0_1.GetBuilding(arg_25_0)
	pairs = var_1_10001

	for iter_25_0, iter_25_1 in var_1_10001(arg_25_0.placedlist) do
		if iter_25_1:IsBuildingType() then
			return iter_25_1
		end
	end

	return nil
end

function var_0_1.GetFoundation(arg_26_0)
	pairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0.placedlist) do
		if iter_26_1:IsFoundationType() then
			return iter_26_1
		end
	end

	return nil
end

function var_0_1.GetPlacedListWithoutFoundationAndBuilding(arg_27_0)
	local var_27_0 = {}

	pairs = var_1_10002

	for iter_27_0, iter_27_1 in var_1_10002(arg_27_0.placedlist) do
		if iter_27_1:IsBuildingType() or iter_27_1:IsFoundationType() then
			-- block empty
		else
			table = var_7

			var_7.insert(var_27_0, iter_27_1)
		end
	end

	return var_27_0
end

function var_0_1.HasTileCell(arg_28_0, arg_28_1)
	local var_28_0 = arg_28_0:GetTileCell(arg_28_1)

	return not var_2.IsEmpty(var_28_0)
end

function var_0_1.IsSameTile(arg_29_0, arg_29_1, arg_29_2, arg_29_3)
	local var_29_0 = arg_29_0:GetTileCell(arg_29_3)

	return var_4.IsSameValue(var_29_0, arg_29_1, arg_29_2)
end

function var_0_1.PlaceTile(arg_30_0, arg_30_1, arg_30_2, arg_30_3)
	if arg_30_0:IsSameTile(arg_30_1, arg_30_2, arg_30_3) then
		return
	end

	arg_30_0:FillTileLayer(arg_30_1, arg_30_2, arg_30_3)

	local var_30_0 = arg_30_0:GetTileCell(arg_30_3)
	local var_30_1 = arg_30_0
	local var_30_2 = arg_30_0.DispatchEvent

	ISLAND_AGORA_EVT = var_7

	var_30_2(var_30_1, var_7.FILL_TILE_CELL, var_30_0)

	return
end

function var_0_1.UnPlaceTile(arg_31_0, arg_31_1)
	if not arg_31_0:HasTileCell(arg_31_1) then
		return
	end

	arg_31_0:ClearTileLayer(arg_31_1)

	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.DispatchEvent

	ISLAND_AGORA_EVT = var_4

	var_31_1(var_31_0, var_4.CLEAR_TILE_CELL, arg_31_1)

	return
end

function var_0_1.HasFloorCell(arg_32_0, arg_32_1)
	local var_32_0 = arg_32_0:GetFloorCell(arg_32_1)

	return not var_2.IsEmpty(var_32_0)
end

function var_0_1.IsSameFloor(arg_33_0, arg_33_1, arg_33_2, arg_33_3)
	local var_33_0 = arg_33_0:GetFloorCell(arg_33_3)

	return var_4.IsSameValue(var_33_0, arg_33_1, arg_33_2)
end

function var_0_1.PlaceFloor(arg_34_0, arg_34_1, arg_34_2, arg_34_3)
	if arg_34_0:IsSameFloor(arg_34_1, arg_34_2, arg_34_3) then
		return
	end

	arg_34_0:FillFloorLayer(arg_34_1, arg_34_2, arg_34_3)

	local var_34_0 = arg_34_0:GetFloorCell(arg_34_3)
	local var_34_1 = arg_34_0
	local var_34_2 = arg_34_0.DispatchEvent

	ISLAND_AGORA_EVT = var_7

	var_34_2(var_34_1, var_7.FILL_FLOOR_CELL, var_34_0)

	return
end

function var_0_1.UnPlaceFloor(arg_35_0, arg_35_1)
	if not arg_35_0:HasFloorCell(arg_35_1) then
		return
	end

	arg_35_0:ClearFloorLayer(arg_35_1)

	local var_35_0 = arg_35_0
	local var_35_1 = arg_35_0.DispatchEvent

	ISLAND_AGORA_EVT = var_4

	var_35_1(var_35_0, var_4.CLEAR_FLOOR_CELL, arg_35_1)

	return
end

function var_0_1.AddVirtualInteractUnitData(arg_36_0, arg_36_1, arg_36_2)
	if arg_36_2:CanInteraction() then
		ipairs = var_3

		for iter_36_0, iter_36_1 in var_3(arg_36_2:GetInteractionPoints()) do
			AgoraCalc = var_1_10008
			var_1_10008 = var_1_10008.GetVirtualInteractUnitId(arg_36_1, iter_36_0)
			pg = var_9

			local var_36_0 = var_9.island_interact_point[iter_36_1]
			local var_36_1 = arg_36_2
			local var_36_2 = arg_36_2.GetRotation(var_36_1)

			AgoraCalc = var_36_1

			local var_36_3 = var_36_1.GetAreaCenterPos
			local var_36_4 = arg_36_2
			local var_36_5 = var_36_3(arg_36_2.GetArea(var_36_4))

			Vector3 = var_12
			unpack = var_36_4

			local var_36_6 = var_12(var_36_4(var_36_0.offset))

			Quaternion = var_13

			local var_36_7 = var_36_5 + var_36_6 * var_13.Euler(0, var_36_2.y, 0)

			IslandConst = var_12

			local var_36_8 = var_36_7 + var_12.AGORA_POSITION_OFFSET

			IslandDataConvertor = var_12

			local var_36_9 = var_12.GenInteractUnitByAgoraFurniture({
				id = var_1_10008,
				pointId = iter_36_1,
				position = {
					var_36_8.x,
					var_36_8.y,
					var_36_8.z
				},
				rotation = {
					var_36_2.x,
					var_36_2.y,
					var_36_2.z
				}
			})

			arg_36_0.virtualInteractUnitData[var_1_10008] = var_36_9

			local var_36_10 = arg_36_2
			local var_36_11 = arg_36_2.AddListener

			ISLAND_AGORA_EVT = var_15

			var_36_11(var_36_10, var_15.ITEM_POSITION_UPDATE, function(arg_37_0, arg_37_1)
				AgoraCalc = var_2_10002

				local var_37_0 = var_2_10002.GetAreaCenterPos(arg_37_1)

				Vector3 = var_3
				unpack = var_2_10004

				local var_37_1 = var_3(var_2_10004(var_36_0.offset))

				Quaternion = var_4

				local var_37_2 = var_4.Euler
				local var_37_3 = 0
				local var_37_4 = arg_36_2
				local var_37_5 = var_37_1 * var_37_2(var_37_3, var_6.GetRotation(var_37_4).y, 0)
				local var_37_6 = arg_36_0
				local var_37_7 = var_4.DispatchEvent

				ISLAND_EVT = var_6

				local var_37_8 = var_6.RESET_UNIT_POS
				local var_37_9 = var_36_9.id

				IslandConst = var_2_10008

				local var_37_10 = var_2_10008.UNIT_LIST_OBJ
				local var_37_11 = var_37_0 + var_37_5

				IslandConst = var_2_10010

				var_37_7(var_37_6, var_37_8, var_37_9, var_37_10, var_37_11 + var_2_10010.AGORA_POSITION_OFFSET)

				return
			end)

			local var_36_12 = arg_36_2
			local var_36_13 = arg_36_2.AddListener

			ISLAND_AGORA_EVT = var_15

			var_36_13(var_36_12, var_15.ITEM_DIR_UPDATE, function(arg_38_0, arg_38_1)
				local var_38_0 = arg_36_0
				local var_38_1 = var_2.DispatchEvent

				ISLAND_EVT = var_2_10004

				local var_38_2 = var_2_10004.RESET_UNIT_ROT
				local var_38_3 = var_36_9.id

				IslandConst = var_2_10006

				var_38_1(var_38_0, var_38_2, var_38_3, var_2_10006.UNIT_LIST_OBJ, arg_38_1)

				return
			end)

			local var_36_14 = arg_36_0
			local var_36_15 = arg_36_0.DispatchEvent

			ISLAND_EVT = var_15

			var_36_15(var_36_14, var_15.GEN_UNIT, var_36_9)
		end
	end

	return
end

function var_0_1.RemoveVirtualInteractUnitData(arg_39_0, arg_39_1, arg_39_2)
	if arg_39_2:CanInteraction() then
		ipairs = var_3

		for iter_39_0, iter_39_1 in var_3(arg_39_2:GetInteractionPoints()) do
			AgoraCalc = var_1_10008
			var_1_10008 = var_1_10008.GetVirtualInteractUnitId(arg_39_1, iter_39_0)
			arg_39_0.virtualInteractUnitData[var_1_10008] = nil

			local var_39_0 = arg_39_0
			local var_39_1 = arg_39_0.DispatchEvent

			ISLAND_EVT = var_1_10011
			var_1_10011 = var_1_10011.RMOVE_UNIT
			IslandConst = var_1_10012

			var_39_1(var_39_0, var_1_10011, var_1_10012.UNIT_LIST_OBJ, var_1_10008)
		end
	end

	return
end

function var_0_1.GetVirtualInteractUnitData(arg_40_0, arg_40_1)
	return arg_40_0.virtualInteractUnitData[arg_40_1]
end

function var_0_1.GetAllVirtualInteractUnitData(arg_41_0)
	return arg_41_0.virtualInteractUnitData
end

function var_0_1.GetPlacedInfoList(arg_42_0)
	local var_42_0 = {}

	pairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.placedlist) do
		table = var_1_10007

		var_1_10007.insert(var_42_0, {
			count = 1,
			icon = iter_42_1:GetIcon(),
			name = iter_42_1:GetName(),
			capacity = iter_42_1:GetCost()
		})
	end

	return var_42_0
end

function var_0_1.IsBuilding(arg_43_0, arg_43_1)
	local var_43_0 = arg_43_0:GetPlaceableItem(arg_43_1)

	return var_2.IsBuildingType(var_43_0)
end

function var_0_1.IsFoundation(arg_44_0, arg_44_1)
	local var_44_0 = arg_44_0:GetPlaceableItem(arg_44_1)

	return var_2.IsFoundationType(var_44_0)
end

return var_0_1
