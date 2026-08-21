local var_0_0 = class("ZumaPTShopWindowMediator", import("...base.ContextMediator"))

function var_0_0.register(arg_1_0)
	return
end

function var_0_0.listNotificationInterests(arg_2_0)
	return {
		GAME.ISLAND_SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.ISLAND_SHOPPING_DONE then
		arg_3_0.viewComponent:closeView()
	end

	return
end

return var_0_0
