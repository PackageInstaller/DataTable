class = var_0_10000

local var_0_0 = "ShopsProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.MERITOROUS_SHOP_UPDATED = "ShopsProxy:MERITOROUS_SHOP_UPDATED"
var_0_1.SHOPPINGSTREET_UPDATE = "ShopsProxy:SHOPPINGSTREET_UPDATE"
var_0_1.FIRST_CHARGE_IDS_UPDATED = "ShopsProxy:FIRST_CHARGE_IDS_UPDATED"
var_0_1.CHARGED_LIST_UPDATED = "ShopsProxy:CHARGED_LIST_UPDATED"
var_0_1.NORMAL_LIST_UPDATED = "ShopsProxy:NORMAL_LIST_UPDATED"
var_0_1.NORMAL_GROUP_LIST_UPDATED = "ShopsProxy:NORMAL_GROUP_LIST_UPDATED"
var_0_1.ACTIVITY_SHOP_UPDATED = "ShopsProxy:ACTIVITY_SHOP_UPDATED"
var_0_1.GUILD_SHOP_ADDED = "ShopsProxy:GUILD_SHOP_ADDED"
var_0_1.GUILD_SHOP_UPDATED = "ShopsProxy:GUILD_SHOP_UPDATED"
var_0_1.ACTIVITY_SHOPS_UPDATED = "ShopsProxy:ACTIVITY_SHOPS_UPDATED"
var_0_1.SHAM_SHOP_UPDATED = "ShopsProxy:SHAM_SHOP_UPDATED"
var_0_1.FRAGMENT_SHOP_UPDATED = "ShopsProxy:FRAGMENT_SHOP_UPDATED"
var_0_1.ACTIVITY_SHOP_GOODS_UPDATED = "ShopsProxy:ACTIVITY_SHOP_GOODS_UPDATED"
var_0_1.META_SHOP_GOODS_UPDATED = "ShopsProxy:META_SHOP_GOODS_UPDATED"
var_0_1.MEDAL_SHOP_UPDATED = "ShopsProxy:MEDAL_SHOP_UPDATED"
var_0_1.QUOTA_SHOP_UPDATED = "ShopsProxy:QUOTA_SHOP_UPDATED"
var_0_1.CRUISE_SHOP_UPDATED = "ShopsProxy:CRUISE_SHOP_UPDATED"

function var_0_1.register(arg_1_0)
	arg_1_0.shopStreet = nil
	arg_1_0.meritorousShop = nil
	arg_1_0.guildShop = nil
	arg_1_0.refreshChargeList = false
	arg_1_0.metaShop = nil
	arg_1_0.miniShop = nil

	arg_1_0:on(22102, function(arg_2_0)
		getProxy = var_2_10001
		ShopsProxy = var_2_10002

		local var_2_0 = var_2_10001(var_2_10002)

		ShoppingStreet = var_2_10002

		local var_2_1 = var_2_10002.New(arg_2_0.street)

		var_2_0:setShopStreet(var_2_1)

		return
	end)

	ShamBattleShop = var_1
	arg_1_0.shamShop = var_1.New()
	FragmentShop = var_1
	arg_1_0.fragmentShop = var_1.New()

	arg_1_0:on(16200, function(arg_3_0)
		local var_3_0 = arg_1_0.shamShop

		var_1.update(var_3_0, arg_3_0.month, arg_3_0.core_shop_list)

		local var_3_1 = arg_1_0.fragmentShop

		var_1.update(var_3_1, arg_3_0.month, arg_3_0.blue_shop_list, arg_3_0.normal_shop_list)

		return
	end)

	arg_1_0.timers = {}
	arg_1_0.tradeNoPrev = ""
	pg = var_1

	local var_1_0 = var_1.shop_template

	arg_1_0.freeGiftIdList = {}
	pairs = var_2

	for iter_1_0, iter_1_1 in var_2(var_1_0.all) do
		local var_1_1 = var_1_0[iter_1_1].genre

		ShopArgs = var_1_10008

		if var_1_1 == var_1_10008.GiftPackage and var_1_0[iter_1_1].discount == 100 then
			table = var_7

			var_7.insert(arg_1_0.freeGiftIdList, iter_1_1)
		end
	end

	arg_1_0.newServerShopList = {}

	return
end

function var_0_1.timeCall(arg_4_0)
	local var_4_0 = {}

	ProxyRegister = var_1_10002
	var_4_0[var_1_10002.DayCall] = function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0

		if var_2.getShopStreet(var_5_0) then
			var_2:resetflashCount()

			local var_5_1 = arg_4_0

			var_3.setShopStreet(var_5_1, var_2)
		end

		arg_4_0.refreshChargeList = true

		local var_5_2 = arg_4_0

		if var_3.getMiniShop(var_5_2) and var_3:checkShopFlash() then
			pg = var_4

			local var_5_3 = var_4.m02
			local var_5_4 = var_4.sendNotification

			GAME = var_2_10006

			var_5_4(var_5_3, var_2_10006.MINI_GAME_SHOP_FLUSH)
		end

		if arg_5_0 == 1 then
			local var_5_5 = arg_4_0.shamShop

			var_4.update(var_5_5, arg_5_1.month, {})

			local var_5_6 = arg_4_0

			var_4.AddShamShop(var_5_6, arg_4_0.shamShop)

			local var_5_7 = arg_4_0.fragmentShop

			var_4.Reset(var_5_7, arg_5_1.month)

			local var_5_8 = arg_4_0

			var_4.AddFragmentShop(var_5_8, arg_4_0.fragmentShop)

			LOCK_UR_SHIP = var_4

			if not var_4 then
				pg = var_4

				local var_5_9 = var_4.gameset.urpt_chapter_max.description[1]

				getProxy = var_6
				BagProxy = var_7

				local var_5_10 = var_6(var_7)

				var_6.ClearLimitCnt(var_5_10, var_5_9)
			end
		end

		return
	end

	return var_4_0
end

function var_0_1.setShopStreet(arg_6_0, arg_6_1)
	arg_6_0.shopStreet = arg_6_1

	local var_6_0 = arg_6_0
	local var_6_1 = arg_6_0.sendNotification
	local var_6_2 = var_0_1.SHOPPINGSTREET_UPDATE
	local var_6_3 = {}

	Clone = var_1_10006
	var_6_3.shopStreet = var_1_10006(arg_6_0.shopStreet)

	var_6_1(var_6_0, var_6_2, var_6_3)

	return
end

function var_0_1.UpdateShopStreet(arg_7_0, arg_7_1)
	arg_7_0.shopStreet = arg_7_1

	return
end

function var_0_1.getShopStreet(arg_8_0)
	Clone = var_1_10001

	return var_1_10001(arg_8_0.shopStreet)
end

function var_0_1.getMeritorousShop(arg_9_0)
	Clone = var_1_10001

	return var_1_10001(arg_9_0.meritorousShop)
end

function var_0_1.addMeritorousShop(arg_10_0, arg_10_1)
	arg_10_0.meritorousShop = arg_10_1

	local var_10_0 = arg_10_0
	local var_10_1 = arg_10_0.sendNotification
	local var_10_2 = var_0_1.MERITOROUS_SHOP_UPDATED

	Clone = var_1_10005

	var_10_1(var_10_0, var_10_2, var_1_10005(arg_10_1))

	return
end

function var_0_1.updateMeritorousShop(arg_11_0, arg_11_1)
	arg_11_0.meritorousShop = arg_11_1

	return
end

function var_0_1.getMiniShop(arg_12_0)
	Clone = var_1_10001

	return var_1_10001(arg_12_0.miniShop)
end

function var_0_1.setMiniShop(arg_13_0, arg_13_1)
	arg_13_0.miniShop = arg_13_1

	return
end

function var_0_1.setNormalList(arg_14_0, arg_14_1)
	arg_14_0.normalList = arg_14_1 or {}

	return
end

function var_0_1.GetNormalList(arg_15_0)
	Clone = var_1_10001

	return var_1_10001(arg_15_0.normalList)
end

function var_0_1.GetNormalByID(arg_16_0, arg_16_1)
	if not arg_16_0.normalList then
		arg_16_0.normalList = {}
	end

	local var_16_0

	if not arg_16_0.normalList[arg_16_1] then
		Goods = var_16_0
		var_16_0 = var_16_0.Create

		local var_16_1 = {
			buyCount = 0,
			id = arg_16_1
		}

		Goods = var_1_10004
		var_16_0 = var_16_0(var_16_1, var_1_10004.TYPE_GIFT_PACKAGE)
	end

	arg_16_0.normalList[arg_16_1] = var_16_0

	return arg_16_0.normalList[arg_16_1]
end

function var_0_1.updateNormalByID(arg_17_0, arg_17_1)
	arg_17_0.normalList[arg_17_1.id] = arg_17_1

	return
end

function var_0_1.checkHasFreeNormal(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0.freeGiftIdList) do
		if arg_18_0:checkNormalCanPurchase(iter_18_1) then
			return true
		end
	end

	return false
end

function var_0_1.checkNormalCanPurchase(arg_19_0, arg_19_1)
	if arg_19_0.normalList[arg_19_1] ~= nil then
		local var_19_0 = arg_19_0.normalList[arg_19_1]

		if not var_2.inTime(var_19_0) then
			return false
		end

		local var_19_1

		if not var_2:getConfig("group") then
			var_19_1 = 0
		end

		if var_19_1 > 0 then
			local var_19_2 = var_2:getConfig("group_limit")
			local var_19_3 = arg_19_0:getGroupLimit(var_19_1)

			return var_19_2 > 0 and var_19_3 < var_19_2
		elseif var_2:canPurchase() then
			return true
		end
	else
		local var_19_4 = arg_19_0:GetNormalByID(arg_19_1)

		return var_2.inTime(var_19_4)
	end

	return
end

function var_0_1.setNormalGroupList(arg_20_0, arg_20_1)
	arg_20_0.normalGroupList = arg_20_1

	return
end

function var_0_1.GetNormalGroupList(arg_21_0)
	return arg_21_0.normalGroupList
end

function var_0_1.updateNormalGroupList(arg_22_0, arg_22_1, arg_22_2)
	if arg_22_1 <= 0 then
		return
	end

	ipairs = var_3

	for iter_22_0, iter_22_1 in var_3(arg_22_0.normalGroupList) do
		if iter_22_1.shop_id == arg_22_1 then
			local var_22_0

			if not arg_22_0.normalGroupList[iter_22_0].pay_count then
				var_22_0 = 0
			end

			arg_22_0.normalGroupList[iter_22_0].pay_count = var_22_0 + arg_22_2

			return
		end
	end

	table = var_3

	var_3.insert(arg_22_0.normalGroupList, {
		shop_id = arg_22_1,
		pay_count = arg_22_2
	})

	return
end

function var_0_1.getGroupLimit(arg_23_0, arg_23_1)
	if not arg_23_0.normalGroupList then
		return 0
	end

	ipairs = var_2

	for iter_23_0, iter_23_1 in var_2(arg_23_0.normalGroupList) do
		if iter_23_1.shop_id == arg_23_1 then
			return iter_23_1.pay_count
		end
	end

	return 0
end

function var_0_1.addActivityShops(arg_24_0, arg_24_1)
	arg_24_0.activityShops = arg_24_1

	arg_24_0:sendNotification(var_0_1.ACTIVITY_SHOPS_UPDATED)

	return
end

function var_0_1.getActivityShopById(arg_25_0, arg_25_1)
	assert = var_1_10002

	var_1_10002(arg_25_0.activityShops[arg_25_1], "activity shop should exist" .. arg_25_1)

	return arg_25_0.activityShops[arg_25_1]
end

function var_0_1.updateActivityShop(arg_26_0, arg_26_1, arg_26_2)
	assert = var_1_10003

	var_1_10003(arg_26_0.activityShops, "activityShops can not be nil")

	arg_26_0.activityShops[arg_26_1] = arg_26_2

	arg_26_0:sendNotification(var_0_1.ACTIVITY_SHOP_UPDATED, {
		activityId = arg_26_1,
		shop = arg_26_2:clone()
	})

	return
end

function var_0_1.UpdateActivityGoods(arg_27_0, arg_27_1, arg_27_2, arg_27_3)
	local var_27_0 = arg_27_0:getActivityShopById(arg_27_1)
	local var_27_1 = var_4.getGoodsById(var_27_0, arg_27_2)

	var_5.addBuyCount(var_27_1, arg_27_3)

	arg_27_0.activityShops[arg_27_1] = var_4

	arg_27_0:sendNotification(var_0_1.ACTIVITY_SHOP_GOODS_UPDATED, {
		activityId = arg_27_1,
		goodsId = arg_27_2
	})

	return
end

function var_0_1.getActivityShops(arg_28_0)
	return arg_28_0.activityShops
end

function var_0_1.setFirstChargeList(arg_29_0, arg_29_1)
	arg_29_0.firstChargeList = arg_29_1

	local var_29_0 = arg_29_0
	local var_29_1 = arg_29_0.sendNotification
	local var_29_2 = var_0_1.FIRST_CHARGE_IDS_UPDATED

	Clone = var_1_10005

	var_29_1(var_29_0, var_29_2, var_1_10005(arg_29_1))

	return
end

function var_0_1.getFirstChargeList(arg_30_0)
	Clone = var_1_10001

	return var_1_10001(arg_30_0.firstChargeList)
end

function var_0_1.setChargedList(arg_31_0, arg_31_1)
	arg_31_0.chargeList = arg_31_1

	local var_31_0 = arg_31_0
	local var_31_1 = arg_31_0.sendNotification
	local var_31_2 = var_0_1.CHARGED_LIST_UPDATED

	Clone = var_1_10005

	var_31_1(var_31_0, var_31_2, var_1_10005(arg_31_1))

	return
end

function var_0_1.getChargedList(arg_32_0)
	Clone = var_1_10001

	return var_1_10001(arg_32_0.chargeList)
end

local var_0_2 = 3
local var_0_3 = 10

function var_0_1.chargeFailed(arg_33_0, arg_33_1, arg_33_2)
	if not arg_33_0.timers[arg_33_1] then
		pg = var_3

		local var_33_0 = var_3.UIMgr.GetInstance()

		var_3.LoadingOn(var_33_0)

		local var_33_1 = arg_33_0.timers

		Timer = var_33_0
		var_33_1[arg_33_1] = var_33_0.New(function()
			if arg_33_0.timers[arg_33_1].loop == 1 then
				pg = var_0

				local var_34_0 = var_0.UIMgr.GetInstance()

				var_0.LoadingOff(var_34_0)
			end

			PaySuccess = var_0

			var_0(arg_33_1, arg_33_2)

			return
		end, var_0_2, var_0_3)

		local var_33_2 = arg_33_0.timers[arg_33_1]

		var_3.Start(var_33_2)
	end

	return
end

function var_0_1.removeChargeTimer(arg_35_0, arg_35_1)
	if arg_35_0.timers[arg_35_1] then
		pg = var_2

		local var_35_0 = var_2.UIMgr.GetInstance()

		var_2.LoadingOff(var_35_0)

		local var_35_1 = arg_35_0.timers[arg_35_1]

		var_2.Stop(var_35_1)

		arg_35_0.timers[arg_35_1] = nil
	end

	return
end

function var_0_1.addWaitTimer(arg_36_0)
	pg = var_1_10001

	local var_36_0 = var_1_10001.UIMgr.GetInstance()

	var_1.LoadingOn(var_36_0)

	Timer = var_1
	arg_36_0.waitBiliTimer = var_1.New(function()
		local var_37_0 = arg_36_0

		var_0.removeWaitTimer(var_37_0)

		pg = var_0

		local var_37_1 = var_0.MsgboxMgr.GetInstance()
		local var_37_2 = var_0.ShowMsgBox
		local var_37_3 = {
			hideNo = true
		}

		i18n = var_2_10003
		var_37_3.content = var_2_10003("charge_time_out")

		var_37_2(var_37_1, var_37_3)

		return
	end, 25, 1)

	local var_36_1 = arg_36_0.waitBiliTimer

	var_1.Start(var_36_1)

	return
end

function var_0_1.removeWaitTimer(arg_38_0)
	if arg_38_0.waitBiliTimer then
		pg = var_1

		local var_38_0 = var_1.UIMgr.GetInstance()

		var_1.LoadingOff(var_38_0)

		local var_38_1 = arg_38_0.waitBiliTimer

		var_1.Stop(var_38_1)

		arg_38_0.waitBiliTimer = nil
	end

	return
end

function var_0_1.setGuildShop(arg_39_0, arg_39_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_39_0 = arg_39_1

	GuildShop = var_1_10005

	var_1_10002(var_1_10003(var_39_0, var_1_10005), "shop should instance of GuildShop")

	assert = var_1_10002

	var_1_10002(arg_39_0.guildShop == nil, "shop already exist")

	arg_39_0.guildShop = arg_39_1

	arg_39_0:sendNotification(var_0_1.GUILD_SHOP_ADDED, arg_39_0.guildShop)

	return
end

function var_0_1.getGuildShop(arg_40_0)
	return arg_40_0.guildShop
end

function var_0_1.updateGuildShop(arg_41_0, arg_41_1, arg_41_2)
	assert = var_1_10003
	isa = var_1_10004

	local var_41_0 = arg_41_1

	GuildShop = var_1_10006

	var_1_10003(var_1_10004(var_41_0, var_1_10006), "shop should instance of GuildShop")

	assert = var_1_10003

	var_1_10003(arg_41_0.guildShop, "should exist shop")

	arg_41_0.guildShop = arg_41_1

	arg_41_0:sendNotification(var_0_1.GUILD_SHOP_UPDATED, {
		shop = arg_41_0.guildShop,
		reset = arg_41_2
	})

	return
end

function var_0_1.AddShamShop(arg_42_0, arg_42_1)
	arg_42_0.shamShop = arg_42_1

	arg_42_0:sendNotification(var_0_1.SHAM_SHOP_UPDATED, arg_42_1)

	return
end

function var_0_1.updateShamShop(arg_43_0, arg_43_1)
	arg_43_0.shamShop = arg_43_1

	return
end

function var_0_1.getShamShop(arg_44_0)
	return arg_44_0.shamShop
end

function var_0_1.AddFragmentShop(arg_45_0, arg_45_1)
	arg_45_0.fragmentShop = arg_45_1

	arg_45_0:sendNotification(var_0_1.FRAGMENT_SHOP_UPDATED, arg_45_1)

	return
end

function var_0_1.updateFragmentShop(arg_46_0, arg_46_1)
	arg_46_0.fragmentShop = arg_46_1

	return
end

function var_0_1.getFragmentShop(arg_47_0)
	return arg_47_0.fragmentShop
end

function var_0_1.AddMetaShop(arg_48_0, arg_48_1)
	arg_48_0.metaShop = arg_48_1

	return
end

function var_0_1.GetMetaShop(arg_49_0)
	return arg_49_0.metaShop
end

function var_0_1.UpdateMetaShopGoods(arg_50_0, arg_50_1, arg_50_2)
	local var_50_0 = arg_50_0:GetMetaShop()
	local var_50_1 = var_3.getGoodsById(var_50_0, arg_50_1)

	var_4.addBuyCount(var_50_1, arg_50_2)
	arg_50_0:sendNotification(var_0_1.META_SHOP_GOODS_UPDATED, {
		goodsId = arg_50_1
	})

	return
end

function var_0_1.SetNewServerShop(arg_51_0, arg_51_1, arg_51_2)
	arg_51_0.newServerShopList[arg_51_1] = arg_51_2

	return
end

function var_0_1.GetNewServerShop(arg_52_0, arg_52_1)
	return arg_52_0.newServerShopList[arg_52_1]
end

function var_0_1.SetMedalShop(arg_53_0, arg_53_1)
	arg_53_0.medalShop = arg_53_1

	return
end

function var_0_1.UpdateMedalShop(arg_54_0, arg_54_1)
	arg_54_0.medalShop = arg_54_1

	arg_54_0:sendNotification(var_0_1.MEDAL_SHOP_UPDATED, arg_54_1)

	return
end

function var_0_1.GetMedalShop(arg_55_0)
	return arg_55_0.medalShop
end

function var_0_1.setQuotaShop(arg_56_0, arg_56_1)
	arg_56_0.quotaShop = arg_56_1

	return
end

function var_0_1.getQuotaShop(arg_57_0)
	return arg_57_0.quotaShop
end

function var_0_1.updateQuotaShop(arg_58_0, arg_58_1, arg_58_2)
	arg_58_0.quotaShop = arg_58_1

	arg_58_0:sendNotification(var_0_1.QUOTA_SHOP_UPDATED, {
		shop = arg_58_0.quotaShop,
		reset = arg_58_2
	})

	return
end

function var_0_1.SetCruiseShop(arg_59_0, arg_59_1)
	arg_59_0.cruiseShop = arg_59_1

	return
end

function var_0_1.UpdateCruiseShop(arg_60_0)
	CruiseShop = var_1_10001
	arg_60_0.cruiseShop = var_1_10001.New(arg_60_0:GetNormalList(), arg_60_0:GetNormalGroupList())

	arg_60_0:sendNotification(var_0_1.CRUISE_SHOP_UPDATED, {
		shop = arg_60_0.cruiseShop
	})

	return
end

function var_0_1.GetCruiseShop(arg_61_0)
	return arg_61_0.cruiseShop
end

function var_0_1.remove(arg_62_0)
	pairs = var_1_10001

	for iter_62_0, iter_62_1 in var_1_10001(arg_62_0.timers) do
		iter_62_1:Stop()
	end

	arg_62_0.timers = nil

	arg_62_0:removeWaitTimer()

	return
end

function var_0_1.ShouldRefreshChargeList(arg_63_0)
	local var_63_0 = arg_63_0:getFirstChargeList()
	local var_63_1 = arg_63_0:getChargedList()
	local var_63_2 = arg_63_0:GetNormalList()
	local var_63_3 = arg_63_0:GetNormalGroupList()

	return not var_63_0 or not var_63_1 or not var_63_2 or not var_63_3 or arg_63_0.refreshChargeList
end

function var_0_1.GetRecommendCommodities(arg_64_0)
	local var_64_0 = arg_64_0:getChargedList()
	local var_64_1 = arg_64_0:GetNormalList()
	local var_64_2 = arg_64_0:GetNormalGroupList()

	if not var_64_0 or not var_64_1 or not var_64_2 then
		return {}
	end

	local var_64_3 = {}

	ipairs = var_1_10005
	pg = var_1_10006

	for iter_64_0, iter_64_1 in var_1_10005(var_1_10006.recommend_shop.all) do
		pg = var_1_10010
		var_1_10010 = var_1_10010.recommend_shop[iter_64_1].time
		pg = var_1_10011

		local var_64_4 = var_1_10011.TimeMgr.GetInstance()

		if var_1_10011.inTime(var_64_4, var_1_10010) then
			RecommendCommodity = var_1_10011

			local var_64_5 = var_1_10011.New({
				id = iter_64_1,
				chargedList = var_64_0,
				normalList = var_64_1,
				normalGroupList = var_64_2
			})

			if var_1_10011.CanShow(var_64_5) then
				table = var_12

				var_12.insert(var_64_3, var_1_10011)
			end
		end
	end

	table = var_5

	var_5.sort(var_64_3, function(arg_65_0, arg_65_1)
		return arg_65_0:GetOrder() < arg_65_1:GetOrder()
	end)

	return var_64_3
end

function var_0_1.GetGiftCommodity(arg_66_0, arg_66_1, arg_66_2)
	Goods = var_1_10003

	local var_66_0 = var_1_10003.Create({
		shop_id = arg_66_1
	}, arg_66_2)
	local var_66_1

	if var_3.isChargeType(var_66_0) then
		ChargeConst = var_66_1
		var_66_1 = var_66_1.getBuyCount(arg_66_0.chargeList, var_3.id)

		var_3:updateBuyCount(var_66_1)
	else
		ChargeConst = var_66_1

		local var_66_2 = var_66_1.getBuyCount(arg_66_0.normalList, var_3.id)

		var_3:updateBuyCount(var_66_2)

		local var_66_3

		if not var_3:getConfig("group") then
			var_66_3 = 0
		end

		if 0 < var_66_3 then
			ChargeConst = var_6

			local var_66_4 = var_6.getGroupLimit(arg_66_0.normalGroupList, var_66_3)

			var_3:updateGroupCount(var_66_4)
		end
	end

	return var_3
end

function var_0_1.GetGroupPayCount(arg_67_0, arg_67_1)
	ipairs = var_1_10002

	for iter_67_0, iter_67_1 in var_1_10002(arg_67_0.normalGroupList) do
		if iter_67_1.shop_id == arg_67_1 then
			local var_67_0

			if not arg_67_0.normalGroupList[iter_67_0].pay_count then
				var_67_0 = 0
			end

			return var_67_0
		end
	end

	return 0
end

function var_0_1.SpecialBannerBlockCheck(arg_68_0, arg_68_1)
	LOCK_SHOP_BANNER_US = var_1_10002

	if not var_1_10002 then
		return true
	end

	unpack = var_1_10002
	getGameset = var_1_10003

	local var_68_0, var_68_1 = var_1_10002(var_1_10003("levellimit_shopbanner"))
	local var_68_2

	if not (var_68_0 <= arg_68_1.level) and arg_68_0.name == "banner_big" then
		table = var_4
		var_68_2 = var_4.contains(var_68_1, arg_68_0.id)

		if false then
			var_68_2 = false
		end
	else
		var_68_2 = true
	end

	return var_68_2
end

function var_0_1.GiftPackageRedDotTip(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0 = {}

	if arg_69_0:ShouldRefreshChargeList() then
		table = var_4

		var_4.insert(var_69_0, function(arg_70_0)
			pg = var_2_10001

			local var_70_0 = var_2_10001.m02
			local var_70_1 = var_1.sendNotification

			GAME = var_2_10003

			var_70_1(var_70_0, var_2_10003.GET_CHARGE_LIST, {
				callback = arg_70_0
			})

			return
		end)
	end

	seriesAsync = var_4

	var_4(var_69_0, function()
		underscore = var_2_10000

		local var_71_0 = var_2_10000.any
		local var_71_1 = arg_69_0
		local var_71_2 = var_71_0(var_1.GetAllShowGiftPackages(var_71_1, arg_69_2), function(arg_72_0)
			return arg_72_0:isTip()
		end)

		ipairs = var_1

		for iter_71_0, iter_71_1 in var_1(arg_69_1) do
			setActive = var_2_10006

			var_2_10006(iter_71_1, var_71_2)
		end

		return
	end)

	return
end

function var_0_1.GetAllShowGiftPackages(arg_73_0, arg_73_1)
	assert = var_1_10002

	local var_73_0 = arg_73_0

	var_1_10002(not arg_73_0.ShouldRefreshChargeList(var_73_0))

	local var_73_1 = {}

	RefluxShopView = var_3

	local var_73_2 = var_3.getAllRefluxPackID()

	getProxy = var_73_0
	PlayerProxy = var_1_10005

	local var_73_3 = var_73_0(var_1_10005)
	local var_73_4 = var_4.getRawData(var_73_3)

	pg = var_73_3

	local var_73_5 = var_73_3.pay_data_display

	pairs = var_1_10006

	for iter_73_0, iter_73_1 in var_1_10006(var_73_5.all) do
		table = var_1_10011

		if not var_1_10011.contains(var_73_2, iter_73_1) then
			local var_73_6 = var_73_5[iter_73_1].extra_service
			local var_73_7 = var_1_10011.akashi_pick
			local var_73_8 = 0 < var_73_7

			if arg_73_1 == nil or var_73_8 == arg_73_1 then
				Goods = var_14

				if var_73_6 ~= var_14.ITEM_BOX then
					Goods = var_14

					if var_73_6 == var_14.PASS_ITEM then
						Goods = var_14

						local var_73_9 = var_14.Create
						local var_73_10 = {
							shop_id = iter_73_1
						}

						Goods = var_1_10016

						local var_73_11 = var_73_9(var_73_10, var_1_10016.TYPE_CHARGE)

						var_1_10016 = arg_73_0

						if arg_73_0.filterLimitTypeGoods(var_1_10016, var_73_11, var_73_4) then
							table = var_15

							var_15.insert(var_73_1, var_73_11)
						end
					end
				end
			end
		end
	end

	ipairs = var_6
	pg = var_7

	local var_73_12 = var_7.shop_template.get_id_list_by_genre

	ShopArgs = var_8

	local var_73_13

	if not var_73_12[var_8.GiftPackage] then
		var_73_13 = {}
	end

	for iter_73_2, iter_73_3 in var_6(var_73_13) do
		pg = var_1_10011

		local var_73_14 = var_1_10011.shop_template[iter_73_3].akashi_pick
		local var_73_15 = 0 < var_73_14

		if arg_73_1 == nil or var_73_15 == arg_73_1 then
			table = var_13

			if not var_13.contains(var_73_2, iter_73_3) then
				Goods = var_13

				local var_73_16 = var_13.Create
				local var_73_17 = {
					shop_id = iter_73_3
				}

				Goods = var_15

				local var_73_18 = var_73_16(var_73_17, var_15.TYPE_GIFT_PACKAGE)

				table = var_73_17

				var_73_17.insert(var_73_1, var_73_18)
			end
		end
	end

	ipairs = var_6
	pg = var_7

	local var_73_19 = var_7.shop_template.get_id_list_by_genre

	ShopArgs = var_8

	local var_73_20

	if not var_73_19[var_8.GiftActPackage] then
		var_73_20 = {}
	end

	for iter_73_4, iter_73_5 in var_6(var_73_20) do
		pg = var_1_10011

		local var_73_21 = var_1_10011.shop_template[iter_73_5].akashi_pick
		local var_73_22 = 0 < var_73_21

		if arg_73_1 == nil or var_73_22 == arg_73_1 then
			table = var_13

			if not var_13.contains(var_73_2, iter_73_5) then
				Goods = var_13

				local var_73_23 = var_13.Create
				local var_73_24 = {
					shop_id = iter_73_5
				}

				Goods = var_15

				local var_73_25 = var_73_23(var_73_24, var_15.TYPE_GIFT_PACKAGE_ACT)

				table = var_73_24

				var_73_24.insert(var_73_1, var_73_25)
			end
		end
	end

	local var_73_26 = {}
	local var_73_27 = {}

	ipairs = var_8

	for iter_73_6, iter_73_7 in var_8(var_73_1) do
		if iter_73_7:isChargeType() then
			ChargeConst = var_13

			local var_73_28 = var_13.getBuyCount(arg_73_0.chargeList, iter_73_7.id)

			iter_73_7:updateBuyCount(var_73_28)

			if iter_73_7:canPurchase() and iter_73_7:inTime() then
				table = var_14

				var_14.insert(var_73_26, iter_73_7)
			end
		elseif not iter_73_7:isLevelLimit(var_73_4.level, true) then
			ChargeConst = var_13

			local var_73_29 = var_13.getBuyCount(arg_73_0.normalList, iter_73_7.id)

			iter_73_7:updateBuyCount(var_73_29)

			local var_73_30

			if not iter_73_7:getConfig("group") then
				var_73_30 = 0
			end

			local var_73_31 = false
			local var_73_33

			if 0 < var_73_30 then
				local var_73_32 = iter_73_7

				var_73_33 = iter_73_7.getConfig(var_73_32, "group_limit")
				ChargeConst = var_73_32

				local var_73_34 = var_73_32.getGroupLimit(arg_73_0.normalGroupList, var_73_30)

				iter_73_7:updateGroupCount(var_73_34)

				var_73_31 = var_73_33 > 0 and var_73_33 <= var_73_34
			end

			pg = var_73_33

			local var_73_35 = var_73_33.TimeMgr.GetInstance()
			local var_73_36, var_73_37 = var_16.inTime(var_73_35, iter_73_7:getConfig("time"))

			if var_73_37 then
				table = var_18

				var_18.insert(var_73_27, iter_73_7)
			end

			if var_73_36 and iter_73_7:canPurchase() and not var_73_31 then
				table = var_18

				var_18.insert(var_73_26, iter_73_7)
			end
		end
	end

	return var_73_26, var_73_27
end

function var_0_1.filterLimitTypeGoods(arg_74_0, arg_74_1, arg_74_2)
	local var_74_0 = arg_74_1
	local var_74_1 = arg_74_1.getConfig(var_74_0, "limit_type")

	switch = var_74_0

	return var_74_0(var_74_1, {
		[3] = function()
			local var_75_0 = arg_74_1

			if var_0.getConfig(var_75_0, "limit_arg") == 0 then
				local var_75_1 = arg_74_1

				if var_0.isLevelLimit(var_75_1, arg_74_2.level, true) then
					return false
				end

				local var_75_2
				local var_75_3
				local var_75_4

				ipairs = var_2_10003

				local var_75_5 = arg_74_1

				for iter_75_0, iter_75_1 in var_2_10003(var_4.getSameLimitGroupTecGoods(var_75_5)) do
					if iter_75_1:getConfig("limit_arg") == 1 then
						var_75_3 = iter_75_1
					elseif iter_75_1:getConfig("limit_arg") == 2 then
						var_75_2 = iter_75_1
					elseif iter_75_1:getConfig("limit_arg") == 3 then
						var_75_4 = iter_75_1
					end
				end

				ChargeConst = var_3

				local var_75_6 = var_3.getBuyCount(arg_74_0.chargeList, var_75_2.id)

				ChargeConst = var_4

				local var_75_7 = var_4.getBuyCount(arg_74_0.chargeList, var_75_3.id)

				ChargeConst = var_5

				local var_75_8 = var_5.getBuyCount(arg_74_0.chargeList, var_75_4.id)

				if var_75_7 > 0 then
					return false
				elseif var_75_6 > 0 and var_75_8 > 0 then
					return false
				else
					return true
				end

				return
			end
		end,
		[5] = function()
			local var_76_0 = arg_74_1

			if var_0.getConfig(var_76_0, "limit_arg") == 0 then
				local var_76_1 = arg_74_1

				if var_0.isLevelLimit(var_76_1, arg_74_2.level, true) then
					return false
				end

				ipairs = var_0

				local var_76_2 = arg_74_1

				for iter_76_0, iter_76_1 in var_0(var_1.getSameLimitGroupTecGoods(var_76_2)) do
					if iter_76_1:getConfig("limit_arg") ~= 0 then
						ChargeConst = var_5

						if var_5.getBuyCount(arg_74_0.chargeList, iter_76_1.id) > 0 then
							return false
						end
					end
				end

				return true
			end
		end
	}, function()
		return true
	end)
end

return var_0_1
