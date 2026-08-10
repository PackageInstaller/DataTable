local var_0_0 = {
	OnClickBubble_30005 = function(arg_1_0)
		_GRAPH_API.PlayStory(10038, function()
			_GRAPH_API.GotoTag(313631, 0)
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, 30005)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30005)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30005] = 1

return var_0_0
