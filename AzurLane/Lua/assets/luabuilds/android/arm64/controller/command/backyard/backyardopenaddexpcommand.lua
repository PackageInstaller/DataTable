class = var_0_10000

local var_0_0 = "BackYardOpenAddExpCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0, arg_1_1)
	if arg_1_1:getBody() == 1 then
		getProxy = var_1_10003
		DormProxy = var_1_10005
		var_1_10005 = var_1_10003(var_1_10005)

		var_1_10003.OnEnterBackyard(var_1_10005)
	elseif var_2 == 0 then
		getProxy = var_1_10003
		DormProxy = var_1_10005

		local var_1_0 = var_1_10003(var_1_10005)

		var_3.OnExitBackyard(var_1_0)
	end

	return
end

return var_0_1
