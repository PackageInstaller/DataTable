local var_0_0 = class("HolidayVillaShopWindowMediator", import("..base.ContextMediator"))

var_0_0.SHOPPING_CONFIRM = "HolidayVillaShopWindowMediator.SHOPPING_CONFIRM"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.SHOPPING_CONFIRM, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.ISLAND_SHOPPING, {
			shop = arg_1_0.contextData.shop,
			arg1 = arg_1_0.contextData.goods.id,
			arg2 = arg_2_1
		})

		return
	end)
	arg_1_0.viewComponent:setGoods(arg_1_0.contextData.goods)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.ISLAND_SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.ISLAND_SHOPPING_DONE then
		arg_4_0.viewComponent:closeView()
	end

	return
end

return var_0_0
