local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(190010)
	end,
	OnClickBubble_190010 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(190010)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 190010)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[190010] = 1

return var_0_0
