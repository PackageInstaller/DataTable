local var_0_0 = {
	trackingEntityIdList = {
		30001
	},
	OnQuestNotStart = function(arg_1_0)
		_GRAPH_API.ThingCreate(30001)
		_GRAPH_API.ThingCreate(160001)
		_GRAPH_API.ThingCreate(160002)
		_GRAPH_API.ThingCreate(160003)
		_GRAPH_API.ZoneEnable(160004)
		_GRAPH_API.ZoneEnable(160005)
	end,
	OnClickBubble_30001 = function(arg_2_0)
		_GRAPH_API.PlayStory(10003, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 30001)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 30001)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[30001] = 1

function var_0_0.OnQuestUnmeet(arg_4_0)
	_GRAPH_API.ThingCreate(30001)
	_GRAPH_API.ThingCreate(160001)
	_GRAPH_API.ThingCreate(160002)
	_GRAPH_API.ThingCreate(160003)
	_GRAPH_API.ZoneEnable(160004)
	_GRAPH_API.ZoneEnable(160005)
end

function var_0_0.OnEnterZone_160004(arg_5_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160004)

function var_0_0.OnEnterZone_160005(arg_7_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160005)

function var_0_0.OnEnterZone_160004(arg_9_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160004)

function var_0_0.OnEnterZone_160005(arg_11_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160005)

return var_0_0
