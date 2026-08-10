return {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.PlayCommonStory(104180101, function()
			_GRAPH_API.PlayStory(11001, function()
				_GRAPH_API.PlayCommonStory(104180201, function()
					_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
				end)
			end, nil)
		end)
	end
}
