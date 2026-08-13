class = var_0_10000

local var_0_0 = "ShoppingStreet"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseShop"))

function var_0_1.getRiseShopId(arg_1_0, arg_1_1)
	ipairs = var_1_10002
	pg = var_1_10003

	for iter_1_0, iter_1_1 in var_1_10002(var_1_10003.shop_template.all) do
		pg = var_1_10007

		if var_1_10007.shop_template[iter_1_1].genre == arg_1_0 and arg_1_1 >= var_1_10007.limit_args[2] and arg_1_1 <= var_1_10007.limit_args[3] then
			return iter_1_1
		end
	end

	return
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	arg_2_0.level = arg_2_1.lv
	arg_2_0.configId = arg_2_0.level
	arg_2_0.nextFlashTime = arg_2_1.next_flash_time
	arg_2_0.levelUpTime = arg_2_1.lv_up_time
	arg_2_0.flashCount = arg_2_1.flash_count
	arg_2_0.goods = {}
	getProxy = var_2
	ActivityProxy = var_1_10003

	local var_2_0 = var_2(var_1_10003)
	local var_2_1 = var_2.getActivityByType

	ActivityConst = var_1_10004

	local var_2_2, var_2_3

	if var_2_1(var_2_0, var_1_10004.ACTIVITY_TYPE_SHOP_DISCOUNT) then
		::label_2_0::

		var_2_2 = var_2
		var_2_3 = not var_2.isEnd(var_2_2)
	end

	ipairs = var_2_2

	for iter_2_0, iter_2_1 in var_2_2(arg_2_1.goods_list) do
		Goods = var_1_10009
		var_1_10009 = var_1_10009.Create

		local var_2_4 = iter_2_1

		Goods = var_1_10011
		var_1_10009 = var_1_10009(var_2_4, var_1_10011.TYPE_SHOPSTREET)
		var_1_10009.activityDiscount = var_2_3
		table = var_2_4

		var_2_4.insert(arg_2_0.goods, var_1_10009)
	end

	ShopArgs = var_4
	arg_2_0.type = var_4.ShopStreet

	return
end

function var_0_1.IsSameKind(arg_3_0, arg_3_1)
	isa = var_1_10002

	local var_3_0 = arg_3_1

	ShoppingStreet = var_1_10004

	return var_1_10002(var_3_0, var_1_10004)
end

function var_0_1.GetCommodityById(arg_4_0, arg_4_1)
	return arg_4_0:getGoodsById(arg_4_1)
end

function var_0_1.GetCommodities(arg_5_0)
	return arg_5_0.goods
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.navalacademy_shoppingstreet_template
end

function var_0_1.resetflashCount(arg_7_0)
	arg_7_0.flashCount = 0

	return
end

function var_0_1.increaseFlashCount(arg_8_0)
	arg_8_0.flashCount = arg_8_0.flashCount + 1

	return
end

function var_0_1.isUpdateGoods(arg_9_0)
	pg = var_1_10001

	local var_9_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetServerTime(var_9_0) >= arg_9_0.nextFlashTime then
		return true
	end

	return false
end

function var_0_1.getMaxLevel(arg_10_0)
	return arg_10_0:bindConfigTable().all[#var_1.all]
end

function var_0_1.isMaxLevel(arg_11_0)
	return arg_11_0:getMaxLevel() <= arg_11_0.level
end

function var_0_1.isUpgradeProcess(arg_12_0)
	pg = var_1_10001

	local var_12_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetServerTime(var_12_0) < arg_12_0.levelUpTime
end

function var_0_1.isFinishUpgrade(arg_13_0)
	pg = var_1_10001

	local var_13_0 = var_1_10001.TimeMgr.GetInstance()

	if var_1.GetServerTime(var_13_0) >= arg_13_0.levelUpTime then
		return true
	end

	return false
end

function var_0_1.getLevelUpTime(arg_14_0)
	return arg_14_0.levelUpTime
end

function var_0_1.updateLeftTime(arg_15_0)
	pg = var_1_10001

	local var_15_0 = var_1_10001.TimeMgr.GetInstance()
	local var_15_1 = var_1.GetServerTime(var_15_0)

	return arg_15_0.levelUpTime - var_15_1
end

function var_0_1.levelUp(arg_16_0)
	arg_16_0.levelUpTime = 0

	local var_16_0 = arg_16_0:bindConfigTable()
	local var_16_1 = arg_16_0.level

	math = var_1_10003
	arg_16_0.level = var_1_10003.min(arg_16_0.level + 1, #var_16_0.all)

	if var_16_1 == arg_16_0.level then
		warning = var_3

		var_3("商品街配置最大等级")
	end

	arg_16_0.configId = arg_16_0.level

	return
end

function var_0_1.setLevelUpTime(arg_17_0)
	pg = var_1_10001

	local var_17_0 = var_1_10001.TimeMgr.GetInstance()
	local var_17_1 = var_1.GetServerTime(var_17_0)

	getConfigFromLevel1 = var_17_0
	pg = var_1_10003
	arg_17_0.levelUpTime = var_17_0(var_1_10003.navalacademy_shoppingstreet_template, arg_17_0.level).levelUpTime + var_17_1

	return
end

function var_0_1.getGoodsById(arg_18_0, arg_18_1)
	ipairs = var_1_10002

	for iter_18_0, iter_18_1 in var_1_10002(arg_18_0.goods) do
		if arg_18_1 == iter_18_1.id then
			return iter_18_1
		end
	end

	return
end

function var_0_1.GetResList(arg_19_0)
	local var_19_0 = {}

	pairs = var_1_10002

	for iter_19_0, iter_19_1 in var_1_10002(arg_19_0.goods) do
		var_1_10008 = iter_19_1
		var_19_0[iter_19_1.getConfig(var_1_10008, "resource_type")] = true
	end

	local var_19_1 = {}

	pairs = var_3

	for iter_19_2, iter_19_3 in var_3(var_19_0) do
		table = var_1_10008

		var_1_10008.insert(var_19_1, iter_19_2)
	end

	return var_19_1
end

return var_0_1
