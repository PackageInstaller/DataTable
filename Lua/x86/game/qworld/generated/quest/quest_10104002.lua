return {
	trackingEntityIdList = {
		40013
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30003)
		_GRAPH_API.CreateDrop(40001, true, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end)
		_GRAPH_API.ThingCreate(40013)
	end,
	OnQuestFinish = function(arg_3_0)
		_GRAPH_API.ThingDestroy(40013)
		_GRAPH_API.ThingCreate(40007)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(40007)
		end)
	end
}
