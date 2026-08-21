local var_0_0 = class("TSTask")

function var_0_0.SetJob(arg_1_0, arg_1_1)
	arg_1_0.job = arg_1_1

	return
end

function var_0_0.Execute(arg_2_0)
	arg_2_0.job()

	return os.clock() - os.clock()
end

function var_0_0.Clear(arg_3_0)
	arg_3_0.job = nil

	return
end

return var_0_0
