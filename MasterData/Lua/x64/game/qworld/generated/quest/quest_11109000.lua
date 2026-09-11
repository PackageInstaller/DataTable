local var_0_0 = {
	OnReceiveEvent_EVENT_QUANZHOU_PHASE_CLOSE_3 = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}

var_0_0.OnReceiveEvent = var_0_0.OnReceiveEvent or {}

table.insert(var_0_0.OnReceiveEvent, "EVENT_QUANZHOU_PHASE_CLOSE_3")

return var_0_0
