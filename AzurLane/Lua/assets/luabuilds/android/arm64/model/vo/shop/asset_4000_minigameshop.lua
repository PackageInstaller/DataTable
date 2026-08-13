class = var_0_10000

local var_0_0 = "MiniGameShop"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".BaseShop"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.goodsData = arg_1_1.goods
	arg_1_0.nextFlashTime = arg_1_1.next_flash_time
	arg_1_0.goods = {}
	ipairs = var_2
	pg = var_1_10004

	for iter_1_0, iter_1_1 in var_2(var_1_10004.gameroom_shop_template.all) do
		Goods = var_1_10007
		var_1_10007 = var_1_10007.Create
		pg = var_1_10009
		var_1_10009 = var_1_10009.gameroom_shop_template[iter_1_1]
		Goods = var_1_10010
		var_1_10007 = var_1_10007(var_1_10009, var_1_10010.TYPE_MINI_GAME)
		var_1_10010 = arg_1_0

		local var_1_0

		if not arg_1_0.getGoodData(var_1_10010, iter_1_1) then
			var_1_0 = 0
		end

		var_1_10007:UpdateCnt(var_1_0)

		var_1_10009 = arg_1_0.goods
		var_1_10009[var_1_10007:getId()] = var_1_10007
	end

	ShopArgs = var_2
	arg_1_0.type = var_2.ShopMiniGame

	return
end

function var_0_1.setNextTime(arg_2_0, arg_2_1)
	arg_2_0.nextFlashTime = arg_2_1
	ipairs = var_1_10002

	for iter_2_0, iter_2_1 in var_1_10002(arg_2_0.goodsData) do
		local var_2_0 = iter_2_1.id
		local var_2_1 = false

		pg = var_1_10009

		if var_1_10009.gameroom_shop_template[var_2_0] then
			pg = var_1_10009
			var_2_1 = var_1_10009.gameroom_shop_template[var_2_0].month_re ~= 0
		else
			warning = var_1_10009

			local var_2_2 = "gameroom_shop_template 不存在 id = "

			tostring = var_1_10012

			var_1_10009(var_2_2 .. var_1_10012(var_2_0) .. "的物品")
		end

		if var_2_1 then
			var_1_10009 = arg_2_0.goodsData[iter_2_0]
			var_1_10009.count = 0
		end
	end

	return
end

function var_0_1.checkShopFlash(arg_3_0)
	pg = var_1_10001

	local var_3_0 = var_1_10001.TimeMgr.GetInstance()
	local var_3_1 = var_1.GetServerTime(var_3_0)

	if arg_3_0.nextFlashTime and arg_3_0.nextFlashTime > 0 then
		return var_3_1 > arg_3_0.nextFlashTime
	end

	return false
end

function var_0_1.getGoodData(arg_4_0, arg_4_1)
	ipairs = var_1_10002

	for iter_4_0, iter_4_1 in var_1_10002(arg_4_0.goodsData) do
		if iter_4_1 and iter_4_1.id == arg_4_1 then
			return iter_4_1.count
		end
	end

	return
end

function var_0_1.consume(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = arg_5_0.goods[arg_5_1]

	var_3.UpdateCnt(var_5_0, arg_5_2)

	return
end

function var_0_1.IsSameKind(arg_6_0, arg_6_1)
	isa = var_1_10002

	local var_6_0 = arg_6_1

	MiniGameShop = var_1_10005

	return var_1_10002(var_6_0, var_1_10005)
end

function var_0_1.GetCommodityById(arg_7_0, arg_7_1)
	return arg_7_0:getGoodsById(arg_7_1)
end

function var_0_1.GetCommodities(arg_8_0)
	local var_8_0 = {}

	pairs = var_1_10002

	for iter_8_0, iter_8_1 in var_1_10002(arg_8_0.goods) do
		table = var_1_10007

		var_1_10007.insert(var_8_0, iter_8_1)
	end

	table = var_2

	var_2.sort(var_8_0, function(arg_9_0, arg_9_1)
		if (arg_9_0:CanPurchase() and 1 or 0) == (arg_9_1:CanPurchase() and 1 or 0) then
			if arg_9_0:getConfig("order") ~= arg_9_1:getConfig("order") then
				return arg_9_0:getConfig("order") < arg_9_1:getConfig("order")
			else
				return arg_9_0:getConfig("id") < arg_9_1:getConfig("id")
			end
		else
			return var_3 < var_2
		end

		return
	end)

	return var_8_0
end

function var_0_1.bindConfigTable(arg_10_0)
	return nil
end

function var_0_1.getRefreshCount(arg_11_0)
	return arg_11_0.refreshCount
end

function var_0_1.resetRefreshCount(arg_12_0)
	arg_12_0.refreshCount = 1

	return
end

function var_0_1.increaseRefreshCount(arg_13_0)
	arg_13_0.refreshCount = arg_13_0.refreshCount + 1

	return
end

function var_0_1.updateAllGoods(arg_14_0, arg_14_1)
	arg_14_0.goods = arg_14_1

	return
end

function var_0_1.getGoodsById(arg_15_0, arg_15_1)
	assert = var_1_10002

	var_1_10002(arg_15_0.goods[arg_15_1], "should exist good" .. arg_15_1)

	Clone = var_1_10002

	return var_1_10002(arg_15_0.goods[arg_15_1])
end

function var_0_1.updateGoods(arg_16_0, arg_16_1)
	assert = var_1_10002

	var_1_10002(arg_16_0.goods[arg_16_1.id], "should exist good" .. arg_16_1.id)

	arg_16_0.goods[arg_16_1.id] = arg_16_1

	return
end

function var_0_1.GetResList(arg_17_0)
	return {
		12
	}
end

return var_0_1
