return {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.PlayStory(11015, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, nil)
	end
}
