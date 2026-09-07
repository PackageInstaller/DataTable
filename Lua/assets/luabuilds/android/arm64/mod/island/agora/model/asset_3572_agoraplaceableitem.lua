local AgoraPlaceableItem = class("AgoraPlaceableItem", import("...IslandDispatcher"))

function AgoraPlaceableItem:Ctor(arg_1_1, arg_1_2)
	AgoraPlaceableItem.super.Ctor(self)

	self.id = arg_1_1.id
	self.position = Vector2.zero
	self.rotation = Vector3.zero
	self.size = arg_1_2 or Vector2.one
	self.area = self:GenArea()

	return
end

function AgoraPlaceableItem:GetMapType()
	return IslandConst.AGORA_MAP_TYPE_COMMON
end

function AgoraPlaceableItem:IsSame(arg_3_1)
	return self.position == arg_3_1.position and self.rotation == arg_3_1.rotation
end

function AgoraPlaceableItem:Clear()
	self.position = Vector2.zero
	self.rotation = Vector3.zero

	return
end

function AgoraPlaceableItem:GetSize()
	return self.size
end

function AgoraPlaceableItem:GetSizeWithRotation()
	if self:IsForward() then
		return self:GetSize()
	else
		return Vector2(self.size.y, self.size.x)
	end

	return
end

function AgoraPlaceableItem:GetRotation()
	return self.rotation
end

function AgoraPlaceableItem:UpdateRotation(arg_8_1)
	self.rotation = arg_8_1

	self:DispatchEvent(ISLAND_AGORA_EVT.ITEM_DIR_UPDATE, self.rotation)
	self:UpdatePosition(self.position)

	return
end

function AgoraPlaceableItem:UpdatePosition(arg_9_1)
	self.position = arg_9_1
	self.area = self:ReGenArea(true)

	self:DispatchEvent(ISLAND_AGORA_EVT.ITEM_POSITION_UPDATE, self.area)

	return
end

function AgoraPlaceableItem:GetPosition()
	return self.position
end

function AgoraPlaceableItem:IsSquareSize()
	return self.size.x == self.size.y
end

function AgoraPlaceableItem:ReGenArea(arg_12_1)
	if self:IsSquareSize() and not arg_12_1 then
		return self:GetArea()
	end

	return self:GenArea()
end

function AgoraPlaceableItem:IsForward()
	return self.rotation.y == 0 or self.rotation.y == 180
end

function AgoraPlaceableItem:Rotation()
	self:UpdateRotation(Vector3(0, (self.rotation.y + 90 > 270 or nil) and 0, 0))

	return
end

function AgoraPlaceableItem:GenArea()
	return self:GenAreaByPosition(self.position)
end

function AgoraPlaceableItem:GenAreaByPosition(arg_16_1)
	if self:IsForward() then
		return AgoraCalc.GetArea(arg_16_1, self.size)
	else
		return AgoraCalc.GetArea(arg_16_1, Vector2(self.size.y, self.size.x))
	end

	return
end

function AgoraPlaceableItem:GetNeighborPoints()
	local var_17_0

	if self:IsForward() then
		var_17_0 = AgoraCalc.GetSizeCoord(self.size)
	end

	local var_17_1

	do
		var_17_0 = AgoraCalc.GetSizeCoord(Vector2(self.size.y, self.size.x))
		var_17_1 = {
			self.position + Vector2(0, var_17_0.y + 1),
			self.position + Vector2(0, var_17_0.w - 1)
		}
	end

	var_17_1[3] = self.position + Vector2(var_17_0.x - 1, 0)
	var_17_1[4] = self.position + Vector2(var_17_0.z + 1, 0)

	return var_17_1
end

function AgoraPlaceableItem:GetArea()
	return self.area
end

function AgoraPlaceableItem:GetResPath()
	assert(false)

	return
end

function AgoraPlaceableItem:ToPlacementData()
	return {
		id = self.id,
		x = self.position.x,
		y = self.position.y,
		dir = self.rotation.y / 90
	}
end

function AgoraPlaceableItem:FlushDataFromPlacementData(arg_21_1)
	self:UpdatePosition(arg_21_1.position)
	self:UpdateRotation(arg_21_1.rotation)

	return
end

return AgoraPlaceableItem
