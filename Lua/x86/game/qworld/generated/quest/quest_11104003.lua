local var_0_0 = {
	trackingEntityIdList = {
		30002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.EntityInteractEnable(30002)
		_GRAPH_API.ThingCreate(30006)
	end,
	OnClickBubble_30002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11099, function()
			_GRAPH_API.ThingDestroy(30013)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingDestroy(30002)
		_GRAPH_API.ThingCreate(30003)
		_GRAPH_API.PlayerTeleport(30017, function()
			return
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30002] = 1

return var_0_0
