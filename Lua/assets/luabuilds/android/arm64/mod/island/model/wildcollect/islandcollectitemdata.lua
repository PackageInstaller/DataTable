local var_0_0 = class("IslandCollectItemData", import("model.vo.BaseVO"))

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0.id = arg_1_1.id
	arg_1_0.hadFragmentList = {}

	local var_1_0 = arg_1_1.had_fragment or {}

	for iter_1_0, iter_1_1 in ipairs(var_1_0) do
		table.insert(arg_1_0.hadFragmentList, iter_1_1)
	end

	return
end

function var_0_0.AddFragment(arg_2_0, arg_2_1)
	table.insert(arg_2_0.hadFragmentList, arg_2_1)

	return
end

function var_0_0.CheckFragment(arg_3_0, arg_3_1)
	for iter_3_0, iter_3_1 in ipairs(arg_3_0.hadFragmentList) do
		if iter_3_1 == arg_3_1 then
			return true
		end
	end

	return false
end

function var_0_0.ResetFragment(arg_4_0)
	arg_4_0.hadFragmentList = {}

	return
end

function var_0_0.UpdateData(arg_5_0, arg_5_1)
	return
end

function var_0_0.bindConfigTable(arg_6_0)
	return pg.island_collection
end

return var_0_0
