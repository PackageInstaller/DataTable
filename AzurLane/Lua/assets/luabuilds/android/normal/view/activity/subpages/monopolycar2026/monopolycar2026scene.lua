class = var_0_10000

local var_0_0 = "MonopolyCar2026Scene"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..MonopolyCar2024.MonopolyCar2024Scene"))

function var_0_1.getUIName(arg_1_0)
	return "MonopolyCar2026UI"
end

function var_0_1.NewGame(arg_2_0)
	MonopolyCar2026Game = var_1_10001

	local var_2_0 = var_1_10001.New
	local var_2_1 = arg_2_0.activity
	local var_2_2 = arg_2_0._tf

	return var_2_0(var_2_1, var_3.Find(var_2_2, "adapt"), arg_2_0.event)
end

return var_0_1
