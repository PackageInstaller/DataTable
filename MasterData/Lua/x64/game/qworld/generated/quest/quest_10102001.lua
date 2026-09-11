local var_0_0 = {
	trackingEntityIdList = {
		40006
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(40006)
		_GRAPH_API.ThingCreate(160001)
		_GRAPH_API.ThingCreate(160002)
		_GRAPH_API.ThingCreate(160003)
		_GRAPH_API.ZoneEnable(20001)
		_GRAPH_API.ZoneEnable(160004)
		_GRAPH_API.ZoneEnable(160005)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(40006)
	end,
	OnEnterZone_20001 = function(arg_3_0)
		_GRAPH_API.PlayStory(10002, function()
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, nil)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 20001)

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

return var_0_0
