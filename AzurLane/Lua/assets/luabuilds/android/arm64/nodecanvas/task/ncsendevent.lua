local var_0_0 = class("NcSendEvent", import("..base.NodeCanvasBaseTask"))

function var_0_0.OnExecute(arg_1_0)
	arg_1_0:SendEvent(ISLAND_EVT[arg_1_0:GetStringArg("eventName")], {
		node = arg_1_0
	})
	arg_1_0:EndAction()

	return
end

return var_0_0
