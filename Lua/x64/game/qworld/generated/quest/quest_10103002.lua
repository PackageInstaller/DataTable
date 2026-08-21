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
	OnQuestUnmeet = function(arg_2_0)
		_GRAPH_API.ThingCreate(30001)
		_GRAPH_API.ThingCreate(160001)
		_GRAPH_API.ThingCreate(160002)
		_GRAPH_API.ThingCreate(160003)
		_GRAPH_API.ZoneEnable(160004)
		_GRAPH_API.ZoneEnable(160005)
		_GRAPH_API.ThingCreate(30001)
		_GRAPH_API.FollowNpc(30001, 60007, 0, 100, function()
			return
		end, function()
			_GRAPH_API.UIInteractEnable()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
		_GRAPH_API.UIInteractDisable()
		_GRAPH_API.PlayTalkList({
			10005001,
			10005002,
			10005003,
			10005004
		}, function()
			return
		end)
	end,
	OnQuestFinish = function(arg_6_0)
		_GRAPH_API.ThingDestroy(30001)
		_GRAPH_API.ThingCreate(30002)
	end,
	OnEnterZone_160004 = function(arg_7_0)
		_GRAPH_API.PlayTalk(10054001, function()
			return
		end)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160004)

function var_0_0.OnEnterZone_160005(arg_9_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160005)

function var_0_0.OnEnterZone_160004(arg_11_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160004)

function var_0_0.OnEnterZone_160005(arg_13_0)
	_GRAPH_API.PlayTalk(10054001, function()
		return
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 160005)

return var_0_0
