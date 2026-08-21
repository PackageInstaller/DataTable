local var_0_0 = class("BaseEntityPool", import(".BaseEntity"))

var_0_0.Fields = {
	pools = "table"
}

function var_0_0.Build(arg_1_0)
	arg_1_0.pools = {}

	return
end

function var_0_0.Get(arg_2_0, arg_2_1)
	arg_2_0.pools[arg_2_1] = arg_2_0.pools[arg_2_1] or {}

	if #arg_2_0.pools[arg_2_1] == 0 then
		return arg_2_1.New()
	else
		arg_2_0.pools[arg_2_1][#arg_2_0.pools[arg_2_1]]:Build()

		return table.remove(arg_2_0.pools[arg_2_1], #arg_2_0.pools[arg_2_1])
	end

	return
end

function var_0_0.Return(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:Dispose()

	arg_3_2 = arg_3_2 or arg_3_1.class

	local var_3_0 = arg_3_0.pools

	var_3_0[arg_3_2] = arg_3_0.pools[arg_3_2] or {}

	table.insert(arg_3_0.pools[arg_3_2], arg_3_1)

	return
end

function var_0_0.ReturnArray(arg_4_0, arg_4_1, arg_4_2)
	for iter_4_0, iter_4_1 in ipairs(arg_4_1) do
		arg_4_0:Return(iter_4_1, arg_4_2)
	end

	return
end

function var_0_0.ReturnMap(arg_5_0, arg_5_1, arg_5_2)
	for iter_5_0, iter_5_1 in pairs(arg_5_1) do
		arg_5_0:Return(iter_5_1, arg_5_2)
	end

	return
end

return var_0_0
