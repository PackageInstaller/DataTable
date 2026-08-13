class = var_0_10000

local var_0_0 = "IslandGroundSystemVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandSystemVO"))

function var_0_1.GetBehaviourTree(arg_1_0)
	return nil
end

function var_0_1.GetType(arg_2_0)
	IslandConst = var_1_10001

	return var_1_10001.SYSTEM_TYPE_GROUND
end

function var_0_1.GetAssetPath(arg_3_0)
	return "ui/FloorTileRenderer"
end

function var_0_1.GetSize(arg_4_0)
	IslandConst = var_1_10001

	local var_4_0 = var_1_10001.AGORA_LEVEL_2_SIZE

	IslandConst = var_1_10002

	local var_4_1 = var_4_0[#var_1_10002.AGORA_LEVEL_2_SIZE]

	Vector2 = var_2

	return var_2(var_4_1, var_4_1)
end

function var_0_1.GetMapLeftBottomPoint(arg_5_0)
	local var_5_0 = arg_5_0
	local var_5_1 = arg_5_0.GetSize(var_5_0)

	AgoraCalc = var_5_0

	local var_5_2 = var_5_0.GetSizeCoord(var_5_1)

	Vector2 = var_3

	return var_3(var_5_2.x, var_5_2.w)
end

function var_0_1.GetPosition(arg_6_0)
	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.GetMapLeftBottomPoint(var_6_0)

	AgoraCalc = var_6_0

	local var_6_2 = var_6_0.MapPosition2WorldPosition(var_6_1)

	IslandConst = var_3

	local var_6_3 = var_6_2 + var_3.AGORA_POSITION_OFFSET

	IslandConst = var_3

	return var_6_3 + var_3.AGORA_GROUND_OFFSET
end

function var_0_1.MapPoint2GroundPoint(arg_7_0, arg_7_1)
	return arg_7_1 - arg_7_0:GetMapLeftBottomPoint()
end

return var_0_1
