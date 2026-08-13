class = var_0_10000

local var_0_0 = "WorldGoods"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	count = "number",
	item = "table",
	moneyItem = "table",
	id = "number"
}
var_0_1.EventUpdateCount = "WorldGoods.EventUpdateCount"

function var_0_1.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.goods_id
	pg = var_2
	arg_1_0.config = var_2.world_goods_data[arg_1_0.id]
	assert = var_2

	var_2(arg_1_0.config, "world_goods_data not exist: " .. arg_1_0.id)

	arg_1_0.count = arg_1_1.count
	Drop = var_2
	arg_1_0.item = var_2.New({
		type = arg_1_0.config.item_type,
		id = arg_1_0.config.item_id,
		count = arg_1_0.config.item_num
	})
	Drop = var_2
	arg_1_0.moneyItem = var_2.New({
		type = arg_1_0.config.price_type,
		id = arg_1_0.config.price_id,
		count = arg_1_0.config.price_num
	})

	return
end

function var_0_1.UpdateCount(arg_2_0, arg_2_1)
	if arg_2_0.count ~= arg_2_1 then
		arg_2_0.count = arg_2_1

		arg_2_0:DispatchEvent(var_0_1.EventUpdateCount)
	end

	return
end

function var_0_1.sortFunc(arg_3_0, arg_3_1)
	if arg_3_0.config.priority == arg_3_1.config.priority then
		return arg_3_0.id < arg_3_1.id
	else
		return arg_3_0.config.priority > arg_3_1.config.priority
	end

	return
end

return var_0_1
