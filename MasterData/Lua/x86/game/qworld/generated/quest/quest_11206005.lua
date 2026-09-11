local var_0_0 = {
	trackingEntityIdList = {
		410011
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(410001)
		_GRAPH_API.ThingCreate(410011)
		_GRAPH_API.ThingCreate(410009)
		_GRAPH_API.EntityInteractEnable(410011)
	end,
	OnClickBubble_410011 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(410011)
		_GRAPH_API.ThingDestroy(410009)
		_GRAPH_API.ThingCreate(410012)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(410012)
		end)
		_GRAPH_API.PlayStory(11165, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 410011)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[410011] = 1

return var_0_0
