local var_0_0 = {
	trackingEntityIdList = {
		110010
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110010)
	end,
	OnMiniGameFinish_110010 = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110010)

return var_0_0
