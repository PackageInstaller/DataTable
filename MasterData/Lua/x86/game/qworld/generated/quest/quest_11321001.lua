local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(130001)
		_GRAPH_API.ThingCreate(130005)
	end,
	OnMiniGameFinish_130001 = function(arg_2_0)
		_GRAPH_API.PlayStory(11911, function()
			_GRAPH_API.ThingDestroy(130005)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 130001)

return var_0_0
