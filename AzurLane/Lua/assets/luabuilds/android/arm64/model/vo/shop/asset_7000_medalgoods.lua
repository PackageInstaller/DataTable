class = var_0_10000

local var_0_0 = "MedalGoods"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.count = arg_1_1.count

	return
end

function var_0_1.UpdateCnt(arg_2_0, arg_2_1)
	arg_2_0.count = arg_2_0.count - arg_2_1

	return
end

function var_0_1.bindConfigTable(arg_3_0)
	pg = var_1_10001

	return var_1_10001.honormedal_goods_list
end

function var_0_1.CanPurchase(arg_4_0)
	return arg_4_0.count > 0
end

function var_0_1.GetPrice(arg_5_0)
	return arg_5_0:getConfig("price")
end

function var_0_1.Selectable(arg_6_0)
	return arg_6_0:getConfig("goods_type") == 2
end

function var_0_1.GetFirstDropId(arg_7_0)
	return arg_7_0:getConfig("goods")
end

function var_0_1.GetMaxCnt(arg_8_0)
	return arg_8_0.count
end

function var_0_1.CanPurchaseCnt(arg_9_0, arg_9_1)
	return arg_9_1 <= arg_9_0.count
end

function var_0_1.GetLimit(arg_10_0)
	return arg_10_0:getConfig("goods_purchase_limit")
end

function var_0_1.GetDropInfo(arg_11_0)
	Drop = var_1_10001

	return var_1_10001.New({
		type = arg_11_0:getConfig("type"),
		id = arg_11_0:getConfig("goods")[1],
		count = arg_11_0:getConfig("num")
	})
end

return var_0_1
