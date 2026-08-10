local var_0_0 = {
	trackingEntityIdList = {
		380001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(380001)
		_GRAPH_API.ThingCreate(380016)
		_GRAPH_API.ThingCreate(380017)
		_GRAPH_API.ThingCreate(380018)
		_GRAPH_API.ThingCreate(380002)
		_GRAPH_API.EntityInteractEnable(380001)
	end,
	OnClickBubble_380001 = function(arg_2_0)
		if _GRAPH_API.QuestGetProg(11106902) == 1 then
			_GRAPH_API.PlayStory(11226, function()
				_GRAPH_API.ThingDestroy(380016)
				_GRAPH_API.ThingDestroy(380017)
				_GRAPH_API.ThingDestroy(380018)
				_GRAPH_API.ThingDestroy(380002)
				_GRAPH_API.ThingCreate(380001)
				_GRAPH_API.NpcMove(380001, 380010, 0, function()
					_GRAPH_API.ThingDestroy(380001)
					_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
				end)
			end, nil)
		else
			_GRAPH_API.PlayStory(11126, function()
				_GRAPH_API.ThingDestroy(380016)
				_GRAPH_API.ThingDestroy(380017)
				_GRAPH_API.ThingDestroy(380018)
				_GRAPH_API.ThingDestroy(380002)
				_GRAPH_API.ThingCreate(380001)
				_GRAPH_API.NpcMove(380001, 380010, 0, function()
					_GRAPH_API.ThingDestroy(380001)
					_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
				end)
			end, nil)
		end
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380001] = 1

return var_0_0
