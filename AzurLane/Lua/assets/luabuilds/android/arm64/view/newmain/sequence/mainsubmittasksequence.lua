local var_0_0 = class("MainSubmitTaskSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy(TaskProxy):pushAutoSubmitTask()
	arg_1_1()

	return
end

return var_0_0
