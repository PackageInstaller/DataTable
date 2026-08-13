class = var_0_10000

local var_0_0 = "GetOpeningUpShopCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1:getBody() and var_2.callback

	getProxy = var_1_10004
	ShopsProxy = var_1_10005
	arg_1_0.shopsProxy = var_1_10004(var_1_10005)
	arg_1_0.shopList = {}
	parallelAsync = var_4

	var_4({
		function(arg_2_0)
			local var_2_0 = arg_1_0

			var_1.GetStressShop(var_2_0, arg_2_0)

			return
		end,
		function(arg_3_0)
			local var_3_0 = arg_1_0

			var_1.GetMilitaryShop(var_3_0, arg_3_0)

			return
		end,
		function(arg_4_0)
			local var_4_0 = arg_1_0

			var_1.GetShamShop(var_4_0, arg_4_0)

			return
		end,
		function(arg_5_0)
			local var_5_0 = arg_1_0

			var_1.GetFragmentShop(var_5_0, arg_5_0)

			return
		end,
		function(arg_6_0)
			local var_6_0 = arg_1_0

			var_1.GetActivityShops(var_6_0, arg_6_0)

			return
		end,
		function(arg_7_0)
			local var_7_0 = arg_1_0

			var_1.GetGuildShop(var_7_0, arg_7_0)

			return
		end,
		function(arg_8_0)
			local var_8_0 = arg_1_0

			var_1.GetMedalShops(var_8_0, arg_8_0)

			return
		end,
		function(arg_9_0)
			local var_9_0 = arg_1_0

			var_1.GetMetaShops(var_9_0, arg_9_0)

			return
		end,
		function(arg_10_0)
			local var_10_0 = arg_1_0

			var_1.GetMiniShops(var_10_0, arg_10_0)

			return
		end,
		function(arg_11_0)
			local var_11_0 = arg_1_0

			var_1.GetQuotaShop(var_11_0, arg_11_0)

			return
		end
	}, function()
		if var_1_0 then
			var_1_0(arg_1_0.shopList)
		end

		return
	end)

	return
end

function var_0_1.GetMilitaryShop(arg_13_0, arg_13_1)
	local var_13_0 = {}
	local var_13_1 = arg_13_0.shopsProxy

	if not var_3.getMeritorousShop(var_13_1) then
		table = var_13_1

		var_13_1.insert(var_13_0, function(arg_14_0)
			local var_14_0 = arg_13_0
			local var_14_1 = var_1.sendNotification

			GAME = var_2_10003

			var_14_1(var_14_0, var_2_10003.GET_MILITARY_SHOP, {
				callback = arg_14_0
			})

			return
		end)
	else
		table = var_13_1

		var_13_1.insert(var_13_0, function(arg_15_0)
			arg_15_0(var_0)

			return
		end)
	end

	table = var_13_1

	var_13_1.insert(var_13_0, function(arg_16_0, arg_16_1)
		local var_16_0 = arg_13_0.shopList

		ShopConst = var_2_10003
		var_16_0[var_2_10003.TYPE_MILITARY_SHOP] = {}
		table = var_16_0

		local var_16_1 = var_16_0.insert
		local var_16_2 = arg_13_0.shopList

		ShopConst = var_4

		var_16_1(var_16_2[var_4.TYPE_MILITARY_SHOP], arg_16_1)
		arg_16_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_13_0, arg_13_1)

	return
end

function var_0_1.GetStressShop(arg_17_0, arg_17_1)
	local var_17_0 = {}
	local var_17_1 = arg_17_0.shopsProxy

	if not var_3.getShopStreet(var_17_1) then
		table = var_17_1

		var_17_1.insert(var_17_0, function(arg_18_0)
			local var_18_0 = arg_17_0
			local var_18_1 = var_1.sendNotification

			GAME = var_2_10003

			var_18_1(var_18_0, var_2_10003.GET_SHOPSTREET, {
				callback = arg_18_0
			})

			return
		end)
	else
		table = var_17_1

		var_17_1.insert(var_17_0, function(arg_19_0)
			arg_19_0(var_0)

			return
		end)
	end

	table = var_17_1

	var_17_1.insert(var_17_0, function(arg_20_0, arg_20_1)
		local var_20_0 = arg_17_0.shopList

		ShopConst = var_2_10003
		var_20_0[var_2_10003.TYPE_SHOP_STREET] = {}
		table = var_20_0

		local var_20_1 = var_20_0.insert
		local var_20_2 = arg_17_0.shopList

		ShopConst = var_4

		var_20_1(var_20_2[var_4.TYPE_SHOP_STREET], arg_20_1)
		arg_20_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_17_0, arg_17_1)

	return
end

function var_0_1.GetGuildShop(arg_21_0, arg_21_1)
	LOCK_GUILD_SHOP = var_1_10002

	if var_1_10002 then
		arg_21_1()

		return
	end

	local var_21_0 = {}
	local var_21_1 = arg_21_0.shopsProxy

	if not var_3.getGuildShop(var_21_1) then
		table = var_21_1

		var_21_1.insert(var_21_0, function(arg_22_0)
			local var_22_0 = arg_21_0
			local var_22_1 = var_1.sendNotification

			GAME = var_2_10003

			local var_22_2 = var_2_10003.GET_GUILD_SHOP
			local var_22_3 = {}

			GuildConst = var_2_10005
			var_22_3.type = var_2_10005.GET_SHOP
			var_22_3.callback = arg_22_0

			var_22_1(var_22_0, var_22_2, var_22_3)

			return
		end)
	else
		table = var_21_1

		var_21_1.insert(var_21_0, function(arg_23_0)
			arg_23_0(var_0)

			return
		end)
	end

	table = var_21_1

	var_21_1.insert(var_21_0, function(arg_24_0, arg_24_1)
		local var_24_0 = arg_21_0.shopList

		ShopConst = var_2_10003
		var_24_0[var_2_10003.TYPE_GUILD] = {}
		table = var_24_0

		local var_24_1 = var_24_0.insert
		local var_24_2 = arg_21_0.shopList

		ShopConst = var_4

		var_24_1(var_24_2[var_4.TYPE_GUILD], arg_24_1)
		arg_24_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_21_0, arg_21_1)

	return
end

function var_0_1.GetShamShop(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = arg_25_0.shopsProxy
	local var_25_2 = var_3.getShamShop(var_25_1)

	LOCK_SHAM_CHAPTER = var_25_1

	if not var_25_1 and var_25_2 and var_25_2:isOpen() then
		table = var_25_1

		var_25_1.insert(var_25_0, function(arg_26_0)
			local var_26_0 = arg_25_0.shopList

			ShopConst = var_2_10002
			var_26_0[var_2_10002.TYPE_SHAM_SHOP] = {}
			table = var_26_0

			local var_26_1 = var_26_0.insert
			local var_26_2 = arg_25_0.shopList

			ShopConst = var_3

			var_26_1(var_26_2[var_3.TYPE_SHAM_SHOP], var_25_2)
			arg_26_0()

			return
		end)
	end

	seriesAsync = var_25_1

	var_25_1(var_25_0, arg_25_1)

	return
end

function var_0_1.GetFragmentShop(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = arg_27_0.shopsProxy
	local var_27_2 = var_3.getFragmentShop(var_27_1)

	LOCK_FRAGMENT_SHOP = var_27_1

	if not var_27_1 and var_27_2 and var_27_2:isOpen() then
		table = var_27_1

		var_27_1.insert(var_27_0, function(arg_28_0)
			local var_28_0 = arg_27_0.shopList

			ShopConst = var_2_10002
			var_28_0[var_2_10002.TYPE_FRAGMENT] = {}
			table = var_28_0

			local var_28_1 = var_28_0.insert
			local var_28_2 = arg_27_0.shopList

			ShopConst = var_3

			var_28_1(var_28_2[var_3.TYPE_FRAGMENT], var_27_2)
			arg_28_0()

			return
		end)
	end

	seriesAsync = var_27_1

	var_27_1(var_27_0, arg_27_1)

	return
end

function var_0_1.GetActivityShops(arg_29_0, arg_29_1)
	local var_29_0 = {}
	local var_29_1 = arg_29_0.shopsProxy

	if not var_3.getActivityShops(var_29_1) or #var_3 == 0 then
		table = var_29_1

		var_29_1.insert(var_29_0, function(arg_30_0)
			local var_30_0 = arg_29_0
			local var_30_1 = var_1.sendNotification

			GAME = var_2_10003

			var_30_1(var_30_0, var_2_10003.GET_ACTIVITY_SHOP, {
				callback = arg_30_0
			})

			return
		end)
	else
		table = var_29_1

		var_29_1.insert(var_29_0, function(arg_31_0)
			arg_31_0(var_0)

			return
		end)
	end

	table = var_29_1

	var_29_1.insert(var_29_0, function(arg_32_0, arg_32_1)
		if arg_32_1 then
			table = var_2_10002

			local var_32_0 = var_2_10002.getCount(arg_32_1)

			if 0 < var_32_0 then
				local var_32_1 = arg_29_0.shopList

				ShopConst = var_3
				var_32_1[var_3.TYPE_ACTIVITY] = {}
				pairs = var_32_1

				for iter_32_0, iter_32_1 in var_32_1(arg_32_1) do
					table = var_2_10007
					var_2_10007 = var_2_10007.insert

					local var_32_2 = arg_29_0.shopList

					ShopConst = var_2_10009

					var_2_10007(var_32_2[var_2_10009.TYPE_ACTIVITY], iter_32_1)
				end

				getProxy = var_2
				ActivityProxy = var_3

				local var_32_3 = var_2(var_3)
				local var_32_4 = var_2.getRawData(var_32_3)

				table = var_32_3

				local var_32_5 = var_32_3.sort
				local var_32_6 = arg_29_0.shopList

				ShopConst = iter_32_0

				local var_32_7 = var_32_6[iter_32_0.TYPE_ACTIVITY]

				CompareFuncs = var_5

				var_32_5(var_32_7, var_5({
					function(arg_33_0)
						local var_33_0 = var_32_4[arg_33_0.activityId]

						return var_1.getStartTime(var_33_0)
					end
				}))
			end
		end

		arg_32_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_29_0, arg_29_1)

	return
end

function var_0_1.GetMetaShops(arg_34_0, arg_34_1)
	local var_34_0 = {}
	local var_34_1 = arg_34_0.shopsProxy

	if not var_3.GetMetaShop(var_34_1) then
		table = var_34_1

		var_34_1.insert(var_34_0, function(arg_35_0)
			getProxy = var_2_10001
			ActivityProxy = var_2_10002

			local var_35_0 = var_2_10001(var_2_10002)
			local var_35_1 = var_1.getActivitiesByType

			ActivityConst = var_2_10003

			local var_35_2 = var_35_1(var_35_0, var_2_10003.ACTIVITY_TYPE_SHOP_SELECTABLE)

			ipairs = var_35_0

			for iter_35_0, iter_35_1 in var_35_0(var_35_2) do
				if iter_35_1 and not iter_35_1:isEnd() and iter_35_1:getConfig("config_id") == 1 then
					MetaShop = var_7

					local var_35_3 = var_7.New(iter_35_1)
					local var_35_4 = arg_34_0.shopsProxy

					var_8.AddMetaShop(var_35_4, var_35_3)

					break
				end
			end

			local var_35_5 = arg_35_0
			local var_35_6 = arg_34_0.shopsProxy

			var_35_5(var_3.GetMetaShop(var_35_6))

			return
		end)
	else
		table = var_34_1

		var_34_1.insert(var_34_0, function(arg_36_0)
			arg_36_0(var_0)

			return
		end)
	end

	table = var_34_1

	var_34_1.insert(var_34_0, function(arg_37_0, arg_37_1)
		if arg_37_1 then
			local var_37_0 = arg_34_0.shopList

			ShopConst = var_2_10003
			var_37_0[var_2_10003.TYPE_META] = {}
			table = var_37_0

			local var_37_1 = var_37_0.insert
			local var_37_2 = arg_34_0.shopList

			ShopConst = var_4

			var_37_1(var_37_2[var_4.TYPE_META], arg_37_1)
		end

		arg_37_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_34_0, arg_34_1)

	return
end

function var_0_1.GetMedalShops(arg_38_0, arg_38_1)
	local var_38_0 = {}
	local var_38_1 = arg_38_0.shopsProxy

	if not var_3.GetMedalShop(var_38_1) then
		table = var_38_1

		var_38_1.insert(var_38_0, function(arg_39_0)
			local var_39_0 = arg_38_0
			local var_39_1 = var_1.sendNotification

			GAME = var_2_10003

			var_39_1(var_39_0, var_2_10003.GET_MEDALSHOP, {
				callback = arg_39_0
			})

			return
		end)
	else
		table = var_38_1

		var_38_1.insert(var_38_0, function(arg_40_0)
			arg_40_0(var_0)

			return
		end)
	end

	table = var_38_1

	var_38_1.insert(var_38_0, function(arg_41_0, arg_41_1)
		if arg_41_1 then
			local var_41_0 = arg_38_0.shopList

			ShopConst = var_2_10003
			var_41_0[var_2_10003.TYPE_MEDAL] = {}
			table = var_41_0

			local var_41_1 = var_41_0.insert
			local var_41_2 = arg_38_0.shopList

			ShopConst = var_4

			var_41_1(var_41_2[var_4.TYPE_MEDAL], arg_41_1)
		end

		arg_41_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_38_0, arg_38_1)

	return
end

function var_0_1.GetMiniShops(arg_42_0, arg_42_1)
	LOCK_MINIGAME_HALL = var_1_10002

	if var_1_10002 then
		if arg_42_1 then
			arg_42_1()
		end

		return
	end

	local var_42_0 = {}
	local var_42_1 = arg_42_0.shopsProxy

	if not var_3.getMiniShop(var_42_1) then
		table = var_42_1

		var_42_1.insert(var_42_0, function(arg_43_0)
			local var_43_0 = arg_42_0
			local var_43_1 = var_1.sendNotification

			GAME = var_2_10003

			var_43_1(var_43_0, var_2_10003.GET_MINI_GAME_SHOP, {
				callback = arg_43_0
			})

			return
		end)
	else
		table = var_42_1

		var_42_1.insert(var_42_0, function(arg_44_0)
			local var_44_0 = var_0

			if var_1.checkShopFlash(var_44_0) then
				local var_44_1 = arg_42_0
				local var_44_2 = var_1.sendNotification

				GAME = var_2_10003

				var_44_2(var_44_1, var_2_10003.MINI_GAME_SHOP_FLUSH, {
					callback = arg_44_0
				})
			else
				arg_44_0(var_0)
			end

			return
		end)
	end

	table = var_42_1

	var_42_1.insert(var_42_0, function(arg_45_0, arg_45_1)
		local var_45_0 = arg_42_0.shopList

		ShopConst = var_2_10003
		var_45_0[var_2_10003.TYPE_MINI_GAME] = {}
		table = var_45_0

		local var_45_1 = var_45_0.insert
		local var_45_2 = arg_42_0.shopList

		ShopConst = var_4

		var_45_1(var_45_2[var_4.TYPE_MINI_GAME], arg_45_1)
		arg_45_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_42_0, arg_42_1)

	return
end

function var_0_1.GetQuotaShop(arg_46_0, arg_46_1)
	LOCK_QUOTA_SHOP = var_1_10002

	if var_1_10002 then
		arg_46_1()

		return
	end

	local var_46_0 = {}
	local var_46_1 = arg_46_0.shopsProxy
	local var_46_2

	if not var_3.getQuotaShop(var_46_1) then
		QuotaShop = var_46_1
		var_46_2 = var_46_1.New()

		local var_46_3 = arg_46_0.shopsProxy

		var_46_1.setQuotaShop(var_46_3, var_46_2)
	else
		table = var_46_1

		var_46_1.insert(var_46_0, function(arg_47_0)
			arg_47_0(var_46_2)

			return
		end)
	end

	table = var_46_1

	var_46_1.insert(var_46_0, function(arg_48_0)
		local var_48_0 = arg_46_0.shopList

		ShopConst = var_2_10002
		var_48_0[var_2_10002.TYPE_QUOTA] = {}
		table = var_48_0

		local var_48_1 = var_48_0.insert
		local var_48_2 = arg_46_0.shopList

		ShopConst = var_3

		var_48_1(var_48_2[var_3.TYPE_QUOTA], var_46_2)
		arg_48_0()

		return
	end)

	seriesAsync = var_4

	var_4(var_46_0, arg_46_1)

	return
end

return var_0_1
