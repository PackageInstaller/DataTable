class = var_0_10000

local var_0_0 = "IslandQTEMiniGameMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.GAME_FINISH = "IslandQTEMiniGameMediator.GAME_FINISH"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.GAME_FINISH, function(arg_2_0, arg_2_1)
		arg_1_0.contextData.finishCallback(arg_2_1 or 0)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_3_0)
	return {}
end

function var_0_1.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getName()
	local var_4_1 = arg_4_1:getBody()

	return
end

return var_0_1
