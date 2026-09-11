local var_0_0 = {
	trackingEntityIdList = {
		30001,
		30018
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30012)
		_GRAPH_API.ZoneEnable(30018)
		_GRAPH_API.ZoneEnable(30020)
	end,
	OnEnterZone_30001 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(30001)
		_GRAPH_API.PlayStory(11012, function()
			_GRAPH_API.ThingDestroy(30012)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 30001)

function var_0_0.OnEnterZone_30018(arg_4_0)
	_GRAPH_API.ZoneDisable(30018)
	_GRAPH_API.ZoneDisable(30020)
	_GRAPH_API.ZoneEnable(30001)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 30018)

function var_0_0.OnEnterZone_30020(arg_5_0)
	_GRAPH_API.ZoneDisable(30020)
	_GRAPH_API.PlayStory(11012, function()
		_GRAPH_API.ThingDestroy(30012)
		_GRAPH_API.QuestSetFinish(arg_5_0.questId_, arg_5_0.questId_)
	end, nil)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 30020)

return var_0_0
