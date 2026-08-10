local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(300001)
		_GRAPH_API.ThingCreate(300003)
	end,
	OnClickBubble_300003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(300003)
		_GRAPH_API.PlayStory(11925, function()
			_GRAPH_API.ThingDestroy(300001)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingCreate(300002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 300003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[300003] = 1

return var_0_0
