class = var_0_10000

local var_0_0 = "RefluxRequestDataCommand"

pm = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003.SimpleCommand)

function var_0_1.execute(arg_1_0)
	pg = var_1_10001

	local var_1_0 = var_1_10001.ConnectionMgr.GetInstance()

	var_1.Send(var_1_0, 11751, {
		type = 0
	}, 11752, function(arg_2_0)
		getProxy = var_2_10001
		RefluxProxy = var_2_10003

		local var_2_0 = var_2_10001(var_2_10003)

		var_1.setData(var_2_0, arg_2_0)

		return
	end)

	return
end

return var_0_1
