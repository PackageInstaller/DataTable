local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(80007)
	end,
	OnClickBubble_80007 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 80007)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[80007] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(80007)
	_GRAPH_API.ThingCreate(80020)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(80020)
	end)
end

return var_0_0
