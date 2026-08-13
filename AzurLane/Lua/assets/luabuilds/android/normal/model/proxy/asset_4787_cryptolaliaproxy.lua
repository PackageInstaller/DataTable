class = var_0_10000

local var_0_0 = "CryptolaliaProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.isLoop = false

	return
end

function var_0_1.SetLoop(arg_2_0, arg_2_1)
	arg_2_0.isLoop = arg_2_1

	return
end

function var_0_1.GetLoop(arg_3_0)
	return arg_3_0.isLoop
end

return var_0_1
