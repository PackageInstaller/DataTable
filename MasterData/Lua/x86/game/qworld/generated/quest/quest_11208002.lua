local var_0_0 = {
	trackingEntityIdList = {
		430002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(430001)
		_GRAPH_API.ThingCreate(430002)
	end,
	OnClickBubble_430002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11182, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 430002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 430002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[430002] = 1

return var_0_0
