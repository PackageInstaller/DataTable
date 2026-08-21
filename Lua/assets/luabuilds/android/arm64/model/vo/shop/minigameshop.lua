local var_0_0 = class("MiniGameShop", import(".BaseShop"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.goodsData = arg_1_1.goods
	arg_1_0.nextFlashTime = arg_1_1.next_flash_time
	arg_1_0.goods = {}

	for iter_1_0, iter_1_1 in ipairs(pg.gameroom_shop_template.all) do
		local var_1_0 = Goods.Create(pg.gameroom_shop_template[iter_1_1], Goods.TYPE_MINI_GAME)
		local var_1_1 = arg_1_0:getGoodData(iter_1_1) or 0

		var_1_0:UpdateCnt(var_1_1)

		arg_1_0.goods[var_1_0:getId()] = var_1_0
	end

	arg_1_0.type = ShopArgs.ShopMiniGame

	return
end

function var_0_0.setNextTime(arg_2_0, arg_2_1)
	arg_2_0.nextFlashTime = arg_2_1

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.goodsData) do
		local var_2_0 = false

		if pg.gameroom_shop_template[iter_2_1.id] then
			var_2_0 = pg.gameroom_shop_template[iter_2_1.id].month_re ~= 0
		else
			warning("gameroom_shop_template 不存在 id = " .. tostring(iter_2_1.id) .. "的物品")
		end

		if var_2_0 then
			arg_2_0.goodsData[iter_2_0].count = 0
		end
	end

	return
end

function var_0_0.checkShopFlash(arg_3_0)
	local var_3_0 = pg.TimeMgr.GetInstance():GetServerTime()

	if arg_3_0.nextFlashTime and arg_3_0.nextFlashTime > 0 then
		return var_3_0 > arg_3_0.nextFlashTime
	end

	return false
end

function var_0_0.getGoodData(arg_4_0, arg_4_1)
	for iter_4_0, iter_4_1 in ipairs(arg_4_0.goodsData) do
		if iter_4_1 and iter_4_1.id == arg_4_1 then
			return iter_4_1.count
		end
	end

	return
end

function var_0_0.consume(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0.goods[arg_5_1]:UpdateCnt(arg_5_2)

	return
end

function var_0_0.IsSameKind(arg_6_0, arg_6_1)
	return isa(arg_6_1, MiniGameShop)
end

function var_0_0.GetCommodityById(arg_7_0, arg_7_1)
	return arg_7_0:getGoodsById(arg_7_1)
end

function var_0_0.GetCommodities(arg_8_0)
	for iter_8_0, iter_8_1 in pairs(arg_8_0.goods) do
		table.insert({}, iter_8_1)
	end

	table.sort({}, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0:CanPurchase() and 1 or 0
		local var_9_1 = arg_9_1:CanPurchase() and 1 or 0

		if var_9_0 == var_9_1 then
			if arg_9_0:getConfig("order") ~= arg_9_1:getConfig("order") then
				return arg_9_0:getConfig("order") < arg_9_1:getConfig("order")
			else
				return arg_9_0:getConfig("id") < arg_9_1:getConfig("id")
			end
		else
			return var_9_1 < var_9_0
		end

		return
	end)

	return {}
end

function var_0_0.bindConfigTable(arg_10_0)
	return nil
end

function var_0_0.getRefreshCount(arg_11_0)
	return arg_11_0.refreshCount
end

function var_0_0.resetRefreshCount(arg_12_0)
	arg_12_0.refreshCount = 1

	return
end

function var_0_0.increaseRefreshCount(arg_13_0)
	arg_13_0.refreshCount = arg_13_0.refreshCount + 1

	return
end

function var_0_0.updateAllGoods(arg_14_0, arg_14_1)
	arg_14_0.goods = arg_14_1

	return
end

function var_0_0.getGoodsById(arg_15_0, arg_15_1)
	assert(arg_15_0.goods[arg_15_1], "should exist good" .. arg_15_1)

	return Clone(arg_15_0.goods[arg_15_1])
end

function var_0_0.updateGoods(arg_16_0, arg_16_1)
	assert(arg_16_0.goods[arg_16_1.id], "should exist good" .. arg_16_1.id)

	arg_16_0.goods[arg_16_1.id] = arg_16_1

	return
end

function var_0_0.GetResList(arg_17_0)
	return {
		12
	}
end

return var_0_0
