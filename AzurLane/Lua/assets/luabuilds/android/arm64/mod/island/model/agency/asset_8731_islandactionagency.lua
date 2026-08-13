class = var_0_10000

local var_0_0 = "IslandActionAgency"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".IslandBaseAgency"))

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.actionList = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.action_list) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.actionList, iter_1_1)
	end

	pg = var_2

	if var_2.island_set.default_action then
		ipairs = var_3

		for iter_1_2, iter_1_3 in var_3(var_2.key_value_varchar) do
			if not arg_1_0:ExistAction(iter_1_3) then
				table = var_8

				var_8.insert(arg_1_0.actionList, iter_1_3)
			end
		end
	end

	return
end

function var_0_1.GetActionList(arg_2_0)
	return arg_2_0.actionList
end

function var_0_1.ExistAction(arg_3_0, arg_3_1)
	table = var_1_10002

	return var_1_10002.contains(arg_3_0.actionList, arg_3_1)
end

function var_0_1.AddAction(arg_4_0, arg_4_1)
	table = var_1_10002

	var_1_10002.insert(arg_4_0.actionList, arg_4_1)

	return
end

return var_0_1
