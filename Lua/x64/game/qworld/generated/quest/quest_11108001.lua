local var_0_0 = {
	trackingEntityIdList = {
		80001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(80001)
		_GRAPH_API.ThingCreate(80004)
		_GRAPH_API.ThingCreate(80005)
	end,
	OnEnterZone_80001 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(80001)
		_GRAPH_API.PlayStory(11042, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
		_GRAPH_API.ThingDestroy(80004)
		_GRAPH_API.ThingDestroy(80005)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 80001)

return var_0_0
