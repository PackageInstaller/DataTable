class = var_0_10000

local var_0_0 = "Dorm3dGameMediatorTemplate"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("view.base.ContextMediator"))

var_0_1.TRIGGER_FAVOR = "Dorm3dGameMediatorTemplate.TRIGGER_FAVOR"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.TRIGGER_FAVOR, function(arg_2_0, arg_2_1)
		getDorm3dGameset = var_2_10002

		local var_2_0 = var_2_10002("drom3d_favir_trigger_game")[1]

		pg = var_3

		local var_2_1 = var_3.dorm3d_favor_trigger[var_2_0]

		getProxy = var_2_10004
		ApartmentProxy = var_2_10005

		if var_2_10004(var_2_10005).stamina < var_2_1.is_daily_max then
			local var_2_2 = arg_1_0.viewComponent

			var_4.ShowResultUI(var_2_2)

			return
		end

		local var_2_3 = arg_1_0
		local var_2_4 = var_4.sendNotification

		GAME = var_2_10006

		var_2_4(var_2_3, var_2_10006.APARTMENT_TRIGGER_FAVOR, {
			groupId = arg_2_1,
			triggerId = var_2_0
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	local var_3_0 = {}

	GAME = var_1_10002
	var_3_0[1] = var_1_10002.APARTMENT_TRIGGER_FAVOR_DONE

	return var_3_0
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1
	local var_4_2 = arg_4_1.getBody(var_4_1)

	GAME = var_4_1

	if var_4_0 == var_4_1.APARTMENT_TRIGGER_FAVOR_DONE then
		local var_4_3 = arg_4_0.viewComponent

		var_4.ShowResultUI(var_4_3, var_4_2)
	end

	return
end

function var_0_1.remove(arg_5_0)
	return
end

return var_0_1
