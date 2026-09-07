local IslandShipOrder = class("IslandShipOrder")

IslandShipOrder.OP_TYPE_UNLOCK = 1
IslandShipOrder.OP_TYPE_GET_AWARD = 2
IslandShipOrder.OP_TYPE_LOADUP = 3
IslandShipOrder.OPOP_TYPE_LOADUP_ALL = 4

function IslandShipOrder:Ctor(arg_1_1)
	self.consumeList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.cost or {}) do
		table.insert(self.consumeList, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_1_1.id,
			count = iter_1_1.num,
			state = iter_1_1.state
		})
	end

	self.awardList = {}

	for iter_1_2, iter_1_3 in ipairs(arg_1_1.reward or {}) do
		table.insert(self.awardList, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_1_3.id,
			count = iter_1_3.num
		})
	end

	return
end

function IslandShipOrder:FillConsumeList(arg_2_1)
	self.consumeList = arg_2_1

	return
end

function IslandShipOrder:FillAwardList(arg_3_1)
	self.awardList = arg_3_1

	return
end

function IslandShipOrder:IsAnyLoadUp()
	return _.any(self.consumeList, function(arg_5_0)
		return arg_5_0.state == 1
	end)
end

function IslandShipOrder:IsLoadUpAll()
	return _.all(self.consumeList, function(arg_7_0)
		return arg_7_0.state == 1
	end)
end

function IslandShipOrder:MarkLoadUp(arg_8_1)
	self:GetComsume(arg_8_1).state = 1

	return
end

function IslandShipOrder:GetConsumeList()
	return self.consumeList
end

function IslandShipOrder:GetComsume(arg_10_1)
	return self.consumeList[arg_10_1] or {}
end

function IslandShipOrder:AnyCanLoadUp()
	if self:IsLoadUpAll() then
		return false
	end

	return _.any(self.consumeList, function(arg_12_0)
		return arg_12_0.state ~= 1 and Drop.New(arg_12_0):getOwnedCount() >= arg_12_0.count
	end)
end

function IslandShipOrder:ItemIsSubmited(arg_13_1)
	return self.consumeList[arg_13_1] and self.consumeList[arg_13_1].state == 1
end

function IslandShipOrder:GetConsumeAwards(arg_14_1)
	local var_14_0 = self:GetComsume(arg_14_1)

	return {
		{
			type = DROP_TYPE_ISLAND_ITEM,
			id = pg.island_set.order_ship_award_coefficient.key_value_varchar[1],
			count = math.floor(pg.island_item_data_template[var_14_0.id].order_price * var_14_0.count * (pg.island_set.order_ship_award_coefficient.key_value_varchar[2] / 100))
		},
		{
			id = 2,
			type = DROP_TYPE_ISLAND_ITEM,
			count = math.floor(pg.island_item_data_template[var_14_0.id].order_price * var_14_0.count * (pg.island_set.order_ship_award_coefficient.key_value_varchar[3] / 100))
		}
	}
end

function IslandShipOrder:GetAwardList()
	return _.select(self.awardList, function(arg_16_0)
		return arg_16_0.count > 0
	end)
end

return IslandShipOrder
