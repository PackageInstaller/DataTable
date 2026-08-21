local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(140001)
	end,
	OnClickBubble_140002 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 140002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[140002] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(140002)
	_GRAPH_API.ThingCreate(140043)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(140043)
	end)
end

function var_0_0.OnMiniGameFinish_140001(arg_5_0)
	_GRAPH_API.ThingCreate(140002)
	_GRAPH_API.ThingDestroy(140001)
end

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 140001)

return var_0_0
