local var_0_0 = {
	trackingEntityIdList = {
		30002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30002)
		_GRAPH_API.ThingCreate(160001)
		_GRAPH_API.ThingCreate(160002)
		_GRAPH_API.ThingCreate(160003)
		_GRAPH_API.ZoneEnable(160004)
		_GRAPH_API.ZoneEnable(160005)
	end,
	OnClickBubble_30002 = function(arg_2_0)
		_GRAPH_API.PlayStory(10006, function()
			_GRAPH_API.ThingCreate(30002)
			_GRAPH_API.NpcMove(30002, 60011, 1, function()
				_GRAPH_API.ThingDestroy(30002)
				_GRAPH_API.ThingCreate(30003)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end)
			_GRAPH_API.PlayStory(10019, function()
				return
			end, nil)
		end, 30002)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30002] = 1

function var_0_0.OnQuestFinish(arg_6_0)
	_GRAPH_API.ThingDestroy(160001)
	_GRAPH_API.ThingDestroy(160002)
	_GRAPH_API.ThingDestroy(160003)
	_GRAPH_API.ZoneDisable(160004)
	_GRAPH_API.ZoneDisable(160005)
end

function var_0_0.OnEnterZone_160004(arg_7_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160004)

function var_0_0.OnEnterZone_160005(arg_9_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160005)

return var_0_0
