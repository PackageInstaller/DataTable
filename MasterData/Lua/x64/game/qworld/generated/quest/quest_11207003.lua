local var_0_0 = {
	trackingEntityIdList = {
		420002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(420001)
		_GRAPH_API.ThingCreate(420002)
		_GRAPH_API.EntityInteractEnable(420002)
	end,
	OnClickBubble_420002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11173, function()
			_GRAPH_API.EntityInteractDisable(420002)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 420002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[420002] = 1

return var_0_0
