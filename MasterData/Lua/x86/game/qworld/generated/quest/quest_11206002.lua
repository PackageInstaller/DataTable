local var_0_0 = {
	trackingEntityIdList = {
		410002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(410001)
		_GRAPH_API.ThingCreate(410002)
		_GRAPH_API.EntityInteractEnable(410002)
	end,
	OnClickBubble_410002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11162, function()
			_GRAPH_API.ThingDestroy(410002)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 410002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[410002] = 1

return var_0_0
