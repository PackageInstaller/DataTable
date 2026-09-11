local var_0_0 = {
	trackingEntityIdList = {
		370011
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(370001)
		_GRAPH_API.ThingCreate(370011)
	end,
	OnClickBubble_370011 = function(arg_2_0)
		_GRAPH_API.PlayStory(11112, function()
			_GRAPH_API.ThingDestroy(370011)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 370011)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[370011] = 1

return var_0_0
