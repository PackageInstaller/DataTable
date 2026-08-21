local var_0_0 = class("WorldGoods", import("...BaseEntity"))

var_0_0.Fields = {
	config = "table",
	count = "number",
	item = "table",
	moneyItem = "table",
	id = "number"
}
var_0_0.EventUpdateCount = "WorldGoods.EventUpdateCount"

function var_0_0.Setup(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.goods_id
	arg_1_0.config = pg.world_goods_data[arg_1_0.id]

	assert(arg_1_0.config, "world_goods_data not exist: " .. arg_1_0.id)

	arg_1_0.count = arg_1_1.count
	arg_1_0.item = Drop.New({
		type = arg_1_0.config.item_type,
		id = arg_1_0.config.item_id,
		count = arg_1_0.config.item_num
	})
	arg_1_0.moneyItem = Drop.New({
		type = arg_1_0.config.price_type,
		id = arg_1_0.config.price_id,
		count = arg_1_0.config.price_num
	})

	return
end

function var_0_0.UpdateCount(arg_2_0, arg_2_1)
	if arg_2_0.count ~= arg_2_1 then
		arg_2_0.count = arg_2_1

		arg_2_0:DispatchEvent(var_0_0.EventUpdateCount)
	end

	return
end

function var_0_0.sortFunc(arg_3_0, arg_3_1)
	if arg_3_0.config.priority == arg_3_1.config.priority then
		return arg_3_0.id < arg_3_1.id
	else
		return arg_3_0.config.priority > arg_3_1.config.priority
	end

	return
end

return var_0_0
