class = var_0_10000

local var_0_0 = "BackYardOpenAddExpCommand"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	local var_1_0 = arg_1_1

	if arg_1_1.getBody(var_1_0) == 1 then
		getProxy = var_1_0
		DormProxy = var_1_10004
		var_1_10004 = var_1_0(var_1_10004)

		var_1_0.OnEnterBackyard(var_1_10004)
	elseif var_2 == 0 then
		getProxy = var_1_0
		DormProxy = var_1_10004

		local var_1_1 = var_1_0(var_1_10004)

		var_3.OnExitBackyard(var_1_1)
	end

	return
end

return var_0_1
