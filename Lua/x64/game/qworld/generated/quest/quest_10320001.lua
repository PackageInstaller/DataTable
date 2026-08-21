local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(90001)
	end,
	OnClickBubble_90018 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 90018)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[90018] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(90018)
	_GRAPH_API.ThingCreate(90040)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(90040)
	end)
end

function var_0_0.OnMiniGameFinish_90001(arg_5_0)
	_GRAPH_API.ThingCreate(90018)
	_GRAPH_API.ThingDestroy(90001)
end

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 90001)

return var_0_0
