local var_0_0 = class("ShoppingStreet", import(".BaseShop"))

function var_0_0.getRiseShopId(arg_1_0, arg_1_1)
	for iter_1_0, iter_1_1 in ipairs(pg.shop_template.all) do
		if pg.shop_template[iter_1_1].genre == arg_1_0 and arg_1_1 >= pg.shop_template[iter_1_1].limit_args[2] and arg_1_1 <= pg.shop_template[iter_1_1].limit_args[3] then
			return iter_1_1
		end
	end

	return
end

function var_0_0.Ctor(arg_2_0, arg_2_1)
	arg_2_0.level = arg_2_1.lv
	arg_2_0.configId = arg_2_0.level
	arg_2_0.nextFlashTime = arg_2_1.next_flash_time
	arg_2_0.levelUpTime = arg_2_1.lv_up_time
	arg_2_0.flashCount = arg_2_1.flash_count
	arg_2_0.goods = {}

	local var_2_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_SHOP_DISCOUNT)
	local var_2_1 = var_2_0 and not var_2_0:isEnd()

	for iter_2_0, iter_2_1 in ipairs(arg_2_1.goods_list) do
		local var_2_2 = Goods.Create(iter_2_1, Goods.TYPE_SHOPSTREET)

		var_2_2.activityDiscount = var_2_1

		table.insert(arg_2_0.goods, var_2_2)
	end

	arg_2_0.type = ShopArgs.ShopStreet

	return
end

function var_0_0.IsSameKind(arg_3_0, arg_3_1)
	return isa(arg_3_1, ShoppingStreet)
end

function var_0_0.GetCommodityById(arg_4_0, arg_4_1)
	return arg_4_0:getGoodsById(arg_4_1)
end

function var_0_0.GetCommodities(arg_5_0)
	return arg_5_0.goods
end

function var_0_0.bindConfigTable(arg_6_0)
	return pg.navalacademy_shoppingstreet_template
end

function var_0_0.resetflashCount(arg_7_0)
	arg_7_0.flashCount = 0

	return
end

function var_0_0.increaseFlashCount(arg_8_0)
	arg_8_0.flashCount = arg_8_0.flashCount + 1

	return
end

function var_0_0.isUpdateGoods(arg_9_0)
	if pg.TimeMgr.GetInstance():GetServerTime() >= arg_9_0.nextFlashTime then
		return true
	end

	return false
end

function var_0_0.getMaxLevel(arg_10_0)
	local var_10_0 = arg_10_0:bindConfigTable()

	return var_10_0.all[#var_10_0.all]
end

function var_0_0.isMaxLevel(arg_11_0)
	return arg_11_0:getMaxLevel() <= arg_11_0.level
end

function var_0_0.isUpgradeProcess(arg_12_0)
	local var_12_0 = pg.TimeMgr.GetInstance()

	return var_12_0:GetServerTime() < arg_12_0.levelUpTime
end

function var_0_0.isFinishUpgrade(arg_13_0)
	if pg.TimeMgr.GetInstance():GetServerTime() >= arg_13_0.levelUpTime then
		return true
	end

	return false
end

function var_0_0.getLevelUpTime(arg_14_0)
	return arg_14_0.levelUpTime
end

function var_0_0.updateLeftTime(arg_15_0)
	return arg_15_0.levelUpTime - pg.TimeMgr.GetInstance():GetServerTime()
end

function var_0_0.levelUp(arg_16_0)
	arg_16_0.levelUpTime = 0
	arg_16_0.level = math.min(arg_16_0.level + 1, #arg_16_0:bindConfigTable().all)

	if arg_16_0.level == arg_16_0.level then
		warning("商品街配置最大等级")
	end

	arg_16_0.configId = arg_16_0.level

	return
end

function var_0_0.setLevelUpTime(arg_17_0)
	arg_17_0.levelUpTime = getConfigFromLevel1(pg.navalacademy_shoppingstreet_template, arg_17_0.level).levelUpTime + pg.TimeMgr.GetInstance():GetServerTime()

	return
end

function var_0_0.getGoodsById(arg_18_0, arg_18_1)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.goods) do
		if arg_18_1 == iter_18_1.id then
			return iter_18_1
		end
	end

	return
end

function var_0_0.GetResList(arg_19_0)
	for iter_19_0, iter_19_1 in pairs(arg_19_0.goods) do
		({})[iter_19_1:getConfig("resource_type")] = true
	end

	for iter_19_2, iter_19_3 in pairs({}) do
		table.insert({}, iter_19_2)
	end

	return {}
end

return var_0_0
