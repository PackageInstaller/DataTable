local var_0_0 = {
	trackingEntityIdList = {
		30015
	},
	OnClickBubble_30015 = function(arg_1_0)
		_GRAPH_API.PlayStory(11016, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30015)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30015] = 1

function var_0_0.OnQuestUnmeet(arg_3_0)
	_GRAPH_API.ThingCreate(30007)
	_GRAPH_API.ThingCreate(30015)
end

return var_0_0
