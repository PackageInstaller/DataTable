local var_0_0 = class("NewCommanderMediator", import("..base.ContextMediator"))

var_0_0.ON_LOCK = "NewCommanderMediator:ON_LOCK"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_LOCK, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.COMMANDER_LOCK, {
			commanderId = arg_2_1,
			flag = arg_2_2
		})

		return
	end)
	assert(arg_1_0.contextData.commander, "commander can not be nil")

	return
end

function var_0_0.listNotificationInterests(arg_3_0)
	return {
		GAME.COMMANDER_LOCK_DONE
	}
end

function var_0_0.handleNotification(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_1:getBody()

	if arg_4_1:getName() == GAME.COMMANDER_LOCK_DONE then
		arg_4_0.viewComponent:updateLockState()
	end

	return
end

return var_0_0
