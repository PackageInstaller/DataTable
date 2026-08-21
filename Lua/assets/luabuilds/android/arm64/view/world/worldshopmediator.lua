local var_0_0 = class("WorldShopMediator", import("view.base.ContextMediator"))

var_0_0.BUY_ITEM = "WorldShopMediator:BUY_ITEM"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.BUY_ITEM, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.SHOPPING, {
			id = arg_2_1,
			count = arg_2_2
		})

		return
	end)
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getRawData())

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		PlayerProxy.UPDATED,
		GAME.SHOPPING_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	if var_4_0 == PlayerProxy.UPDATED then
		arg_4_0.viewComponent:setPlayer(var_4_1)
	elseif var_4_0 == GAME.SHOPPING_DONE and #var_4_1.awards > 0 then
		arg_4_0.viewComponent:emit(BaseUI.ON_AWARD, {
			items = var_4_1.awards
		})
	end

	return
end

return var_0_0
