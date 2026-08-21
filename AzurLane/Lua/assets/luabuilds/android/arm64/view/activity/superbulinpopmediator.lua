local var_0_0 = class("SuperBulinPopMediator", import("..base.ContextMediator"))

var_0_0.ON_SIMULATION_COMBAT = "event simulation combat"

function var_0_0.register(arg_1_0)
	arg_1_0:bind(var_0_0.ON_SIMULATION_COMBAT, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SIMULATION,
			stageId = arg_2_1.stageId,
			warnMsg = arg_2_1.warnMsg,
			exitCallback = arg_2_2
		})

		return
	end)

	return
end

return var_0_0
