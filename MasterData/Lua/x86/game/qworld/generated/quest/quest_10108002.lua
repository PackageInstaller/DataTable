return {
	trackingEntityIdList = {
		40012
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30006)
		_GRAPH_API.CreateDrop(40003, true, function()
			_GRAPH_API.ThingDestroy(40012)
			_GRAPH_API.ThingCreate(40009)
			_GRAPH_API.Delay(1.5, function()
				_GRAPH_API.ThingDestroy(40009)
			end)
			_GRAPH_API.PlayStory(10014, function()
				_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
			end, 30005)
		end)
		_GRAPH_API.ThingCreate(40012)
	end
}
