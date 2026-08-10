local var_0_0 = {
	trackingEntityIdList = {
		30004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30003)
		_GRAPH_API.ThingCreate(40001)
	end,
	OnClickBubble_30004 = function(arg_2_0)
		_GRAPH_API.PlayStory(10007, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 30004)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30004] = 1

return var_0_0
