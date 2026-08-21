local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(100003)
		_GRAPH_API.ThingCreate(100021)
		_GRAPH_API.ThingCreate(100022)
	end,
	OnClickBubble_100003 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 100003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[100003] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(100003)
	_GRAPH_API.ThingDestroy(100021)
	_GRAPH_API.ThingDestroy(100022)
	_GRAPH_API.ThingCreate(100025)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(100025)
	end)
end

return var_0_0
