local ShopsProxy = class("ShopsProxy", import(".NetProxy"))

ShopsProxy.MERITOROUS_SHOP_UPDATED = "ShopsProxy:MERITOROUS_SHOP_UPDATED"
ShopsProxy.SHOPPINGSTREET_UPDATE = "ShopsProxy:SHOPPINGSTREET_UPDATE"
ShopsProxy.FIRST_CHARGE_IDS_UPDATED = "ShopsProxy:FIRST_CHARGE_IDS_UPDATED"
ShopsProxy.CHARGED_LIST_UPDATED = "ShopsProxy:CHARGED_LIST_UPDATED"
ShopsProxy.NORMAL_LIST_UPDATED = "ShopsProxy:NORMAL_LIST_UPDATED"
ShopsProxy.NORMAL_GROUP_LIST_UPDATED = "ShopsProxy:NORMAL_GROUP_LIST_UPDATED"
ShopsProxy.ACTIVITY_SHOP_UPDATED = "ShopsProxy:ACTIVITY_SHOP_UPDATED"
ShopsProxy.GUILD_SHOP_ADDED = "ShopsProxy:GUILD_SHOP_ADDED"
ShopsProxy.GUILD_SHOP_UPDATED = "ShopsProxy:GUILD_SHOP_UPDATED"
ShopsProxy.ACTIVITY_SHOPS_UPDATED = "ShopsProxy:ACTIVITY_SHOPS_UPDATED"
ShopsProxy.SHAM_SHOP_UPDATED = "ShopsProxy:SHAM_SHOP_UPDATED"
ShopsProxy.FRAGMENT_SHOP_UPDATED = "ShopsProxy:FRAGMENT_SHOP_UPDATED"
ShopsProxy.ACTIVITY_SHOP_GOODS_UPDATED = "ShopsProxy:ACTIVITY_SHOP_GOODS_UPDATED"
ShopsProxy.META_SHOP_GOODS_UPDATED = "ShopsProxy:META_SHOP_GOODS_UPDATED"
ShopsProxy.MEDAL_SHOP_UPDATED = "ShopsProxy:MEDAL_SHOP_UPDATED"
ShopsProxy.QUOTA_SHOP_UPDATED = "ShopsProxy:QUOTA_SHOP_UPDATED"
ShopsProxy.CRUISE_SHOP_UPDATED = "ShopsProxy:CRUISE_SHOP_UPDATED"

function ShopsProxy:register()
	self.shopStreet = nil
	self.meritorousShop = nil
	self.guildShop = nil
	self.refreshChargeList = false
	self.metaShop = nil
	self.miniShop = nil

	self:on(22102, function(arg_2_0)
		getProxy(ShopsProxy):setShopStreet((ShoppingStreet.New(arg_2_0.street)))

		return
	end)

	self.shamShop = ShamBattleShop.New()
	self.fragmentShop = FragmentShop.New()

	self:on(16200, function(arg_3_0)
		self.shamShop:update(arg_3_0.month, arg_3_0.core_shop_list)
		self.fragmentShop:update(arg_3_0.month, arg_3_0.blue_shop_list, arg_3_0.normal_shop_list)

		return
	end)

	self.timers = {}
	self.tradeNoPrev = ""
	self.freeGiftIdList = {}

	for iter_1_0, iter_1_1 in pairs(pg.shop_template.all) do
		if pg.shop_template[iter_1_1].genre == ShopArgs.GiftPackage and pg.shop_template[iter_1_1].discount == 100 then
			table.insert(self.freeGiftIdList, iter_1_1)
		end
	end

	self.newServerShopList = {}

	return
end

function ShopsProxy:timeCall()
	return {
		[ProxyRegister.DayCall] = function(arg_5_0, arg_5_1)
			local var_5_0 = self:getShopStreet()

			if var_5_0 then
				var_5_0:resetflashCount()
				self:setShopStreet(var_5_0)
			end

			self.refreshChargeList = true

			local var_5_1 = self:getMiniShop()

			if var_5_1 and var_5_1:checkShopFlash() then
				pg.m02:sendNotification(GAME.MINI_GAME_SHOP_FLUSH)
			end

			if arg_5_0 == 1 then
				self.shamShop:update(arg_5_1.month, {})
				self:AddShamShop(self.shamShop)
				self.fragmentShop:Reset(arg_5_1.month)
				self:AddFragmentShop(self.fragmentShop)

				if not LOCK_UR_SHIP then
					getProxy(BagProxy):ClearLimitCnt(pg.gameset.urpt_chapter_max.description[1])
				end
			end

			return
		end
	}
end

function ShopsProxy:setShopStreet(arg_6_1)
	self.shopStreet = arg_6_1

	self:sendNotification(ShopsProxy.SHOPPINGSTREET_UPDATE, {
		shopStreet = Clone(self.shopStreet)
	})

	return
end

function ShopsProxy:UpdateShopStreet(arg_7_1)
	self.shopStreet = arg_7_1

	return
end

function ShopsProxy:getShopStreet()
	return Clone(self.shopStreet)
end

function ShopsProxy:getMeritorousShop()
	return Clone(self.meritorousShop)
end

function ShopsProxy:addMeritorousShop(arg_10_1)
	self.meritorousShop = arg_10_1

	self:sendNotification(ShopsProxy.MERITOROUS_SHOP_UPDATED, Clone(arg_10_1))

	return
end

function ShopsProxy:updateMeritorousShop(arg_11_1)
	self.meritorousShop = arg_11_1

	return
end

function ShopsProxy:getMiniShop()
	return Clone(self.miniShop)
end

function ShopsProxy:setMiniShop(arg_13_1)
	self.miniShop = arg_13_1

	return
end

function ShopsProxy:setNormalList(arg_14_1)
	self.normalList = arg_14_1 or {}

	return
end

function ShopsProxy:GetNormalList()
	return Clone(self.normalList)
end

function ShopsProxy:GetNormalByID(arg_16_1)
	self.normalList = self.normalList or {}
	self.normalList[arg_16_1] = self.normalList[arg_16_1] or Goods.Create({
		buyCount = 0,
		id = arg_16_1
	}, Goods.TYPE_GIFT_PACKAGE)

	return self.normalList[arg_16_1]
end

function ShopsProxy:updateNormalByID(arg_17_1)
	self.normalList[arg_17_1.id] = arg_17_1

	return
end

function ShopsProxy:checkHasFreeNormal()
	for iter_18_0, iter_18_1 in ipairs(self.freeGiftIdList) do
		if self:checkNormalCanPurchase(iter_18_1) then
			return true
		end
	end

	return false
end

function ShopsProxy:checkNormalCanPurchase(arg_19_1)
	if self.normalList[arg_19_1] ~= nil then
		if not self.normalList[arg_19_1]:inTime() then
			return false
		end

		local var_19_0 = self.normalList[arg_19_1]:getConfig("group") or 0

		if var_19_0 > 0 then
			local var_19_1 = self.normalList[arg_19_1]:getConfig("group_limit")

			return var_19_1 > 0 and self:getGroupLimit(var_19_0) < var_19_1
		elseif self.normalList[arg_19_1]:canPurchase() then
			return true
		end
	else
		return self:GetNormalByID(arg_19_1):inTime()
	end

	return
end

function ShopsProxy:setNormalGroupList(arg_20_1)
	self.normalGroupList = arg_20_1

	return
end

function ShopsProxy:GetNormalGroupList()
	return self.normalGroupList
end

function ShopsProxy:updateNormalGroupList(arg_22_1, arg_22_2)
	if arg_22_1 <= 0 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(self.normalGroupList) do
		if iter_22_1.shop_id == arg_22_1 then
			self.normalGroupList[iter_22_0].pay_count = (self.normalGroupList[iter_22_0].pay_count or 0) + arg_22_2

			return
		end
	end

	table.insert(self.normalGroupList, {
		shop_id = arg_22_1,
		pay_count = arg_22_2
	})

	return
end

function ShopsProxy:getGroupLimit(arg_23_1)
	if not self.normalGroupList then
		return 0
	end

	for iter_23_0, iter_23_1 in ipairs(self.normalGroupList) do
		if iter_23_1.shop_id == arg_23_1 then
			return iter_23_1.pay_count
		end
	end

	return 0
end

function ShopsProxy:addActivityShops(arg_24_1)
	self.activityShops = arg_24_1

	self:sendNotification(ShopsProxy.ACTIVITY_SHOPS_UPDATED)

	return
end

function ShopsProxy:getActivityShopById(arg_25_1)
	assert(self.activityShops[arg_25_1], "activity shop should exist" .. arg_25_1)

	return self.activityShops[arg_25_1]
end

function ShopsProxy:updateActivityShop(arg_26_1, arg_26_2)
	assert(self.activityShops, "activityShops can not be nil")

	self.activityShops[arg_26_1] = arg_26_2

	self:sendNotification(ShopsProxy.ACTIVITY_SHOP_UPDATED, {
		activityId = arg_26_1,
		shop = arg_26_2:clone()
	})

	return
end

function ShopsProxy:UpdateActivityGoods(arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = self:getActivityShopById(arg_27_1)

	var_27_0:getGoodsById(arg_27_2):addBuyCount(arg_27_3)

	self.activityShops[arg_27_1] = var_27_0

	self:sendNotification(ShopsProxy.ACTIVITY_SHOP_GOODS_UPDATED, {
		activityId = arg_27_1,
		goodsId = arg_27_2
	})

	return
end

function ShopsProxy:getActivityShops()
	return self.activityShops
end

function ShopsProxy:setFirstChargeList(arg_29_1)
	self.firstChargeList = arg_29_1

	self:sendNotification(ShopsProxy.FIRST_CHARGE_IDS_UPDATED, Clone(arg_29_1))

	return
end

function ShopsProxy:getFirstChargeList()
	return Clone(self.firstChargeList)
end

function ShopsProxy:setChargedList(arg_31_1)
	self.chargeList = arg_31_1

	self:sendNotification(ShopsProxy.CHARGED_LIST_UPDATED, Clone(arg_31_1))

	return
end

function ShopsProxy:getChargedList()
	return Clone(self.chargeList)
end

local var_0_1 = 3
local var_0_2 = 10

function ShopsProxy:chargeFailed(arg_33_1, arg_33_2)
	if not self.timers[arg_33_1] then
		pg.UIMgr.GetInstance():LoadingOn()

		self.timers[arg_33_1] = Timer.New(function()
			if self.timers[arg_33_1].loop == 1 then
				pg.UIMgr.GetInstance():LoadingOff()
			end

			PaySuccess(arg_33_1, arg_33_2)

			return
		end, var_0_1, var_0_2)

		self.timers[arg_33_1]:Start()
	end

	return
end

function ShopsProxy:removeChargeTimer(arg_35_1)
	if self.timers[arg_35_1] then
		pg.UIMgr.GetInstance():LoadingOff()
		self.timers[arg_35_1]:Stop()

		self.timers[arg_35_1] = nil
	end

	return
end

function ShopsProxy:addWaitTimer()
	pg.UIMgr.GetInstance():LoadingOn()

	self.waitBiliTimer = Timer.New(function()
		self:removeWaitTimer()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("charge_time_out")
		})

		return
	end, 25, 1)

	self.waitBiliTimer:Start()

	return
end

function ShopsProxy:removeWaitTimer()
	if self.waitBiliTimer then
		pg.UIMgr.GetInstance():LoadingOff()
		self.waitBiliTimer:Stop()

		self.waitBiliTimer = nil
	end

	return
end

function ShopsProxy:setGuildShop(arg_39_1)
	assert(isa(arg_39_1, GuildShop), "shop should instance of GuildShop")
	assert(self.guildShop == nil, "shop already exist")

	self.guildShop = arg_39_1

	self:sendNotification(ShopsProxy.GUILD_SHOP_ADDED, self.guildShop)

	return
end

function ShopsProxy:getGuildShop()
	return self.guildShop
end

function ShopsProxy:updateGuildShop(arg_41_1, arg_41_2)
	assert(isa(arg_41_1, GuildShop), "shop should instance of GuildShop")
	assert(self.guildShop, "should exist shop")

	self.guildShop = arg_41_1

	self:sendNotification(ShopsProxy.GUILD_SHOP_UPDATED, {
		shop = self.guildShop,
		reset = arg_41_2
	})

	return
end

function ShopsProxy:AddShamShop(arg_42_1)
	self.shamShop = arg_42_1

	self:sendNotification(ShopsProxy.SHAM_SHOP_UPDATED, arg_42_1)

	return
end

function ShopsProxy:updateShamShop(arg_43_1)
	self.shamShop = arg_43_1

	return
end

function ShopsProxy:getShamShop()
	return self.shamShop
end

function ShopsProxy:AddFragmentShop(arg_45_1)
	self.fragmentShop = arg_45_1

	self:sendNotification(ShopsProxy.FRAGMENT_SHOP_UPDATED, arg_45_1)

	return
end

function ShopsProxy:updateFragmentShop(arg_46_1)
	self.fragmentShop = arg_46_1

	return
end

function ShopsProxy:getFragmentShop()
	return self.fragmentShop
end

function ShopsProxy:AddMetaShop(arg_48_1)
	self.metaShop = arg_48_1

	return
end

function ShopsProxy:GetMetaShop()
	return self.metaShop
end

function ShopsProxy:UpdateMetaShopGoods(arg_50_1, arg_50_2)
	self:GetMetaShop():getGoodsById(arg_50_1):addBuyCount(arg_50_2)
	self:sendNotification(ShopsProxy.META_SHOP_GOODS_UPDATED, {
		goodsId = arg_50_1
	})

	return
end

function ShopsProxy:SetNewServerShop(arg_51_1, arg_51_2)
	self.newServerShopList[arg_51_1] = arg_51_2

	return
end

function ShopsProxy:GetNewServerShop(arg_52_1)
	return self.newServerShopList[arg_52_1]
end

function ShopsProxy:SetMedalShop(arg_53_1)
	self.medalShop = arg_53_1

	return
end

function ShopsProxy:UpdateMedalShop(arg_54_1)
	self.medalShop = arg_54_1

	self:sendNotification(ShopsProxy.MEDAL_SHOP_UPDATED, arg_54_1)

	return
end

function ShopsProxy:GetMedalShop()
	return self.medalShop
end

function ShopsProxy:setQuotaShop(arg_56_1)
	self.quotaShop = arg_56_1

	return
end

function ShopsProxy:getQuotaShop()
	return self.quotaShop
end

function ShopsProxy:updateQuotaShop(arg_58_1, arg_58_2)
	self.quotaShop = arg_58_1

	self:sendNotification(ShopsProxy.QUOTA_SHOP_UPDATED, {
		shop = self.quotaShop,
		reset = arg_58_2
	})

	return
end

function ShopsProxy:SetCruiseShop(arg_59_1)
	self.cruiseShop = arg_59_1

	return
end

function ShopsProxy:UpdateCruiseShop()
	self.cruiseShop = CruiseShop.New(self:GetNormalList(), self:GetNormalGroupList())

	self:sendNotification(ShopsProxy.CRUISE_SHOP_UPDATED, {
		shop = self.cruiseShop
	})

	return
end

function ShopsProxy:GetCruiseShop()
	return self.cruiseShop
end

function ShopsProxy:remove()
	for iter_62_0, iter_62_1 in pairs(self.timers) do
		iter_62_1:Stop()
	end

	self.timers = nil

	self:removeWaitTimer()

	return
end

function ShopsProxy:ShouldRefreshChargeList()
	return not self:getFirstChargeList() or not self:getChargedList() or not self:GetNormalList() or not self:GetNormalGroupList() or self.refreshChargeList
end

function ShopsProxy:GetRecommendCommodities()
	local var_64_0 = self:getChargedList()
	local var_64_1 = self:GetNormalList()
	local var_64_2 = self:GetNormalGroupList()

	if not var_64_0 or not var_64_1 or not var_64_2 then
		return {}
	end

	local var_64_3 = {}

	for iter_64_0, iter_64_1 in ipairs(pg.recommend_shop.all) do
		if pg.TimeMgr.GetInstance():inTime(pg.recommend_shop[iter_64_1].time) then
			local var_64_4 = RecommendCommodity.New({
				id = iter_64_1,
				chargedList = var_64_0,
				normalList = var_64_1,
				normalGroupList = var_64_2
			})

			if var_64_4:CanShow() then
				table.insert(var_64_3, var_64_4)
			end
		end
	end

	table.sort(var_64_3, function(arg_65_0, arg_65_1)
		return arg_65_0:GetOrder() < arg_65_1:GetOrder()
	end)

	return var_64_3
end

function ShopsProxy:GetGiftCommodity(arg_66_1, arg_66_2)
	local var_66_0 = Goods.Create({
		shop_id = arg_66_1
	}, arg_66_2)

	if var_66_0:isChargeType() then
		var_66_0:updateBuyCount((ChargeConst.getBuyCount(self.chargeList, var_66_0.id)))
	else
		var_66_0:updateBuyCount((ChargeConst.getBuyCount(self.normalList, var_66_0.id)))

		local var_66_1 = var_66_0:getConfig("group") or 0

		if var_66_1 > 0 then
			var_66_0:updateGroupCount((ChargeConst.getGroupLimit(self.normalGroupList, var_66_1)))
		end
	end

	return var_66_0
end

function ShopsProxy:GetGroupPayCount(arg_67_1)
	for iter_67_0, iter_67_1 in ipairs(self.normalGroupList) do
		if iter_67_1.shop_id == arg_67_1 then
			return self.normalGroupList[iter_67_0].pay_count or 0
		end
	end

	return 0
end

function ShopsProxy:SpecialBannerBlockCheck(arg_68_1)
	if not LOCK_SHOP_BANNER_US then
		return true
	end

	local var_68_0, var_68_1 = unpack(getGameset("levellimit_shopbanner"))

	return var_68_0 <= arg_68_1.level or self.name ~= "banner_big" or table.contains(var_68_1, self.id)
end

function ShopsProxy:GiftPackageRedDotTip(arg_69_1, arg_69_2)
	local var_69_0 = {}

	if self:ShouldRefreshChargeList() then
		table.insert(var_69_0, function(arg_70_0)
			pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
				callback = arg_70_0
			})

			return
		end)
	end

	seriesAsync(var_69_0, function()
		local var_71_0 = underscore.any(self:GetAllShowGiftPackages(arg_69_2), function(arg_72_0)
			return arg_72_0:isTip()
		end)

		for iter_71_0, iter_71_1 in ipairs(arg_69_1) do
			setActive(iter_71_1, var_71_0)
		end

		return
	end)

	return
end

function ShopsProxy:GetAllShowGiftPackages(arg_73_1)
	assert(not self:ShouldRefreshChargeList())

	local var_73_0 = {}
	local var_73_1 = RefluxShopView.getAllRefluxPackID()
	local var_73_2 = getProxy(PlayerProxy):getRawData()

	for iter_73_0, iter_73_1 in pairs(pg.pay_data_display.all) do
		if not table.contains(var_73_1, iter_73_1) then
			local var_73_3 = pg.pay_data_display[iter_73_1].extra_service

			if (arg_73_1 == nil or pg.pay_data_display[iter_73_1].akashi_pick > 0 == arg_73_1) and (var_73_3 == Goods.ITEM_BOX or var_73_3 == Goods.PASS_ITEM) then
				local var_73_4 = Goods.Create({
					shop_id = iter_73_1
				}, Goods.TYPE_CHARGE)

				if self:filterLimitTypeGoods(var_73_4, var_73_2) then
					table.insert(var_73_0, var_73_4)
				end
			end
		end
	end

	for iter_73_2, iter_73_3 in ipairs(pg.shop_template.get_id_list_by_genre[ShopArgs.GiftPackage] or {}) do
		if (arg_73_1 == nil or pg.shop_template[iter_73_3].akashi_pick > 0 == arg_73_1) and not table.contains(var_73_1, iter_73_3) then
			table.insert(var_73_0, (Goods.Create({
				shop_id = iter_73_3
			}, Goods.TYPE_GIFT_PACKAGE)))
		end
	end

	for iter_73_4, iter_73_5 in ipairs(pg.shop_template.get_id_list_by_genre[ShopArgs.GiftActPackage] or {}) do
		if (arg_73_1 == nil or pg.shop_template[iter_73_5].akashi_pick > 0 == arg_73_1) and not table.contains(var_73_1, iter_73_5) then
			table.insert(var_73_0, (Goods.Create({
				shop_id = iter_73_5
			}, Goods.TYPE_GIFT_PACKAGE_ACT)))
		end
	end

	local var_73_5 = {}
	local var_73_6 = {}

	for iter_73_6, iter_73_7 in ipairs(var_73_0) do
		if iter_73_7:isChargeType() then
			iter_73_7:updateBuyCount((ChargeConst.getBuyCount(self.chargeList, iter_73_7.id)))

			if iter_73_7:canPurchase() and iter_73_7:inTime() then
				table.insert(var_73_5, iter_73_7)
			end
		elseif not iter_73_7:isLevelLimit(var_73_2.level, true) then
			iter_73_7:updateBuyCount((ChargeConst.getBuyCount(self.normalList, iter_73_7.id)))

			local var_73_7 = iter_73_7:getConfig("group") or 0
			local var_73_8 = false

			if var_73_7 > 0 then
				local var_73_9 = iter_73_7:getConfig("group_limit")
				local var_73_10 = ChargeConst.getGroupLimit(self.normalGroupList, var_73_7)

				iter_73_7:updateGroupCount(var_73_10)

				var_73_8 = var_73_9 > 0 and var_73_9 <= var_73_10
			end

			local var_73_11, var_73_12 = pg.TimeMgr.GetInstance():inTime(iter_73_7:getConfig("time"))

			if var_73_12 then
				table.insert(var_73_6, iter_73_7)
			end

			if var_73_11 and iter_73_7:canPurchase() and not var_73_8 then
				table.insert(var_73_5, iter_73_7)
			end
		end
	end

	return var_73_5, var_73_6
end

function ShopsProxy:filterLimitTypeGoods(arg_74_1, arg_74_2)
	return switch(arg_74_1:getConfig("limit_type"), {
		[3] = function()
			if arg_74_1:getConfig("limit_arg") ~= 0 or arg_74_1:isLevelLimit(arg_74_2.level, true) then
				return false
			end

			local var_75_0

			for iter_75_0, iter_75_1 in ipairs(arg_74_1:getSameLimitGroupTecGoods()) do
				local var_75_1

				if iter_75_1:getConfig("limit_arg") == 1 then
					var_75_1 = iter_75_1
				elseif iter_75_1:getConfig("limit_arg") == 2 then
					var_75_0 = iter_75_1
				elseif iter_75_1:getConfig("limit_arg") == 3 then
					-- block empty
				end
			end

			if ChargeConst.getBuyCount(self.chargeList, (nil).id) > 0 then
				return false
			elseif ChargeConst.getBuyCount(self.chargeList, var_75_0.id) > 0 and ChargeConst.getBuyCount(self.chargeList, (nil).id) > 0 then
				return false
			else
				return true
			end

			return
		end,
		[5] = function()
			if arg_74_1:getConfig("limit_arg") ~= 0 or arg_74_1:isLevelLimit(arg_74_2.level, true) then
				return false
			end

			for iter_76_0, iter_76_1 in ipairs(arg_74_1:getSameLimitGroupTecGoods()) do
				if iter_76_1:getConfig("limit_arg") ~= 0 and ChargeConst.getBuyCount(self.chargeList, iter_76_1.id) > 0 then
					return false
				end
			end

			return true
		end
	}, function()
		return true
	end)
end

return ShopsProxy
