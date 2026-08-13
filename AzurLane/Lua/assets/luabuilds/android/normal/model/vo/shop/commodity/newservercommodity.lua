class = var_0_10000

local var_0_0 = "NewServerCommodity"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id

	local var_1_0

	if not arg_1_1.count then
		var_1_0 = arg_1_0:getConfig("goods_purchase_limit")
	end

	arg_1_0.count = var_1_0
	arg_1_0.boughtRecord = {}
	ipairs = var_2

	local var_1_1

	if not arg_1_1.bought_record then
		var_1_1 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_1) do
		arg_1_0.boughtRecord[iter_1_1] = true
	end

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.newserver_shop_template
end

function var_0_1.CanPurchase(arg_3_0)
	return arg_3_0.count > 0
end

function var_0_1.ReduceCnt(arg_4_0, arg_4_1)
	arg_4_0.count = arg_4_0.count - arg_4_1

	return
end

function var_0_1.CanPurchaseMulTimes(arg_5_0, arg_5_1)
	return arg_5_1 <= arg_5_0.count
end

function var_0_1.CanPurchaseSubGoods(arg_6_0, arg_6_1)
	if arg_6_0:LimitPurchaseSubGoods() then
		return not (arg_6_0.boughtRecord[arg_6_1] == true)
	else
		return true
	end

	return
end

function var_0_1.UpdateBoughtRecord(arg_7_0, arg_7_1)
	arg_7_0.boughtRecord[arg_7_1] = true

	return
end

function var_0_1.LimitPurchaseSubGoods(arg_8_0)
	return arg_8_0:getConfig("goods_type") == 4
end

function var_0_1.Selectable(arg_9_0)
	return arg_9_0:getConfig("goods_type") == 2 or var_1 == 4
end

function var_0_1.GetConsume(arg_10_0)
	Drop = var_1_10001

	return var_1_10001.New({
		type = arg_10_0:getConfig("resource_category"),
		id = arg_10_0:getConfig("resource_type"),
		count = arg_10_0:getConfig("resource_num")
	})
end

function var_0_1.GetDesc(arg_11_0)
	return {
		name = arg_11_0:getConfig("goods_name"),
		icon = arg_11_0:getConfig("goods_icon"),
		rarity = arg_11_0:getConfig("goods_rarity")
	}
end

function var_0_1.IsOpening(arg_12_0, arg_12_1)
	local var_12_0 = {}
	local var_12_1 = arg_12_1 + arg_12_0:getConfig("unlock_time")

	pg = var_5

	local var_12_2 = var_5.TimeMgr.GetInstance()

	if not (var_12_1 <= var_5.GetServerTime(var_12_2)) then
		pg = var_1_10007

		local var_12_3 = var_1_10007.TimeMgr.GetInstance()
		local var_12_4, var_12_5, var_12_6, var_12_7 = var_7.parseTimeFrom(var_12_3, var_12_1 - var_5)

		var_12_0.day = var_12_4
		var_12_0.hour = var_12_5
	end

	return var_6, var_12_0
end

function var_0_1.GetDropCnt(arg_13_0)
	return arg_13_0:getConfig("num")
end

function var_0_1.GetCanPurchaseCnt(arg_14_0)
	return arg_14_0.count
end

function var_0_1.GetCanPurchaseMaxCnt(arg_15_0)
	return arg_15_0:getConfig("goods_purchase_limit")
end

function var_0_1.GetDropType(arg_16_0)
	return arg_16_0:getConfig("type")
end

function var_0_1.GetSelectableGoods(arg_17_0)
	return arg_17_0:getConfig("goods")
end

function var_0_1.CheckTimeLimit(arg_18_0)
	local var_18_0 = false
	local var_18_1 = false
	local var_18_2
	local var_18_3 = arg_18_0:getConfig("type")
	local var_18_4 = arg_18_0
	local var_18_5 = arg_18_0.getConfig(var_18_4, "goods")[1]

	Item = var_18_4

	local var_18_6 = var_18_4.getConfigData(var_18_5)

	DROP_TYPE_VITEM = var_7

	if var_18_3 == var_7 and var_18_6.virtual_type == 22 then
		var_18_0 = true
		var_18_2 = true
		getProxy = var_7
		ActivityProxy = var_1_10008

		local var_18_7 = var_7(var_1_10008)

		if var_7.getActivityById(var_18_7, var_18_6.link_id) and not var_8:isEnd() then
			var_18_1 = true
		end
	end

	return var_18_0, var_18_1, var_18_2
end

function var_0_1.GetPurchasableCnt(arg_19_0)
	return arg_19_0.count
end

return var_0_1
