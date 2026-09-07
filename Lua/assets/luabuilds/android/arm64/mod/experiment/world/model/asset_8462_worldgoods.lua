local WorldGoods = class("WorldGoods", import("...BaseEntity"))

WorldGoods.Fields = {
	config = "table",
	count = "number",
	item = "table",
	moneyItem = "table",
	id = "number"
}
WorldGoods.EventUpdateCount = "WorldGoods.EventUpdateCount"

function WorldGoods:Setup(arg_1_1)
	self.id = arg_1_1.goods_id
	self.config = pg.world_goods_data[self.id]

	assert(self.config, "world_goods_data not exist: " .. self.id)

	self.count = arg_1_1.count
	self.item = Drop.New({
		type = self.config.item_type,
		id = self.config.item_id,
		count = self.config.item_num
	})
	self.moneyItem = Drop.New({
		type = self.config.price_type,
		id = self.config.price_id,
		count = self.config.price_num
	})

	return
end

function WorldGoods:UpdateCount(arg_2_1)
	if self.count ~= arg_2_1 then
		self.count = arg_2_1

		self:DispatchEvent(WorldGoods.EventUpdateCount)
	end

	return
end

function WorldGoods:sortFunc(arg_3_1)
	if self.config.priority == arg_3_1.config.priority then
		return self.id < arg_3_1.id
	else
		return self.config.priority > arg_3_1.config.priority
	end

	return
end

return WorldGoods
