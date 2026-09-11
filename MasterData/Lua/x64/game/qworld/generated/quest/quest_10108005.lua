local var_0_0 = {
	trackingEntityIdList = {
		30048
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30048)
	end,
	OnClickBubble_30048 = function(arg_2_0)
		_GRAPH_API.PlayStory(10017, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 30048)
		_GRAPH_API.Delay(0.5, function()
			_GRAPH_API.ThingDestroy(30048)
			_GRAPH_API.ThingCreate(40005)
		end)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30048)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30048] = 1

function var_0_0.OnQuestFinish(arg_5_0)
	_GRAPH_API.ThingCreate(40005)
	_GRAPH_API.ThingDestroy(30048)
end

return var_0_0
