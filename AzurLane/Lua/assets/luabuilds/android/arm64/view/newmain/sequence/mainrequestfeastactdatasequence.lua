local var_0_0 = class("MainRequestFeastActDataSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy(FeastProxy):RequestData(arg_1_1)

	return
end

return var_0_0
