local ZumaPTShopWindowMediator = class("ZumaPTShopWindowMediator", import("...base.ContextMediator"))

function ZumaPTShopWindowMediator:register()
	return
end

function ZumaPTShopWindowMediator:listNotificationInterests()
	return {
		GAME.ISLAND_SHOPPING_DONE
	}
end

function ZumaPTShopWindowMediator:handleNotification(arg_3_1)
	local var_3_0 = arg_3_1:getBody()

	if arg_3_1:getName() == GAME.ISLAND_SHOPPING_DONE then
		self.viewComponent:closeView()
	end

	return
end

return ZumaPTShopWindowMediator
