local var_0_0 = {
	trackingEntityIdList = {
		30006
	},
	OnClickBubble_30006 = function(arg_1_0)
		_GRAPH_API.AddTag(11010603, 4)
		_GRAPH_API.PlayStory(11014, function()
			_GRAPH_API.GotoTag(11010603, 4)
			_GRAPH_API.EntityInteractDisable(30006)
			_GRAPH_API.ThingDestroy(30006)
			_GRAPH_API.QuestSetFinish(arg_1_0.questId_, arg_1_0.questId_)
		end, 4)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30006)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30006] = 1

function var_0_0.OnQuestUnmeet(arg_3_0)
	_GRAPH_API.ThingCreate(30006)
	_GRAPH_API.EntityInteractEnable(30006)
end

return var_0_0
