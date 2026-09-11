local var_0_0 = {
	trackingEntityIdList = {
		110004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110004)
	end,
	OnMiniGameFinish_110004 = function(arg_2_0)
		_GRAPH_API.PlayStory(11032, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110004)

return var_0_0
