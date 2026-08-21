local var_0_0 = {
	trackingEntityIdList = {
		430001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(430001)
		_GRAPH_API.ThingCreate(430002)
	end,
	OnClickBubble_430001 = function(arg_2_0)
		_GRAPH_API.PlayStory(11183, function()
			_GRAPH_API.ThingDestroy(430001)
			_GRAPH_API.ThingDestroy(430002)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 430001)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 430001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[430001] = 1

return var_0_0
