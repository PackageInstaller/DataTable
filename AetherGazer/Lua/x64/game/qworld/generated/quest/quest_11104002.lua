local var_0_0 = {
	trackingEntityIdList = {
		30004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.EntityInteractEnable(30004)
		_GRAPH_API.ThingCreate(30006)
	end,
	OnClickBubble_30004 = function(arg_2_0)
		_GRAPH_API.PlayStory(11098, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.Delay(0.5, function()
			_GRAPH_API.ThingCreate(30005)
			_GRAPH_API.ThingDestroy(30004)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30004] = 1

return var_0_0
