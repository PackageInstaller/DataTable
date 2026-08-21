local var_0_0 = {
	trackingEntityIdList = {
		30014
	},
	OnQuestFinish = function(arg_1_0)
		return
	end,
	OnQuestUnmeet = function(arg_2_0)
		_GRAPH_API.ThingCreate(30007)
		_GRAPH_API.ThingCreate(30014)
		_GRAPH_API.ThingCreate(30015)
	end,
	OnClickBubble_30014 = function(arg_3_0)
		_GRAPH_API.ThingDestroy(30014)
		_GRAPH_API.PlayStory(11017, function()
			_GRAPH_API.ThingDestroy(30015)
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, nil)
		_GRAPH_API.Delay(6.2, function()
			_GRAPH_API.ThingCreate(30008)
			_GRAPH_API.ThingDestroy(30007)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30014)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30014] = 1

return var_0_0
