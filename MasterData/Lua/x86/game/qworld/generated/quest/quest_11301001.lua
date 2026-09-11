local var_0_0 = {
	trackingEntityIdList = {
		110001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110001)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(110001)
	end,
	OnMiniGameFinish_110001 = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110001)

return var_0_0
