local var_0_0 = {
	trackingEntityIdList = {
		110005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110005)
		_GRAPH_API.ThingCreate(80009)
		_GRAPH_API.ThingCreate(80010)
		_GRAPH_API.ThingCreate(80011)
		_GRAPH_API.ThingCreate(80012)
		_GRAPH_API.ThingCreate(80013)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(80009)
		_GRAPH_API.ThingDestroy(80010)
		_GRAPH_API.ThingDestroy(80011)
		_GRAPH_API.ThingDestroy(80012)
		_GRAPH_API.ThingDestroy(80013)
	end,
	OnMiniGameFinish_110005 = function(arg_3_0)
		_GRAPH_API.PlayCommonStory(104181001, function()
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110005)

return var_0_0
