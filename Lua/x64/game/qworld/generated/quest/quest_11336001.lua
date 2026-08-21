local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(310001)
		_GRAPH_API.ThingCreate(310003)
	end,
	OnClickBubble_310003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(310003)
		_GRAPH_API.PlayStory(11926, function()
			_GRAPH_API.ThingDestroy(310001)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingCreate(310002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 310003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[310003] = 1

return var_0_0
