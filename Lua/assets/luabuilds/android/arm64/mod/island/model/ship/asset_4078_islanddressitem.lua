local IslandDressItem = class("IslandDressItem", import("model.vo.BaseVO"))

function IslandDressItem:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.ownCount = arg_1_1.ownCount
	self.holdedShipId = arg_1_1.holdedShipId
	self.needRedDot = arg_1_1.needRedDot
	self.quality = arg_1_1.quality

	return
end

function IslandDressItem:bindConfigTable()
	return pg.island_dress_template
end

function IslandDressItem:GetSortValue(arg_3_1, arg_3_2)
	local var_3_0 = 0

	var_3_0 = arg_3_1 == IslandShipDressUpPageNew.SORT_RARITY and self:GetRarity() or arg_3_1 == IslandShipDressUpPageNew.SORT_CANSEND and (self.ownCount and 1 or 0) or self.id

	return arg_3_2 == 1 and var_3_0 or -1 * var_3_0
end

function IslandDressItem:GetRarity()
	return self:getConfig("quality")
end

return IslandDressItem
