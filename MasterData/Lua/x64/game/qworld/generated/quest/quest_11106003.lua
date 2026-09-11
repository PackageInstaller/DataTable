local var_0_0 = {
	trackingEntityIdList = {
		50002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(50002)
		_GRAPH_API.ThingCreate(50011)
		_GRAPH_API.ThingCreate(50012)
		_GRAPH_API.ThingCreate(50013)
		_GRAPH_API.EntityInteractEnable(50002)
		_GRAPH_API.EntityInteractDisable(50003)
	end,
	OnClickBubble_50002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11028, function()
			_GRAPH_API.EntityInteractDisable(50002)
			_GRAPH_API.ThingDestroy(50011)
			_GRAPH_API.ThingDestroy(50012)
			_GRAPH_API.ThingDestroy(50013)
			_GRAPH_API.ThingDestroy(50003)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 50002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[50002] = 1

return var_0_0
