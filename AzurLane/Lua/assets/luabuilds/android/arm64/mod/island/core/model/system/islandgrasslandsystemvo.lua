local var_0_0 = class("IslandGrassLandSystemVO", import(".IslandGroundSystemVO"))

function var_0_0.GetType(arg_1_0)
	return IslandConst.SYSTEM_TYPE_GRASSLAND
end

function var_0_0.GetAssetPath(arg_2_0)
	return nil
end

function var_0_0.MapPoint2GroundPoint(arg_3_0, arg_3_1)
	local var_3_0 = var_0_0.super.MapPoint2GroundPoint(arg_3_0, arg_3_1)

	return Vector2(var_3_0.x - 1, var_3_0.y - 1)
end

return var_0_0
