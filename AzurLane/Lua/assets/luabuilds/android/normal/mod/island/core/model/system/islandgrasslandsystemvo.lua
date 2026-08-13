class = var_0_10000

local var_0_0 = "IslandGrassLandSystemVO"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandGroundSystemVO"))

function var_0_1.GetType(arg_1_0)
	IslandConst = var_1_10001

	return var_1_10001.SYSTEM_TYPE_GRASSLAND
end

function var_0_1.GetAssetPath(arg_2_0)
	return nil
end

function var_0_1.MapPoint2GroundPoint(arg_3_0, arg_3_1)
	local var_3_0 = var_0_1.super.MapPoint2GroundPoint(arg_3_0, arg_3_1)

	Vector2 = var_3

	return var_3(var_3_0.x - 1, var_3_0.y - 1)
end

return var_0_1
