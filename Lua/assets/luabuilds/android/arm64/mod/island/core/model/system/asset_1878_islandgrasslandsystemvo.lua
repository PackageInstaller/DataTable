local IslandGrassLandSystemVO = class("IslandGrassLandSystemVO", import(".IslandGroundSystemVO"))

function IslandGrassLandSystemVO:GetType()
	return IslandConst.SYSTEM_TYPE_GRASSLAND
end

function IslandGrassLandSystemVO:GetAssetPath()
	return nil
end

function IslandGrassLandSystemVO:MapPoint2GroundPoint(arg_3_1)
	local var_3_0 = IslandGrassLandSystemVO.super.MapPoint2GroundPoint(self, arg_3_1)

	return Vector2(var_3_0.x - 1, var_3_0.y - 1)
end

return IslandGrassLandSystemVO
