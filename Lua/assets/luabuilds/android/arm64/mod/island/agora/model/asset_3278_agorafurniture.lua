local AgoraFurniture = class("AgoraFurniture", import(".AgoraPlaceableItem"))

function AgoraFurniture:Ctor(arg_1_1)
	self.configId = arg_1_1.configId
	self.time = arg_1_1.time or self.configId
	self.isNew = defaultValue(arg_1_1.isNew, false)
	self.config = pg.island_furniture_template[self.configId]

	assert(self.config, self.configId)
	AgoraFurniture.super.Ctor(self, arg_1_1, Vector2(self.config.size[1], self.config.size[2]))

	return
end

function AgoraFurniture:IsNew()
	return self.isNew
end

function AgoraFurniture:ClearNew()
	self.isNew = false

	return
end

function AgoraFurniture:GetMapType()
	if self:IsNewTileType() then
		return IslandConst.AGORA_MAP_TYPE_NEWTILE
	elseif self:IsBuildingType() then
		return IslandConst.AGORA_MAP_TYPE_BUILDING
	else
		return IslandConst.AGORA_MAP_TYPE_COMMON
	end

	return
end

function AgoraFurniture:CanInteraction()
	return self.config.interact_point ~= "" and #self.config.interact_point > 0
end

function AgoraFurniture:GetInteractionPoints()
	if not self:CanInteraction() then
		return {}
	end

	return self.config.interact_point
end

function AgoraFurniture:Read()
	return false
end

function AgoraFurniture:HasBt()
	return self.config.bt ~= nil and self.config.bt ~= ""
end

function AgoraFurniture:GetBt()
	return self.config.bt
end

function AgoraFurniture:GetResPath()
	return self.config.model
end

function AgoraFurniture:GetTimeline()
	return self.timelineInfo
end

function AgoraFurniture:HasTimeline()
	return #self.timelineInfo > 0
end

function AgoraFurniture:GetName()
	return self.config.name
end

function AgoraFurniture:GetCost()
	return self.config.capacityCost
end

function AgoraFurniture:GetRarity()
	return self.config.rarity
end

function AgoraFurniture:GetIcon()
	return self.config.icon
end

function AgoraFurniture:GetType()
	return self.config.type
end

function AgoraFurniture:GetTime()
	return self.time
end

function AgoraFurniture:GetDesc()
	return self.config.describe or ""
end

function AgoraFurniture:IsOptionalShapeType()
	return self:GetType() == AgoraFurnitureType.FLOOR or self:GetType() == AgoraFurnitureType.TILE
end

function AgoraFurniture:IsFoundationType()
	return self:GetType() == AgoraFurnitureType.FOUNDATION
end

function AgoraFurniture:IsBuildingType()
	return self:GetType() == AgoraFurnitureType.BUILDING
end

function AgoraFurniture:IsNewTileType()
	return self:GetType() == AgoraFurnitureType.TILE_NEW
end

function AgoraFurniture:CanSelect()
	return true
end

function AgoraFurniture:CanOp()
	if self:IsFoundationType() or self:IsBuildingType() then
		return false
	end

	return true
end

function AgoraFurniture:IsFloor()
	return self:GetType() == AgoraFurnitureType.FLOOR
end

function AgoraFurniture:IsTile()
	return self:GetType() == AgoraFurnitureType.TILE
end

function AgoraFurniture:Match(arg_28_1)
	if arg_28_1 == "" or not arg_28_1 then
		do return true end

		arg_28_1 = string.lower(arg_28_1)
	end

	if string.find(string.lower((self:GetName())), arg_28_1) then
		return true
	end

	return false
end

function AgoraFurniture:ToPlacementData()
	local var_29_0 = AgoraFurniture.super.ToPlacementData(self)

	var_29_0.configId = self.configId

	return var_29_0
end

return AgoraFurniture
