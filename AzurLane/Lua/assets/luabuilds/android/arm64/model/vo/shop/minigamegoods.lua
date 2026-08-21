local var_0_0 = class("MiniGameGoods", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.configId = arg_1_1.id
	arg_1_0.id = arg_1_1.id
	arg_1_0.count = arg_1_0:GetLimit()

	return
end

function var_0_0.getId(arg_2_0)
	return arg_2_0.id
end

function var_0_0.UpdateCnt(arg_3_0, arg_3_1)
	arg_3_0.count = arg_3_0.count - arg_3_1

	if arg_3_0.count < 0 then
		arg_3_0.count = 0
	end

	return
end

function var_0_0.bindConfigTable(arg_4_0)
	return pg.gameroom_shop_template
end

function var_0_0.CanPurchase(arg_5_0)
	local var_5_0 = arg_5_0:GetDropInfo()
	local var_5_1 = var_5_0:getOwnedLimit()

	if var_5_1 > 0 and var_5_1 <= var_5_0:getOwnedCount() then
		return false
	end

	return arg_5_0.count > 0
end

function var_0_0.GetPrice(arg_6_0)
	return arg_6_0:getConfig("price")
end

function var_0_0.Selectable(arg_7_0)
	return arg_7_0:getConfig("goods_type") == 2
end

function var_0_0.Single(arg_8_0)
	return arg_8_0:getConfig("goods_type") == 1
end

function var_0_0.GetFirstDropId(arg_9_0)
	return arg_9_0:getConfig("goods")
end

function var_0_0.GetMaxCnt(arg_10_0)
	if arg_10_0:CanPurchase() then
		return arg_10_0.count
	else
		return 0
	end

	return
end

function var_0_0.CanPurchaseCnt(arg_11_0, arg_11_1)
	return arg_11_1 <= arg_11_0.count
end

function var_0_0.GetLimit(arg_12_0)
	return arg_12_0:getConfig("goods_purchase_limit")
end

function var_0_0.GetDropInfo(arg_13_0)
	return Drop.New({
		type = arg_13_0:getConfig("drop_type"),
		id = arg_13_0:getConfig("goods")[1],
		count = arg_13_0:getConfig("num")
	})
end

return var_0_0
