local var_0_0 = class("CryptolaliaMediator", import("view.base.ContextMediator"))

var_0_0.UNLOCK = "CryptolaliaMediator:UNLOCK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.UNLOCK, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.UNLOCK_CRYPTOLALIA, {
			id = arg_2_1,
			costType = arg_2_2
		})

		return
	end)
	arg_1_0.viewComponent:SetCryptolaliaList(getProxy(PlayerProxy):getRawData():GetCryptolaliaList())

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.UNLOCK_CRYPTOLALIA_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == GAME.UNLOCK_CRYPTOLALIA_DONE then
		arg_4_0.viewComponent:emit(CryptolaliaScene.ON_UNLOCK, arg_4_1:getBody().id)
	end

	return
end

return var_0_0
