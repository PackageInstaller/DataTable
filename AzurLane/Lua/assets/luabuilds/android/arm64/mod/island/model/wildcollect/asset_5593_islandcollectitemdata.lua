class = var_0_10000

local var_0_0 = "IslandCollectItemData"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("model.vo.BaseVO"))

function var_0_1.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.hadFragmentList = {}
	ipairs = var_2

	local var_1_0

	if not arg_1_1.had_fragment then
		var_1_0 = {}
	end

	for iter_1_0, iter_1_1 in var_2(var_1_0) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.hadFragmentList, iter_1_1)
	end

	return
end

function var_0_1.AddFragment(arg_2_0, arg_2_1)
	table = var_1_10002

	var_1_10002.insert(arg_2_0.hadFragmentList, arg_2_1)

	return
end

function var_0_1.CheckFragment(arg_3_0, arg_3_1)
	ipairs = var_1_10002

	for iter_3_0, iter_3_1 in var_1_10002(arg_3_0.hadFragmentList) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

function var_0_1.ResetFragment(arg_4_0)
	arg_4_0.hadFragmentList = {}

	return
end

function var_0_1.UpdateData(arg_5_0, arg_5_1)
	return
end

function var_0_1.bindConfigTable(arg_6_0)
	pg = var_1_10001

	return var_1_10001.island_collection
end

return var_0_1
