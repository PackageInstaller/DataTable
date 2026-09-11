local var_0_0 = {
	trackingEntityIdList = {
		20014
	},
	OnClickBubble_20014 = function(arg_1_0)
		_GRAPH_API.ThingDestroy(20004)
		_GRAPH_API.ThingCreate(11)
		_GRAPH_API.AddTag(11010602, 4)
		_GRAPH_API.PlayStory(11009, function()
			_GRAPH_API.GotoTag(11010602, 4)
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, 4)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 20014)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[20014] = 1

function var_0_0.OnQuestUnmeet(arg_3_0)
	_GRAPH_API.ThingCreate(20014)
	_GRAPH_API.ThingCreate(20004)
end

return var_0_0
