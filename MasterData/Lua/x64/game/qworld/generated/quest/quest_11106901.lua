local var_0_0 = {
	trackingEntityIdList = {
		18
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(22)
		_GRAPH_API.ThingCreate(18)
		_GRAPH_API.EntityInteractEnable(18)
		_GRAPH_API.AddTag(11010605, 18)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(22)
		_GRAPH_API.ThingDestroy(18)
	end,
	OnClickBubble_18 = function(arg_3_0)
		_GRAPH_API.GotoTag(11010605, 16)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 18)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[18] = 1

return var_0_0
