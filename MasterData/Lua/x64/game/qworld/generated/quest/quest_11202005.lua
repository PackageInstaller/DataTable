local var_0_0 = {
	trackingEntityIdList = {
		380005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(380005)
		_GRAPH_API.ThingCreate(380001)
		_GRAPH_API.ThingCreate(380002)
		_GRAPH_API.EntityInteractEnable(380005)
	end,
	OnClickBubble_380005 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(380005)
		_GRAPH_API.ThingCreate(380008)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(380008)
		end)
		_GRAPH_API.PlayStory(11125, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380005)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380005] = 1

return var_0_0
