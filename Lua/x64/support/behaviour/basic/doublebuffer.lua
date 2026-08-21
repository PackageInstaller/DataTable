local var_0_0 = import("..BehaviourBase")
local var_0_1 = class("DoubleBuffer", var_0_0)
local var_0_2 = 0

function var_0_1.Ctor(arg_1_0)
	return
end

function var_0_1.Next(arg_2_0)
	return 1 - var_0_2
end

function var_0_1.Swap(arg_3_0)
	var_0_2 = var_0_1.Next()
end

function var_0_1.OnBind_(arg_4_0)
	arg_4_0:ExportMethods_({
		"Next"
	})

	return arg_4_0.target_
end

function var_0_1.OnUnbind_(arg_5_0)
	return
end

return var_0_1
