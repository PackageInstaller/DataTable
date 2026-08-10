local var_0_0 = {
	trackingEntityIdList = {
		110003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110003)
	end,
	OnMiniGameFinish_110003 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110003)

return var_0_0
