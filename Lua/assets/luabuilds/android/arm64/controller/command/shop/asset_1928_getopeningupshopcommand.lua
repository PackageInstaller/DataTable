local GetOpeningUpShopCommand = class("GetOpeningUpShopCommand", pm.SimpleCommand)

function GetOpeningUpShopCommand:execute(arg_1_1)
	local var_1_0 = arg_1_1:getBody()
	local var_1_1 = var_1_0 and var_1_0.callback

	self.shopsProxy = getProxy(ShopsProxy)
	self.shopList = {}

	parallelAsync({
		function(arg_2_0)
			self:GetStressShop(arg_2_0)

			return
		end,
		function(arg_3_0)
			self:GetMilitaryShop(arg_3_0)

			return
		end,
		function(arg_4_0)
			self:GetShamShop(arg_4_0)

			return
		end,
		function(arg_5_0)
			self:GetFragmentShop(arg_5_0)

			return
		end,
		function(arg_6_0)
			self:GetActivityShops(arg_6_0)

			return
		end,
		function(arg_7_0)
			self:GetGuildShop(arg_7_0)

			return
		end,
		function(arg_8_0)
			self:GetMedalShops(arg_8_0)

			return
		end,
		function(arg_9_0)
			self:GetMetaShops(arg_9_0)

			return
		end,
		function(arg_10_0)
			self:GetMiniShops(arg_10_0)

			return
		end,
		function(arg_11_0)
			self:GetQuotaShop(arg_11_0)

			return
		end
	}, function()
		if var_1_1 then
			var_1_1(self.shopList)
		end

		return
	end)

	return
end

function GetOpeningUpShopCommand:GetMilitaryShop(arg_13_1)
	local var_13_0 = {}
	local var_13_1 = self.shopsProxy:getMeritorousShop()

	if not var_13_1 then
		table.insert(var_13_0, function(arg_14_0)
			self:sendNotification(GAME.GET_MILITARY_SHOP, {
				callback = arg_14_0
			})

			return
		end)
	else
		table.insert(var_13_0, function(arg_15_0)
			arg_15_0(var_13_1)

			return
		end)
	end

	table.insert(var_13_0, function(arg_16_0, arg_16_1)
		self.shopList[ShopConst.TYPE_MILITARY_SHOP] = {}

		table.insert(self.shopList[ShopConst.TYPE_MILITARY_SHOP], arg_16_1)
		arg_16_0()

		return
	end)
	seriesAsync(var_13_0, arg_13_1)

	return
end

function GetOpeningUpShopCommand:GetStressShop(arg_17_1)
	local var_17_0 = {}
	local var_17_1 = self.shopsProxy:getShopStreet()

	if not var_17_1 then
		table.insert(var_17_0, function(arg_18_0)
			self:sendNotification(GAME.GET_SHOPSTREET, {
				callback = arg_18_0
			})

			return
		end)
	else
		table.insert(var_17_0, function(arg_19_0)
			arg_19_0(var_17_1)

			return
		end)
	end

	table.insert(var_17_0, function(arg_20_0, arg_20_1)
		self.shopList[ShopConst.TYPE_SHOP_STREET] = {}

		table.insert(self.shopList[ShopConst.TYPE_SHOP_STREET], arg_20_1)
		arg_20_0()

		return
	end)
	seriesAsync(var_17_0, arg_17_1)

	return
end

function GetOpeningUpShopCommand:GetGuildShop(arg_21_1)
	if LOCK_GUILD_SHOP then
		arg_21_1()

		return
	end

	local var_21_0 = {}
	local var_21_1 = self.shopsProxy:getGuildShop()

	if not var_21_1 then
		table.insert(var_21_0, function(arg_22_0)
			self:sendNotification(GAME.GET_GUILD_SHOP, {
				type = GuildConst.GET_SHOP,
				callback = arg_22_0
			})

			return
		end)
	else
		table.insert(var_21_0, function(arg_23_0)
			arg_23_0(var_21_1)

			return
		end)
	end

	table.insert(var_21_0, function(arg_24_0, arg_24_1)
		self.shopList[ShopConst.TYPE_GUILD] = {}

		table.insert(self.shopList[ShopConst.TYPE_GUILD], arg_24_1)
		arg_24_0()

		return
	end)
	seriesAsync(var_21_0, arg_21_1)

	return
end

function GetOpeningUpShopCommand:GetShamShop(arg_25_1)
	local var_25_0 = {}
	local var_25_1 = self.shopsProxy:getShamShop()

	if not LOCK_SHAM_CHAPTER and var_25_1 and var_25_1:isOpen() then
		table.insert(var_25_0, function(arg_26_0)
			self.shopList[ShopConst.TYPE_SHAM_SHOP] = {}

			table.insert(self.shopList[ShopConst.TYPE_SHAM_SHOP], var_25_1)
			arg_26_0()

			return
		end)
	end

	seriesAsync(var_25_0, arg_25_1)

	return
end

function GetOpeningUpShopCommand:GetFragmentShop(arg_27_1)
	local var_27_0 = {}
	local var_27_1 = self.shopsProxy:getFragmentShop()

	if not LOCK_FRAGMENT_SHOP and var_27_1 and var_27_1:isOpen() then
		table.insert(var_27_0, function(arg_28_0)
			self.shopList[ShopConst.TYPE_FRAGMENT] = {}

			table.insert(self.shopList[ShopConst.TYPE_FRAGMENT], var_27_1)
			arg_28_0()

			return
		end)
	end

	seriesAsync(var_27_0, arg_27_1)

	return
end

function GetOpeningUpShopCommand:GetActivityShops(arg_29_1)
	local var_29_0 = {}
	local var_29_1 = self.shopsProxy:getActivityShops()

	if not var_29_1 or #var_29_1 == 0 then
		table.insert(var_29_0, function(arg_30_0)
			self:sendNotification(GAME.GET_ACTIVITY_SHOP, {
				callback = arg_30_0
			})

			return
		end)
	else
		table.insert(var_29_0, function(arg_31_0)
			arg_31_0(var_29_1)

			return
		end)
	end

	table.insert(var_29_0, function(arg_32_0, arg_32_1)
		if arg_32_1 and table.getCount(arg_32_1) > 0 then
			self.shopList[ShopConst.TYPE_ACTIVITY] = {}

			for iter_32_0, iter_32_1 in pairs(arg_32_1) do
				table.insert(self.shopList[ShopConst.TYPE_ACTIVITY], iter_32_1)
			end

			local var_32_0 = getProxy(ActivityProxy):getRawData()

			table.sort(self.shopList[ShopConst.TYPE_ACTIVITY], CompareFuncs({
				function(arg_33_0)
					return var_32_0[arg_33_0.activityId]:getStartTime()
				end
			}))
		end

		arg_32_0()

		return
	end)
	seriesAsync(var_29_0, arg_29_1)

	return
end

function GetOpeningUpShopCommand:GetMetaShops(arg_34_1)
	local var_34_0 = {}
	local var_34_1 = self.shopsProxy:GetMetaShop()

	if not var_34_1 then
		table.insert(var_34_0, function(arg_35_0)
			for iter_35_0, iter_35_1 in ipairs((getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_SHOP_SELECTABLE))) do
				if iter_35_1 and not iter_35_1:isEnd() and iter_35_1:getConfig("config_id") == 1 then
					self.shopsProxy:AddMetaShop((MetaShop.New(iter_35_1)))

					break
				end
			end

			arg_35_0(self.shopsProxy:GetMetaShop())

			return
		end)
	else
		table.insert(var_34_0, function(arg_36_0)
			arg_36_0(var_34_1)

			return
		end)
	end

	table.insert(var_34_0, function(arg_37_0, arg_37_1)
		if arg_37_1 then
			self.shopList[ShopConst.TYPE_META] = {}

			table.insert(self.shopList[ShopConst.TYPE_META], arg_37_1)
		end

		arg_37_0()

		return
	end)
	seriesAsync(var_34_0, arg_34_1)

	return
end

function GetOpeningUpShopCommand:GetMedalShops(arg_38_1)
	local var_38_0 = {}
	local var_38_1 = self.shopsProxy:GetMedalShop()

	if not var_38_1 then
		table.insert(var_38_0, function(arg_39_0)
			self:sendNotification(GAME.GET_MEDALSHOP, {
				callback = arg_39_0
			})

			return
		end)
	else
		table.insert(var_38_0, function(arg_40_0)
			arg_40_0(var_38_1)

			return
		end)
	end

	table.insert(var_38_0, function(arg_41_0, arg_41_1)
		if arg_41_1 then
			self.shopList[ShopConst.TYPE_MEDAL] = {}

			table.insert(self.shopList[ShopConst.TYPE_MEDAL], arg_41_1)
		end

		arg_41_0()

		return
	end)
	seriesAsync(var_38_0, arg_38_1)

	return
end

function GetOpeningUpShopCommand:GetMiniShops(arg_42_1)
	if LOCK_MINIGAME_HALL then
		if arg_42_1 then
			arg_42_1()
		end

		return
	end

	local var_42_0 = {}
	local var_42_1 = self.shopsProxy:getMiniShop()

	if not var_42_1 then
		table.insert(var_42_0, function(arg_43_0)
			self:sendNotification(GAME.GET_MINI_GAME_SHOP, {
				callback = arg_43_0
			})

			return
		end)
	else
		table.insert(var_42_0, function(arg_44_0)
			if var_42_1:checkShopFlash() then
				self:sendNotification(GAME.MINI_GAME_SHOP_FLUSH, {
					callback = arg_44_0
				})
			else
				arg_44_0(var_42_1)
			end

			return
		end)
	end

	table.insert(var_42_0, function(arg_45_0, arg_45_1)
		self.shopList[ShopConst.TYPE_MINI_GAME] = {}

		table.insert(self.shopList[ShopConst.TYPE_MINI_GAME], arg_45_1)
		arg_45_0()

		return
	end)
	seriesAsync(var_42_0, arg_42_1)

	return
end

function GetOpeningUpShopCommand:GetQuotaShop(arg_46_1)
	if LOCK_QUOTA_SHOP then
		arg_46_1()

		return
	end

	local var_46_0 = {}
	local var_46_1 = self.shopsProxy:getQuotaShop()

	if not var_46_1 then
		var_46_1 = QuotaShop.New()

		self.shopsProxy:setQuotaShop(var_46_1)
	else
		table.insert(var_46_0, function(arg_47_0)
			arg_47_0(var_46_1)

			return
		end)
	end

	table.insert(var_46_0, function(arg_48_0)
		self.shopList[ShopConst.TYPE_QUOTA] = {}

		table.insert(self.shopList[ShopConst.TYPE_QUOTA], var_46_1)
		arg_48_0()

		return
	end)
	seriesAsync(var_46_0, arg_46_1)

	return
end

return GetOpeningUpShopCommand
