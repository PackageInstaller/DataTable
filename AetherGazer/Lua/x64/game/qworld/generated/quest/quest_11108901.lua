local var_0_0 = {
	trackingEntityIdList = {
		19
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(80016)
		_GRAPH_API.ThingCreate(23)
		_GRAPH_API.ThingCreate(24)
		_GRAPH_API.ThingCreate(19)
		_GRAPH_API.EntityInteractEnable(19)
		_GRAPH_API.AddTag(11010607, 19)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(80016)
		_GRAPH_API.ThingDestroy(23)
		_GRAPH_API.ThingDestroy(24)
		_GRAPH_API.ThingDestroy(19)
	end,
	OnClickBubble_19 = function(arg_3_0)
		_GRAPH_API.GotoTag(11010607, 16)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 19)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[19] = 1

return var_0_0
