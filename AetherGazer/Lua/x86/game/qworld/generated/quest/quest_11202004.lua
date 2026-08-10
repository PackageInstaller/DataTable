local var_0_0 = {
	trackingEntityIdList = {
		380004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(380004)
		_GRAPH_API.ThingCreate(380001)
		_GRAPH_API.ThingCreate(380002)
		_GRAPH_API.EntityInteractEnable(380004)
	end,
	OnClickBubble_380004 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(380004)
		_GRAPH_API.ThingCreate(380007)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(380007)
		end)
		_GRAPH_API.PlayStory(11124, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380004] = 1

return var_0_0
