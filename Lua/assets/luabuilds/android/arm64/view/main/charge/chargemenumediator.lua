local var_0_0 = class("ChargeMenuMediator", import("...base.ContextMediator"))

var_0_0.GO_SKIN_SHOP = "ChargeMenuMediator:GO_SKIN_SHOP"
var_0_0.GO_SUPPLY_SHOP = "ChargeMenuMediator:GO_SUPPLY_SHOP"
var_0_0.GO_CHARGE_SHOP = "ChargeMenuMediator:GO_CHARGE_SHOP"

function var_0_0.register(arg_1_0)
	arg_1_0:bindEvent()

	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		PlayerProxy.UPDATED,
		GAME.CHARGE_SUCCESS,
		GAME.SHOPPING_DONE,
		GAME.REMOVE_LAYER_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getName()
	local var_3_1 = arg_3_1:getBody()

	if var_3_0 == PlayerProxy.UPDATED then
		arg_3_0.viewComponent:updatePlayerRes(var_3_1)
	elseif var_3_0 == GAME.CHARGE_SUCCESS or var_3_0 == GAME.SHOPPING_DONE then
		arg_3_0.viewComponent:FlushBanner()

		if arg_3_0.viewComponent.lookUpIndex then
			pg.m02:sendNotification(GAME.TRACK, TrackConst.GetTrackData(TrackConst.SYSTEM_SHOP, TrackConst.ACTION_BUY_RECOMMEND, arg_3_0.viewComponent.lookUpIndex))
		end

		if var_3_0 == GAME.CHARGE_SUCCESS then
			arg_3_0.viewComponent:OnChargeSuccess((Goods.Create({
				shop_id = var_3_1.shopId
			}, Goods.TYPE_CHARGE)))
		end
	elseif var_3_0 == GAME.REMOVE_LAYER_DONE then
		arg_3_0.viewComponent:OnRemoveLayer(var_3_1)
	end

	return
end

function var_0_0.bindEvent(arg_4_0)
	arg_4_0:bind(var_0_0.GO_SKIN_SHOP, function(arg_5_0, arg_5_1)
		arg_4_0:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)
	arg_4_0:bind(var_0_0.GO_SUPPLY_SHOP, function(arg_6_0, arg_6_1)
		arg_4_0:sendNotification(GAME.GO_SCENE, SCENE.SHOP, arg_6_1)

		return
	end)
	arg_4_0:bind(var_0_0.GO_CHARGE_SHOP, function(arg_7_0, arg_7_1)
		arg_4_0:sendNotification(GAME.GO_SCENE, SCENE.CHARGE, {
			warp = arg_7_1
		})

		return
	end)

	return
end

return var_0_0
