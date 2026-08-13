class = var_0_10000

local var_0_0 = "IslandShipDressItem"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.ship_id = arg_1_1.ship_id
	arg_1_0.dress_id = arg_1_1.dress_id
	arg_1_0.configId = arg_1_0.dress_id

	return
end

function var_0_1.CheckIsEqualByShipDressItem(arg_2_0, arg_2_1)
	return arg_2_0.ship_id == arg_2_1.ship_id and arg_2_0.dress_id == arg_2_1.dress_id
end

function var_0_1.CheckIsEqualByShipIdAndDressId(arg_3_0, arg_3_1, arg_3_2)
	return arg_3_0.ship_id == arg_3_1 and arg_3_0.dress_id == arg_3_2
end

function var_0_1.SetShipAndDressId(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.ship_id = arg_4_1
	arg_4_0.dress_id = arg_4_2

	return
end

function var_0_1.bindConfigTable(arg_5_0)
	pg = var_1_10001

	return var_1_10001.island_dress_template
end

return var_0_1
