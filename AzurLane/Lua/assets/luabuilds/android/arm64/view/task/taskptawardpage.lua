class = var_0_10000

local var_0_0 = "TaskPtAwardPage"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.BaseSubView"))

function var_0_1.getUIName(arg_1_0)
	return "ActivitybonusWindow"
end

function var_0_1.Display(arg_2_0, arg_2_1)
	if not arg_2_0.window then
		TaskPtAwardWindow = var_2
		arg_2_0.window = var_2.New(arg_2_0._tf, arg_2_0)
	end

	local var_2_0 = arg_2_0.window

	var_2.Show(var_2_0, arg_2_1)
	arg_2_0:Show()

	return
end

function var_0_1.OnDestroy(arg_3_0)
	if arg_3_0.window then
		local var_3_0 = arg_3_0.window

		var_1.Dispose(var_3_0)

		arg_3_0.window = nil
	end

	return
end

return var_0_1
