local var_0_0 = class("RivalInfoMediator", import("..base.ContextMediator"))

var_0_0.START_BATTLE = "RivalInfoMediator:START_BATTLE"

function var_0_0.register(arg_1_0)
	assert(arg_1_0.contextData.rival, "rival should exist")
	assert(arg_1_0.contextData.type, "type should exist")
	arg_1_0.viewComponent:setRival(arg_1_0.contextData.rival)
	arg_1_0:bind(var_0_0.START_BATTLE, function(arg_2_0)
		local var_2_0

		if arg_1_0.contextData.type == RivalInfoLayer.TYPE_BATTLE then
			var_2_0 = SYSTEM_DUEL
		end

		arg_1_0:sendNotification(GAME.MILITARY_STARTED, {
			rivalId = arg_1_0.contextData.rival.id,
			system = var_2_0
		})
		arg_1_0.viewComponent:emit(BaseUI.ON_CLOSE)

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_0
