class = var_0_10000

local var_0_0 = "DynamicCellView"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".LevelCellView"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_0.go.transform

	arg_1_0:OverrideCanvas()

	FuncBuffer = var_2
	arg_1_0.buffer = var_2.New()

	return
end

return var_0_1
