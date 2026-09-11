local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(20001)
	end,
	OnEnterZone_20001 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(20001)
		_GRAPH_API.PlayTalk(11005011, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 20001)

return var_0_0
