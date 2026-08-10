return {
	trackingEntityIdList = {
		30005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.BubbleOptionAdd(arg_1_0.questId_, 30005, function()
			_GRAPH_API.BubbleOptionRemove(arg_1_0.questId_, 30005)
			_GRAPH_API.PlayStory(10024, function()
				_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
			end, 30005)
		end)
	end
}
