return {
	OnQuestFinish = function(arg_1_0)
		_GRAPH_API.PlayCommonStoryLoading(923021001)
	end,
	OnQuestUnmeet = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}
