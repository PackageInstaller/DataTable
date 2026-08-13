class = var_0_10000

local var_0_0 = "ChargeMenuMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.GO_SKIN_SHOP = "ChargeMenuMediator:GO_SKIN_SHOP"
var_0_1.GO_SUPPLY_SHOP = "ChargeMenuMediator:GO_SUPPLY_SHOP"
var_0_1.GO_CHARGE_SHOP = "ChargeMenuMediator:GO_CHARGE_SHOP"

function var_0_1.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_1.listNotificationInterests(arg_2_0)
	local var_2_0 = {}

	PlayerProxy = var_1_10002
	var_2_0[1] = var_1_10002.UPDATED
	GAME = var_2
	var_2_0[2] = var_2.CHARGE_SUCCESS
	GAME = var_2
	var_2_0[3] = var_2.SHOPPING_DONE
	GAME = var_2
	var_2_0[4] = var_2.REMOVE_LAYER_DONE

	return var_2_0
end

function var_0_1.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1
	local var_3_2 = arg_3_1.getBody(var_3_1)

	PlayerProxy = var_3_1

	if var_3_0 == var_3_1.UPDATED then
		local var_3_3 = arg_3_0.viewComponent

		var_4.updatePlayerRes(var_3_3, var_3_2)

		goto label_3_0
	end

	GAME = var_4

	if var_3_0 ~= var_4.CHARGE_SUCCESS then
		GAME = var_3_6

		do
			local var_3_6

			if var_3_0 == var_3_6.SHOPPING_DONE then
				local var_3_4 = arg_3_0.viewComponent

				var_3_6.FlushBanner(var_3_4)

				if arg_3_0.viewComponent.lookUpIndex then
					pg = var_3_6

					local var_3_5 = var_3_6.m02

					var_3_6 = var_3_6.sendNotification
					GAME = var_1_10006

					local var_3_7 = var_1_10006.TRACK

					TrackConst = var_1_10007

					local var_3_8 = var_1_10007.GetTrackData

					TrackConst = var_1_10008

					local var_3_9 = var_1_10008.SYSTEM_SHOP

					TrackConst = var_1_10009

					var_3_6(var_3_5, var_3_7, var_3_8(var_3_9, var_1_10009.ACTION_BUY_RECOMMEND, arg_3_0.viewComponent.lookUpIndex))
				end

				GAME = var_3_6

				if var_3_0 == var_3_6.CHARGE_SUCCESS then
					Goods = var_3_6
					var_3_6 = var_3_6.Create

					local var_3_10 = {
						shop_id = var_3_2.shopId
					}

					Goods = var_6
					var_3_6 = var_3_6(var_3_10, var_6.TYPE_CHARGE)

					local var_3_11 = arg_3_0.viewComponent

					var_5.OnChargeSuccess(var_3_11, var_3_6)
				end
			else
				GAME = var_3_6

				if var_3_0 == var_3_6.REMOVE_LAYER_DONE then
					local var_3_12 = arg_3_0.viewComponent

					var_4.OnRemoveLayer(var_3_12, var_3_2)
				end
			end
		end

		::label_3_0::

		return
	end
end

function var_0_1.bindEvent(arg_4_0)
	arg_4_0:bind(var_0_1.GO_SKIN_SHOP, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_4_0
		local var_5_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_5_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_5_1(var_5_0, var_5_2, var_2_10005.SKINSHOP)

		return
	end)
	arg_4_0:bind(var_0_1.GO_SUPPLY_SHOP, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_4_0
		local var_6_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_6_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_6_1(var_6_0, var_6_2, var_2_10005.SHOP, arg_6_1)

		return
	end)
	arg_4_0:bind(var_0_1.GO_CHARGE_SHOP, function(arg_7_0, arg_7_1)
		local var_7_0 = arg_4_0
		local var_7_1 = var_2.sendNotification

		GAME = var_2_10004

		local var_7_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		var_7_1(var_7_0, var_7_2, var_2_10005.CHARGE, {
			warp = arg_7_1
		})

		return
	end)

	return
end

return var_0_1
