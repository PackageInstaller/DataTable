local var_0_0 = {
	trackingEntityIdList = {
		60003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(60003)
	end,
	OnClickBubble_60003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(60003)
		_GRAPH_API.PlayStory(11095, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 60003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[60003] = 1

return var_0_0
