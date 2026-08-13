class = var_0_10000

local var_0_0 = "BaseEntityBank"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".BaseEntityPool"))

var_0_1.Fields = {
	marks = "table"
}

function var_0_1.Build(arg_1_0)
	var_0_1.super.Build(arg_1_0)

	arg_1_0.marks = {}

	return
end

function var_0_1.Fetch(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0:Get(arg_2_1)
	local var_2_1 = arg_2_0.marks
	local var_2_2

	if not arg_2_0.marks[arg_2_1] then
		var_2_2 = {}
	end

	var_2_1[arg_2_1] = var_2_2
	table = var_2_1

	var_2_1.insert(arg_2_0.marks[arg_2_1], var_2_0)

	return var_2_0
end

function var_0_1.Recycle(arg_3_0, arg_3_1)
	if arg_3_0.marks[arg_3_1] then
		ipairs = var_1_10003

		for iter_3_0, iter_3_1 in var_1_10003(var_2) do
			arg_3_0:Return(iter_3_1, arg_3_1)
		end

		arg_3_0.marks[arg_3_1] = nil
	end

	return
end

function var_0_1.RecycleAll(arg_4_0)
	pairs = var_1_10001

	for iter_4_0, iter_4_1 in var_1_10001(arg_4_0.marks) do
		ipairs = var_1_10006

		for iter_4_2, iter_4_3 in var_1_10006(iter_4_1) do
			arg_4_0:Return(iter_4_3, iter_4_0)
		end
	end

	arg_4_0.marks = {}

	return
end

return var_0_1
