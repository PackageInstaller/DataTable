local var_0_0 = {
	OnReceiveEvent_EVENT_QUANZHOU_PHASE_CLOSE_2 = function(arg_1_0)
		_GRAPH_API.ThingCreate(60011)
		_GRAPH_API.ThingCreate(60012)
		_GRAPH_API.ThingCreate(60013)
		_GRAPH_API.ThingCreate(60014)
		_GRAPH_API.PlayStory(11033, function()
			_GRAPH_API.Delay(2, function()
				_GRAPH_API.PlayTalkList({
					11033001,
					11033002,
					11033003
				}, function()
					return
				end)
			end)
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, nil)
		_GRAPH_API.Delay(7.65, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, 11106902)
		end)
	end
}

var_0_0.OnReceiveEvent = var_0_0.OnReceiveEvent or {}

table.insert(var_0_0.OnReceiveEvent, "EVENT_QUANZHOU_PHASE_CLOSE_2")

return var_0_0
