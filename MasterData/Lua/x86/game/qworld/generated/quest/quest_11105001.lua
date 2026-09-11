local var_0_0 = {
	trackingEntityIdList = {
		40001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(40001)
	end,
	OnClickBubble_40001 = function(arg_2_0)
		_GRAPH_API.PlayCommonStory(104180501, function()
			_GRAPH_API.ThingDestroy(40001)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 40001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[40001] = 1

return var_0_0
