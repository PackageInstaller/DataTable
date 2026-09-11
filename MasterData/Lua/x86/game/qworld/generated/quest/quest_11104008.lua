local var_0_0 = {
	trackingEntityIdList = {
		110002
	},
	OnQuestUnmeet = function(arg_1_0)
		return
	end,
	OnQuestNotStart = function(arg_2_0)
		return
	end,
	OnQuestUnmeet = function(arg_3_0)
		_GRAPH_API.ThingCreate(110002)
	end,
	OnMiniGameFinish_110002 = function(arg_4_0)
		_GRAPH_API.ThingDestroy(110002)
		_GRAPH_API.PlayStory(11018, function()
			_GRAPH_API.QuestSetFinish(arg_4_0.questId_, arg_4_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110002)

return var_0_0
