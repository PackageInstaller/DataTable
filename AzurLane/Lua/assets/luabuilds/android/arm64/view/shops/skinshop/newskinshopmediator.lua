class = var_0_10000

local var_0_0 = "NewSkinShopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("view.base.ContextMediator"))

var_0_1.ON_ATLAS = "NewSkinShopMediator:ON_ATLAS"
var_0_1.ON_INDEX = "NewSkinShopMediator:ON_INDEX"
var_0_1.ON_BACKYARD_SHOP = "NewSkinShopMediator:ON_BACKYARD_SHOP"
var_0_1.GO_SHOPS_LAYER = "NewSkinShopMediator:GO_SHOPS_LAYER"
var_0_1.OPEN_SCENE = "NewSkinShopMediator:OPEN_SCENE"
var_0_1.OPEN_ACTIVITY = "NewSkinShopMediator:OPEN_ACTIVITY"
var_0_1.ON_SHOPPING_BY_ACT = "NewSkinShopMediator:ON_SHOPPING_BY_ACT"
var_0_1.ON_SHOPPING = "NewSkinShopMediator:ON_SHOPPING"
var_0_1.ON_RECORD_ANIM_PREVIEW_BTN = "NewSkinShopMediator:ON_RECORD_ANIM_PREVIEW_BTN"
var_0_1.ON_ITEM_PURCHASE = "NewSkinShopMediator:ON_ITEM_PURCHASE"
var_0_1.ON_ITEM_EXPERIENCE = "NewSkinShopMediator:ON_ITEM_EXPERIENCE"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_ITEM_EXPERIENCE, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		local var_2_0 = arg_1_0
		local var_2_1 = var_4.sendNotification

		GAME = var_2_10007

		var_2_1(var_2_0, var_2_10007.USE_ITEM, {
			id = arg_2_1,
			count = arg_2_3,
			arg = {
				arg_2_2
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_ITEM_PURCHASE, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.sendNotification

		GAME = var_2_10006

		var_3_1(var_3_0, var_2_10006.USE_ITEM, {
			count = 1,
			id = arg_3_1,
			arg = {
				arg_3_2
			}
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_RECORD_ANIM_PREVIEW_BTN, function(arg_4_0, arg_4_1)
		local var_4_0 = arg_1_0
		local var_4_1 = var_2.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.RECORD_SKIN_ANIM_PREVIEW, {
			isOpen = arg_4_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.sendNotification

		GAME = var_2_10006

		var_5_1(var_5_0, var_2_10006.SKIN_SHOPPIGN, {
			id = arg_5_1,
			count = arg_5_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHOPPING_BY_ACT, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0 = arg_1_0
		local var_6_1 = var_3.sendNotification

		GAME = var_2_10006

		var_6_1(var_6_0, var_2_10006.SKIN_COUPON_SHOPPING, {
			shopId = arg_6_1,
			cnt = arg_6_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_ACTIVITY, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_1_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		var_7_1(var_7_0, var_7_2, var_2_10006.ACTIVITY, {
			id = arg_7_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOPS_LAYER, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_8_2 = var_2_10005.GO_SCENE

		SCENE = var_2_10006

		local var_8_3 = var_2_10006.SHOP
		local var_8_4 = {}

		NewShopsScene = var_2_10008
		var_8_4.warp = var_2_10008.TYPE_ACTIVITY
		var_8_4.actId = arg_8_1

		var_8_1(var_8_0, var_8_2, var_8_3, var_8_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_SCENE, function(arg_9_0, arg_9_1)
		local var_9_0 = arg_1_0
		local var_9_1 = var_2.sendNotification

		GAME = var_2_10005

		var_9_1(var_9_0, var_2_10005.GO_SCENE, arg_9_1[1], arg_9_1[2])

		return
	end)
	arg_1_0:bind(var_0_1.ON_BACKYARD_SHOP, function(arg_10_0)
		local var_10_0 = arg_1_0
		local var_10_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_10_2 = var_2_10004.New
		local var_10_3 = {}

		NewBackYardShopMediator = var_2_10007
		var_10_3.mediator = var_2_10007
		NewBackYardShopLayer = var_2_10007
		var_10_3.viewComponent = var_2_10007
		var_10_3.data = {
			topLayer = true,
			page = 5
		}

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)
	arg_1_0:bind(var_0_1.ON_ATLAS, function(arg_11_0)
		local var_11_0 = arg_1_0
		local var_11_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_11_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_11_1(var_11_0, var_11_2, var_2_10005.SKINATALAS)

		return
	end)
	arg_1_0:bind(var_0_1.ON_INDEX, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_12_2 = var_2_10005.New
		local var_12_3 = {}

		SkinIndexLayer = var_2_10008
		var_12_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_12_3.mediator = var_2_10008
		var_12_3.data = arg_12_1

		var_12_1(var_12_0, var_12_2(var_12_3))

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_13_0)
	local var_13_0 = {}

	GAME = var_1_10002
	var_13_0[1] = var_1_10002.SKIN_SHOPPIGN_DONE
	GAME = var_2
	var_13_0[2] = var_2.SKIN_COUPON_SHOPPING_DONE
	GAME = var_2
	var_13_0[3] = var_2.BUY_FURNITURE_DONE
	GAME = var_2
	var_13_0[4] = var_2.LOAD_LAYERS
	GAME = var_2
	var_13_0[5] = var_2.REMOVE_LAYERS

	return var_13_0
end

function var_0_1.handleNotification(arg_14_0, arg_14_1)
	local var_14_0 = arg_14_1:getName()
	local var_14_1 = arg_14_1
	local var_14_2 = arg_14_1.getBody(var_14_1)
	local var_14_3 = arg_14_1
	local var_14_4 = arg_14_1.getType(var_14_3)

	GAME = var_14_1

	if var_14_0 ~= var_14_1.SKIN_SHOPPIGN_DONE then
		GAME = var_5

		if var_14_0 == var_5.SKIN_COUPON_SHOPPING_DONE then
			pg = var_5

			if var_5.shop_template[var_14_2.id] then
				var_14_3 = var_5.genre
				ShopArgs = var_1_10007

				if var_14_3 ~= var_1_10007.SkinShop then
					var_14_3 = var_5.genre
					ShopArgs = var_7

					if var_14_3 == var_7.SkinShopTimeLimit then
						var_14_3 = var_5.effect_args[1]
						pg = var_7

						local var_14_5 = var_7.ship_skin_template[var_14_3].skin_type

						ShipSkin = var_1_10008

						if var_14_5 == var_1_10008.SKIN_TYPE_TB then
							local var_14_6 = arg_14_0
							local var_14_7 = arg_14_0.addSubLayers

							Context = var_1_10010

							local var_14_8 = var_1_10010.New
							local var_14_9 = {}

							NewSkinTBMediator = var_1_10013
							var_14_9.mediator = var_1_10013
							NewSkinTBLayer = var_1_10013
							var_14_9.viewComponent = var_1_10013

							local var_14_10 = {
								skinId = var_5.effect_args[1]
							}

							var_1_10014 = var_5.genre
							ShopArgs = var_1_10015
							var_1_10014 = var_1_10014 == var_1_10015.SkinShopTimeLimit
							var_14_10.timeLimit = var_1_10014
							var_14_9.data = var_14_10

							var_14_7(var_14_6, var_14_8(var_14_9))
						else
							local function var_14_11()
								local var_15_0 = arg_14_0
								local var_15_1 = var_0.addSubLayers

								Context = var_2_10003

								local var_15_2 = var_2_10003.New
								local var_15_3 = {}

								NewSkinMediator = var_2_10006
								var_15_3.mediator = var_2_10006
								NewSkinLayer = var_2_10006
								var_15_3.viewComponent = var_2_10006

								local var_15_4 = {
									skinId = var_0.effect_args[1]
								}
								local var_15_5 = var_0.genre

								ShopArgs = var_2_10008
								var_15_4.timeLimit = var_15_5 == var_2_10008.SkinShopTimeLimit
								var_15_3.data = var_15_4

								var_15_1(var_15_0, var_15_2(var_15_3))

								return
							end

							PaintingShowScene = var_1_10008

							if var_1_10008.GetSkinShowAble(var_14_3) then
								local var_14_12 = arg_14_0

								var_1_10008 = arg_14_0.addSubLayers
								Context = var_1_10011

								local var_14_13 = var_1_10011.New
								local var_14_14 = {}

								PaintingShowMediator = var_1_10014
								var_14_14.mediator = var_1_10014
								PaintingShowScene = var_1_10014
								var_14_14.viewComponent = var_1_10014
								var_14_14.data = {
									is_shop = true,
									skinId = var_14_3,
									callback = var_14_11
								}

								var_1_10008(var_14_12, var_14_13(var_14_14))
							else
								var_14_11()
							end
						end

						local var_14_15 = arg_14_0.viewComponent

						var_7.OnShopping(var_14_15, var_14_2.id)
					end

					goto label_14_0

					GAME = var_5

					if var_14_0 == var_5.BUY_FURNITURE_DONE then
						local var_14_16 = arg_14_0.viewComponent

						var_5.OnFurnitureUpdate(var_14_16, var_14_4[1])
					else
						GAME = var_5

						local var_14_17

						if var_14_0 == var_5.LOAD_LAYERS then
							var_14_17 = var_14_2.context.mediator
							NewBackYardShopMediator = var_14_3

							if var_14_17 == var_14_3 then
								local var_14_18 = arg_14_0

								var_14_17 = arg_14_0.sendNotification
								PlayerResUI = var_1_10008

								var_14_17(var_14_18, var_1_10008.HIDE)
							end
						else
							GAME = var_14_17

							if var_14_0 == var_14_17.REMOVE_LAYERS then
								local var_14_19 = var_14_2.context.mediator

								NewBackYardShopMediator = var_14_3

								if var_14_19 == var_14_3 then
									local var_14_20 = arg_14_0
									local var_14_21 = arg_14_0.sendNotification

									PlayerResUI = var_1_10008

									var_14_21(var_14_20, var_1_10008.SHOW)
								end
							end
						end
					end

					::label_14_0::

					return
				end
			end
		end
	end
end

return var_0_1
