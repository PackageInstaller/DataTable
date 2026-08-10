local var_0_0 = {
	trackingEntityIdList = {
		8
	},
	OnQuestUnmeet = function(arg_1_0)
		return
	end,
	OnClickBubble_8 = function(arg_2_0)
		_GRAPH_API.PlayerTeleport(7, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 8)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[8] = 1

return var_0_0
