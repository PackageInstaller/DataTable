local var_0_0 = class("PrepViewCommand", pm.SimpleCommand)

function var_0_0.execute(arg_1_0, arg_1_1)
	arg_1_0.facade:registerMediator(GameMediator.New())

	return
end

return var_0_0
