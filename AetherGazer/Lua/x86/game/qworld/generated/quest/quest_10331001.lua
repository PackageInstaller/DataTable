local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(100013)
		_GRAPH_API.ThingCreate(100014)
	end,
	OnClickBubble_100013 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 100013)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[100013] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(100013)
	_GRAPH_API.ThingDestroy(100014)
	_GRAPH_API.ThingCreate(100029)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(100029)
	end)
end

return var_0_0
