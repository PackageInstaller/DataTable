local var_0_0 = {
	trackingEntityIdList = {
		390001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(390001)
	end,
	OnClickBubble_390001 = function(arg_2_0)
		_GRAPH_API.PlayStory(11134, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 390001)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 390001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[390001] = 1

return var_0_0
