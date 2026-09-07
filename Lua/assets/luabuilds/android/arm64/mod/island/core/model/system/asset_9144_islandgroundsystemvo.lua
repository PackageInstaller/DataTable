local IslandGroundSystemVO = class("IslandGroundSystemVO", import(".IslandSystemVO"))

function IslandGroundSystemVO:GetBehaviourTree()
	return nil
end

function IslandGroundSystemVO:GetType()
	return IslandConst.SYSTEM_TYPE_GROUND
end

function IslandGroundSystemVO:GetAssetPath()
	return "ui/FloorTileRenderer"
end

function IslandGroundSystemVO:GetSize()
	return Vector2(IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE], IslandConst.AGORA_LEVEL_2_SIZE[#IslandConst.AGORA_LEVEL_2_SIZE])
end

function IslandGroundSystemVO:GetMapLeftBottomPoint()
	local var_5_0 = AgoraCalc.GetSizeCoord((self:GetSize()))

	return Vector2(var_5_0.x, var_5_0.w)
end

function IslandGroundSystemVO:GetPosition()
	return AgoraCalc.MapPosition2WorldPosition((self:GetMapLeftBottomPoint())) + IslandConst.AGORA_POSITION_OFFSET + IslandConst.AGORA_GROUND_OFFSET
end

function IslandGroundSystemVO:MapPoint2GroundPoint(arg_7_1)
	return arg_7_1 - self:GetMapLeftBottomPoint()
end

return IslandGroundSystemVO
