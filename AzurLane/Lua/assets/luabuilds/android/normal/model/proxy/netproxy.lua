class = var_0_10000

local var_0_0 = "NetProxy"

pm = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002.Proxy)

function var_0_1.onRegister(arg_1_0)
	arg_1_0.event = {}

	arg_1_0:register()

	return
end

function var_0_1.register(arg_2_0)
	return
end

function var_0_1.on(arg_3_0, arg_3_1, arg_3_2)
	pg = var_1_10003

	local var_3_0 = var_1_10003.ConnectionMgr.GetInstance()

	var_3.On(var_3_0, arg_3_1, function(arg_4_0)
		arg_3_2(arg_4_0)

		return
	end)

	table = var_3

	var_3.insert(arg_3_0.event, arg_3_1)

	return
end

function var_0_1.onRemove(arg_5_0)
	arg_5_0:remove()

	ipairs = var_1

	for iter_5_0, iter_5_1 in var_1(arg_5_0.event) do
		pg = var_1_10006

		local var_5_0 = var_1_10006.ConnectionMgr.GetInstance()

		var_1_10006.Off(var_5_0, iter_5_1)
	end

	return
end

function var_0_1.remove(arg_6_0)
	return
end

function var_0_1.getRawData(arg_7_0)
	return arg_7_0.data
end

function var_0_1.getData(arg_8_0)
	Clone = var_1_10001

	return var_1_10001(arg_8_0.data)
end

function var_0_1.timeCall(arg_9_0)
	return {}
end

return var_0_1
