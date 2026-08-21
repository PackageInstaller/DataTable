local var_0_0 = class("GetOpeningUpShopCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	arg_1_0.shopsProxy = getProxy(ShopsProxy)
	arg_1_0.shopList = {}

	parallelAsync({
		function(arg_2_0)
			arg_1_0:GetStressShop(arg_2_0)

			return
		end,
		function(arg_3_0)
			arg_1_0:GetMilitaryShop(arg_3_0)

			return
		end,
		function(arg_4_0)
			arg_1_0:GetShamShop(arg_4_0)

			return
		end,
		function(arg_5_0)
			arg_1_0:GetFragmentShop(arg_5_0)

			return
		end,
		function(arg_6_0)
			arg_1_0:GetActivityShops(arg_6_0)

			return
		end,
		function(arg_7_0)
			arg_1_0:GetGuildShop(arg_7_0)

			return
		end,
		function(arg_8_0)
			arg_1_0:GetMedalShops(arg_8_0)

			return
		end,
		function(arg_9_0)
			arg_1_0:GetMetaShops(arg_9_0)

			return
		end,
		function(arg_10_0)
			arg_1_0:GetMiniShops(arg_10_0)

			return
		end,
		function(arg_11_0)
			arg_1_0:GetQuotaShop(arg_11_0)

			return
		end
	}, function()
		if var_1_1 then
			var_1_1(arg_1_0.shopList)
		end

		return
	end)

	return
end

function var_0_0.GetMilitaryShop(arg_13_0, arg_13_1)
	if not arg_13_0.shopsProxy:getMeritorousShop() then
		table.insert({}, function(arg_14_0)
			arg_13_0:sendNotification(GAME.GET_MILITARY_SHOP, {
				callback = arg_14_0
			})

			return
		end)
	else
		table.insert({}, function(arg_15_0)
			arg_15_0(var_0)

			return
		end)
	end

	table.insert({}, function(arg_16_0, arg_16_1)
		arg_13_0.shopList[ShopConst.TYPE_MILITARY_SHOP] = {}

		table.insert(arg_13_0.shopList[ShopConst.TYPE_MILITARY_SHOP], arg_16_1)
		arg_16_0()

		return
	end)
	seriesAsync({}, arg_13_1)

	return
end

function var_0_0.GetStressShop(arg_17_0, arg_17_1)
	if not arg_17_0.shopsProxy:getShopStreet() then
		table.insert({}, function(arg_18_0)
			arg_17_0:sendNotification(GAME.GET_SHOPSTREET, {
				callback = arg_18_0
			})

			return
		end)
	else
		table.insert({}, function(arg_19_0)
			arg_19_0(var_0)

			return
		end)
	end

	table.insert({}, function(arg_20_0, arg_20_1)
		arg_17_0.shopList[ShopConst.TYPE_SHOP_STREET] = {}

		table.insert(arg_17_0.shopList[ShopConst.TYPE_SHOP_STREET], arg_20_1)
		arg_20_0()

		return
	end)
	seriesAsync({}, arg_17_1)

	return
end

function var_0_0.GetGuildShop(arg_21_0, arg_21_1)
	if LOCK_GUILD_SHOP then
		arg_21_1()

		return
	end

	local var_21_0 = {}

	if not arg_21_0.shopsProxy:getGuildShop() then
		table.insert(var_21_0, function(arg_22_0)
			arg_21_0:sendNotification(GAME.GET_GUILD_SHOP, {
				type = GuildConst.GET_SHOP,
				callback = arg_22_0
			})

			return
		end)
	else
		table.insert(var_21_0, function(arg_23_0)
			arg_23_0(var_0)

			return
		end)
	end

	table.insert(var_21_0, function(arg_24_0, arg_24_1)
		arg_21_0.shopList[ShopConst.TYPE_GUILD] = {}

		table.insert(arg_21_0.shopList[ShopConst.TYPE_GUILD], arg_24_1)
		arg_24_0()

		return
	end)
	seriesAsync(var_21_0, arg_21_1)

	return
end

function var_0_0.GetShamShop(arg_25_0, arg_25_1)
	local var_25_0 = arg_25_0.shopsProxy:getShamShop()

	if not LOCK_SHAM_CHAPTER and var_25_0 and var_25_0:isOpen() then
		table.insert({}, function(arg_26_0)
			arg_25_0.shopList[ShopConst.TYPE_SHAM_SHOP] = {}

			table.insert(arg_25_0.shopList[ShopConst.TYPE_SHAM_SHOP], var_25_0)
			arg_26_0()

			return
		end)
	end

	seriesAsync({}, arg_25_1)

	return
end

function var_0_0.GetFragmentShop(arg_27_0, arg_27_1)
	local var_27_0 = arg_27_0.shopsProxy:getFragmentShop()

	if not LOCK_FRAGMENT_SHOP and var_27_0 and var_27_0:isOpen() then
		table.insert({}, function(arg_28_0)
			arg_27_0.shopList[ShopConst.TYPE_FRAGMENT] = {}

			table.insert(arg_27_0.shopList[ShopConst.TYPE_FRAGMENT], var_27_0)
			arg_28_0()

			return
		end)
	end

	seriesAsync({}, arg_27_1)

	return
end

function var_0_0.GetActivityShops(arg_29_0, arg_29_1)
	local var_29_0 = arg_29_0.shopsProxy:getActivityShops()

	if not var_29_0 or #var_29_0 == 0 then
		table.insert({}, function(arg_30_0)
			arg_29_0:sendNotification(GAME.GET_ACTIVITY_SHOP, {
				callback = arg_30_0
			})

			return
		end)
	else
		table.insert({}, function(arg_31_0)
			arg_31_0(var_29_0)

			return
		end)
	end

	table.insert({}, function(arg_32_0, arg_32_1)
		if arg_32_1 and table.getCount(arg_32_1) > 0 then
			arg_29_0.shopList[ShopConst.TYPE_ACTIVITY] = {}

			for iter_32_0, iter_32_1 in pairs(arg_32_1) do
				table.insert(arg_29_0.shopList[ShopConst.TYPE_ACTIVITY], iter_32_1)
			end

			local var_32_0 = getProxy(ActivityProxy):getRawData()

			table.sort(arg_29_0.shopList[ShopConst.TYPE_ACTIVITY], CompareFuncs({
				function(arg_33_0)
					return var_32_0[arg_33_0.activityId]:getStartTime()
				end
			}))
		end

		arg_32_0()

		return
	end)
	seriesAsync({}, arg_29_1)

	return
end

function var_0_0.GetMetaShops(arg_34_0, arg_34_1)
	if not arg_34_0.shopsProxy:GetMetaShop() then
		table.insert({}, function(arg_35_0)
			for iter_35_0, iter_35_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP_SELECTABLE))) do
				if iter_35_1 and not iter_35_1:isEnd() and iter_35_1:getConfig("config_id") == 1 then
					arg_34_0.shopsProxy:AddMetaShop((MetaShop.New(iter_35_1)))

					break
				end
			end

			arg_35_0(arg_34_0.shopsProxy:GetMetaShop())

			return
		end)
	else
		table.insert({}, function(arg_36_0)
			arg_36_0(var_0)

			return
		end)
	end

	table.insert({}, function(arg_37_0, arg_37_1)
		if arg_37_1 then
			arg_34_0.shopList[ShopConst.TYPE_META] = {}

			table.insert(arg_34_0.shopList[ShopConst.TYPE_META], arg_37_1)
		end

		arg_37_0()

		return
	end)
	seriesAsync({}, arg_34_1)

	return
end

function var_0_0.GetMedalShops(arg_38_0, arg_38_1)
	if not arg_38_0.shopsProxy:GetMedalShop() then
		table.insert({}, function(arg_39_0)
			arg_38_0:sendNotification(GAME.GET_MEDALSHOP, {
				callback = arg_39_0
			})

			return
		end)
	else
		table.insert({}, function(arg_40_0)
			arg_40_0(var_0)

			return
		end)
	end

	table.insert({}, function(arg_41_0, arg_41_1)
		if arg_41_1 then
			arg_38_0.shopList[ShopConst.TYPE_MEDAL] = {}

			table.insert(arg_38_0.shopList[ShopConst.TYPE_MEDAL], arg_41_1)
		end

		arg_41_0()

		return
	end)
	seriesAsync({}, arg_38_1)

	return
end

function var_0_0.GetMiniShops(arg_42_0, arg_42_1)
	if LOCK_MINIGAME_HALL then
		if arg_42_1 then
			arg_42_1()
		end

		return
	end

	local var_42_0 = {}

	if not arg_42_0.shopsProxy:getMiniShop() then
		table.insert(var_42_0, function(arg_43_0)
			arg_42_0:sendNotification(GAME.GET_MINI_GAME_SHOP, {
				callback = arg_43_0
			})

			return
		end)
	else
		table.insert(var_42_0, function(arg_44_0)
			if var_0:checkShopFlash() then
				arg_42_0:sendNotification(GAME.MINI_GAME_SHOP_FLUSH, {
					callback = arg_44_0
				})
			else
				arg_44_0(var_0)
			end

			return
		end)
	end

	table.insert(var_42_0, function(arg_45_0, arg_45_1)
		arg_42_0.shopList[ShopConst.TYPE_MINI_GAME] = {}

		table.insert(arg_42_0.shopList[ShopConst.TYPE_MINI_GAME], arg_45_1)
		arg_45_0()

		return
	end)
	seriesAsync(var_42_0, arg_42_1)

	return
end

function var_0_0.GetQuotaShop(arg_46_0, arg_46_1)
	if LOCK_QUOTA_SHOP then
		arg_46_1()

		return
	end

	local var_46_0 = {}
	local var_46_1 = arg_46_0.shopsProxy:getQuotaShop()

	if not var_46_1 then
		var_46_1 = QuotaShop.New()

		arg_46_0.shopsProxy:setQuotaShop(var_46_1)
	else
		table.insert(var_46_0, function(arg_47_0)
			arg_47_0(var_46_1)

			return
		end)
	end

	table.insert(var_46_0, function(arg_48_0)
		arg_46_0.shopList[ShopConst.TYPE_QUOTA] = {}

		table.insert(arg_46_0.shopList[ShopConst.TYPE_QUOTA], var_46_1)
		arg_48_0()

		return
	end)
	seriesAsync(var_46_0, arg_46_1)

	return
end

return var_0_0
