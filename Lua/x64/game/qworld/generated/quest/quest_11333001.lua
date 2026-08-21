local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(280001)
		_GRAPH_API.ThingCreate(280003)
	end,
	OnClickBubble_280003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(280003)
		_GRAPH_API.PlayStory(11923, function()
			_GRAPH_API.ThingDestroy(280001)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingCreate(280002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 280003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[280003] = 1

return var_0_0
