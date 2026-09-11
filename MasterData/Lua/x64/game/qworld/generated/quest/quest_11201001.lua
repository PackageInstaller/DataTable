local var_0_0 = {
	trackingEntityIdList = {
		370001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(370001)
		_GRAPH_API.EntityInteractEnable(370001)
	end,
	OnClickBubble_370001 = function(arg_2_0)
		if _GRAPH_API.QuestGetProg(11106902) == 1 then
			_GRAPH_API.PlayStory(11211, function()
				_GRAPH_API.EntityInteractDisable(370001)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 370001)
		else
			_GRAPH_API.PlayStory(11111, function()
				_GRAPH_API.EntityInteractDisable(370001)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 370001)
		end
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 370001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[370001] = 1

return var_0_0
