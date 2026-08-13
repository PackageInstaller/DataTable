class = var_0_10000

local var_0_0 = var_0_10000("TSTask")

function var_0_0.SetJob(arg_1_0, arg_1_1)
	arg_1_0.job = arg_1_1

	return
end

function var_0_0.Execute(arg_2_0)
	os = var_1_10001

	local var_2_0 = var_1_10001.clock()

	arg_2_0.job()

	os = var_2

	return var_2.clock() - var_2_0
end

function var_0_0.Clear(arg_3_0)
	arg_3_0.job = nil

	return
end

return var_0_0
