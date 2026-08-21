local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(80004)
	end,
	OnClickBubble_80004 = function(arg_2_0)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 80004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[80004] = 1

function var_0_0.OnQuestFinish(arg_3_0)
	_GRAPH_API.ThingDestroy(80004)
	_GRAPH_API.ThingCreate(80017)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(80017)
	end)
end

return var_0_0
