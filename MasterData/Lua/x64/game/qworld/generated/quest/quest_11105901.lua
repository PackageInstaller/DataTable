local var_0_0 = {
	trackingEntityIdList = {
		17
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(40009)
		_GRAPH_API.ThingCreate(17)
		_GRAPH_API.ThingDestroy(12)
		_GRAPH_API.EntityInteractEnable(17)
		_GRAPH_API.AddTag(11010604, 17)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(40009)
		_GRAPH_API.ThingDestroy(17)
	end,
	OnClickBubble_17 = function(arg_3_0)
		_GRAPH_API.GotoTag(11010604, 16)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 17)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[17] = 1

return var_0_0
