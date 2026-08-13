class = var_0_10000

local var_0_0 = "NewShopMainMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.OPEN_LAYER = "NewShopMainMediator.OPEN_LAYER"
var_0_1.SWITCH_TO_SHOP = "NewShopMainMediator.SWITCH_TO_SHOP"
var_0_1.CHARGE = "NewShopMainMediator.CHARGE"
var_0_1.BUY_ITEM = "NewShopMainMediator.BUY_ITEM"
var_0_1.CLICK_MING_SHI = "NewShopMainMediator.CLICK_MING_SHI"
var_0_1.GET_CHARGE_LIST = "NewShopMainMediator.GET_CHARGE_LIST"
var_0_1.OPEN_CHARGE_ITEM_PANEL = "NewShopMainMediator.OPEN_CHARGE_ITEM_PANEL"
var_0_1.OPEN_CHARGE_ITEM_BOX = "NewShopMainMediator.OPEN_CHARGE_ITEM_BOX"
var_0_1.OPEN_CHARGE_BIRTHDAY = "NewShopMainMediator.OPEN_CHARGE_BIRTHDAY"
var_0_1.OPEN_USER_AGREE = "NewShopMainMediator.OPEN_USER_AGREE"
var_0_1.VIEW_SKIN_PROBABILITY = "NewShopMainMediator.VIEW_SKIN_PROBABILITY"
var_0_1.OPEN_TEC_SHIP_GIFT_SELL_LAYER = "NewShopMainMediator.OPEN_TEC_SHIP_GIFT_SELL_LAYER"
var_0_1.OPEN_BATTLE_UI_SELL_LAYER = "NewShopMainMediator.OPEN_BATTLE_UI_SELL_LAYER"
var_0_1.FAST_BUILD_ITEM_ID = 61004
var_0_1.REFRESH_STREET_SHOP = "NewShopMainMediator.REFRESH_STREET_SHOP"
var_0_1.REFRESH_MILITARY_SHOP = "NewShopMainMediator.REFRESH_MILITARY_SHOP"
var_0_1.ON_SHAM_SHOPPING = "NewShopMainMediator.ON_SHAM_SHOPPING"
var_0_1.ON_FRAGMENT_SHOPPING = "NewShopMainMediator.ON_FRAGMENT_SHOPPING"
var_0_1.ON_ACT_SHOPPING = "NewShopMainMediator.ON_ACT_SHOPPING"
var_0_1.SELL_BLUEPRINT = "NewShopMainMediator.SELL_BLUEPRINT"
var_0_1.SET_PLAYER_FLAG = "NewShopMainMediator.SET_PLAYER_FLAG"
var_0_1.ON_GUILD_SHOPPING = "NewShopMainMediator.ON_GUILD_SHOPPING"
var_0_1.ON_MEDAL_SHOPPING = "NewShopMainMediator.ON_MEDAL_SHOPPING"
var_0_1.REFRESH_GUILD_SHOP = "NewShopMainMediator.REFRESH_GUILD_SHOP"
var_0_1.REFRESH_MEDAL_SHOP = "NewShopMainMediator.REFRESH_MEDAL_SHOP"
var_0_1.ON_META_SHOP = "NewShopMainMediator.ON_META_SHOP"
var_0_1.ON_ESKIN_PREVIEW = "NewShopMainMediator.ON_ESKIN_PREVIEW"
var_0_1.ON_QUOTA_SHOPPING = "NewShopMainMediator.ON_QUOTA_SHOPPING"
var_0_1.ON_MINI_GAME_SHOP_BUY = "NewShopMainMediator.ON_MINI_GAME_SHOP_BUY"
var_0_1.ON_MINI_GAME_SHOP_FLUSH = "NewShopMainMediator.ON_MINI_GAME_SHOP_FLUSH"
var_0_1.UR_EXCHANGE_TRACKING = "NewShopMainMediator.UR_EXCHANGE_TRACKING"
var_0_1.ON_ACT_OPERATION = "NewShopMainMediator.ON_ACT_OPERATION"
var_0_1.NOTI_UPDATE_CURRENT = "NewShopMainMediator.NOTI_UPDATE_CURRENT"
var_0_1.OPEN_GIFT_ACT_LAYER = "NewShopMainMediator.OPEN_GIFT_ACT_LAYER"
var_0_1.ON_SUBLAYER_EVENT = "NewShopMainMediator.ON_SUBLAYER_EVENT"

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0

	arg_1_0.bind(var_1_0, var_0_1.OPEN_LAYER, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.addSubLayers

		Context = var_2_10007

		var_2_1(var_2_0, var_2_10007.New({
			viewComponent = arg_2_1,
			mediator = arg_2_2,
			data = arg_2_3
		}))

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)
	local var_1_2 = var_1.getData(var_1_1)
	local var_1_3 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_3, var_1_2)

	local var_1_4 = arg_1_0.viewComponent

	var_3.SetSupplyShopList(var_1_4, arg_1_0.contextData.supplyShopList)

	local var_1_5 = arg_1_0.viewComponent
	local var_1_6 = var_3.OnInitItems

	getProxy = var_6
	BagProxy = var_1_10008

	local var_1_7 = var_6(var_1_10008)

	var_1_6(var_1_5, var_6.getRawData(var_1_7))
	arg_1_0:bind(var_0_1.VIEW_SKIN_PROBABILITY, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0.contextData.warp = arg_3_2

		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		var_3_1(var_3_0, var_3_2, var_2_10007.PROBABILITY_SKINSHOP, {
			commodityId = arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GET_CHARGE_LIST, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.sendNotification

		GAME = var_2_10004

		var_4_1(var_4_0, var_2_10004.GET_CHARGE_LIST)

		return
	end)
	arg_1_0:bind(var_0_1.SWITCH_TO_SHOP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_5_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_5_1(var_5_0, var_5_2, var_2_10006.SHOP, arg_5_1)

		return
	end)
	arg_1_0:bind(var_0_1.CHARGE, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10005

		var_6_1(var_6_0, var_2_10005.CHARGE_OPERATION, {
			shopId = arg_6_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.BUY_ITEM, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10006

		var_7_1(var_7_0, var_2_10006.SHOPPING, {
			id = arg_7_1,
			count = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.CLICK_MING_SHI, function(arg_8_0)
		local var_8_0 = arg_1_0
		local var_8_1 = var_1.sendNotification

		GAME = var_2_10004

		var_8_1(var_8_0, var_2_10004.CLICK_MING_SHI)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_PANEL, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_9_2 = var_2_10005.New
		local var_9_3 = {}

		ChargeItemPanelMediator = var_2_10008
		var_9_3.mediator = var_2_10008
		ChargeItemPanelLayer = var_2_10008
		var_9_3.viewComponent = var_2_10008
		var_9_3.data = {
			panelConfig = arg_9_1
		}

		var_9_1(var_9_0, var_9_2(var_9_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_ITEM_BOX, function(arg_10_0, arg_10_1)
		local var_10_0 = arg_1_0
		local var_10_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_10_2 = var_2_10005.New
		local var_10_3 = {}

		ChargeItemBoxMediator = var_2_10008
		var_10_3.mediator = var_2_10008
		ChargeItemBoxLayer = var_2_10008
		var_10_3.viewComponent = var_2_10008
		var_10_3.data = {
			panelConfig = arg_10_1
		}

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_CHARGE_BIRTHDAY, function(arg_11_0, arg_11_1)
		local var_11_0 = arg_1_0
		local var_11_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_11_2 = var_2_10005.New
		local var_11_3 = {}

		ChargeBirthdayMediator = var_2_10008
		var_11_3.mediator = var_2_10008
		ChargeBirthdayLayer = var_2_10008
		var_11_3.viewComponent = var_2_10008
		var_11_3.data = {}

		var_11_1(var_11_0, var_11_2(var_11_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_USER_AGREE, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_12_2 = var_2_10005.New
		local var_12_3 = {}

		ChargeJPUserAgreeMediator = var_2_10008
		var_12_3.mediator = var_2_10008
		ChargeJPUserAgreeLayer = var_2_10008
		var_12_3.viewComponent = var_2_10008
		var_12_3.data = {
			contentStr = arg_12_1
		}

		var_12_1(var_12_0, var_12_2(var_12_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_TEC_SHIP_GIFT_SELL_LAYER, function(arg_13_0, arg_13_1, arg_13_2)
		local var_13_0 = arg_1_0
		local var_13_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_13_2 = var_2_10006.New
		local var_13_3 = {}

		ChargeTecShipGiftSellMediator = var_2_10009
		var_13_3.mediator = var_2_10009
		ChargeTecShipGiftSellLayer = var_2_10009
		var_13_3.viewComponent = var_2_10009
		var_13_3.data = {
			showGoodVO = arg_13_1,
			chargedList = arg_13_2
		}

		var_13_1(var_13_0, var_13_2(var_13_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_BATTLE_UI_SELL_LAYER, function(arg_14_0, arg_14_1, arg_14_2)
		local var_14_0 = arg_1_0
		local var_14_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_14_2 = var_2_10006.New
		local var_14_3 = {}

		ChargeBattleUISellMediator = var_2_10009
		var_14_3.mediator = var_2_10009
		ChargeBattleUISellLayer = var_2_10009
		var_14_3.viewComponent = var_2_10009
		var_14_3.data = {
			showGoodVO = arg_14_1,
			chargedList = arg_14_2
		}

		var_14_1(var_14_0, var_14_2(var_14_3))

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_STREET_SHOP, function(arg_15_0, arg_15_1)
		if not arg_15_1 then
			local var_15_0 = arg_1_0
			local var_15_1 = var_2.sendNotification

			GAME = var_2_10005

			var_15_1(var_15_0, var_2_10005.GET_SHOPSTREET)
		else
			local var_15_2 = arg_1_0
			local var_15_3 = var_2.sendNotification

			GAME = var_2_10005

			var_15_3(var_15_2, var_2_10005.SHOPPING, {
				count = 1,
				id = arg_15_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_MILITARY_SHOP, function(arg_16_0, arg_16_1)
		if not arg_16_1 then
			local var_16_0 = arg_1_0
			local var_16_1 = var_2.sendNotification

			GAME = var_2_10005

			var_16_1(var_16_0, var_2_10005.GET_MILITARY_SHOP)
		else
			local var_16_2 = arg_1_0
			local var_16_3 = var_2.sendNotification

			GAME = var_2_10005

			var_16_3(var_16_2, var_2_10005.REFRESH_MILITARY_SHOP)
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHAM_SHOPPING, function(arg_17_0, arg_17_1, arg_17_2)
		local var_17_0 = arg_1_0
		local var_17_1 = var_3.sendNotification

		GAME = var_2_10006

		var_17_1(var_17_0, var_2_10006.SHAM_SHOPPING, {
			id = arg_17_1,
			count = arg_17_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_FRAGMENT_SHOPPING, function(arg_18_0, arg_18_1, arg_18_2)
		local var_18_0 = arg_1_0
		local var_18_1 = var_3.sendNotification

		GAME = var_2_10006

		var_18_1(var_18_0, var_2_10006.FRAG_SHOPPING, {
			id = arg_18_1,
			count = arg_18_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACT_SHOPPING, function(arg_19_0, arg_19_1, arg_19_2, arg_19_3, arg_19_4)
		local var_19_0 = arg_1_0
		local var_19_1 = var_5.sendNotification

		GAME = var_2_10008

		var_19_1(var_19_0, var_2_10008.ACTIVITY_OPERATION, {
			activity_id = arg_19_1,
			cmd = arg_19_2,
			arg1 = arg_19_3,
			arg2 = arg_19_4
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ACT_OPERATION, function(arg_20_0, arg_20_1, arg_20_2)
		local var_20_0 = arg_1_0
		local var_20_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_20_2 = var_2_10006.ACTIVITY_OPERATION

		setmetatable = var_2_10007

		var_20_1(var_20_0, var_20_2, var_2_10007({
			activity_id = arg_20_1
		}, {
			__index = arg_20_2
		}))

		return
	end)
	arg_1_0:bind(var_0_1.SELL_BLUEPRINT, function(arg_21_0, arg_21_1)
		local var_21_0 = arg_1_0
		local var_21_1 = var_2.sendNotification

		GAME = var_2_10005

		var_21_1(var_21_0, var_2_10005.FRAG_SELL, arg_21_1)

		return
	end)
	arg_1_0:bind(var_0_1.SET_PLAYER_FLAG, function(arg_22_0, arg_22_1, arg_22_2)
		if arg_22_2 then
			local var_22_0 = arg_1_0
			local var_22_1 = var_3.sendNotification

			GAME = var_2_10006

			var_22_1(var_22_0, var_2_10006.COMMON_FLAG, {
				flagID = arg_22_1
			})
		else
			local var_22_2 = arg_1_0
			local var_22_3 = var_3.sendNotification

			GAME = var_2_10006

			var_22_3(var_22_2, var_2_10006.CANCEL_COMMON_FLAG, {
				flagID = arg_22_1
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_GUILD_SHOPPING, function(arg_23_0, arg_23_1, arg_23_2)
		local var_23_0 = arg_1_0
		local var_23_1 = var_3.sendNotification

		GAME = var_2_10006

		var_23_1(var_23_0, var_2_10006.ON_GUILD_SHOP_PURCHASE, {
			goodsId = arg_23_1,
			selectedId = arg_23_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MEDAL_SHOPPING, function(arg_24_0, arg_24_1, arg_24_2)
		local var_24_0 = arg_1_0
		local var_24_1 = var_3.sendNotification

		GAME = var_2_10006

		var_24_1(var_24_0, var_2_10006.ON_MEDAL_SHOP_PURCHASE, {
			goodsId = arg_24_1,
			selectedId = arg_24_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.REFRESH_GUILD_SHOP, function(arg_25_0, arg_25_1)
		if arg_25_1 then
			GuildConst = var_2_10002

			if not var_2_10002.MANUAL_REFRESH then
				GuildConst = var_2_10002
				var_2_10002 = var_2_10002.AUTO_REFRESH
			end

			local var_25_0 = arg_1_0
			local var_25_1 = var_3.sendNotification

			GAME = var_2_10006

			var_25_1(var_25_0, var_2_10006.GET_GUILD_SHOP, {
				type = var_2_10002
			})

			return
		end
	end)
	arg_1_0:bind(var_0_1.REFRESH_MEDAL_SHOP, function(arg_26_0)
		local var_26_0 = arg_1_0
		local var_26_1 = var_1.sendNotification

		GAME = var_2_10004

		var_26_1(var_26_0, var_2_10004.GET_MEDALSHOP, {})

		return
	end)
	arg_1_0:bind(var_0_1.ON_META_SHOP, function(arg_27_0, arg_27_1, arg_27_2, arg_27_3, arg_27_4, arg_27_5)
		local var_27_0 = arg_1_0
		local var_27_1 = var_6.sendNotification

		GAME = var_2_10009

		var_27_1(var_27_0, var_2_10009.ON_META_SHOPPING, {
			activity_id = arg_27_1,
			cmd = arg_27_2,
			arg1 = arg_27_3,
			arg2 = arg_27_4,
			kvargs1 = arg_27_5
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ESKIN_PREVIEW, function(arg_28_0, arg_28_1)
		pg = var_2_10002

		local var_28_0 = var_2_10002.equip_skin_template[arg_28_1]

		Ship = var_2_10003

		local var_28_1 = var_2_10003.New({
			id = var_28_0.ship_config_id,
			configId = var_28_0.ship_config_id,
			skin_id = var_28_0.ship_skin_id
		})
		local var_28_2 = {}

		if var_28_0.ship_skin_id ~= 0 then
			var_28_2 = {
				equipSkinId = 0,
				shipVO = var_28_1,
				weaponIds = {}
			}
		else
			local var_28_3 = {
				shipVO = var_28_1
			}

			Clone = var_6
			var_28_3.weaponIds = var_6(var_28_0.weapon_ids)
			var_28_3.equipSkinId = arg_28_1
			var_28_2 = var_28_3
		end

		local var_28_4 = arg_1_0
		local var_28_5 = var_5.addSubLayers

		Context = var_2_10008

		local var_28_6 = var_2_10008.New
		local var_28_7 = {}

		ShipPreviewLayer = var_2_10011
		var_28_7.viewComponent = var_2_10011
		ShipPreviewMediator = var_2_10011
		var_28_7.mediator = var_2_10011
		var_28_7.data = var_28_2

		var_28_5(var_28_4, var_28_6(var_28_7))

		return
	end)
	arg_1_0:bind(var_0_1.ON_QUOTA_SHOPPING, function(arg_29_0, arg_29_1, arg_29_2)
		local var_29_0 = arg_1_0
		local var_29_1 = var_3.sendNotification

		GAME = var_2_10006

		var_29_1(var_29_0, var_2_10006.QUOTA_SHOPPING, {
			id = arg_29_1,
			count = arg_29_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_MINI_GAME_SHOP_BUY, function(arg_30_0, arg_30_1, arg_30_2)
		local var_30_0 = arg_1_0
		local var_30_1 = var_3.sendNotification

		GAME = var_2_10006

		var_30_1(var_30_0, var_2_10006.MINI_GAME_SHOP_BUY, arg_30_1)

		return
	end)
	arg_1_0:bind(var_0_1.ON_MINI_GAME_SHOP_FLUSH, function(arg_31_0, arg_31_1, arg_31_2)
		local var_31_0 = arg_1_0
		local var_31_1 = var_3.sendNotification

		GAME = var_2_10006

		var_31_1(var_31_0, var_2_10006.MINI_GAME_SHOP_FLUSH, arg_31_1)

		return
	end)
	arg_1_0:bind(var_0_1.UR_EXCHANGE_TRACKING, function(arg_32_0, arg_32_1)
		getProxy = var_2_10002
		ActivityProxy = var_2_10004

		local var_32_0 = var_2_10002(var_2_10004)
		local var_32_1 = var_2.getActivityByType

		ActivityConst = var_2_10005

		if var_32_1(var_32_0, var_2_10005.ACTIVITY_TYPE_UR_EXCHANGE) then
			local var_32_2 = var_2

			if not var_2.isEnd(var_32_2) then
				getProxy = var_3
				ShopsProxy = var_32_2

				local var_32_3 = var_3(var_32_2)
				local var_32_4 = var_3.getActivityShopById(var_32_3, var_2:getConfig("config_client").shopId)
				local var_32_5 = var_3.GetCommodityById(var_32_4, var_2:getConfig("config_client").goodsId[1])

				if var_3.getConfig(var_32_5, "commodity_id") == arg_32_1 then
					pg = var_4

					local var_32_6 = var_4.GameTrackerMgr.GetInstance()
					local var_32_7 = var_4.Record

					GameTrackerBuilder = var_7

					var_32_7(var_32_6, var_7.BuildUrRedeem(arg_32_1, 1))
				end
			end
		end

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_GIFT_ACT_LAYER, function(arg_33_0, arg_33_1)
		local var_33_0 = arg_1_0

		var_2.OpenGiftActLayer(var_33_0, arg_33_1)

		return
	end)

	return
end

function var_0_1.OpenGiftActLayer(arg_34_0, arg_34_1)
	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_34_0 = var_1_10002(var_1_10004)
	local var_34_1 = var_2.getActivityById(var_34_0, arg_34_1)

	switch = var_1_10003

	local var_34_2 = var_34_1
	local var_34_3 = var_34_1.getConfig(var_34_2, "type")
	local var_34_4 = {}

	ActivityConst = var_34_2
	var_34_4[var_34_2.ACTIVITY_TYPE_SKIN_FAKE_PACKAGE] = function()
		local var_35_0 = arg_34_0.viewComponent
		local var_35_1 = var_0.emit

		NewShopMainMediator = var_2_10003

		local var_35_2 = var_2_10003.OPEN_LAYER

		ChargeActGiftLayer = var_2_10004
		ChargeActGiftMediator = var_2_10005

		var_35_1(var_35_0, var_35_2, var_2_10004, var_2_10005, {
			actId = var_34_1.id
		})

		return
	end
	ActivityConst = var_7
	var_34_4[var_7.ACTIVITY_TYPE_TIMES_FAKE_PACKAGE] = function()
		pg = var_2_10000

		local var_36_0 = var_2_10000.activity_giftpackage
		local var_36_1 = var_34_1
		local var_36_2 = var_36_0[var_1.getConfig(var_36_1, "config_id")]

		Goods = var_1

		local var_36_3 = var_1.Create
		local var_36_4 = {
			id = var_36_2.shop_id
		}

		Goods = var_4

		local var_36_5 = var_36_3(var_36_4, var_4.TYPE_GIFT_PACKAGE_ACT)

		Drop = var_2_10002

		local var_36_6 = var_2_10002.New
		local var_36_7 = {
			count = 1
		}

		DROP_TYPE_ITEM = var_2_10005
		var_36_7.type = var_2_10005

		local var_36_8 = var_36_5

		var_36_7.id = var_36_5.getConfig(var_36_8, "effect_args")[1]

		local var_36_9 = var_36_6(var_36_7)
		local var_36_10 = var_36_5
		local var_36_11 = var_36_5.GetPrice(var_36_10)
		local var_36_12 = {}

		getProxy = var_36_10
		ShipSkinProxy = var_36_8

		local var_36_13 = var_36_10(var_36_8)

		ipairs = var_2_10006

		for iter_36_0, iter_36_1 in var_2_10006(var_36_2.skin) do
			table = var_2_10011
			var_2_10011 = var_2_10011.insert

			local var_36_14 = var_36_12

			Drop = var_2_10014
			var_2_10014 = var_2_10014.New

			local var_36_15 = {
				count = 1
			}

			DROP_TYPE_SKIN = var_2_10017
			var_36_15.type = var_2_10017
			var_36_15.id = iter_36_1
			var_36_15.got = var_36_13:hasNonLimitSkin(iter_36_1)
			underscore = var_2_10017
			var_36_15.special = var_2_10017.any(var_36_2.special_skin, function(arg_37_0)
				return iter_36_1 == arg_37_0
			end)

			var_2_10011(var_36_14, var_2_10014(var_36_15))
		end

		underscore = var_6

		local var_36_16 = var_6.all(var_36_2.special_skin, function(arg_38_0)
			local var_38_0 = var_36_13

			return var_1.hasNonLimitSkin(var_38_0, arg_38_0)
		end)
		local var_36_17 = {
			isLocalPrice = false,
			isChargeType = false,
			isMonthCard = false,
			commodity = var_36_5,
			icon = var_36_9:getIcon(),
			name = var_36_9:getName()
		}

		i18n = var_8
		var_36_17.tipExtra = var_8("charge_title_getskin")
		var_36_17.extraItems = var_36_12
		var_36_17.descExtra = var_36_2[var_36_16 and "desc_2" or "desc_1"]
		var_36_17.price = var_36_11
		var_36_17.tagType = var_36_5:getConfig("tag")

		function var_36_17.onYes()
			pg = var_3_10000

			local var_39_0 = var_3_10000.MsgboxMgr.GetInstance()
			local var_39_1 = var_0.ShowMsgBox
			local var_39_2 = {}

			i18n = var_3_10004

			local var_39_3 = "charge_scene_buy_confirm"
			local var_39_4 = var_36_11
			local var_39_5 = var_36_9

			var_39_2.content = var_3_10004(var_39_3, var_39_4, var_8.getName(var_39_5))

			function var_39_2.onYes()
				local var_40_0 = arg_34_0.viewComponent
				local var_40_1 = var_0.emit

				NewShopMainMediator = var_4_10003

				local var_40_2 = var_4_10003.ON_ACT_OPERATION
				local var_40_3 = var_34_1.id
				local var_40_4 = {
					cmd = 1
				}

				Drop = var_4_10006

				local var_40_5 = var_4_10006.New
				local var_40_6 = {}

				DROP_TYPE_RESOURCE = var_4_10009
				var_40_6.type = var_4_10009
				PlayerConst = var_4_10009
				var_40_6.id = var_4_10009.ResDiamond
				var_40_6.count = var_36_11
				var_40_4.costDrop = var_40_5(var_40_6)

				var_40_1(var_40_0, var_40_2, var_40_3, var_40_4)

				return
			end

			var_39_1(var_39_0, var_39_2)

			return
		end

		local var_36_18 = arg_34_0.viewComponent
		local var_36_19 = var_8.emit

		NewShopMainMediator = var_11

		var_36_19(var_36_18, var_11.OPEN_CHARGE_ITEM_PANEL, var_36_17)

		return
	end

	var_1_10003(var_34_3, var_34_4, function()
		assert = var_2_10000

		var_2_10000(false)

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_42_0)
	local var_42_0 = {}

	NewShopMainScene = var_1_10002
	var_42_0[var_1_10002.SHOW_OR_HIDE_UI] = function(arg_43_0, arg_43_1)
		local var_43_0 = arg_43_0.viewComponent

		var_2.ShowOrHideUI(var_43_0, arg_43_1:getBody())

		return
	end
	NewShopMainScene = var_2
	var_42_0[var_2.SHOW_OR_HIDE_UI_2] = function(arg_44_0, arg_44_1)
		local var_44_0 = arg_44_0.viewComponent

		var_2.ShowOrHideUI2(var_44_0, arg_44_1:getBody())

		return
	end
	NewShopMainScene = var_2
	var_42_0[var_2.CLOSE_VIEW] = function(arg_45_0, arg_45_1)
		local var_45_0 = arg_45_0.viewComponent

		var_2.closeView(var_45_0)

		return
	end
	PlayerProxy = var_2
	var_42_0[var_2.UPDATED] = function(arg_46_0, arg_46_1)
		local var_46_0 = arg_46_1:getBody()
		local var_46_1 = arg_46_0.viewComponent

		var_3.setPlayer(var_46_1, var_46_0)

		local var_46_2 = arg_46_0.viewComponent

		var_3.updateNoRes(var_46_2)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.FIRST_CHARGE_IDS_UPDATED] = function(arg_47_0, arg_47_1)
		local var_47_0 = arg_47_0.viewComponent

		var_2.setFirstChargeIds(var_47_0, arg_47_1:getBody())

		local var_47_1 = arg_47_0.viewComponent

		var_2.updateCurSubView(var_47_1)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.CHARGED_LIST_UPDATED] = function(arg_48_0, arg_48_1)
		local var_48_0 = arg_48_0.viewComponent

		var_2.setChargedList(var_48_0, arg_48_1:getBody())

		local var_48_1 = arg_48_0.viewComponent

		var_2.updateCurSubView(var_48_1)

		return
	end
	GAME = var_2
	var_42_0[var_2.CHARGE_CONFIRM_FAILED] = function(arg_49_0, arg_49_1)
		local var_49_0 = arg_49_1:getBody()

		getProxy = var_2_10003
		ShopsProxy = var_2_10005

		local var_49_1 = var_2_10003(var_2_10005)

		var_3.chargeFailed(var_49_1, var_49_0.payId, var_49_0.bsId)

		return
	end
	GAME = var_2
	var_42_0[var_2.SHOPPING_DONE] = function(arg_50_0, arg_50_1)
		local var_50_0 = arg_50_1:getBody()
		local var_50_1
		local var_50_2 = var_50_0.shopType

		ShopArgs = var_2_10005

		local var_50_4

		if var_50_2 == var_2_10005.ShopStreet then
			getProxy = var_50_2
			ShopsProxy = var_2_10006
			var_2_10006 = var_50_2(var_2_10006)
			var_2_10007 = var_4.getShopStreet(var_2_10006)

			local var_50_3 = var_4.getGoodsById(var_2_10007, var_50_0.id)

			var_2_10007 = arg_50_0.viewComponent
			var_50_4 = var_50_4.OnUpdateCommodity
			NewShopsScene = var_2_10008

			var_50_4(var_2_10007, var_2_10008.TYPE_SHOP_STREET, var_4, var_50_0.id)
		else
			local var_50_5 = var_50_0.shopType

			ShopArgs = var_50_4

			if var_50_5 == var_50_4.MilitaryShop then
				getProxy = var_50_5
				ShopsProxy = var_2_10006
				var_2_10006 = var_50_5(var_2_10006)

				local var_50_6 = var_4.getMeritorousShop(var_2_10006).goods[var_50_0.id]

				var_2_10007 = arg_50_0.viewComponent

				local var_50_7 = var_5.OnUpdateCommodity

				NewShopsScene = var_2_10008

				var_50_7(var_2_10007, var_2_10008.TYPE_MILITARY_SHOP, var_4, var_50_0.id)
			end
		end

		if var_50_0.awards and #var_50_0.awards > 0 then
			var_2_10006 = arg_50_0.viewComponent

			var_4.unBlurView(var_2_10006)

			var_2_10006 = arg_50_0.viewComponent

			local var_50_8 = var_4.emit

			BaseUI = var_2_10007

			var_50_8(var_2_10006, var_2_10007.ON_ACHIEVE, var_50_0.awards)
		end

		local var_50_9 = var_50_0.normalList
		local var_50_10 = var_50_0.normalGroupList

		if var_50_9 then
			local var_50_11 = arg_50_0.viewComponent

			var_2_10006.setNormalList(var_50_11, var_50_9)
		end

		if var_50_10 then
			local var_50_12 = arg_50_0.viewComponent

			var_2_10006.setNormalGroupList(var_50_12, var_50_10)
		end

		pg = var_2_10006

		local var_50_13 = var_2_10006.shop_template[var_50_0.id]
		local var_50_14 = arg_50_0.viewComponent

		var_7.checkBuyDone(var_50_14, var_50_0.id)

		local var_50_15 = arg_50_0.viewComponent

		var_7.updateCurSubView(var_50_15)

		pg = var_7

		local var_50_16 = var_7.EasyRedDotMgr.GetInstance()

		var_7.TriggerMarks(var_50_16, "specialShop")

		return
	end
	GAME = var_2
	var_42_0[var_2.USE_ITEM_DONE] = function(arg_51_0, arg_51_1)
		if #arg_51_1:getBody().drops ~= 0 then
			local var_51_0 = arg_51_0.viewComponent
			local var_51_1 = var_3.emit

			BaseUI = var_2_10006

			var_51_1(var_51_0, var_2_10006.ON_AWARD, {
				items = var_2.drops
			})
		end

		return
	end
	GAME = var_2
	var_42_0[var_2.GET_CHARGE_LIST_DONE] = function(arg_52_0, arg_52_1)
		local var_52_0 = arg_52_1:getBody().firstChargeIds
		local var_52_1 = var_2.chargedList
		local var_52_2 = var_2.normalList
		local var_52_3 = var_2.normalGroupList

		if var_52_0 then
			local var_52_4 = arg_52_0.viewComponent

			var_2_10007.setFirstChargeIds(var_52_4, var_52_0)
		end

		if var_52_1 then
			local var_52_5 = arg_52_0.viewComponent

			var_2_10007.setChargedList(var_52_5, var_52_1)
		end

		if var_52_2 then
			local var_52_6 = arg_52_0.viewComponent

			var_2_10007.setNormalList(var_52_6, var_52_2)
		end

		if var_52_3 then
			local var_52_7 = arg_52_0.viewComponent

			var_2_10007.setNormalGroupList(var_52_7, var_52_3)
		end

		if var_52_0 or var_52_1 or var_52_2 or var_52_3 then
			local var_52_8 = arg_52_0.viewComponent

			var_2_10007.updateCurSubView(var_52_8)
		end

		pg = var_2_10007

		local var_52_9 = var_2_10007.EasyRedDotMgr.GetInstance()

		var_7.TriggerMarks(var_52_9, "specialShop")

		return
	end
	GAME = var_2
	var_42_0[var_2.CLICK_MING_SHI_SUCCESS] = function(arg_53_0, arg_53_1)
		local var_53_0 = arg_53_0.viewComponent

		var_2.playHeartEffect(var_53_0)

		return
	end
	PlayerResUI = var_2
	var_42_0[var_2.GO_MALL] = function(arg_54_0, arg_54_1)
		local var_54_0 = arg_54_1:getBody()

		ChargeScene = var_2_10003

		local var_54_1 = var_2_10003.TYPE_DIAMOND

		if var_54_0 and not var_54_0.type then
			::label_54_0::

			ChargeScene = var_4
			var_54_1 = var_4.TYPE_DIAMOND
		end

		local var_54_2 = arg_54_0.viewComponent

		var_4.switchSubViewByTogger(var_54_2, var_54_1)

		local var_54_3 = arg_54_0.viewComponent
		local var_54_4 = var_4.updateNoRes
		local var_54_5

		if not var_54_0 or not var_54_0.noRes then
			var_54_5 = nil
		end

		var_54_4(var_54_3, var_54_5)

		return
	end
	GAME = var_2
	var_42_0[var_2.CHARGE_SUCCESS] = function(arg_55_0, arg_55_1)
		local var_55_0 = arg_55_1:getBody()
		local var_55_1 = arg_55_0.viewComponent

		var_3.checkBuyDone(var_55_1, "damonds")

		Goods = var_3

		local var_55_2 = var_3.Create
		local var_55_3 = {
			shop_id = var_55_0.shopId
		}

		Goods = var_6

		local var_55_4 = var_55_2(var_55_3, var_6.TYPE_CHARGE)
		local var_55_5 = arg_55_0.viewComponent

		var_4.OnChargeSuccess(var_55_5, var_55_4)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.SHOPPINGSTREET_UPDATE] = function(arg_56_0, arg_56_1)
		local var_56_0 = arg_56_1:getBody()
		local var_56_1 = arg_56_0.viewComponent
		local var_56_2 = var_3.OnUpdateShop

		NewShopsScene = var_2_10006

		var_56_2(var_56_1, var_2_10006.TYPE_SHOP_STREET, var_56_0.shopStreet)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.MERITOROUS_SHOP_UPDATED] = function(arg_57_0, arg_57_1)
		local var_57_0 = arg_57_0.viewComponent
		local var_57_1 = var_2.OnUpdateShop

		NewShopsScene = var_2_10005

		var_57_1(var_57_0, var_2_10005.TYPE_MILITARY_SHOP, arg_57_1:getBody())

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.SHAM_SHOP_UPDATED] = function(arg_58_0, arg_58_1)
		local var_58_0 = arg_58_0.viewComponent
		local var_58_1 = var_2.OnUpdateShop

		NewShopsScene = var_2_10005

		var_58_1(var_58_0, var_2_10005.TYPE_SHAM_SHOP, arg_58_1:getBody())

		return
	end
	GAME = var_2
	var_42_0[var_2.SHAM_SHOPPING_DONE] = function(arg_59_0, arg_59_1)
		local var_59_0 = arg_59_1:getBody()

		getProxy = var_2_10003
		ShopsProxy = var_2_10005

		local var_59_1 = var_2_10003(var_2_10005)
		local var_59_2 = var_3.getShamShop(var_59_1)
		local var_59_3 = arg_59_0.viewComponent
		local var_59_4 = var_4.OnUpdateCommodity

		NewShopsScene = var_2_10007

		var_59_4(var_59_3, var_2_10007.TYPE_SHAM_SHOP, var_59_2, var_59_0.id)

		local var_59_5 = arg_59_0.viewComponent
		local var_59_6 = var_4.emit

		BaseUI = var_7

		var_59_6(var_59_5, var_7.ON_ACHIEVE, var_59_0.awards)

		return
	end
	BagProxy = var_2
	var_42_0[var_2.ITEM_UPDATED] = function(arg_60_0, arg_60_1)
		getProxy = var_2_10002
		BagProxy = var_2_10004

		local var_60_0 = var_2_10002(var_2_10004)
		local var_60_1 = var_2.getRawData(var_60_0)
		local var_60_2 = arg_60_0.viewComponent

		var_3.OnUpdateItems(var_60_2, var_60_1)

		return
	end
	GAME = var_2
	var_42_0[var_2.FRAG_SHOPPING_DONE] = function(arg_61_0, arg_61_1)
		local var_61_0 = arg_61_1:getBody()

		getProxy = var_2_10003
		ShopsProxy = var_2_10005

		local var_61_1 = var_2_10003(var_2_10005)
		local var_61_2 = var_3.getFragmentShop(var_61_1)
		local var_61_3 = arg_61_0.viewComponent
		local var_61_4 = var_4.OnUpdateCommodity

		NewShopsScene = var_2_10007

		var_61_4(var_61_3, var_2_10007.TYPE_FRAGMENT, var_61_2, var_61_0.id)

		local var_61_5 = arg_61_0.viewComponent
		local var_61_6 = var_4.emit

		BaseUI = var_7

		var_61_6(var_61_5, var_7.ON_ACHIEVE, var_61_0.awards)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.FRAGMENT_SHOP_UPDATED] = function(arg_62_0, arg_62_1)
		local var_62_0 = arg_62_0.viewComponent
		local var_62_1 = var_2.OnUpdateShop

		NewShopsScene = var_2_10005

		var_62_1(var_62_0, var_2_10005.TYPE_FRAGMENT, arg_62_1:getBody())

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.ACTIVITY_SHOP_GOODS_UPDATED] = function(arg_63_0, arg_63_1)
		local var_63_0 = arg_63_1:getBody()

		getProxy = var_2_10003
		ShopsProxy = var_2_10005

		local var_63_1 = var_2_10003(var_2_10005)
		local var_63_2 = var_3.getActivityShopById(var_63_1, var_63_0.activityId)
		local var_63_3 = arg_63_0.viewComponent
		local var_63_4 = var_4.OnUpdateCommodity

		NewShopsScene = var_2_10007

		var_63_4(var_63_3, var_2_10007.TYPE_ACTIVITY, var_63_2, var_63_0.goodsId)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.META_SHOP_GOODS_UPDATED] = function(arg_64_0, arg_64_1)
		local var_64_0 = arg_64_1:getBody()

		getProxy = var_2_10003
		ShopsProxy = var_2_10005

		local var_64_1 = var_2_10003(var_2_10005)
		local var_64_2 = var_3.GetMetaShop(var_64_1)
		local var_64_3 = arg_64_0.viewComponent
		local var_64_4 = var_4.OnUpdateCommodity

		NewShopsScene = var_2_10007

		var_64_4(var_64_3, var_2_10007.TYPE_META, var_64_2, var_64_0.goodsId)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.ACTIVITY_SHOP_UPDATED] = function(arg_65_0, arg_65_1)
		local var_65_0 = arg_65_1:getBody()
		local var_65_1 = arg_65_0.viewComponent
		local var_65_2 = var_3.OnUpdateShop

		NewShopsScene = var_2_10006

		var_65_2(var_65_1, var_2_10006.TYPE_ACTIVITY, var_65_0.shop)

		return
	end
	ActivityProxy = var_2
	var_42_0[var_2.ACTIVITY_SHOP_SHOW_AWARDS] = function(arg_66_0, arg_66_1)
		local var_66_0 = arg_66_1:getBody()
		local var_66_1 = arg_66_0.viewComponent
		local var_66_2 = var_3.emit

		BaseUI = var_2_10006

		var_66_2(var_66_1, var_2_10006.ON_ACHIEVE, var_66_0.awards, var_66_0.callback)

		return
	end
	GAME = var_2
	var_42_0[var_2.FRAG_SELL_DONE] = function(arg_67_0, arg_67_1)
		local var_67_0 = arg_67_1:getBody()
		local var_67_1 = arg_67_0.viewComponent

		var_3.OnFragmentSellUpdate(var_67_1)

		local var_67_2 = arg_67_0.viewComponent
		local var_67_3 = var_3.emit

		BaseUI = var_2_10006

		var_67_3(var_67_2, var_2_10006.ON_ACHIEVE, var_67_0.awards)

		return
	end
	GAME = var_2
	var_42_0[var_2.ON_GUILD_SHOP_PURCHASE_DONE] = function(arg_68_0, arg_68_1)
		local var_68_0 = arg_68_1:getBody()
		local var_68_1 = arg_68_0.viewComponent
		local var_68_2 = var_3.emit

		BaseUI = var_2_10006

		var_68_2(var_68_1, var_2_10006.ON_ACHIEVE, var_68_0.awards)

		return
	end
	GAME = var_2
	var_42_0[var_2.ON_MEDAL_SHOP_PURCHASE_DONE] = function(arg_69_0, arg_69_1)
		local var_69_0 = arg_69_1:getBody()
		local var_69_1 = arg_69_0.viewComponent
		local var_69_2 = var_3.emit

		BaseUI = var_2_10006

		var_69_2(var_69_1, var_2_10006.ON_ACHIEVE, var_69_0.awards)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.GUILD_SHOP_UPDATED] = function(arg_70_0, arg_70_1)
		local var_70_0 = arg_70_1:getBody()
		local var_70_1 = arg_70_0.viewComponent
		local var_70_2 = var_3.OnUpdateShop

		NewShopsScene = var_2_10006

		var_70_2(var_70_1, var_2_10006.TYPE_GUILD, var_70_0.shop)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.GUILD_SHOP_ADDED] = function(arg_71_0, arg_71_1)
		local var_71_0 = arg_71_1:getBody()
		local var_71_1 = arg_71_0.viewComponent
		local var_71_2 = var_3.OnUpdateShop

		NewShopsScene = var_2_10006

		var_71_2(var_71_1, var_2_10006.TYPE_GUILD, var_71_0.shop)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.MEDAL_SHOP_UPDATED] = function(arg_72_0, arg_72_1)
		local var_72_0 = arg_72_0.viewComponent
		local var_72_1 = var_2.OnUpdateShop

		NewShopsScene = var_2_10005

		var_72_1(var_72_0, var_2_10005.TYPE_MEDAL, arg_72_1:getBody())

		return
	end
	GAME = var_2
	var_42_0[var_2.ON_META_SHOPPING_DONE] = function(arg_73_0, arg_73_1)
		local var_73_0 = arg_73_1:getBody()
		local var_73_1 = arg_73_0.viewComponent
		local var_73_2 = var_3.emit

		BaseUI = var_2_10006

		var_73_2(var_73_1, var_2_10006.ON_ACHIEVE, var_73_0.awards)

		return
	end
	ShopsProxy = var_2
	var_42_0[var_2.QUOTA_SHOP_UPDATED] = function(arg_74_0, arg_74_1)
		local var_74_0 = arg_74_1:getBody()
		local var_74_1 = arg_74_0.viewComponent
		local var_74_2 = var_3.OnUpdateShop

		NewShopsScene = var_2_10006

		var_74_2(var_74_1, var_2_10006.TYPE_QUOTA, var_74_0.shop)

		return
	end
	GAME = var_2
	var_42_0[var_2.QUOTA_SHOPPING_DONE] = function(arg_75_0, arg_75_1)
		local var_75_0 = arg_75_1:getBody()

		getProxy = var_2_10003
		ShopsProxy = var_2_10005

		local var_75_1 = var_2_10003(var_2_10005)
		local var_75_2 = var_3.getQuotaShop(var_75_1)
		local var_75_3 = arg_75_0.viewComponent
		local var_75_4 = var_4.OnUpdateCommodity

		NewShopsScene = var_2_10007

		var_75_4(var_75_3, var_2_10007.TYPE_QUOTA, var_75_2, var_75_0.id)

		local var_75_5 = arg_75_0.viewComponent
		local var_75_6 = var_4.emit

		BaseUI = var_7

		var_75_6(var_75_5, var_7.ON_ACHIEVE, var_75_0.awards)

		return
	end
	GAME = var_2
	var_42_0[var_2.MINI_GAME_SHOP_BUY_DONE] = function(arg_76_0, arg_76_1)
		local var_76_0 = arg_76_1

		if arg_76_1.getBody(var_76_0).list and #var_3 > 0 then
			var_2_10006 = arg_76_0.viewComponent
			var_76_0 = var_76_0.emit
			BaseUI = var_2_10007

			var_76_0(var_2_10006, var_2_10007.ON_ACHIEVE, var_3)
		end

		getProxy = var_76_0
		ShopsProxy = var_2_10006

		local var_76_1 = var_76_0(var_2_10006)
		local var_76_2 = var_4.getMiniShop(var_76_1)
		local var_76_3 = arg_76_0.viewComponent
		local var_76_4 = var_5.OnUpdateShop

		NewShopsScene = var_2_10008

		var_76_4(var_76_3, var_2_10008.TYPE_MINI_GAME, var_76_2)

		return
	end
	var_42_0[var_0_1.NOTI_UPDATE_CURRENT] = function(arg_77_0, arg_77_1)
		local var_77_0 = arg_77_0.viewComponent

		var_2.updateCurSubView(var_77_0)

		pg = var_2

		local var_77_1 = var_2.EasyRedDotMgr.GetInstance()

		var_2.TriggerMarks(var_77_1, "specialShop")

		return
	end
	var_42_0[var_0_1.ON_SUBLAYER_EVENT] = function(arg_78_0, arg_78_1)
		local var_78_0 = arg_78_1:getBody()
		local var_78_1 = arg_78_0.viewComponent
		local var_78_2 = var_3.emit

		unpackEx = var_2_10006

		var_78_2(var_78_1, var_2_10006(var_78_0))

		return
	end
	arg_42_0.handleDic = var_42_0

	return
end

return var_0_1
