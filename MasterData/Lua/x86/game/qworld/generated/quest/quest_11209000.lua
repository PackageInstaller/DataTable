return {
	OnQuestUnmeet = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}
