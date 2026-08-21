local var_0_0 = class("EducateShopMediator", import("..base.EducateContextMediator"))

var_0_0.ON_SHOPPING = "ON_SHOPPING"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SHOPPING, function(arg_2_0, arg_2_1)
		arg_1_0:sendNotification(GAME.EDUCATE_SHOPPING, {
			shopId = arg_2_1.shopId,
			goods = arg_2_1.goods
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.EDUCATE_SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == GAME.EDUCATE_SHOPPING_DONE then
		arg_4_0.viewComponent:emit(EducateBaseUI.EDUCATE_ON_AWARD, {
			items = arg_4_1:getBody().drops
		})
		arg_4_0.viewComponent:refreshShops()
	end

	return
end

return var_0_0
