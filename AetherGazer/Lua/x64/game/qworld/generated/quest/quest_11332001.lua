local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(270001)
		_GRAPH_API.ThingCreate(270003)
		_GRAPH_API.ThingCreate(270004)
	end,
	OnClickBubble_270003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(270003)
		_GRAPH_API.PlayStory(11922, function()
			_GRAPH_API.ThingDestroy(270001)
			_GRAPH_API.ThingDestroy(270004)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingCreate(270002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 270003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[270003] = 1

return var_0_0
