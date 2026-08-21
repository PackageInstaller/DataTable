local var_0_0 = class("CryptolaliaProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.isLoop = false

	return
end

function var_0_0.SetLoop(arg_2_0, arg_2_1)
	arg_2_0.isLoop = arg_2_1

	return
end

function var_0_0.GetLoop(arg_3_0)
	return arg_3_0.isLoop
end

return var_0_0
