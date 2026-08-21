local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(100005)
		_GRAPH_API.ThingCreate(100006)
	end,
	OnClickBubble_100005 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 100005)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[100005] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(100006)
	_GRAPH_API.ThingDestroy(100005)
	_GRAPH_API.ThingCreate(100023)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(100023)
	end)
end

return var_0_0
