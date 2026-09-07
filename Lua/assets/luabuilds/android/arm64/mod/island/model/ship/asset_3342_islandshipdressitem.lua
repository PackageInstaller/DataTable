local IslandShipDressItem = class("IslandShipDressItem", import("model.vo.BaseVO"))

function IslandShipDressItem:Ctor(arg_1_1)
	self.ship_id = arg_1_1.ship_id
	self.dress_id = arg_1_1.dress_id
	self.configId = self.dress_id

	return
end

function IslandShipDressItem:CheckIsEqualByShipDressItem(arg_2_1)
	return self.ship_id == arg_2_1.ship_id and self.dress_id == arg_2_1.dress_id
end

function IslandShipDressItem:CheckIsEqualByShipIdAndDressId(arg_3_1, arg_3_2)
	return self.ship_id == arg_3_1 and self.dress_id == arg_3_2
end

function IslandShipDressItem:SetShipAndDressId(arg_4_1, arg_4_2)
	self.ship_id = arg_4_1
	self.dress_id = arg_4_2

	return
end

function IslandShipDressItem:bindConfigTable()
	return pg.island_dress_template
end

return IslandShipDressItem
