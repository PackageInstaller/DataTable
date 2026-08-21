local var_0_0 = class("T0GameManagerBase.StateBase")

function var_0_0.Enter(arg_1_0, arg_1_1)
	arg_1_1:RegisterStateEvents(arg_1_0, arg_1_0.events)
end

function var_0_0.Exit(arg_2_0, arg_2_1)
	arg_2_1:RemoveAllStateEvents()
end

return var_0_0
