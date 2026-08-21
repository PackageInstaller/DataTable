local var_0_0 = {
	OnClickBubble_30043 = function(arg_1_0)
		_GRAPH_API.PlayStory(10043, function()
			_GRAPH_API.GotoTag(313435, 0)
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, 30043)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30043)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30043] = 1

return var_0_0
