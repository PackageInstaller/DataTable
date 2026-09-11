local var_0_0 = {
	trackingEntityIdList = {
		110006
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110006)
	end,
	OnMiniGameFinish_110006 = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110006)

return var_0_0
