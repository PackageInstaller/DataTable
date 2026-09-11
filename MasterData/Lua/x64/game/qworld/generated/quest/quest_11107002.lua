local var_0_0 = {
	trackingEntityIdList = {
		60001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(60001)
	end,
	OnEnterZone_60001 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(60001)
		_GRAPH_API.PlayStory(11034, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 60001)

return var_0_0
