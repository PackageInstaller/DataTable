return {
	OnBackMainHome = function(self)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.PlayTalkList({
			10012001,
			10012002,
			10012003
		}, function()
			return
		end)
	end
}
