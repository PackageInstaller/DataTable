local var_0_0 = class("BaseLadyEnv")

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0.event = arg_1_1
	arg_1_0.scene = arg_1_2

	return
end

function var_0_0.Emit(arg_2_0, arg_2_1, ...)
	arg_2_0.event:emit(arg_2_1, ...)

	return
end

function var_0_0.Func(arg_3_0, arg_3_1, ...)
	assert(arg_3_0.scene[arg_3_1], "Function " .. arg_3_1 .. " not found in scene")

	return arg_3_0.scene[arg_3_1](arg_3_0.scene, ...)
end

function var_0_0.Get(arg_4_0, arg_4_1)
	return arg_4_0.scene[arg_4_1]
end

function var_0_0.Init(arg_5_0)
	return
end

function var_0_0.HandleNotification(arg_6_0, arg_6_1, arg_6_2)
	return
end

function var_0_0.GetInterests()
	return {}
end

function var_0_0.IsOpen()
	return false
end

function var_0_0.Dispose(arg_9_0)
	return
end

return var_0_0
