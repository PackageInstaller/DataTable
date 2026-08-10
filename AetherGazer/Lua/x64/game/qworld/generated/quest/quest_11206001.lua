local var_0_0 = {
	trackingEntityIdList = {
		410001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(410001)
		_GRAPH_API.EntityInteractEnable(410001)
	end,
	OnClickBubble_410001 = function(arg_2_0)
		if _GRAPH_API.QuestGetProg(11106902) == 1 then
			_GRAPH_API.PlayStory(11261, function()
				_GRAPH_API.EntityInteractDisable(410001)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 410001)
		else
			_GRAPH_API.PlayStory(11161, function()
				_GRAPH_API.EntityInteractDisable(410001)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 410001)
		end
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 410001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[410001] = 1

return var_0_0
