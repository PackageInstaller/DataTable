local var_0_0 = class("IslandActionAgency", import(".IslandBaseAgency"))

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.actionList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.action_list) do
		table.insert(arg_1_0.actionList, iter_1_1)
	end

	if pg.island_set.default_action then
		for iter_1_2, iter_1_3 in ipairs(pg.island_set.default_action.key_value_varchar) do
			if not arg_1_0:ExistAction(iter_1_3) then
				table.insert(arg_1_0.actionList, iter_1_3)
			end
		end
	end

	return
end

function var_0_0.GetActionList(arg_2_0)
	return arg_2_0.actionList
end

function var_0_0.ExistAction(arg_3_0, arg_3_1)
	return table.contains(arg_3_0.actionList, arg_3_1)
end

function var_0_0.AddAction(arg_4_0, arg_4_1)
	table.insert(arg_4_0.actionList, arg_4_1)

	return
end

return var_0_0
