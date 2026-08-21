local var_0_0 = {
	trackingEntityIdList = {
		390003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(390001)
		_GRAPH_API.ThingCreate(390003)
		_GRAPH_API.EntityInteractDisable(390001)
	end,
	OnClickBubble_390003 = function(arg_2_0)
		_GRAPH_API.PlayStory(11132, function()
			_GRAPH_API.ThingDestroy(390003)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 390003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[390003] = 1

return var_0_0
