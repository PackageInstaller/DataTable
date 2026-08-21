local var_0_0 = class("IslandShipDressItem", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.ship_id = arg_1_1.ship_id
	arg_1_0.dress_id = arg_1_1.dress_id
	arg_1_0.configId = arg_1_0.dress_id

	return
end

function var_0_0.CheckIsEqualByShipDressItem(arg_2_0, arg_2_1)
	return arg_2_0.ship_id == arg_2_1.ship_id and arg_2_0.dress_id == arg_2_1.dress_id
end

function var_0_0.CheckIsEqualByShipIdAndDressId(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.ship_id == arg_3_1 and arg_3_0.dress_id == arg_3_2
end

function var_0_0.SetShipAndDressId(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.ship_id = arg_4_1
	arg_4_0.dress_id = arg_4_2

	return
end

function var_0_0.bindConfigTable(arg_5_0)
	return pg.island_dress_template
end

return var_0_0
