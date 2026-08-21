local var_0_0 = class("MainBaseIcon")

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tf = arg_1_1
	arg_1_0._go = arg_1_1.gameObject
	arg_1_0.loading = false

	return
end

function var_0_0.Resume(arg_2_0)
	return
end

function var_0_0.Pause(arg_3_0)
	return
end

function var_0_0.Load(arg_4_0, arg_4_1)
	return
end

function var_0_0.Unload(arg_5_0)
	return
end

function var_0_0.IsLoading(arg_6_0)
	return arg_6_0.loading
end

function var_0_0.Dispose(arg_7_0)
	arg_7_0.exited = true

	arg_7_0:Unload()

	return
end

return var_0_0
