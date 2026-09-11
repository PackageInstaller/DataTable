local var_0_0 = {
	trackingEntityIdList = {
		50003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(50006)
		_GRAPH_API.ThingCreate(50007)
		_GRAPH_API.ThingCreate(50008)
		_GRAPH_API.ThingCreate(50010)
	end,
	OnClickBubble_50003 = function(arg_2_0)
		_GRAPH_API.PlayStory(11027, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 50003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[50003] = 1

return var_0_0
