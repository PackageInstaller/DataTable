local var_0_0 = {
	trackingEntityIdList = {
		60004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(60004)
	end,
	OnClickBubble_60004 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(60004)
		_GRAPH_API.PlayStory(11096, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 60004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[60004] = 1

return var_0_0
