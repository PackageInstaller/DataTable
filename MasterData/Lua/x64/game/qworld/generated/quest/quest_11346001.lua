local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(190006)
	end,
	OnClickBubble_190006 = function(self)
		_GRAPH_API.ThingDestroy(190006)
		_GRAPH_API.QuestSetFinish(self.questId_, self.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 190006)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[190006] = 1

return var_0_0
