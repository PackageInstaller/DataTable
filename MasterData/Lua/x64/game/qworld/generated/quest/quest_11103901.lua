local var_0_0 = {
	trackingEntityIdList = {
		20012
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(20014)
		_GRAPH_API.ThingCreate(20012)
		_GRAPH_API.ThingDestroy(10)
		_GRAPH_API.AddTag(11010602, 20012)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(20014)
		_GRAPH_API.ThingDestroy(20012)
	end,
	OnClickBubble_20012 = function(arg_3_0)
		_GRAPH_API.GotoTag(11010602, 16)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 20012)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[20012] = 1

return var_0_0
