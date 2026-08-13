class = var_0_10000

local var_0_0 = "FeastThemeTemplate"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.NewBackYard.BackYardSelfThemeTemplate"))

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0.mapSize = arg_1_3

	return
end

function var_0_1.GetMapSize(arg_2_0)
	return arg_2_0.mapSize
end

return var_0_1
