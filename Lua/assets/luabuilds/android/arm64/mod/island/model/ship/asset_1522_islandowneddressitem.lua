local IslandOwnedDressItem = class("IslandOwnedDressItem", import("model.vo.BaseVO"))

function IslandOwnedDressItem:Ctor(arg_1_1)
	self.id = arg_1_1.id
	self.configId = self.id
	self.num = arg_1_1.num
	self.read = arg_1_1.read

	return
end

function IslandOwnedDressItem:bindConfigTable()
	return pg.island_dress_template
end

function IslandOwnedDressItem:GetRarity()
	return self:getConfig("quality")
end

return IslandOwnedDressItem
