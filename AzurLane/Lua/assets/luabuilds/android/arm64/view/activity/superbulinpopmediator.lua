class = var_0_10000

local var_0_0 = "SuperBulinPopMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.ON_SIMULATION_COMBAT = "event simulation combat"

function var_0_1.register(arg_1_0)
	arg_1_0:bind(var_0_1.ON_SIMULATION_COMBAT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		local var_2_2 = var_2_10006.BEGIN_STAGE
		local var_2_3 = {}

		SYSTEM_SIMULATION = var_2_10008
		var_2_3.system = var_2_10008
		var_2_3.stageId = arg_2_1.stageId
		var_2_3.warnMsg = arg_2_1.warnMsg
		var_2_3.exitCallback = arg_2_2

		var_2_1(var_2_0, var_2_2, var_2_3)

		return
	end)

	return
end

return var_0_1
