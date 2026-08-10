local var_0_0 = {
	trackingEntityIdList = {
		110001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.PlayStory(11010, function()
			_GRAPH_API.ThingCreate(110001)
			_GRAPH_API.ThingCreate(20017)
		end, nil)
	end,
	OnQuestFinish = function(arg_3_0)
		_GRAPH_API.ThingDestroy(20017)
	end,
	OnMiniGameFinish_110001 = function(arg_4_0)
		_GRAPH_API.ThingDestroy(110001)
		_GRAPH_API.PlayStory(11011, function()
			_GRAPH_API.ThingDestroy(20004)
			_GRAPH_API.QuestSetFinish(arg_4_0.questId_, arg_4_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110001)

return var_0_0
