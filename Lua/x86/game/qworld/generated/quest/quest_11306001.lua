local var_0_0 = {
	trackingEntityIdList = {
		110006
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110006)
	end,
	OnMiniGameFinish_110006 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110006)

return var_0_0
