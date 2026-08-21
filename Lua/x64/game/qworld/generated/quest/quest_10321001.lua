local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(110001)
	end,
	OnClickBubble_110002 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 110002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[110002] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(110002)
	_GRAPH_API.ThingCreate(110039)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(110039)
	end)
end

function var_0_0.OnMiniGameFinish_110001(arg_5_0)
	_GRAPH_API.ThingCreate(110002)
	_GRAPH_API.ThingDestroy(110001)
end

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 110001)

return var_0_0
