return {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.PlayCommonStory(104180901, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end)
		_GRAPH_API.ThingDestroy(60011)
		_GRAPH_API.ThingDestroy(60012)
		_GRAPH_API.ThingDestroy(60013)
		_GRAPH_API.ThingDestroy(60014)
	end
}
