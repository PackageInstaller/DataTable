class = var_0_10000

local var_0_0 = "AgoraFurniture"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".AgoraPlaceableItem"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.configId

	local var_1_0

	if not arg_1_1.time then
		var_1_0 = arg_1_0.configId
	end

	arg_1_0.time = var_1_0
	defaultValue = var_1_0
	arg_1_0.isNew = var_1_0(arg_1_1.isNew, false)
	pg = var_2
	arg_1_0.config = var_2.island_furniture_template[arg_1_0.configId]
	assert = var_2

	var_2(arg_1_0.config, arg_1_0.configId)

	local var_1_1 = var_0_1.super.Ctor
	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_1

	Vector2 = var_1_10006

	var_1_1(var_1_2, var_1_3, var_1_10006(arg_1_0.config.size[1], arg_1_0.config.size[2]))

	return
end

function var_0_1.IsNew(arg_2_0)
	return arg_2_0.isNew
end

function var_0_1.ClearNew(arg_3_0)
	arg_3_0.isNew = false

	return
end

function var_0_1.GetMapType(arg_4_0)
	if arg_4_0:IsNewTileType() then
		IslandConst = var_1

		return var_1.AGORA_MAP_TYPE_NEWTILE
	elseif arg_4_0:IsBuildingType() then
		IslandConst = var_1

		return var_1.AGORA_MAP_TYPE_BUILDING
	else
		IslandConst = var_1

		return var_1.AGORA_MAP_TYPE_COMMON
	end

	return
end

function var_0_1.CanInteraction(arg_5_0)
	return arg_5_0.config.interact_point ~= "" and #arg_5_0.config.interact_point > 0
end

function var_0_1.GetInteractionPoints(arg_6_0)
	if not arg_6_0:CanInteraction() then
		return {}
	end

	return arg_6_0.config.interact_point
end

function var_0_1.Read(arg_7_0)
	return false
end

function var_0_1.HasBt(arg_8_0)
	return arg_8_0.config.bt ~= nil and arg_8_0.config.bt ~= ""
end

function var_0_1.GetBt(arg_9_0)
	return arg_9_0.config.bt
end

function var_0_1.GetResPath(arg_10_0)
	return arg_10_0.config.model
end

function var_0_1.GetTimeline(arg_11_0)
	return arg_11_0.timelineInfo
end

function var_0_1.HasTimeline(arg_12_0)
	return #arg_12_0.timelineInfo > 0
end

function var_0_1.GetName(arg_13_0)
	return arg_13_0.config.name
end

function var_0_1.GetCost(arg_14_0)
	return arg_14_0.config.capacityCost
end

function var_0_1.GetRarity(arg_15_0)
	return arg_15_0.config.rarity
end

function var_0_1.GetIcon(arg_16_0)
	return arg_16_0.config.icon
end

function var_0_1.GetType(arg_17_0)
	return arg_17_0.config.type
end

function var_0_1.GetTime(arg_18_0)
	return arg_18_0.time
end

function var_0_1.GetDesc(arg_19_0)
	local var_19_0

	if not arg_19_0.config.describe then
		var_19_0 = ""
	end

	return var_19_0
end

function var_0_1.IsOptionalShapeType(arg_20_0)
	local var_20_0 = arg_20_0:GetType()

	AgoraFurnitureType = var_1_10002

	local var_20_2

	if var_20_0 ~= var_1_10002.FLOOR then
		local var_20_1 = arg_20_0:GetType()

		AgoraFurnitureType = var_2

		if var_20_1 ~= var_2.TILE then
			var_20_2 = false

			goto label_20_0
		end
	end

	var_20_2 = true

	::label_20_0::

	return var_20_2
end

function var_0_1.IsFoundationType(arg_21_0)
	local var_21_0 = arg_21_0:GetType()

	AgoraFurnitureType = var_1_10002

	return var_21_0 == var_1_10002.FOUNDATION
end

function var_0_1.IsBuildingType(arg_22_0)
	local var_22_0 = arg_22_0:GetType()

	AgoraFurnitureType = var_1_10002

	return var_22_0 == var_1_10002.BUILDING
end

function var_0_1.IsNewTileType(arg_23_0)
	local var_23_0 = arg_23_0:GetType()

	AgoraFurnitureType = var_1_10002

	return var_23_0 == var_1_10002.TILE_NEW
end

function var_0_1.CanSelect(arg_24_0)
	return true
end

function var_0_1.CanOp(arg_25_0)
	if arg_25_0:IsFoundationType() or arg_25_0:IsBuildingType() then
		return false
	end

	return true
end

function var_0_1.IsFloor(arg_26_0)
	local var_26_0 = arg_26_0:GetType()

	AgoraFurnitureType = var_1_10002

	return var_26_0 == var_1_10002.FLOOR
end

function var_0_1.IsTile(arg_27_0)
	local var_27_0 = arg_27_0:GetType()

	AgoraFurnitureType = var_1_10002

	return var_27_0 == var_1_10002.TILE
end

function var_0_1.Match(arg_28_0, arg_28_1)
	if arg_28_1 == "" or not arg_28_1 then
		return true
	end

	local var_28_0 = arg_28_0:GetName()

	string = var_1_10003
	arg_28_1 = var_1_10003.lower(arg_28_1)
	string = var_3

	local var_28_1 = var_3.lower(var_28_0)

	string = var_3

	if var_3.find(var_28_1, arg_28_1) then
		return true
	end

	return false
end

function var_0_1.ToPlacementData(arg_29_0)
	local var_29_0 = var_0_1.super.ToPlacementData(arg_29_0)

	var_29_0.configId = arg_29_0.configId

	return var_29_0
end

return var_0_1
