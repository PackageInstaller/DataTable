local var_0_0 = class("DynamicCellView", import(".LevelCellView"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0)

	arg_1_0.go = arg_1_1
	arg_1_0.tf = arg_1_0.go.transform

	arg_1_0:OverrideCanvas()

	arg_1_0.buffer = FuncBuffer.New()

	return
end

return var_0_0
