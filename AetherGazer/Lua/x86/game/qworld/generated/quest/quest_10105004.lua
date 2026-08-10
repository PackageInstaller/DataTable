return {
	OnBackMainHome = function(arg_1_0)
		_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
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
