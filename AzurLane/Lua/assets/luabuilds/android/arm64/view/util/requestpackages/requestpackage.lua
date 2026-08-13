class = var_0_10000

local var_0_0 = var_0_10000("RequestPackage")

function var_0_0.Start(arg_1_0, ...)
	if arg_1_0.__call then
		arg_1_0.__call(arg_1_0, ...)
	end

	return arg_1_0
end

function var_0_0.Stop(arg_2_0)
	setmetatable = var_1_10001

	var_1_10001(arg_2_0, nil)

	table = var_1_10001

	var_1_10001.clear(arg_2_0)

	arg_2_0.stopped = true

	return
end

return var_0_0
