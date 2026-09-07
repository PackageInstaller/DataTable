local GiftActCommodity = class("GiftActCommodity", import(".CommonCommodity"))

function GiftActCommodity:canPurchase()
	assert(self:getConfig("genre") == ShopArgs.GiftActPackage)

	local var_1_0 = self:getBindActivity()

	if not var_1_0 or var_1_0:isEnd() then
		return false
	end

	return (var_1_0.data1 or 0) < self:getLimitCount()
end

function GiftActCommodity:getBindActivity()
	assert(self:getConfig("genre") == ShopArgs.GiftActPackage)

	return getProxy(ActivityProxy):getActivityById((self:getDropInfo():getConfig("link_id")))
end

function GiftActCommodity:GetPrice()
	return GiftActCommodity.CalcPrice((self:getBindActivity()))
end

function GiftActCommodity:getLimitCount()
	local var_4_0 = self:getBindActivity()

	return switch(var_4_0:getConfig("type"), {
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

function GiftActCommodity:getBuyCount()
	local var_8_0 = self:getBindActivity()

	return (var_8_0 and not var_8_0:isEnd() or nil) and (var_8_0.data1 or 0)
end

function GiftActCommodity:isFree()
	return self:GetPrice() == 0
end

function GiftActCommodity:CalcPrice()
	return switch(self:getConfig("type"), {
		[ActivityConst.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
			local var_11_0 = 0
			local var_11_1 = 0

			for iter_11_0, iter_11_1 in ipairs(self:getConfig("config_data")[1]) do
				assert(pg.ship_skin_template[iter_11_1].shop_id and pg.ship_skin_template[iter_11_1].shop_id > 0)

				local var_11_2 = Goods.Create({
					shop_id = pg.ship_skin_template[iter_11_1].shop_id
				}, Goods.TYPE_SKIN)

				var_11_1 = var_11_1 + var_11_2:getConfig("resource_num")

				if not getProxy(ShipSkinProxy):hasNonLimitSkin(iter_11_1) then
					var_11_0 = var_11_0 + var_11_2:getConfig("resource_num")
				end
			end

			return var_11_0, (var_11_1 - var_11_0) * 100 / var_11_1, var_11_1
		end,
		[ActivityConst.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
			local var_12_0 = pg.activity_giftpackage[self:getConfig("config_id")]

			assert(var_12_0)

			return var_12_0.price, 0, var_12_0.price
		end
	}, function()
		assert(false)

		return
	end)
end

return GiftActCommodity
