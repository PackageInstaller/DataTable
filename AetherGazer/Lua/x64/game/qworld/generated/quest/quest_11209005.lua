local var_0_0 = {
	trackingEntityIdList = {
		440008
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(440008)
	end,
	OnClickBubble_440008 = function(arg_2_0)
		_GRAPH_API.PlayStory(11192, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 440008)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[440008] = 1

function var_0_0.OnQuestFinish(arg_4_0)
	_GRAPH_API.ThingDestroy(440008)
end

return var_0_0
