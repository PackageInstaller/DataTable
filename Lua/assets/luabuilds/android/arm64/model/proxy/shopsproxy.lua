local var_0_0 = class("ShopsProxy", import(".NetProxy"))

var_0_0.MERITOROUS_SHOP_UPDATED = "ShopsProxy:MERITOROUS_SHOP_UPDATED"
var_0_0.SHOPPINGSTREET_UPDATE = "ShopsProxy:SHOPPINGSTREET_UPDATE"
var_0_0.FIRST_CHARGE_IDS_UPDATED = "ShopsProxy:FIRST_CHARGE_IDS_UPDATED"
var_0_0.CHARGED_LIST_UPDATED = "ShopsProxy:CHARGED_LIST_UPDATED"
var_0_0.NORMAL_LIST_UPDATED = "ShopsProxy:NORMAL_LIST_UPDATED"
var_0_0.NORMAL_GROUP_LIST_UPDATED = "ShopsProxy:NORMAL_GROUP_LIST_UPDATED"
var_0_0.ACTIVITY_SHOP_UPDATED = "ShopsProxy:ACTIVITY_SHOP_UPDATED"
var_0_0.GUILD_SHOP_ADDED = "ShopsProxy:GUILD_SHOP_ADDED"
var_0_0.GUILD_SHOP_UPDATED = "ShopsProxy:GUILD_SHOP_UPDATED"
var_0_0.ACTIVITY_SHOPS_UPDATED = "ShopsProxy:ACTIVITY_SHOPS_UPDATED"
var_0_0.SHAM_SHOP_UPDATED = "ShopsProxy:SHAM_SHOP_UPDATED"
var_0_0.FRAGMENT_SHOP_UPDATED = "ShopsProxy:FRAGMENT_SHOP_UPDATED"
var_0_0.ACTIVITY_SHOP_GOODS_UPDATED = "ShopsProxy:ACTIVITY_SHOP_GOODS_UPDATED"
var_0_0.META_SHOP_GOODS_UPDATED = "ShopsProxy:META_SHOP_GOODS_UPDATED"
var_0_0.MEDAL_SHOP_UPDATED = "ShopsProxy:MEDAL_SHOP_UPDATED"
var_0_0.QUOTA_SHOP_UPDATED = "ShopsProxy:QUOTA_SHOP_UPDATED"
var_0_0.CRUISE_SHOP_UPDATED = "ShopsProxy:CRUISE_SHOP_UPDATED"

function var_0_0.register(arg_1_0)
	arg_1_0.shopStreet = nil
	arg_1_0.meritorousShop = nil
	arg_1_0.guildShop = nil
	arg_1_0.refreshChargeList = false
	arg_1_0.metaShop = nil
	arg_1_0.miniShop = nil

	arg_1_0:on(22102, function(arg_2_0)
		getProxy(ShopsProxy):setShopStreet((ShoppingStreet.New(arg_2_0.street)))

		return
	end)

	arg_1_0.shamShop = ShamBattleShop.New()
	arg_1_0.fragmentShop = FragmentShop.New()

	arg_1_0:on(16200, function(arg_3_0)
		arg_1_0.shamShop:update(arg_3_0.month, arg_3_0.core_shop_list)
		arg_1_0.fragmentShop:update(arg_3_0.month, arg_3_0.blue_shop_list, arg_3_0.normal_shop_list)

		return
	end)

	arg_1_0.timers = {}
	arg_1_0.tradeNoPrev = ""
	arg_1_0.freeGiftIdList = {}

	for iter_1_0, iter_1_1 in pairs(pg.shop_template.all) do
		if pg.shop_template[iter_1_1].genre == ShopArgs.GiftPackage and pg.shop_template[iter_1_1].discount == 100 then
			table.insert(arg_1_0.freeGiftIdList, iter_1_1)
		end
	end

	arg_1_0.newServerShopList = {}

	return
end

function var_0_0.timeCall(arg_4_0)
	return {
		[ProxyRegister.DayCall] = function(arg_5_0, arg_5_1)
			local var_5_0 = arg_4_0:getShopStreet()

			if var_5_0 then
				var_5_0:resetflashCount()
				arg_4_0:setShopStreet(var_5_0)
			end

			arg_4_0.refreshChargeList = true

			local var_5_1 = arg_4_0:getMiniShop()

			if var_5_1 and var_5_1:checkShopFlash() then
				pg.m02:sendNotification(GAME.MINI_GAME_SHOP_FLUSH)
			end

			if arg_5_0 == 1 then
				arg_4_0.shamShop:update(arg_5_1.month, {})
				arg_4_0:AddShamShop(arg_4_0.shamShop)
				arg_4_0.fragmentShop:Reset(arg_5_1.month)
				arg_4_0:AddFragmentShop(arg_4_0.fragmentShop)

				if not LOCK_UR_SHIP then
					getProxy(BagProxy):ClearLimitCnt(pg.gameset.urpt_chapter_max.description[1])
				end
			end

			return
		end
	}
end

function var_0_0.setShopStreet(arg_6_0, arg_6_1)
	arg_6_0.shopStreet = arg_6_1

	arg_6_0:sendNotification(var_0_0.SHOPPINGSTREET_UPDATE, {
		shopStreet = Clone(arg_6_0.shopStreet)
	})

	return
end

function var_0_0.UpdateShopStreet(arg_7_0, arg_7_1)
	arg_7_0.shopStreet = arg_7_1

	return
end

function var_0_0.getShopStreet(arg_8_0)
	return Clone(arg_8_0.shopStreet)
end

function var_0_0.getMeritorousShop(arg_9_0)
	return Clone(arg_9_0.meritorousShop)
end

function var_0_0.addMeritorousShop(arg_10_0, arg_10_1)
	arg_10_0.meritorousShop = arg_10_1

	arg_10_0:sendNotification(var_0_0.MERITOROUS_SHOP_UPDATED, Clone(arg_10_1))

	return
end

function var_0_0.updateMeritorousShop(arg_11_0, arg_11_1)
	arg_11_0.meritorousShop = arg_11_1

	return
end

function var_0_0.getMiniShop(arg_12_0)
	return Clone(arg_12_0.miniShop)
end

function var_0_0.setMiniShop(arg_13_0, arg_13_1)
	arg_13_0.miniShop = arg_13_1

	return
end

function var_0_0.setNormalList(arg_14_0, arg_14_1)
	arg_14_0.normalList = arg_14_1 or {}

	return
end

function var_0_0.GetNormalList(arg_15_0)
	return Clone(arg_15_0.normalList)
end

function var_0_0.GetNormalByID(arg_16_0, arg_16_1)
	arg_16_0.normalList = arg_16_0.normalList or {}
	arg_16_0.normalList[arg_16_1] = arg_16_0.normalList[arg_16_1] or Goods.Create({
		buyCount = 0,
		id = arg_16_1
	}, Goods.TYPE_GIFT_PACKAGE)

	return arg_16_0.normalList[arg_16_1]
end

function var_0_0.updateNormalByID(arg_17_0, arg_17_1)
	arg_17_0.normalList[arg_17_1.id] = arg_17_1

	return
end

function var_0_0.checkHasFreeNormal(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0.freeGiftIdList) do
		if arg_18_0:checkNormalCanPurchase(iter_18_1) then
			return true
		end
	end

	return false
end

function var_0_0.checkNormalCanPurchase(arg_19_0, arg_19_1)
	if arg_19_0.normalList[arg_19_1] ~= nil then
		if not arg_19_0.normalList[arg_19_1]:inTime() then
			return false
		end

		local var_19_0 = arg_19_0.normalList[arg_19_1]:getConfig("group") or 0

		if var_19_0 > 0 then
			local var_19_1 = arg_19_0.normalList[arg_19_1]:getConfig("group_limit")
			local var_19_2 = arg_19_0:getGroupLimit(var_19_0)

			return var_19_1 > 0 and var_19_2 < var_19_1
		elseif arg_19_0.normalList[arg_19_1]:canPurchase() then
			return true
		end
	else
		return arg_19_0:GetNormalByID(arg_19_1):inTime()
	end

	return
end

function var_0_0.setNormalGroupList(arg_20_0, arg_20_1)
	arg_20_0.normalGroupList = arg_20_1

	return
end

function var_0_0.GetNormalGroupList(arg_21_0)
	return arg_21_0.normalGroupList
end

function var_0_0.updateNormalGroupList(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 <= 0 then
		return
	end

	for iter_22_0, iter_22_1 in ipairs(arg_22_0.normalGroupList) do
		if iter_22_1.shop_id == arg_22_1 then
			local var_22_0 = arg_22_0.normalGroupList[iter_22_0].pay_count or 0

			arg_22_0.normalGroupList[iter_22_0].pay_count = var_22_0 + arg_22_2

			return
		end
	end

	table.insert(arg_22_0.normalGroupList, {
		shop_id = arg_22_1,
		pay_count = arg_22_2
	})

	return
end

function var_0_0.getGroupLimit(arg_23_0, arg_23_1)
	if not arg_23_0.normalGroupList then
		return 0
	end

	for iter_23_0, iter_23_1 in ipairs(arg_23_0.normalGroupList) do
		if iter_23_1.shop_id == arg_23_1 then
			return iter_23_1.pay_count
		end
	end

	return 0
end

function var_0_0.addActivityShops(arg_24_0, arg_24_1)
	arg_24_0.activityShops = arg_24_1

	arg_24_0:sendNotification(var_0_0.ACTIVITY_SHOPS_UPDATED)

	return
end

function var_0_0.getActivityShopById(arg_25_0, arg_25_1)
	assert(arg_25_0.activityShops[arg_25_1], "activity shop should exist" .. arg_25_1)

	return arg_25_0.activityShops[arg_25_1]
end

function var_0_0.updateActivityShop(arg_26_0, arg_26_1, arg_26_2)
	assert(arg_26_0.activityShops, "activityShops can not be nil")

	arg_26_0.activityShops[arg_26_1] = arg_26_2

	arg_26_0:sendNotification(var_0_0.ACTIVITY_SHOP_UPDATED, {
		activityId = arg_26_1,
		shop = arg_26_2:clone()
	})

	return
end

function var_0_0.UpdateActivityGoods(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0:getActivityShopById(arg_27_1)

	var_27_0:getGoodsById(arg_27_2):addBuyCount(arg_27_3)

	arg_27_0.activityShops[arg_27_1] = var_27_0

	arg_27_0:sendNotification(var_0_0.ACTIVITY_SHOP_GOODS_UPDATED, {
		activityId = arg_27_1,
		goodsId = arg_27_2
	})

	return
end

function var_0_0.getActivityShops(arg_28_0)
	return arg_28_0.activityShops
end

function var_0_0.setFirstChargeList(arg_29_0, arg_29_1)
	arg_29_0.firstChargeList = arg_29_1

	arg_29_0:sendNotification(var_0_0.FIRST_CHARGE_IDS_UPDATED, Clone(arg_29_1))

	return
end

function var_0_0.getFirstChargeList(arg_30_0)
	return Clone(arg_30_0.firstChargeList)
end

function var_0_0.setChargedList(arg_31_0, arg_31_1)
	arg_31_0.chargeList = arg_31_1

	arg_31_0:sendNotification(var_0_0.CHARGED_LIST_UPDATED, Clone(arg_31_1))

	return
end

function var_0_0.getChargedList(arg_32_0)
	return Clone(arg_32_0.chargeList)
end

local var_0_1 = 3
local var_0_2 = 10

function var_0_0.chargeFailed(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.timers[arg_33_1] then
		pg.UIMgr.GetInstance():LoadingOn()

		arg_33_0.timers[arg_33_1] = Timer.New(function()
			if arg_33_0.timers[arg_33_1].loop == 1 then
				pg.UIMgr.GetInstance():LoadingOff()
			end

			PaySuccess(arg_33_1, arg_33_2)

			return
		end, var_0_1, var_0_2)

		arg_33_0.timers[arg_33_1]:Start()
	end

	return
end

function var_0_0.removeChargeTimer(arg_35_0, arg_35_1)
	if arg_35_0.timers[arg_35_1] then
		pg.UIMgr.GetInstance():LoadingOff()
		arg_35_0.timers[arg_35_1]:Stop()

		arg_35_0.timers[arg_35_1] = nil
	end

	return
end

function var_0_0.addWaitTimer(arg_36_0)
	pg.UIMgr.GetInstance():LoadingOn()

	arg_36_0.waitBiliTimer = Timer.New(function()
		arg_36_0:removeWaitTimer()
		pg.MsgboxMgr.GetInstance():ShowMsgBox({
			hideNo = true,
			content = i18n("charge_time_out")
		})

		return
	end, 25, 1)

	arg_36_0.waitBiliTimer:Start()

	return
end

function var_0_0.removeWaitTimer(arg_38_0)
	if arg_38_0.waitBiliTimer then
		pg.UIMgr.GetInstance():LoadingOff()
		arg_38_0.waitBiliTimer:Stop()

		arg_38_0.waitBiliTimer = nil
	end

	return
end

function var_0_0.setGuildShop(arg_39_0, arg_39_1)
	assert(isa(arg_39_1, GuildShop), "shop should instance of GuildShop")
	assert(arg_39_0.guildShop == nil, "shop already exist")

	arg_39_0.guildShop = arg_39_1

	arg_39_0:sendNotification(var_0_0.GUILD_SHOP_ADDED, arg_39_0.guildShop)

	return
end

function var_0_0.getGuildShop(arg_40_0)
	return arg_40_0.guildShop
end

function var_0_0.updateGuildShop(arg_41_0, arg_41_1, arg_41_2)
	assert(isa(arg_41_1, GuildShop), "shop should instance of GuildShop")
	assert(arg_41_0.guildShop, "should exist shop")

	arg_41_0.guildShop = arg_41_1

	arg_41_0:sendNotification(var_0_0.GUILD_SHOP_UPDATED, {
		shop = arg_41_0.guildShop,
		reset = arg_41_2
	})

	return
end

function var_0_0.AddShamShop(arg_42_0, arg_42_1)
	arg_42_0.shamShop = arg_42_1

	arg_42_0:sendNotification(var_0_0.SHAM_SHOP_UPDATED, arg_42_1)

	return
end

function var_0_0.updateShamShop(arg_43_0, arg_43_1)
	arg_43_0.shamShop = arg_43_1

	return
end

function var_0_0.getShamShop(arg_44_0)
	return arg_44_0.shamShop
end

function var_0_0.AddFragmentShop(arg_45_0, arg_45_1)
	arg_45_0.fragmentShop = arg_45_1

	arg_45_0:sendNotification(var_0_0.FRAGMENT_SHOP_UPDATED, arg_45_1)

	return
end

function var_0_0.updateFragmentShop(arg_46_0, arg_46_1)
	arg_46_0.fragmentShop = arg_46_1

	return
end

function var_0_0.getFragmentShop(arg_47_0)
	return arg_47_0.fragmentShop
end

function var_0_0.AddMetaShop(arg_48_0, arg_48_1)
	arg_48_0.metaShop = arg_48_1

	return
end

function var_0_0.GetMetaShop(arg_49_0)
	return arg_49_0.metaShop
end

function var_0_0.UpdateMetaShopGoods(arg_50_0, arg_50_1, arg_50_2)
	arg_50_0:GetMetaShop():getGoodsById(arg_50_1):addBuyCount(arg_50_2)
	arg_50_0:sendNotification(var_0_0.META_SHOP_GOODS_UPDATED, {
		goodsId = arg_50_1
	})

	return
end

function var_0_0.SetNewServerShop(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.newServerShopList[arg_51_1] = arg_51_2

	return
end

function var_0_0.GetNewServerShop(arg_52_0, arg_52_1)
	return arg_52_0.newServerShopList[arg_52_1]
end

function var_0_0.SetMedalShop(arg_53_0, arg_53_1)
	arg_53_0.medalShop = arg_53_1

	return
end

function var_0_0.UpdateMedalShop(arg_54_0, arg_54_1)
	arg_54_0.medalShop = arg_54_1

	arg_54_0:sendNotification(var_0_0.MEDAL_SHOP_UPDATED, arg_54_1)

	return
end

function var_0_0.GetMedalShop(arg_55_0)
	return arg_55_0.medalShop
end

function var_0_0.setQuotaShop(arg_56_0, arg_56_1)
	arg_56_0.quotaShop = arg_56_1

	return
end

function var_0_0.getQuotaShop(arg_57_0)
	return arg_57_0.quotaShop
end

function var_0_0.updateQuotaShop(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.quotaShop = arg_58_1

	arg_58_0:sendNotification(var_0_0.QUOTA_SHOP_UPDATED, {
		shop = arg_58_0.quotaShop,
		reset = arg_58_2
	})

	return
end

function var_0_0.SetCruiseShop(arg_59_0, arg_59_1)
	arg_59_0.cruiseShop = arg_59_1

	return
end

function var_0_0.UpdateCruiseShop(arg_60_0)
	arg_60_0.cruiseShop = CruiseShop.New(arg_60_0:GetNormalList(), arg_60_0:GetNormalGroupList())

	arg_60_0:sendNotification(var_0_0.CRUISE_SHOP_UPDATED, {
		shop = arg_60_0.cruiseShop
	})

	return
end

function var_0_0.GetCruiseShop(arg_61_0)
	return arg_61_0.cruiseShop
end

function var_0_0.remove(arg_62_0)
	for iter_62_0, iter_62_1 in pairs(arg_62_0.timers) do
		iter_62_1:Stop()
	end

	arg_62_0.timers = nil

	arg_62_0:removeWaitTimer()

	return
end

function var_0_0.ShouldRefreshChargeList(arg_63_0)
	local var_63_0 = arg_63_0:getChargedList()
	local var_63_1 = arg_63_0:GetNormalList()
	local var_63_2 = arg_63_0:GetNormalGroupList()

	return not arg_63_0:getFirstChargeList() or not var_63_0 or not var_63_1 or not var_63_2 or arg_63_0.refreshChargeList
end

function var_0_0.GetRecommendCommodities(arg_64_0)
	local var_64_0 = arg_64_0:getChargedList()
	local var_64_1 = arg_64_0:GetNormalList()
	local var_64_2 = arg_64_0:GetNormalGroupList()

	if not var_64_0 or not var_64_1 or not var_64_2 then
		return {}
	end

	local var_64_3 = {}

	for iter_64_0, iter_64_1 in ipairs(pg.recommend_shop.all) do
		local var_64_4 = pg.TimeMgr.GetInstance()

		if var_64_4:inTime(pg.recommend_shop[iter_64_1].time) then
			local var_64_5 = RecommendCommodity.New({
				id = iter_64_1,
				chargedList = var_64_0,
				normalList = var_64_1,
				normalGroupList = var_64_2
			})

			if var_64_5:CanShow() then
				table.insert(var_64_3, var_64_5)
			end
		end
	end

	table.sort(var_64_3, function(arg_65_0, arg_65_1)
		return arg_65_0:GetOrder() < arg_65_1:GetOrder()
	end)

	return var_64_3
end

function var_0_0.GetGiftCommodity(arg_66_0, arg_66_1, arg_66_2)
	local var_66_0 = Goods.Create({
		shop_id = arg_66_1
	}, arg_66_2)

	if var_66_0:isChargeType() then
		var_66_0:updateBuyCount((ChargeConst.getBuyCount(arg_66_0.chargeList, var_66_0.id)))
	else
		var_66_0:updateBuyCount((ChargeConst.getBuyCount(arg_66_0.normalList, var_66_0.id)))

		local var_66_1 = var_66_0:getConfig("group") or 0

		if var_66_1 > 0 then
			var_66_0:updateGroupCount((ChargeConst.getGroupLimit(arg_66_0.normalGroupList, var_66_1)))
		end
	end

	return var_66_0
end

function var_0_0.GetGroupPayCount(arg_67_0, arg_67_1)
	for iter_67_0, iter_67_1 in ipairs(arg_67_0.normalGroupList) do
		if iter_67_1.shop_id == arg_67_1 then
			return arg_67_0.normalGroupList[iter_67_0].pay_count or 0
		end
	end

	return 0
end

function var_0_0.SpecialBannerBlockCheck(arg_68_0, arg_68_1)
	if not LOCK_SHOP_BANNER_US then
		return true
	end

	local var_68_0, var_68_1 = unpack(getGameset("levellimit_shopbanner"))

	return var_68_0 <= arg_68_1.level or arg_68_0.name ~= "banner_big" or table.contains(var_68_1, arg_68_0.id)
end

function var_0_0.GiftPackageRedDotTip(arg_69_0, arg_69_1, arg_69_2)
	if arg_69_0:ShouldRefreshChargeList() then
		table.insert({}, function(arg_70_0)
			pg.m02:sendNotification(GAME.GET_CHARGE_LIST, {
				callback = arg_70_0
			})

			return
		end)
	end

	seriesAsync({}, function()
		local var_71_0 = underscore.any(arg_69_0:GetAllShowGiftPackages(arg_69_2), function(arg_72_0)
			return arg_72_0:isTip()
		end)

		for iter_71_0, iter_71_1 in ipairs(arg_69_1) do
			setActive(iter_71_1, var_71_0)
		end

		return
	end)

	return
end

function var_0_0.GetAllShowGiftPackages(arg_73_0, arg_73_1)
	assert(not arg_73_0:ShouldRefreshChargeList())

	local var_73_0 = {}
	local var_73_1 = RefluxShopView.getAllRefluxPackID()
	local var_73_2 = getProxy(PlayerProxy):getRawData()

	for iter_73_0, iter_73_1 in pairs(pg.pay_data_display.all) do
		if not table.contains(var_73_1, iter_73_1) then
			local var_73_3 = pg.pay_data_display[iter_73_1].extra_service
			local var_73_4 = pg.pay_data_display[iter_73_1].akashi_pick > 0

			if (arg_73_1 == nil or var_73_4 == arg_73_1) and (var_73_3 == Goods.ITEM_BOX or var_73_3 == Goods.PASS_ITEM) then
				local var_73_5 = Goods.Create({
					shop_id = iter_73_1
				}, Goods.TYPE_CHARGE)

				if arg_73_0:filterLimitTypeGoods(var_73_5, var_73_2) then
					table.insert(var_73_0, var_73_5)
				end
			end
		end
	end

	local var_73_6 = pg.shop_template.get_id_list_by_genre[ShopArgs.GiftPackage] or {}

	for iter_73_2, iter_73_3 in ipairs(var_73_6) do
		local var_73_7 = pg.shop_template[iter_73_3].akashi_pick > 0

		if (arg_73_1 == nil or var_73_7 == arg_73_1) and not table.contains(var_73_1, iter_73_3) then
			table.insert(var_73_0, (Goods.Create({
				shop_id = iter_73_3
			}, Goods.TYPE_GIFT_PACKAGE)))
		end
	end

	local var_73_8 = pg.shop_template.get_id_list_by_genre[ShopArgs.GiftActPackage] or {}

	for iter_73_4, iter_73_5 in ipairs(var_73_8) do
		local var_73_9 = pg.shop_template[iter_73_5].akashi_pick > 0

		if (arg_73_1 == nil or var_73_9 == arg_73_1) and not table.contains(var_73_1, iter_73_5) then
			table.insert(var_73_0, (Goods.Create({
				shop_id = iter_73_5
			}, Goods.TYPE_GIFT_PACKAGE_ACT)))
		end
	end

	for iter_73_6, iter_73_7 in ipairs(var_73_0) do
		if iter_73_7:isChargeType() then
			iter_73_7:updateBuyCount((ChargeConst.getBuyCount(arg_73_0.chargeList, iter_73_7.id)))

			if iter_73_7:canPurchase() and iter_73_7:inTime() then
				table.insert({}, iter_73_7)
			end
		elseif not iter_73_7:isLevelLimit(var_73_2.level, true) then
			iter_73_7:updateBuyCount((ChargeConst.getBuyCount(arg_73_0.normalList, iter_73_7.id)))

			local var_73_10 = iter_73_7:getConfig("group") or 0
			local var_73_11 = false

			if var_73_10 > 0 then
				local var_73_12 = iter_73_7:getConfig("group_limit")
				local var_73_13 = ChargeConst.getGroupLimit(arg_73_0.normalGroupList, var_73_10)

				iter_73_7:updateGroupCount(var_73_13)

				var_73_11 = var_73_12 > 0 and var_73_12 <= var_73_13
			end

			local var_73_14, var_73_15 = pg.TimeMgr.GetInstance():inTime(iter_73_7:getConfig("time"))

			if var_73_15 then
				table.insert({}, iter_73_7)
			end

			if var_73_14 and iter_73_7:canPurchase() and not var_73_11 then
				table.insert({}, iter_73_7)
			end
		end
	end

	return {}, {}
end

function var_0_0.filterLimitTypeGoods(arg_74_0, arg_74_1, arg_74_2)
	return switch(arg_74_1:getConfig("limit_type"), {
		[3] = function()
			if arg_74_1:getConfig("limit_arg") ~= 0 or arg_74_1:isLevelLimit(arg_74_2.level, true) then
				return false
			end

			local var_75_0

			for iter_75_0, iter_75_1 in ipairs(arg_74_1:getSameLimitGroupTecGoods()) do
				local var_75_1, var_75_2

				if iter_75_1:getConfig("limit_arg") == 1 then
					var_75_1 = iter_75_1
				elseif iter_75_1:getConfig("limit_arg") == 2 then
					var_75_0 = iter_75_1
				elseif iter_75_1:getConfig("limit_arg") == 3 then
					var_75_2 = iter_75_1
				end
			end

			if ChargeConst.getBuyCount(arg_74_0.chargeList, (nil).id) > 0 then
				return false
			elseif ChargeConst.getBuyCount(arg_74_0.chargeList, var_75_0.id) > 0 and ChargeConst.getBuyCount(arg_74_0.chargeList, (nil).id) > 0 then
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
				if iter_76_1:getConfig("limit_arg") ~= 0 and ChargeConst.getBuyCount(arg_74_0.chargeList, iter_76_1.id) > 0 then
					return false
				end
			end

			return true
		end
	}, function()
		return true
	end)
end

return var_0_0
