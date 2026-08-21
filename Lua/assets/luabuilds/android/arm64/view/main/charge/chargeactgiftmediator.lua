local var_0_0 = class("ChargeActGiftMediator", import("view.base.ContextMediator"))

var_0_0.DO_PAY = "ChargeActGiftMediator.DO_PAY"
var_0_0.GO_SHOP = "ChargeActGiftMediator.GO_SHOP"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.DO_PAY, function(arg_2_0)
		local var_2_0 = getProxy(ActivityProxy):getActivityById(arg_1_0.contextData.actId)

		arg_1_0:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = var_2_0.id,
			costDrop = Drop.New({
				type = DROP_TYPE_RESOURCE,
				id = PlayerConst.ResDiamond,
				count = GiftActCommodity.CalcPrice(var_2_0)
			})
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOP, function(arg_3_0, arg_3_1)
		arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.SKINSHOP)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_4_0)
	return {
		ActivityProxy.ACTIVITY_OPERATION_DONE
	}
end

function var_0_0.handleNotification(arg_5_0, arg_5_1)
	if arg_5_1:getName() == ActivityProxy.ACTIVITY_OPERATION_DONE and arg_5_1:getBody() == arg_5_0.contextData.actId then
		arg_5_0.viewComponent:closeView()
	end

	return
end

return var_0_0
