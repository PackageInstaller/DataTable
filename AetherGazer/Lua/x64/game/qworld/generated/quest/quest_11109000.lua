local var_0_0 = {
	OnReceiveEvent_EVENT_QUANZHOU_PHASE_CLOSE_3 = function(arg_1_0)
		_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
	end
}

var_0_0.OnReceiveEvent = var_0_0.OnReceiveEvent or {}

table.insert(var_0_0.OnReceiveEvent, "EVENT_QUANZHOU_PHASE_CLOSE_3")

return var_0_0
