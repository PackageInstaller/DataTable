class = var_0_10000

local var_0_0 = "NewShopsMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.FAST_BUILD_ITEM_ID = 61004
var_0_1.ON_SHOPPING = "NewShopsMediator:ON_SHOPPING"
var_0_1.REFRESH_STREET_SHOP = "NewShopsMediator:REFRESH_STREET_SHOP"
var_0_1.REFRESH_MILITARY_SHOP = "NewShopsMediator:REFRESH_MILITARY_SHOP"
var_0_1.ON_SHAM_SHOPPING = "NewShopsMediator:ON_SHAM_SHOPPING"
var_0_1.ON_FRAGMENT_SHOPPING = "NewShopsMediator:ON_FRAGMENT_SHOPPING"
var_0_1.ON_ACT_SHOPPING = "NewShopsMediator:ON_ACT_SHOPPING"
var_0_1.SELL_BLUEPRINT = "NewShopsMediator:SELL_BLUEPRINT"
var_0_1.GO_MALL = "NewShopsMediator:GO_MALL"
var_0_1.ON_SKIN_SHOP = "NewShopsMediator:ON_SKIN_SHOP"
var_0_1.SET_PLAYER_FLAG = "NewShopsMediator:SET_PLAYER_FLAG"
var_0_1.ON_GUILD_SHOPPING = "NewShopsMediator:ON_GUILD_SHOPPING"
var_0_1.ON_MEDAL_SHOPPING = "NewShopsMediator:ON_MEDAL_SHOPPING"
var_0_1.REFRESH_GUILD_SHOP = "NewShopsMediator:REFRESH_GUILD_SHOP"
var_0_1.REFRESH_MEDAL_SHOP = "NewShopsMediator:REFRESH_MEDAL_SHOP"
var_0_1.ON_GUILD_PURCHASE = "NewShopsMediator:ON_GUILD_PURCHASE"
var_0_1.ON_META_SHOP = "NewShopsMediator:ON_META_SHOP"
var_0_1.ON_ESKIN_PREVIEW = "NewShopsMediator:ON_ESKIN_PREVIEW"
var_0_1.ON_QUOTA_SHOPPING = "NewShopsMediator:ON_QUOTA_SHOPPING"
var_0_1.ON_MINI_GAME_SHOP_BUY = "NewShopsMediator:ON_MINI_GAME_SHOP_BUY"
var_0_1.ON_MINI_GAME_SHOP_FLUSH = "NewShopsMediator:ON_MINI_GAME_SHOP_FLUSH"
var_0_1.MINI_GAME_SHOP_BUY_DONE = "NewShopsMediator:MINI_GAME_SHOP_BUY_DONE"
var_0_1.UR_EXCHANGE_TRACKING = "NewShopsMediator:UR_EXCHANGE_TRACKING"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_META_SHOP, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3, arg_2_4, arg_2_5)
		local var_2_0 = arg_1_0
		local var_2_1 = var_6.sendNotification

		GAME = var_2_10008

		var_2_1(var_2_0, var_2_10008.ON_META_SHOPPING, {
			activity_id = arg_2_1,
			cmd = arg_2_2,
			arg1 = arg_2_3,
			arg2 = arg_2_4,
			kvargs1 = arg_2_5
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_GUILD_SHOPPING, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10005

		var_3_1(var_3_0, var_2_10005.ON_GUILD_SHOP_PURCHASE, {
			goodsId = arg_3_1,
			selectedId = arg_3_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MINI_GAME_SHOP_BUY, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.MINI_GAME_SHOP_BUY, arg_4_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_MINI_GAME_SHOP_FLUSH, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10005

		var_5_1(var_5_0, var_2_10005.MINI_GAME_SHOP_FLUSH, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_MEDAL_SHOPPING, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.ON_MEDAL_SHOP_PURCHASE, {
			goodsId = arg_6_1,
			selectedId = arg_6_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_GUILD_SHOP, function(arg_7_0, arg_7_1)
		if arg_7_1 then
			GuildConst = var_2_10002

			if not var_2_10002.MANUAL_REFRESH then
				GuildConst = var_2_10002
				var_2_10002 = var_2_10002.AUTO_REFRESH
			end

			local var_7_0 = arg_1_0
			local var_7_1 = var_3.sendNotification

			GAME = var_2_10005

			var_7_1(var_7_0, var_2_10005.GET_GUILD_SHOP, {
				type = var_2_10002
			})

			return
		end
	end)
	arg_1_0:bind(var_0_1.REFRESH_MEDAL_SHOP, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		GAME = var_2_10003

		var_8_1(var_8_0, var_2_10003.GET_MEDALSHOP, {})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SKIN_SHOP, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_9_2 = var_2_10004.CHANGE_SCENE

		SCENE = var_2_10005

		var_9_1(var_9_0, var_9_2, var_2_10005.SKINSHOP)

		return
	end)
	arg_1_0:bind(var_0_1.GO_MALL, function(arg_10_0, arg_10_1)
		getProxy = var_2_10002
		ContextProxy = var_2_10003

		local var_10_0 = var_2_10002(var_2_10003)
		local var_10_1 = arg_1_0.contextData.fromMediatorName

		NewShopMainMediator = var_2_10004

		if var_10_1 == var_2_10004.__cname then
			local var_10_2 = var_10_0

			var_10_1 = var_10_0.getContextByMediator
			NewShopMainMediator = var_2_10005
			var_10_1 = var_10_1(var_10_2, var_2_10005)
			var_2_10005 = arg_1_0.viewComponent

			var_4.closeView(var_2_10005)
		else
			pg = var_10_1

			local var_10_3 = var_10_1.m02
			local var_10_4 = var_3.sendNotification

			GAME = var_2_10005

			local var_10_5 = var_2_10005.CHANGE_SCENE

			SCENE = var_2_10006

			var_10_4(var_10_3, var_10_5, var_2_10006.CHARGE, {
				wrap = arg_10_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.SELL_BLUEPRINT, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.sendNotification

		GAME = var_2_10004

		var_11_1(var_11_0, var_2_10004.FRAG_SELL, arg_11_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACT_SHOPPING, function(arg_12_0, arg_12_1, arg_12_2, arg_12_3, arg_12_4)
		local var_12_0 = arg_1_0
		local var_12_1 = var_5.sendNotification

		GAME = var_2_10007

		var_12_1(var_12_0, var_2_10007.ACTIVITY_OPERATION, {
			activity_id = arg_12_1,
			cmd = arg_12_2,
			arg1 = arg_12_3,
			arg2 = arg_12_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FRAGMENT_SHOPPING, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_1_0
		local var_13_1 = var_3.sendNotification

		GAME = var_2_10005

		var_13_1(var_13_0, var_2_10005.FRAG_SHOPPING, {
			id = arg_13_1,
			count = arg_13_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHAM_SHOPPING, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0
		local var_14_1 = var_3.sendNotification

		GAME = var_2_10005

		var_14_1(var_14_0, var_2_10005.SHAM_SHOPPING, {
			id = arg_14_1,
			count = arg_14_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_15_0, arg_15_1, arg_15_2)
		local var_15_0 = arg_1_0
		local var_15_1 = var_3.sendNotification

		GAME = var_2_10005

		var_15_1(var_15_0, var_2_10005.SHOPPING, {
			id = arg_15_1,
			count = arg_15_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_MILITARY_SHOP, function(arg_16_0, arg_16_1)
		if not arg_16_1 then
			local var_16_0 = arg_1_0
			local var_16_1 = var_2.sendNotification

			GAME = var_2_10004

			var_16_1(var_16_0, var_2_10004.GET_MILITARY_SHOP)
		else
			local var_16_2 = arg_1_0
			local var_16_3 = var_2.sendNotification

			GAME = var_2_10004

			var_16_3(var_16_2, var_2_10004.REFRESH_MILITARY_SHOP)
		end

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_STREET_SHOP, function(arg_17_0, arg_17_1)
		if not arg_17_1 then
			local var_17_0 = arg_1_0
			local var_17_1 = var_2.sendNotification

			GAME = var_2_10004

			var_17_1(var_17_0, var_2_10004.GET_SHOPSTREET)
		else
			local var_17_2 = arg_1_0
			local var_17_3 = var_2.sendNotification

			GAME = var_2_10004

			var_17_3(var_17_2, var_2_10004.SHOPPING, {
				count = 1,
				id = arg_17_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.SET_PLAYER_FLAG, function(arg_18_0, arg_18_1, arg_18_2)
		if arg_18_2 then
			local var_18_0 = arg_1_0
			local var_18_1 = var_3.sendNotification

			GAME = var_2_10005

			var_18_1(var_18_0, var_2_10005.COMMON_FLAG, {
				flagID = arg_18_1
			})
		else
			local var_18_2 = arg_1_0
			local var_18_3 = var_3.sendNotification

			GAME = var_2_10005

			var_18_3(var_18_2, var_2_10005.CANCEL_COMMON_FLAG, {
				flagID = arg_18_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_ESKIN_PREVIEW, function(arg_19_0, arg_19_1)
		pg = var_2_10002

		local var_19_0 = var_2_10002.equip_skin_template[arg_19_1]

		Ship = var_2_10003

		local var_19_1 = var_2_10003.New({
			id = var_19_0.ship_config_id,
			configId = var_19_0.ship_config_id,
			skin_id = var_19_0.ship_skin_id
		})
		local var_19_2 = {}

		if var_19_0.ship_skin_id ~= 0 then
			var_19_2 = {
				equipSkinId = 0,
				shipVO = var_19_1,
				weaponIds = {}
			}
		else
			local var_19_3 = {
				shipVO = var_19_1
			}

			Clone = var_2_10006
			var_19_3.weaponIds = var_2_10006(var_19_0.weapon_ids)
			var_19_3.equipSkinId = arg_19_1
			var_19_2 = var_19_3
		end

		local var_19_4 = arg_1_0
		local var_19_5 = var_5.addSubLayers

		Context = var_2_10007

		local var_19_6 = var_2_10007.New
		local var_19_7 = {}

		ShipPreviewLayer = var_2_10009
		var_19_7.viewComponent = var_2_10009
		ShipPreviewMediator = var_2_10009
		var_19_7.mediator = var_2_10009
		var_19_7.data = var_19_2

		var_19_5(var_19_4, var_19_6(var_19_7))

		return
	end)
	arg_1_0:bind(var_0_1.UR_EXCHANGE_TRACKING, function(arg_20_0, arg_20_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10003

		local var_20_0 = var_2_10002(var_2_10003)
		local var_20_1 = var_2.getActivityByType

		ActivityConst = var_2_10004

		if var_20_1(var_20_0, var_2_10004.ACTIVITY_TYPE_UR_EXCHANGE) then
			local var_20_2 = var_2

			if not var_2.isEnd(var_20_2) then
				getProxy = var_3
				ShopsProxy = var_20_2

				local var_20_3 = var_3(var_20_2)
				local var_20_4 = var_3.getActivityShopById(var_20_3, var_2:getConfig("config_client").shopId)
				local var_20_5 = var_3.GetCommodityById(var_20_4, var_2:getConfig("config_client").goodsId[1])

				if var_3.getConfig(var_20_5, "commodity_id") == arg_20_1 then
					pg = var_4

					local var_20_6 = var_4.GameTrackerMgr.GetInstance()
					local var_20_7 = var_4.Record

					GameTrackerBuilder = var_6

					var_20_7(var_20_6, var_6.BuildUrRedeem(arg_20_1, 1))
				end
			end
		end

		return
	end)

	local var_1_0 = arg_1_0.viewComponent

	var_1.SetShops(var_1_0, arg_1_0.contextData.shops)
	arg_1_0:bind(var_0_1.ON_QUOTA_SHOPPING, function(arg_21_0, arg_21_1, arg_21_2)
		local var_21_0 = arg_1_0
		local var_21_1 = var_3.sendNotification

		GAME = var_2_10005

		var_21_1(var_21_0, var_2_10005.QUOTA_SHOPPING, {
			id = arg_21_1,
			count = arg_21_2
		})

		return
	end)

	local var_1_1 = arg_1_0.viewComponent
	local var_1_2 = var_1.SetPlayer

	getProxy = var_3
	PlayerProxy = var_4

	local var_1_3 = var_3(var_4)

	var_1_2(var_1_1, var_3.getRawData(var_1_3))

	local var_1_4 = arg_1_0.viewComponent
	local var_1_5 = var_1.OnUpdateItems

	getProxy = var_3
	BagProxy = var_1_3

	local var_1_6 = var_3(var_1_3)

	var_1_5(var_1_4, var_3.getRawData(var_1_6))

	return
end

function var_0_1.listNotificationInterests(arg_22_0)
	local var_22_0 = {}

	PlayerProxy = var_1_10002
	var_22_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_22_0[2] = var_2.SHOPPING_DONE
	ShopsProxy = var_2
	var_22_0[3] = var_2.SHOPPINGSTREET_UPDATE
	ShopsProxy = var_2
	var_22_0[4] = var_2.MERITOROUS_SHOP_UPDATED
	ShopsProxy = var_2
	var_22_0[5] = var_2.SHAM_SHOP_UPDATED
	GAME = var_2
	var_22_0[6] = var_2.SHAM_SHOPPING_DONE
	BagProxy = var_2
	var_22_0[7] = var_2.ITEM_UPDATED
	GAME = var_2
	var_22_0[8] = var_2.FRAG_SHOPPING_DONE
	ShopsProxy = var_2
	var_22_0[9] = var_2.FRAGMENT_SHOP_UPDATED
	ShopsProxy = var_2
	var_22_0[10] = var_2.ACTIVITY_SHOP_GOODS_UPDATED
	ShopsProxy = var_2
	var_22_0[11] = var_2.ACTIVITY_SHOP_UPDATED
	GAME = var_2
	var_22_0[12] = var_2.FRAG_SELL_DONE
	ActivityProxy = var_2
	var_22_0[13] = var_2.ACTIVITY_SHOP_SHOW_AWARDS
	GAME = var_2
	var_22_0[14] = var_2.USE_ITEM_DONE
	GAME = var_2
	var_22_0[15] = var_2.ON_GUILD_SHOP_PURCHASE_DONE
	GAME = var_2
	var_22_0[16] = var_2.ON_MEDAL_SHOP_PURCHASE_DONE
	ShopsProxy = var_2
	var_22_0[17] = var_2.GUILD_SHOP_UPDATED
	ShopsProxy = var_2
	var_22_0[18] = var_2.MEDAL_SHOP_UPDATED
	GAME = var_2
	var_22_0[19] = var_2.ON_META_SHOPPING_DONE
	ShopsProxy = var_2
	var_22_0[20] = var_2.META_SHOP_GOODS_UPDATED
	ShopsProxy = var_2
	var_22_0[21] = var_2.QUOTA_SHOP_UPDATED
	GAME = var_2
	var_22_0[22] = var_2.QUOTA_SHOPPING_DONE
	GAME = var_2
	var_22_0[23] = var_2.MINI_GAME_SHOP_BUY_DONE

	return var_22_0
end

function var_0_1.handleNotification(arg_23_0, arg_23_1)
	local var_23_0 = arg_23_1:getName()
	local var_23_1 = arg_23_1
	local var_23_2 = arg_23_1.getBody(var_23_1)

	PlayerProxy = var_23_1

	if var_23_0 == var_23_1.UPDATED then
		var_1_10005 = arg_23_0.viewComponent

		var_4.SetPlayer(var_1_10005, var_23_2)
	else
		ShopsProxy = var_4

		local var_23_3

		if var_23_0 == var_4.SHOPPINGSTREET_UPDATE then
			var_1_10005 = arg_23_0.viewComponent
			var_23_3 = var_23_3.OnUpdateShop
			NewShopsScene = var_1_10006

			var_23_3(var_1_10005, var_1_10006.TYPE_SHOP_STREET, var_23_2.shopStreet)
		else
			GAME = var_23_3

			local var_23_4

			if var_23_0 == var_23_3.SHOPPING_DONE then
				var_23_4 = nil
				var_1_10005 = var_23_2.shopType
				ShopArgs = var_1_10006

				if var_1_10005 == var_1_10006.ShopStreet then
					getProxy = var_1_10005
					ShopsProxy = var_1_10006
					var_1_10006 = var_1_10005(var_1_10006)
					var_1_10007 = var_1_10005.getShopStreet(var_1_10006)
					var_23_4 = var_1_10005.getGoodsById(var_1_10007, var_23_2.id)
					var_1_10007 = arg_23_0.viewComponent
					var_1_10006 = var_1_10006.OnUpdateCommodity
					NewShopsScene = var_1_10008

					var_1_10006(var_1_10007, var_1_10008.TYPE_SHOP_STREET, var_1_10005, var_23_2.id)
				else
					var_1_10005 = var_23_2.shopType
					ShopArgs = var_1_10006

					if var_1_10005 == var_1_10006.MilitaryShop then
						getProxy = var_1_10005
						ShopsProxy = var_1_10006
						var_1_10006 = var_1_10005(var_1_10006)
						var_23_4 = var_1_10005.getMeritorousShop(var_1_10006).goods[var_23_2.id]
						var_1_10007 = arg_23_0.viewComponent
						var_1_10006 = var_1_10006.OnUpdateCommodity
						NewShopsScene = var_1_10008

						var_1_10006(var_1_10007, var_1_10008.TYPE_MILITARY_SHOP, var_1_10005, var_23_2.id)
					end
				end

				if var_23_2.awards then
					var_1_10005 = #var_23_2.awards

					if 0 < var_1_10005 then
						var_1_10006 = arg_23_0.viewComponent
						var_1_10005 = var_1_10005.emit
						BaseUI = var_1_10007

						var_1_10005(var_1_10006, var_1_10007.ON_ACHIEVE, var_23_2.awards)
					end
				end
			else
				ShopsProxy = var_23_4

				local var_23_5

				if var_23_0 == var_23_4.MERITOROUS_SHOP_UPDATED then
					var_1_10005 = arg_23_0.viewComponent
					var_23_5 = var_23_5.OnUpdateShop
					NewShopsScene = var_1_10006

					var_23_5(var_1_10005, var_1_10006.TYPE_MILITARY_SHOP, var_23_2)
				else
					ShopsProxy = var_23_5

					local var_23_6

					if var_23_0 == var_23_5.SHAM_SHOP_UPDATED then
						var_1_10005 = arg_23_0.viewComponent
						var_23_6 = var_23_6.OnUpdateShop
						NewShopsScene = var_1_10006

						var_23_6(var_1_10005, var_1_10006.TYPE_SHAM_SHOP, var_23_2)
					else
						GAME = var_23_6

						local var_23_7

						if var_23_0 == var_23_6.SHAM_SHOPPING_DONE then
							getProxy = var_23_7
							ShopsProxy = var_1_10005
							var_1_10005 = var_23_7(var_1_10005)
							var_23_7 = var_23_7.getShamShop(var_1_10005)
							var_1_10006 = arg_23_0.viewComponent
							var_1_10005 = var_1_10005.OnUpdateCommodity
							NewShopsScene = var_1_10007

							var_1_10005(var_1_10006, var_1_10007.TYPE_SHAM_SHOP, var_23_7, var_23_2.id)

							var_1_10006 = arg_23_0.viewComponent
							var_1_10005 = var_1_10005.emit
							BaseUI = var_1_10007

							var_1_10005(var_1_10006, var_1_10007.ON_ACHIEVE, var_23_2.awards)
						else
							BagProxy = var_23_7

							local var_23_8

							if var_23_0 == var_23_7.ITEM_UPDATED then
								getProxy = var_23_8
								BagProxy = var_1_10005
								var_1_10005 = var_23_8(var_1_10005)
								var_23_8 = var_23_8.getRawData(var_1_10005)
								var_1_10006 = arg_23_0.viewComponent

								var_1_10005.OnUpdateItems(var_1_10006, var_23_8)
							else
								GAME = var_23_8

								local var_23_9

								if var_23_0 == var_23_8.FRAG_SHOPPING_DONE then
									getProxy = var_23_9
									ShopsProxy = var_1_10005
									var_1_10005 = var_23_9(var_1_10005)
									var_23_9 = var_23_9.getFragmentShop(var_1_10005)
									var_1_10006 = arg_23_0.viewComponent
									var_1_10005 = var_1_10005.OnUpdateCommodity
									NewShopsScene = var_1_10007

									var_1_10005(var_1_10006, var_1_10007.TYPE_FRAGMENT, var_23_9, var_23_2.id)

									var_1_10006 = arg_23_0.viewComponent
									var_1_10005 = var_1_10005.emit
									BaseUI = var_1_10007

									var_1_10005(var_1_10006, var_1_10007.ON_ACHIEVE, var_23_2.awards)
								else
									ShopsProxy = var_23_9

									local var_23_10

									if var_23_0 == var_23_9.FRAGMENT_SHOP_UPDATED then
										var_1_10005 = arg_23_0.viewComponent
										var_23_10 = var_23_10.OnUpdateShop
										NewShopsScene = var_1_10006

										var_23_10(var_1_10005, var_1_10006.TYPE_FRAGMENT, var_23_2)
									else
										ShopsProxy = var_23_10

										local var_23_11

										if var_23_0 == var_23_10.ACTIVITY_SHOP_GOODS_UPDATED then
											getProxy = var_23_11
											ShopsProxy = var_1_10005
											var_1_10005 = var_23_11(var_1_10005)
											var_23_11 = var_23_11.getActivityShopById(var_1_10005, var_23_2.activityId)
											var_1_10006 = arg_23_0.viewComponent
											var_1_10005 = var_1_10005.OnUpdateCommodity
											NewShopsScene = var_1_10007

											var_1_10005(var_1_10006, var_1_10007.TYPE_ACTIVITY, var_23_11, var_23_2.goodsId)
										else
											ShopsProxy = var_23_11

											local var_23_12

											if var_23_0 == var_23_11.META_SHOP_GOODS_UPDATED then
												getProxy = var_23_12
												ShopsProxy = var_1_10005
												var_1_10005 = var_23_12(var_1_10005)
												var_23_12 = var_23_12.GetMetaShop(var_1_10005)
												var_1_10006 = arg_23_0.viewComponent
												var_1_10005 = var_1_10005.OnUpdateCommodity
												NewShopsScene = var_1_10007

												var_1_10005(var_1_10006, var_1_10007.TYPE_META, var_23_12, var_23_2.goodsId)
											else
												ShopsProxy = var_23_12

												local var_23_13

												if var_23_0 == var_23_12.ACTIVITY_SHOP_UPDATED then
													var_1_10005 = arg_23_0.viewComponent
													var_23_13 = var_23_13.OnUpdateShop
													NewShopsScene = var_1_10006

													var_23_13(var_1_10005, var_1_10006.TYPE_ACTIVITY, var_23_2.shop)
												else
													ActivityProxy = var_23_13

													local var_23_14

													if var_23_0 == var_23_13.ACTIVITY_SHOP_SHOW_AWARDS then
														var_1_10005 = arg_23_0.viewComponent
														var_23_14 = var_23_14.emit
														BaseUI = var_1_10006

														var_23_14(var_1_10005, var_1_10006.ON_ACHIEVE, var_23_2.awards, var_23_2.callback)
													else
														GAME = var_23_14

														local var_23_15

														if var_23_0 == var_23_14.USE_ITEM_DONE then
															if #var_23_2.drops ~= 0 then
																var_1_10005 = arg_23_0.viewComponent
																var_23_15 = var_23_15.emit
																BaseUI = var_1_10006

																var_23_15(var_1_10005, var_1_10006.ON_AWARD, {
																	items = var_23_2.drops
																})
															end
														else
															GAME = var_23_15

															local var_23_16

															if var_23_0 == var_23_15.FRAG_SELL_DONE then
																var_1_10005 = arg_23_0.viewComponent
																var_23_16 = var_23_16.emit
																BaseUI = var_1_10006

																var_23_16(var_1_10005, var_1_10006.ON_ACHIEVE, var_23_2.awards)

																var_23_16 = arg_23_0.viewComponent.pages
																NewShopsScene = var_1_10005
																var_23_16 = var_23_16[var_1_10005.TYPE_FRAGMENT]

																if arg_23_0.viewComponent.page == var_23_16 then
																	var_1_10006 = arg_23_0.viewComponent.page

																	var_1_10005.OnFragmentSellUpdate(var_1_10006)
																end
															else
																GAME = var_23_16

																local var_23_17

																if var_23_0 == var_23_16.ON_GUILD_SHOP_PURCHASE_DONE then
																	var_1_10005 = arg_23_0.viewComponent
																	var_23_17 = var_23_17.emit
																	BaseUI = var_1_10006

																	var_23_17(var_1_10005, var_1_10006.ON_ACHIEVE, var_23_2.awards)
																else
																	GAME = var_23_17

																	local var_23_18

																	if var_23_0 == var_23_17.ON_MEDAL_SHOP_PURCHASE_DONE then
																		var_1_10005 = arg_23_0.viewComponent
																		var_23_18 = var_23_18.emit
																		BaseUI = var_1_10006

																		var_23_18(var_1_10005, var_1_10006.ON_ACHIEVE, var_23_2.awards)
																	else
																		ShopsProxy = var_23_18

																		local var_23_19

																		if var_23_0 == var_23_18.GUILD_SHOP_UPDATED then
																			var_1_10005 = arg_23_0.viewComponent
																			var_23_19 = var_23_19.OnUpdateShop
																			NewShopsScene = var_1_10006

																			var_23_19(var_1_10005, var_1_10006.TYPE_GUILD, var_23_2.shop)
																		else
																			ShopsProxy = var_23_19

																			local var_23_20

																			if var_23_0 == var_23_19.MEDAL_SHOP_UPDATED then
																				var_1_10005 = arg_23_0.viewComponent
																				var_23_20 = var_23_20.OnUpdateShop
																				NewShopsScene = var_1_10006

																				var_23_20(var_1_10005, var_1_10006.TYPE_MEDAL, var_23_2)
																			else
																				GAME = var_23_20

																				local var_23_21

																				if var_23_0 == var_23_20.ON_META_SHOPPING_DONE then
																					var_1_10005 = arg_23_0.viewComponent
																					var_23_21 = var_23_21.emit
																					BaseUI = var_1_10006

																					var_23_21(var_1_10005, var_1_10006.ON_ACHIEVE, var_23_2.awards)
																				else
																					ShopsProxy = var_23_21

																					local var_23_22

																					if var_23_0 == var_23_21.QUOTA_SHOP_UPDATED then
																						var_1_10005 = arg_23_0.viewComponent
																						var_23_22 = var_23_22.OnUpdateShop
																						NewShopsScene = var_1_10006

																						var_23_22(var_1_10005, var_1_10006.TYPE_QUOTA, var_23_2.shop)
																					else
																						GAME = var_23_22

																						local var_23_23

																						if var_23_0 == var_23_22.QUOTA_SHOPPING_DONE then
																							getProxy = var_23_23
																							ShopsProxy = var_1_10005
																							var_1_10005 = var_23_23(var_1_10005)
																							var_23_23 = var_23_23.getQuotaShop(var_1_10005)
																							var_1_10006 = arg_23_0.viewComponent
																							var_1_10005 = var_1_10005.OnUpdateCommodity
																							NewShopsScene = var_1_10007

																							var_1_10005(var_1_10006, var_1_10007.TYPE_QUOTA_SHOP, var_23_23, var_23_2.id)

																							var_1_10006 = arg_23_0.viewComponent
																							var_1_10005 = var_1_10005.emit
																							BaseUI = var_1_10007

																							var_1_10005(var_1_10006, var_1_10007.ON_ACHIEVE, var_23_2.awards)
																						else
																							GAME = var_23_23

																							if var_23_0 == var_23_23.MINI_GAME_SHOP_BUY_DONE then
																								if var_23_2.list then
																									var_1_10005 = #var_4

																									if 0 < var_1_10005 then
																										var_1_10006 = arg_23_0.viewComponent
																										var_1_10005 = var_1_10005.emit
																										BaseUI = var_1_10007

																										var_1_10005(var_1_10006, var_1_10007.ON_ACHIEVE, var_4)
																									end
																								end

																								getProxy = var_1_10005
																								ShopsProxy = var_1_10006

																								local var_23_24 = var_1_10005(var_1_10006)
																								local var_23_25 = var_5.getMiniShop(var_23_24)
																								local var_23_26 = arg_23_0.viewComponent
																								local var_23_27 = var_6.OnUpdateShop

																								NewShopsScene = var_1_10008

																								var_23_27(var_23_26, var_1_10008.TYPE_MINI_GAME, var_23_25)
																							end
																						end
																					end
																				end
																			end
																		end
																	end
																end
															end
														end
													end
												end
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

return var_0_1
