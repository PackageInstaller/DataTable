class = var_0_10000

local var_0_0 = "NcSendEvent"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.NodeCanvasBaseTask"))

function var_0_1.OnExecute(arg_1_0)
	local var_1_0 = arg_1_0:GetStringArg("eventName")
	local var_1_1 = arg_1_0
	local var_1_2 = arg_1_0.SendEvent

	ISLAND_EVT = var_1_10005

	var_1_2(var_1_1, var_1_10005[var_1_0], {
		node = arg_1_0
	})
	arg_1_0:EndAction()

	return
end

return var_0_1
