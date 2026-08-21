local var_0_0 = class("IslandShipOrder")

var_0_0.OP_TYPE_UNLOCK = 1
var_0_0.OP_TYPE_GET_AWARD = 2
var_0_0.OP_TYPE_LOADUP = 3
var_0_0.OPOP_TYPE_LOADUP_ALL = 4

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.consumeList = {}

	local var_1_0 = arg_1_1.cost or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.consumeList, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_1_1.id,
			count = iter_1_1.num,
			state = iter_1_1.state
		})
	end

	arg_1_0.awardList = {}

	local var_1_1 = arg_1_1.reward or {}

	for iter_1_2, iter_1_3 in ipairs(var_1_1) do
		table.insert(arg_1_0.awardList, {
			type = DROP_TYPE_ISLAND_ITEM,
			id = iter_1_3.id,
			count = iter_1_3.num
		})
	end

	return
end

function var_0_0.FillConsumeList(arg_2_0, arg_2_1)
	arg_2_0.consumeList = arg_2_1

	return
end

function var_0_0.FillAwardList(arg_3_0, arg_3_1)
	arg_3_0.awardList = arg_3_1

	return
end

function var_0_0.IsAnyLoadUp(arg_4_0)
	return _.any(arg_4_0.consumeList, function(arg_5_0)
		return arg_5_0.state == 1
	end)
end

function var_0_0.IsLoadUpAll(arg_6_0)
	return _.all(arg_6_0.consumeList, function(arg_7_0)
		return arg_7_0.state == 1
	end)
end

function var_0_0.MarkLoadUp(arg_8_0, arg_8_1)
	arg_8_0:GetComsume(arg_8_1).state = 1

	return
end

function var_0_0.GetConsumeList(arg_9_0)
	return arg_9_0.consumeList
end

function var_0_0.GetComsume(arg_10_0, arg_10_1)
	return arg_10_0.consumeList[arg_10_1] or {}
end

function var_0_0.AnyCanLoadUp(arg_11_0)
	if arg_11_0:IsLoadUpAll() then
		return false
	end

	return _.any(arg_11_0.consumeList, function(arg_12_0)
		local var_12_0 = Drop.New(arg_12_0)

		return arg_12_0.state ~= 1 and var_12_0:getOwnedCount() >= arg_12_0.count
	end)
end

function var_0_0.ItemIsSubmited(arg_13_0, arg_13_1)
	return arg_13_0.consumeList[arg_13_1] and arg_13_0.consumeList[arg_13_1].state == 1
end

function var_0_0.GetConsumeAwards(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_0:GetComsume(arg_14_1)

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

function var_0_0.GetAwardList(arg_15_0)
	return _.select(arg_15_0.awardList, function(arg_16_0)
		return arg_16_0.count > 0
	end)
end

return var_0_0
