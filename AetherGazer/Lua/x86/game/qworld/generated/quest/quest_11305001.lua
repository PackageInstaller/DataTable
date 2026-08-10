local var_0_0 = {
	trackingEntityIdList = {
		110005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110005)
	end,
	OnMiniGameFinish_110005 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110005)

return var_0_0
