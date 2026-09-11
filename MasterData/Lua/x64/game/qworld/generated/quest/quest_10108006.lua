return {
	trackingEntityIdList = {
		40011
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.CreateDrop(40005, true, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end)
		_GRAPH_API.ThingCreate(40011)
	end,
	OnQuestFinish = function(arg_3_0)
		_GRAPH_API.PlayTalkList({
			10018001,
			10018002,
			10018003
		}, function()
			return
		end)
		_GRAPH_API.ThingDestroy(40011)
		_GRAPH_API.ThingCreate(40010)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(40010)
		end)
	end
}
