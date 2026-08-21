local var_0_0 = {
	trackingEntityIdList = {
		30011
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30011)
	end,
	OnClickBubble_30011 = function(arg_2_0)
		_GRAPH_API.PlayStory(11020, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30011)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30011] = 1

return var_0_0
