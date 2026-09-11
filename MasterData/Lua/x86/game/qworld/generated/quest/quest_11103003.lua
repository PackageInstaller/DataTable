local var_0_0 = {
	trackingEntityIdList = {
		20004
	},
	OnClickBubble_20004 = function(arg_1_0)
		_GRAPH_API.PlayStory(11007, function()
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, 20004)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 20004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[20004] = 1

function var_0_0.OnQuestUnmeet(arg_3_0)
	_GRAPH_API.ThingCreate(20004)
	_GRAPH_API.ThingCreate(20014)
	_GRAPH_API.ThingDestroy(20002)
end

return var_0_0
