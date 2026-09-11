local var_0_0 = {
	trackingEntityIdList = {
		410007
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(410001)
		_GRAPH_API.ThingCreate(410007)
		_GRAPH_API.ThingCreate(410006)
		_GRAPH_API.EntityInteractEnable(410007)
	end,
	OnClickBubble_410007 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(410007)
		_GRAPH_API.ThingDestroy(410006)
		_GRAPH_API.ThingCreate(410008)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(410008)
		end)
		_GRAPH_API.PlayStory(11164, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 410007)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[410007] = 1

return var_0_0
