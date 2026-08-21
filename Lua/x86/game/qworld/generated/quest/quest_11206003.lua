local var_0_0 = {
	trackingEntityIdList = {
		410003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(410001)
		_GRAPH_API.ThingCreate(410003)
		_GRAPH_API.ThingCreate(410005)
		_GRAPH_API.EntityInteractEnable(410003)
	end,
	OnClickBubble_410003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(410003)
		_GRAPH_API.ThingDestroy(410005)
		_GRAPH_API.ThingCreate(410004)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(410004)
		end)
		_GRAPH_API.PlayStory(11163, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 410003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[410003] = 1

return var_0_0
