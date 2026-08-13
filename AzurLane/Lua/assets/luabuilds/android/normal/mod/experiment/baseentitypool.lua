class = var_0_10000

local var_0_0 = "BaseEntityPool"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseEntity"))

var_0_1.Fields = {
	pools = "table"
}

function var_0_1.Build(arg_1_0)
	arg_1_0.pools = {}

	return
end

function var_0_1.Get(arg_2_0, arg_2_1)
	local var_2_0

	if not arg_2_0.pools[arg_2_1] then
		var_2_0 = {}
	end

	var_2[arg_2_1] = var_2_0

	if #var_2[arg_2_1] == 0 then
		return arg_2_1.New()
	else
		local var_2_1 = var_3[#var_3]

		var_4.Build(var_2_1)

		table = var_4

		return var_4.remove(var_3, #var_3)
	end

	return
end

function var_0_1.Return(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:Dispose()

	arg_3_2 = arg_3_2 or arg_3_1.class

	local var_3_0 = arg_3_0.pools
	local var_3_1

	if not arg_3_0.pools[arg_3_2] then
		var_3_1 = {}
	end

	var_3_0[arg_3_2] = var_3_1
	table = var_3_0

	var_3_0.insert(arg_3_0.pools[arg_3_2], arg_3_1)

	return
end

function var_0_1.ReturnArray(arg_4_0, arg_4_1, arg_4_2)
	ipairs = var_1_10003

	for iter_4_0, iter_4_1 in var_1_10003(arg_4_1) do
		arg_4_0:Return(iter_4_1, arg_4_2)
	end

	return
end

function var_0_1.ReturnMap(arg_5_0, arg_5_1, arg_5_2)
	pairs = var_1_10003

	for iter_5_0, iter_5_1 in var_1_10003(arg_5_1) do
		arg_5_0:Return(iter_5_1, arg_5_2)
	end

	return
end

return var_0_1
