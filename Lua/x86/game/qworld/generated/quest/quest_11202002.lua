local var_0_0 = {
	trackingEntityIdList = {
		380002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(380001)
		_GRAPH_API.ThingCreate(380016)
		_GRAPH_API.ThingCreate(380017)
		_GRAPH_API.ThingCreate(380018)
		_GRAPH_API.ThingCreate(380002)
		_GRAPH_API.EntityInteractEnable(380002)
	end,
	OnClickBubble_380002 = function(arg_2_0)
		_GRAPH_API.PlayStory(11122, function()
			_GRAPH_API.ThingDestroy(380016)
			_GRAPH_API.ThingDestroy(380017)
			_GRAPH_API.ThingDestroy(380018)
		end, nil)
		_GRAPH_API.EntityInteractDisable(380002)
		_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380002] = 1

return var_0_0
