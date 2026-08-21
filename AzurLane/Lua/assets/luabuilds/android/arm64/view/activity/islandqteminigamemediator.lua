local var_0_0 = class("IslandQTEMiniGameMediator", import("..base.ContextMediator"))

var_0_0.GAME_FINISH = "IslandQTEMiniGameMediator.GAME_FINISH"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.GAME_FINISH, function(arg_2_0, arg_2_1)
		arg_1_0.contextData.finishCallback(arg_2_1 or 0)

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
