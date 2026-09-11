return {
	trackingEntityIdList = {
		40014
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(40014)
		_GRAPH_API.ThingCreate(30003)
		_GRAPH_API.CreateDrop(40002, true, function()
			_GRAPH_API.ThingDestroy(40014)
			_GRAPH_API.ThingCreate(40008)
			_GRAPH_API.Delay(1.5, function()
				_GRAPH_API.ThingDestroy(40008)
			end)
			_GRAPH_API.PlayStory(10010, function()
				_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
			end, 30005)
		end)
	end
}
