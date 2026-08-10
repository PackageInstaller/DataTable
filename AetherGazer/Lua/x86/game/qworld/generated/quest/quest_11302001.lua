local var_0_0 = {
	trackingEntityIdList = {
		110002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110002)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(110002)
	end,
	OnMiniGameFinish_110002 = function(arg_3_0)
		_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110002)

return var_0_0
