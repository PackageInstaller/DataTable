class = var_0_10000

local var_0_0 = "CatteryStyle"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.configId = arg_1_0.id
	arg_1_0.own = arg_1_1.own

	return
end

function var_0_1.bindConfigTable(arg_2_0)
	pg = var_1_10001

	return var_1_10001.commander_home_style
end

function var_0_1.IsOwn(arg_3_0)
	return arg_3_0.own
end

function var_0_1.GetName(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0:getConfig("name")
	local var_4_1

	if not arg_4_1 or not (var_4_0 .. "_d") then
		var_4_1 = var_4_0
	end

	return var_4_1
end

return var_0_1
