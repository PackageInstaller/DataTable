class = var_0_10000

local var_0_0 = "IslandNpcFeedbackAgency"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".IslandBaseAgency"))

var_0_1.NPC_ACTION_CHANGE = "IslandNpcFeedbackAgency:NPC_ACTION_CHANGE"
var_0_1.RESET_NPC_ACTIONS = "IslandNpcFeedbackAgency:RESET_NPC_ACTIONS"

function var_0_1.OnInit(arg_1_0, arg_1_1)
	arg_1_0.npcList = {}
	ipairs = var_2

	for iter_1_0, iter_1_1 in var_2(arg_1_1.action_feedback_npc_list) do
		table = var_1_10007

		var_1_10007.insert(arg_1_0.npcList, iter_1_1)
	end

	return
end

function var_0_1.GetNpcList(arg_2_0)
	return arg_2_0.npcList
end

function var_0_1.AddNpc(arg_3_0, arg_3_1)
	table = var_1_10002

	var_1_10002.insert(arg_3_0.npcList, arg_3_1)
	arg_3_0:DispatchEvent(var_0_1.NPC_ACTION_CHANGE, arg_3_1)

	return
end

function var_0_1.UpdatePerDay(arg_4_0)
	arg_4_0.npcList = {}

	arg_4_0:DispatchEvent(var_0_1.RESET_NPC_ACTIONS)

	return
end

return var_0_1
