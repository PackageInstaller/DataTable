local var_0_0 = {
	trackingEntityIdList = {
		110008
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110008)
	end,
	OnMiniGameFinish_110008 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110008)

return var_0_0
