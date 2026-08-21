local var_0_0 = class("AgoraFurniture", import(".AgoraPlaceableItem"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.configId
	arg_1_0.time = arg_1_1.time or arg_1_0.configId
	arg_1_0.isNew = defaultValue(arg_1_1.isNew, false)
	arg_1_0.config = pg.island_furniture_template[arg_1_0.configId]

	assert(arg_1_0.config, arg_1_0.configId)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, Vector2(arg_1_0.config.size[1], arg_1_0.config.size[2]))

	return
end

function var_0_0.IsNew(arg_2_0)
	return arg_2_0.isNew
end

function var_0_0.ClearNew(arg_3_0)
	arg_3_0.isNew = false

	return
end

function var_0_0.GetMapType(arg_4_0)
	if arg_4_0:IsNewTileType() then
		return IslandConst.AGORA_MAP_TYPE_NEWTILE
	elseif arg_4_0:IsBuildingType() then
		return IslandConst.AGORA_MAP_TYPE_BUILDING
	else
		return IslandConst.AGORA_MAP_TYPE_COMMON
	end

	return
end

function var_0_0.CanInteraction(arg_5_0)
	return arg_5_0.config.interact_point ~= "" and #arg_5_0.config.interact_point > 0
end

function var_0_0.GetInteractionPoints(arg_6_0)
	if not arg_6_0:CanInteraction() then
		return {}
	end

	return arg_6_0.config.interact_point
end

function var_0_0.Read(arg_7_0)
	return false
end

function var_0_0.HasBt(arg_8_0)
	return arg_8_0.config.bt ~= nil and arg_8_0.config.bt ~= ""
end

function var_0_0.GetBt(arg_9_0)
	return arg_9_0.config.bt
end

function var_0_0.GetResPath(arg_10_0)
	return arg_10_0.config.model
end

function var_0_0.GetTimeline(arg_11_0)
	return arg_11_0.timelineInfo
end

function var_0_0.HasTimeline(arg_12_0)
	return #arg_12_0.timelineInfo > 0
end

function var_0_0.GetName(arg_13_0)
	return arg_13_0.config.name
end

function var_0_0.GetCost(arg_14_0)
	return arg_14_0.config.capacityCost
end

function var_0_0.GetRarity(arg_15_0)
	return arg_15_0.config.rarity
end

function var_0_0.GetIcon(arg_16_0)
	return arg_16_0.config.icon
end

function var_0_0.GetType(arg_17_0)
	return arg_17_0.config.type
end

function var_0_0.GetTime(arg_18_0)
	return arg_18_0.time
end

function var_0_0.GetDesc(arg_19_0)
	return arg_19_0.config.describe or ""
end

function var_0_0.IsOptionalShapeType(arg_20_0)
	return arg_20_0:GetType() == AgoraFurnitureType.FLOOR or arg_20_0:GetType() == AgoraFurnitureType.TILE
end

function var_0_0.IsFoundationType(arg_21_0)
	return arg_21_0:GetType() == AgoraFurnitureType.FOUNDATION
end

function var_0_0.IsBuildingType(arg_22_0)
	return arg_22_0:GetType() == AgoraFurnitureType.BUILDING
end

function var_0_0.IsNewTileType(arg_23_0)
	return arg_23_0:GetType() == AgoraFurnitureType.TILE_NEW
end

function var_0_0.CanSelect(arg_24_0)
	return true
end

function var_0_0.CanOp(arg_25_0)
	if arg_25_0:IsFoundationType() or arg_25_0:IsBuildingType() then
		return false
	end

	return true
end

function var_0_0.IsFloor(arg_26_0)
	return arg_26_0:GetType() == AgoraFurnitureType.FLOOR
end

function var_0_0.IsTile(arg_27_0)
	return arg_27_0:GetType() == AgoraFurnitureType.TILE
end

function var_0_0.Match(arg_28_0, arg_28_1)
	if arg_28_1 == "" or not arg_28_1 then
		do return true end

		arg_28_1 = string.lower(arg_28_1)
	end

	if string.find(string.lower((arg_28_0:GetName())), arg_28_1) then
		return true
	end

	return false
end

function var_0_0.ToPlacementData(arg_29_0)
	local var_29_0 = var_0_0.super.ToPlacementData(arg_29_0)

	var_29_0.configId = arg_29_0.configId

	return var_29_0
end

return var_0_0
