local var_0_0 = class("IslandNpcFeedbackAgency", import(".IslandBaseAgency"))

var_0_0.NPC_ACTION_CHANGE = "IslandNpcFeedbackAgency:NPC_ACTION_CHANGE"
var_0_0.RESET_NPC_ACTIONS = "IslandNpcFeedbackAgency:RESET_NPC_ACTIONS"

function var_0_0.OnInit(arg_1_0, arg_1_1)
	arg_1_0.npcList = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.action_feedback_npc_list) do
		table.insert(arg_1_0.npcList, iter_1_1)
	end

	return
end

function var_0_0.GetNpcList(arg_2_0)
	return arg_2_0.npcList
end

function var_0_0.AddNpc(arg_3_0, arg_3_1)
	table.insert(arg_3_0.npcList, arg_3_1)
	arg_3_0:DispatchEvent(var_0_0.NPC_ACTION_CHANGE, arg_3_1)

	return
end

function var_0_0.UpdatePerDay(arg_4_0)
	arg_4_0.npcList = {}

	arg_4_0:DispatchEvent(var_0_0.RESET_NPC_ACTIONS)

	return
end

return var_0_0
