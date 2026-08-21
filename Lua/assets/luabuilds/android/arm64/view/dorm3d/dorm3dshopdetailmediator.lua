local var_0_0 = class("Dorm3dShopDetailMediator", import("view.base.ContextMediator"))

var_0_0.SHOPPING = "Dorm3dShopDetailMediator.SHOPPING"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SHOPPING, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_2_1.shopId,
			count = arg_2_1.count,
			silentTip = arg_2_1.silentTip
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.SHOPPING_DONE then
		arg_4_0.viewComponent:closeView()
	end

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
