local var_0_0 = class("GiftActCommodity", import(".CommonCommodity"))

function var_0_0.canPurchase(arg_1_0)
	assert(arg_1_0:getConfig("genre") == ShopArgs.GiftActPackage)

	local var_1_0 = arg_1_0:getBindActivity()

	if not var_1_0 or var_1_0:isEnd() then
		return false
	end

	local var_1_1 = var_1_0.data1 or 0

	return var_1_1 < arg_1_0:getLimitCount()
end

function var_0_0.getBindActivity(arg_2_0)
	assert(arg_2_0:getConfig("genre") == ShopArgs.GiftActPackage)

	return getProxy(ActivityProxy):getActivityById((arg_2_0:getDropInfo():getConfig("link_id")))
end

function var_0_0.GetPrice(arg_3_0)
	return var_0_0.CalcPrice((arg_3_0:getBindActivity()))
end

function var_0_0.getLimitCount(arg_4_0)
	local var_4_0 = arg_4_0:getBindActivity()

	return switch(arg_4_0:getBindActivity():getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
			return 1
		end,
		[ActivityConst.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
			local var_6_0 = pg.activity_giftpackage[var_4_0:getConfig("config_id")]

			assert(var_6_0)

			local var_6_1 = var_4_0.data1 or 0
			local var_6_2 = getProxy(ShipSkinProxy)

			for iter_6_0, iter_6_1 in ipairs(var_6_0.skin) do
				if not var_6_2:hasNonLimitSkin(iter_6_1) then
					var_6_1 = var_6_1 + 1
				end
			end

			return math.min(var_6_1, var_6_0.limit_count)
		end
	}, function()
		assert(false)

		return
	end)
end

function var_0_0.getBuyCount(arg_8_0)
	local var_8_0 = arg_8_0:getBindActivity()

	if var_8_0 and not var_8_0:isEnd() then
		return var_8_0.data1 or 0
	end
end

function var_0_0.isFree(arg_9_0)
	return arg_9_0:GetPrice() == 0
end

function var_0_0.CalcPrice(arg_10_0)
	return switch(arg_10_0:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
			local var_11_0 = 0
			local var_11_1 = 0

			for iter_11_0, iter_11_1 in ipairs(arg_10_0:getConfig("config_data")[1]) do
				assert(pg.ship_skin_template[iter_11_1].shop_id and pg.ship_skin_template[iter_11_1].shop_id > 0)

				local var_11_2 = Goods.Create({
					shop_id = pg.ship_skin_template[iter_11_1].shop_id
				}, Goods.TYPE_SKIN)

				var_11_1 = var_11_1 + var_11_2:getConfig("resource_num")

				local var_11_3 = getProxy(ShipSkinProxy)

				if not var_11_3:hasNonLimitSkin(iter_11_1) then
					var_11_0 = var_11_0 + var_11_2:getConfig("resource_num")
				end
			end

			return var_11_0, (var_11_1 - var_11_0) * 100 / var_11_1, var_11_1
		end,
		[ActivityConst.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
			local var_12_0 = pg.activity_giftpackage[arg_10_0:getConfig("config_id")]

			assert(var_12_0)

			return var_12_0.price, 0, var_12_0.price
		end
	}, function()
		assert(false)

		return
	end)
end

return var_0_0
