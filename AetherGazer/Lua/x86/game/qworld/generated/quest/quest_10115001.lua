return {
	OnQuestFinish = function(arg_1_0)
		_GRAPH_API.PlayCommonStoryLoading(923021001)
	end,
	OnQuestUnmeet = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}
