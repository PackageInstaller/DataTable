local var_0_0 = class("Dorm3dGameMediatorTemplate", import("view.base.ContextMediator"))

var_0_0.TRIGGER_FAVOR = "Dorm3dGameMediatorTemplate.TRIGGER_FAVOR"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.TRIGGER_FAVOR, function(arg_2_0, arg_2_1)
		local var_2_0 = getDorm3dGameset("drom3d_favir_trigger_game")[1]

		if getProxy(ApartmentProxy).stamina < pg.dorm3d_favor_trigger[var_2_0].is_daily_max then
			arg_1_0.viewComponent:ShowResultUI()

			return
		end

		arg_1_0:sendNotification(GAME.APARTMENT_TRIGGER_FAVOR, {
			groupId = arg_2_1,
			triggerId = var_2_0
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.APARTMENT_TRIGGER_FAVOR_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	if arg_4_1:getName() == GAME.APARTMENT_TRIGGER_FAVOR_DONE then
		arg_4_0.viewComponent:ShowResultUI((arg_4_1:getBody()))
	end

	return
end

function var_0_0.remove(arg_5_0)
	return
end

return var_0_0
