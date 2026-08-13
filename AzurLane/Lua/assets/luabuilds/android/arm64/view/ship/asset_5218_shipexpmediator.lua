class = var_0_10000

local var_0_0 = "ShipExpMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0.contextData
	local var_1_1

	if not arg_1_0.contextData.type then
		ShipExpLayer = var_1_1
		var_1_1 = var_1_1.TypeDefault
	end

	var_1_0.type = var_1_1

	return
end

return var_0_1
