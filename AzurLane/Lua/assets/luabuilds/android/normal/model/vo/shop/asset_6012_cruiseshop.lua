class = var_0_10000

local var_0_0 = "CruiseShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShop"))

var_0_1.TYPE_SKIN = "skin"
var_0_1.TYPE_EQUIP_SKIN = "equip_skin"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.type = var_0_1.ShopCruise

	local var_1_0 = {}
	local var_1_1 = var_0_1.TYPE_SKIN

	ShopArgs = var_1_10005
	var_1_0[var_1_1] = var_1_10005.CruiseSkin

	local var_1_2 = var_0_1.TYPE_EQUIP_SKIN

	ShopArgs = var_5
	var_1_0[var_1_2] = var_5.CruiseGearSkin
	arg_1_0.genres = var_1_0

	local var_1_3 = {}

	pairs = var_1_2

	for iter_1_0, iter_1_1 in var_1_2(arg_1_0.genres) do
		pg = var_1_10009

		if var_1_10009.shop_template.get_id_list_by_genre[iter_1_1] then
			pg = var_1_10010
			var_1_10010 = var_1_10010.TimeMgr.GetInstance()
			ipairs = var_1_10011

			for iter_1_2, iter_1_3 in var_1_10011(var_1_10009) do
				local var_1_4 = var_1_10010

				var_1_10016 = var_1_10010.inTime
				pg = var_1_10018

				if var_1_10016(var_1_4, var_1_10018.shop_template[iter_1_3].time) then
					table = var_1_10016

					var_1_10016.insert(var_1_3, iter_1_3)
				end
			end
		end
	end

	local var_1_5 = {}

	ipairs = var_5

	for iter_1_4, iter_1_5 in var_5(arg_1_1) do
		var_1_5[iter_1_5.shop_id] = iter_1_5.pay_count
	end

	local var_1_6 = {}

	ipairs = var_6

	for iter_1_6, iter_1_7 in var_6(arg_1_2) do
		var_1_6[iter_1_7.shop_id] = iter_1_7.pay_count
	end

	arg_1_0.goods = {}
	ipairs = var_6

	for iter_1_8, iter_1_9 in var_6(var_1_3) do
		local var_1_7

		if not var_1_5[iter_1_9] then
			var_1_7 = 0
		end

		pg = var_1_10012

		if not var_1_6[var_1_10012.shop_template[iter_1_9].group] then
			var_1_10012 = 0
		end

		local var_1_8 = arg_1_0.goods

		Goods = iter_1_2
		iter_1_2 = iter_1_2.Create

		local var_1_9 = {
			shop_id = iter_1_9,
			buy_count = var_1_7,
			groupCount = var_1_10012
		}

		Goods = var_1_10016
		var_1_8[iter_1_9] = iter_1_2(var_1_9, var_1_10016.TYPE_CRUISE)
	end

	return
end

function var_0_1.GetRemainEquipSkinCnt(arg_2_0)
	pairs = var_1_10001

	for iter_2_0, iter_2_1 in var_1_10001(arg_2_0.goods) do
		local var_2_0 = iter_2_1
		local var_2_1 = iter_2_1.getConfig(var_2_0, "genre")

		ShopArgs = var_2_0

		if var_2_1 == var_2_0.CruiseGearSkin then
			return iter_2_1:getConfig("group_limit") - iter_2_1.groupCount
		end
	end

	return 0
end

function var_0_1.IsSameKind(arg_3_0, arg_3_1)
	isa = var_1_10002

	local var_3_0 = arg_3_1

	CruiseShop = var_1_10004

	return var_1_10002(var_3_0, var_1_10004)
end

function var_0_1.GetCommodityById(arg_4_0, arg_4_1)
	return arg_4_0:getGoodsById(arg_4_1)
end

function var_0_1.GetCommodities(arg_5_0)
	return arg_5_0:getSortGoods()
end

function var_0_1.GetCommoditiesByType(arg_6_0, arg_6_1)
	return arg_6_0:getSortGoodsByType(arg_6_1)
end

function var_0_1.getGoodsById(arg_7_0, arg_7_1)
	return arg_7_0.goods[arg_7_1]
end

function var_0_1.getSortGoods(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_8_0, iter_8_1)
	end

	return arg_8_0:sort(var_8_0)
end

function var_0_1.getSortGoodsByType(arg_9_0, arg_9_1)
	local var_9_0 = {}

	pairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_0.goods) do
		if iter_9_1:getConfig("genre") == arg_9_0.genres[arg_9_1] then
			table = var_8

			var_8.insert(var_9_0, iter_9_1)
		end
	end

	return arg_9_0:sort(var_9_0)
end

function var_0_1.sort(arg_10_0, arg_10_1)
	table = var_1_10002

	local var_10_0 = var_1_10002.sort
	local var_10_1 = arg_10_1

	CompareFuncs = var_1_10004

	var_10_0(var_10_1, var_1_10004({
		function(arg_11_0)
			return arg_11_0:canPurchase() and 0 or 1
		end,
		function(arg_12_0)
			return arg_12_0:getConfig("order")
		end,
		function(arg_13_0)
			return arg_13_0.id
		end
	}))

	return arg_10_1
end

return var_0_1
