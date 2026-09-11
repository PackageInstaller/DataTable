local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(290001)
		_GRAPH_API.ThingCreate(290003)
	end,
	OnClickBubble_290003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(290003)
		_GRAPH_API.PlayStory(11924, function()
			_GRAPH_API.ThingDestroy(290001)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingCreate(290002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 290003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[290003] = 1

return var_0_0
