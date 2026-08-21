local var_0_0 = class("ShipExpMediator", import("..base.ContextMediator"))

function var_0_0.register(arg_1_0)
	arg_1_0.contextData.type = arg_1_0.contextData.type or ShipExpLayer.TypeDefault

	return
end

return var_0_0
