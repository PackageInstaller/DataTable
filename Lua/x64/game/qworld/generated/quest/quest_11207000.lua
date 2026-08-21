local var_0_0 = {
	trackingEntityIdList = {
		420004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(420004)
		_GRAPH_API.ThingCreate(420001)
		_GRAPH_API.ThingCreate(420002)
		_GRAPH_API.EntityInteractEnable(420004)
	end,
	OnClickBubble_420004 = function(arg_2_0)
		if _GRAPH_API.QuestGetProg(11106902) == 1 then
			_GRAPH_API.PlayStory(11270, function()
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 420004)
			_GRAPH_API.EntityInteractDisable(420004)
		else
			_GRAPH_API.PlayStory(11170, function()
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 420004)
			_GRAPH_API.EntityInteractDisable(420004)
		end
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 420004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[420004] = 1

return var_0_0
