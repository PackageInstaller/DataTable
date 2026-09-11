return {
	trackingEntityIdList = {
		30005
	},
	OnQuestUnmeet = function(self)
		_GRAPH_API.BubbleOptionAdd(self.questId_, 30005, function()
			_GRAPH_API.BubbleOptionRemove(self.questId_, 30005)
			_GRAPH_API.PlayStory(10013, function()
				_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
			end, 30005)
		end)
	end,
	OnQuestFinish = function(arg_4_0)
		_GRAPH_API.ThingCreate(30006)
	end
}
