local var_0_0 = {
	trackingEntityIdList = {
		440001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(440001)
	end,
	OnClickBubble_440001 = function(arg_2_0)
		_GRAPH_API.PlayStory(11191, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 440001)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 440001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[440001] = 1

function var_0_0.OnQuestFinish(arg_4_0)
	_GRAPH_API.ThingDestroy(440001)
end

return var_0_0
