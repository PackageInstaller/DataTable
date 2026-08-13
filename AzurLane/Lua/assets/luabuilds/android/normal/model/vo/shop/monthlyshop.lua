class = var_0_10000

local var_0_0 = "MonthlyShop"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShop"))

function var_0_1.Ctor(arg_1_0)
	arg_1_0.goods = {}

	return
end

var_0_1.GoodsType = nil

function var_0_1.IsSameKind(arg_2_0, arg_2_1)
	isa = var_1_10002

	local var_2_0 = arg_2_1

	MonthlyShop = var_1_10004

	return var_1_10002(var_2_0, var_1_10004)
end

function var_0_1.GetCommodityById(arg_3_0, arg_3_1)
	return arg_3_0:getGoodsById(arg_3_1)
end

function var_0_1.GetCommodities(arg_4_0)
	return arg_4_0:getSortGoods()
end

function var_0_1.isOpen(arg_5_0)
	if not arg_5_0.id then
		return false
	end

	local var_5_0 = false

	if arg_5_0:bindConfigTable()[arg_5_0.id] then
		pg = var_3

		local var_5_1 = var_3.TimeMgr.GetInstance()

		var_5_0 = var_3.STimeDescS(var_5_1, var_3:GetServerTime(), "*t").month == arg_5_0.id
	end

	return var_5_0
end

function var_0_1.getRestDays(arg_6_0)
	if not arg_6_0.id then
		return 0
	end

	pg = var_1

	local var_6_0 = var_1.TimeMgr.GetInstance()
	local var_6_1 = var_1.STimeDescS(var_6_0, var_1:GetServerTime(), "*t")

	Clone = var_6_0

	local var_6_2 = var_6_0(var_6_1)

	var_6_2.month = arg_6_0.id

	if var_6_2.month >= 12 then
		var_6_2.month = 0
		var_6_2.year = var_6_2.year + 1
	end

	var_6_2.month = var_6_2.month + 1
	var_6_2.day = 0
	os = var_4

	local var_6_3 = var_4.date
	local var_6_4 = "%d"

	os = var_1_10006

	local var_6_5 = var_6_3(var_6_4, var_1_10006.time(var_6_2)) - var_6_1.day + 1

	math = var_6

	return (var_6.max(var_6_5, 1))
end

function var_0_1.GetRestTime(arg_7_0)
	if not arg_7_0.id then
		return 0
	end

	pg = var_1

	local var_7_0 = var_1.TimeMgr.GetInstance()
	local var_7_1 = var_1.STimeDescS(var_7_0, var_1:GetServerTime(), "*t")

	Clone = var_7_0

	local var_7_2 = var_7_0(var_7_1)

	var_7_2.month = arg_7_0.id

	if var_7_2.month >= 12 then
		var_7_2.month = 0
		var_7_2.year = var_7_2.year + 1
	end

	var_7_2.month = var_7_2.month + 1
	var_7_2.day = 0
	var_7_2.hour = 23
	var_7_2.min = 59
	var_7_2.sec = 59
	var_7_2.isdst = false
	os = var_4

	local var_7_3 = var_4.time(var_7_2)
	local var_7_4 = var_1
	local var_7_5 = var_7_3 - var_1.GetServerTime(var_7_4)

	math = var_7_4

	return (var_7_4.max(var_7_5, 0))
end

function var_0_1.getSortGoods(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_8_0, iter_8_1)
	end

	local function var_8_1(arg_9_0)
		math = var_2_10001

		return var_2_10001.floor(arg_9_0 * 0.1)
	end

	table = var_3

	var_3.sort(var_8_0, function(arg_10_0, arg_10_1)
		local var_10_0 = 100
		local var_10_1 = 1000
		local var_10_2 = arg_10_0:getConfig("order") + arg_10_0.id / 100000
		local var_10_3 = arg_10_1:getConfig("order") + arg_10_1.id / 100000

		getProxy = var_6
		CollectionProxy = var_7

		local var_10_4 = var_6(var_7)

		local function var_10_5(arg_11_0)
			local var_11_0 = arg_11_0:getConfig("commodity_id")
			local var_11_2

			if arg_11_0:isSham() then
				local var_11_1 = arg_11_0

				var_11_2 = arg_11_0.checkCommodityType
				DROP_TYPE_SHIP = var_3_10004

				if var_11_2(var_11_1, var_3_10004) then
					local var_11_3 = var_10_4

					var_11_2 = var_11_2.getShipGroup(var_11_3, var_8_1(var_11_0))
				end
			end

			return var_11_2
		end

		local function var_10_6(arg_12_0)
			return not arg_12_0:canPurchase()
		end

		var_10_2 = var_10_5(arg_10_0) and not var_10_6(arg_10_0) and var_10_2 + var_10_0 or var_10_2
		var_10_3 = var_10_5(arg_10_1) and not var_10_6(arg_10_1) and var_10_3 + var_10_0 or var_10_3
		var_10_2 = var_10_6(arg_10_0) and var_10_2 + var_10_1 or var_10_2
		var_10_3 = var_10_6(arg_10_1) and var_10_3 + var_10_1 or var_10_3

		return var_10_2 < var_10_3
	end)

	return var_8_0
end

function var_0_1.getGoodsCfg(arg_13_0, arg_13_1)
	pg = var_1_10002

	return var_1_10002.activity_shop_template[arg_13_1]
end

function var_0_1.getGoodsById(arg_14_0, arg_14_1)
	return arg_14_0.goods[arg_14_1]
end

function var_0_1.bindConfigTable(arg_15_0)
	pg = var_1_10001

	return var_1_10001.month_shop_template
end

return var_0_1
