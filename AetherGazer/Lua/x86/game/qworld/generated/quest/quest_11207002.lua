local var_0_0 = {
	trackingEntityIdList = {
		420003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(420001)
		_GRAPH_API.ThingCreate(420002)
	end,
	OnClickBubble_420003 = function(arg_2_0)
		_GRAPH_API.PlayStory(11172, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 420003)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 420003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[420003] = 1

return var_0_0
