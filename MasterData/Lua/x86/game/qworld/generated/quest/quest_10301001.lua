local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(20003)
	end,
	OnEnterZone_20003 = function(arg_2_0)
		_GRAPH_API.PlayStory(10019, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 20003)

return var_0_0
