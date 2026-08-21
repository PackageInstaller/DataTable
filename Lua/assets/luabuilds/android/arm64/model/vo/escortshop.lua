local var_0_0 = class("EscortShop", import(".BaseVO"))

function var_0_0.Ctor(arg_1_0)
	arg_1_0.goods = {}
	arg_1_0.type = ShopArgs.ShopEscort

	return
end

function var_0_0.update(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0.id = arg_2_1
	arg_2_0.configId = arg_2_0.id

	for iter_2_0, iter_2_1 in ipairs(arg_2_2) do
		({})[iter_2_1.shop_id] = iter_2_1.count
	end

	arg_2_0.goods = {}

	if arg_2_0.id and arg_2_0.id > 0 then
		for iter_2_2, iter_2_3 in ipairs(arg_2_0:getConfig("goods")) do
			local var_2_0 = ({})[iter_2_3]

			if not ({})[iter_2_3] then
				var_2_0 = 0
			end

			arg_2_0.goods[iter_2_3] = Goods.Create({
				shop_id = iter_2_3,
				buy_count = var_2_0
			}, Goods.TYPE_SHAM_BATTLE)
		end
	end

	return
end

function var_0_0.isOpen(arg_3_0)
	local var_3_0 = false
	local var_3_1 = arg_3_0:bindConfigTable()[arg_3_0.id]

	if var_3_1 then
		local var_3_2 = pg.TimeMgr.GetInstance()
		local var_3_3 = var_3_2:STimeDescS(var_3_2:GetServerTime(), "*t")

		if var_3_3.month == arg_3_0.id then
			var_3_0 = var_3_3.day >= var_3_1.time[1] and var_3_3.day <= var_3_1.time[2]
		end
	end

	return var_3_0
end

function var_0_0.getRestDays(arg_4_0)
	local var_4_0 = 0
	local var_4_1 = arg_4_0:bindConfigTable()[arg_4_0.id]

	if var_4_1 then
		var_4_0 = var_4_1.time[2] - pg.TimeMgr.GetInstance():STimeDescS(pg.TimeMgr.GetInstance():GetServerTime(), "*t").day + 1
	end

	return (math.max(var_4_0, 1))
end

function var_0_0.getSortGoods(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0.goods) do
		table.insert({}, iter_5_1)
	end

	table.sort({}, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_6_0:canPurchase() and 1 or 0
		local var_6_1 = arg_6_1:canPurchase() and 1 or 0

		if var_6_0 == var_6_1 then
			local var_6_2 = arg_6_0:getConfig("order")
			local var_6_3 = arg_6_1:getConfig("order")

			if var_6_2 == var_6_3 then
				return arg_6_0.id < arg_6_1.id
			else
				return var_6_2 < var_6_3
			end
		else
			return var_6_1 < var_6_0
		end

		return
	end)

	return {}
end

function var_0_0.bindConfigTable(arg_7_0)
	return pg.escort_shop_template
end

function var_0_0.getGoodsCfg(arg_8_0, arg_8_1)
	return pg.activity_shop_template[arg_8_1]
end

function var_0_0.getGoodsById(arg_9_0, arg_9_1)
	return arg_9_0.goods[arg_9_1]
end

return var_0_0
