class = var_0_10000

local var_0_0 = var_0_10000("MainOpenSystemSequence")

function var_0_0.Execute(arg_1_0, arg_1_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10004

	local var_1_0 = var_1_10002(var_1_10004)
	local var_1_1 = var_2.getRawData(var_1_0)

	pg = var_1_10003

	local var_1_2 = var_1_10003.SystemOpenMgr.GetInstance()

	var_3.notification(var_1_2, var_1_1.level)
	arg_1_1()

	return
end

return var_0_0
