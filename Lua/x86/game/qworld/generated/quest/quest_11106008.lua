local var_0_0 = {
	trackingEntityIdList = {
		10015
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(10015)
	end,
	OnClickBubble_10015 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(10015)
		_GRAPH_API.PlayCommonStory(104180701, function()
			_GRAPH_API.ThingDestroy(350041)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 10015)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[10015] = 1

return var_0_0
