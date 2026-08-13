class = var_0_10000

local var_0_0 = "EscortShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseVO"))

function var_0_1.Ctor(arg_1_0)
	arg_1_0.goods = {}
	ShopArgs = var_1
	arg_1_0.type = var_1.ShopEscort

	return
end

function var_0_1.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id

	local var_2_0 = {}

	ipairs = var_1_10004

	for iter_2_0, iter_2_1 in var_1_10004(arg_2_2) do
		var_2_0[iter_2_1.shop_id] = iter_2_1.count
	end

	arg_2_0.goods = {}

	if arg_2_0.id and arg_2_0.id > 0 then
		ipairs = var_4

		for iter_2_2, iter_2_3 in var_4(arg_2_0:getConfig("goods")) do
			local var_2_1

			if not var_2_0[iter_2_3] then
				var_2_1 = 0
			end

			local var_2_2 = arg_2_0.goods

			Goods = var_1_10011
			var_1_10011 = var_1_10011.Create

			local var_2_3 = {
				shop_id = iter_2_3,
				buy_count = var_2_1
			}

			Goods = var_1_10014
			var_2_2[iter_2_3] = var_1_10011(var_2_3, var_1_10014.TYPE_SHAM_BATTLE)
		end
	end

	return
end

function var_0_1.isOpen(arg_3_0)
	local var_3_0 = false

	if arg_3_0:bindConfigTable()[arg_3_0.id] then
		pg = var_3

		local var_3_1 = var_3.TimeMgr.GetInstance()

		if var_3.STimeDescS(var_3_1, var_3:GetServerTime(), "*t").month == arg_3_0.id then
			var_3_0 = var_4.day >= var_2.time[1] and var_4.day <= var_2.time[2]
		end
	end

	return var_3_0
end

function var_0_1.getRestDays(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = arg_4_0
	local var_4_2

	if arg_4_0.bindConfigTable(var_4_1)[arg_4_0.id] then
		pg = var_4_2
		var_4_2 = var_4_2.TimeMgr.GetInstance()
		pg = var_4_1

		local var_4_3 = var_4_1.TimeMgr.GetInstance()
		local var_4_4 = var_4.STimeDescS(var_4_3, var_4_2:GetServerTime(), "*t")

		var_4_0 = var_2.time[2] - var_4_4.day + 1
	end

	math = var_4_2

	return (var_4_2.max(var_4_0, 1))
end

function var_0_1.getSortGoods(arg_5_0)
	local var_5_0 = {}

	pairs = var_1_10002

	for iter_5_0, iter_5_1 in var_1_10002(arg_5_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_5_0, iter_5_1)
	end

	table = var_2

	var_2.sort(var_5_0, function(arg_6_0, arg_6_1)
		if (arg_6_0:canPurchase() and 1 or 0) == (arg_6_1:canPurchase() and 1 or 0) then
			if arg_6_0:getConfig("order") == arg_6_1:getConfig("order") then
				return arg_6_0.id < arg_6_1.id
			else
				return var_4 < var_5
			end
		else
			return var_3 < var_2
		end

		return
	end)

	return var_5_0
end

function var_0_1.bindConfigTable(arg_7_0)
	pg = var_1_10001

	return var_1_10001.escort_shop_template
end

function var_0_1.getGoodsCfg(arg_8_0, arg_8_1)
	pg = var_1_10002

	return var_1_10002.activity_shop_template[arg_8_1]
end

function var_0_1.getGoodsById(arg_9_0, arg_9_1)
	return arg_9_0.goods[arg_9_1]
end

return var_0_1
