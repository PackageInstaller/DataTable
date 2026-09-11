local var_0_0 = {
	trackingEntityIdList = {
		60002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(60002)
	end,
	OnClickBubble_60002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11035, function()
			_GRAPH_API.ThingDestroy(60002)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 60002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 60002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[60002] = 1

return var_0_0
