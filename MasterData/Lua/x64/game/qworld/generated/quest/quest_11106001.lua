local var_0_0 = {
	trackingEntityIdList = {
		50001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(50006)
		_GRAPH_API.ThingCreate(50007)
		_GRAPH_API.ThingCreate(50008)
		_GRAPH_API.ThingCreate(50009)
		_GRAPH_API.ThingCreate(50010)
		_GRAPH_API.ThingDestroy(50015)
		_GRAPH_API.ZoneEnable(50001)
	end,
	OnEnterZone_50001 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(50001)
		_GRAPH_API.PlayStory(11026, function()
			_GRAPH_API.ThingDestroy(50009)
			_GRAPH_API.ThingDestroy(50015)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 50001)

return var_0_0
