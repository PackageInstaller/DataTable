local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(200001)
	end,
	OnMiniGameFinish_200001 = function(arg_2_0)
		_GRAPH_API.PlayStory(11902, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 200001)

return var_0_0
