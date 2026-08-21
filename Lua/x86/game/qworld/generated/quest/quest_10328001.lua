local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(100007)
		_GRAPH_API.ThingCreate(100008)
	end,
	OnClickBubble_100007 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 100007)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[100007] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(100007)
	_GRAPH_API.ThingDestroy(100008)
	_GRAPH_API.ThingCreate(100026)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(100026)
	end)
end

return var_0_0
