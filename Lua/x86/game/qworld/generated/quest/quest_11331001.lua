local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(140001)
		_GRAPH_API.ThingCreate(140003)
	end,
	OnClickBubble_140003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(140003)
		_GRAPH_API.PlayStory(11921, function()
			_GRAPH_API.ThingDestroy(140001)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingCreate(140002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 140003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[140003] = 1

return var_0_0
