local var_0_0 = {
	trackingEntityIdList = {
		40004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(40006)
		_GRAPH_API.ThingCreate(40009)
		_GRAPH_API.ThingCreate(13)
		_GRAPH_API.ZoneEnable(40004)
	end,
	OnEnterZone_40004 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(40004)
		_GRAPH_API.AddTag(11010604, 4)
		_GRAPH_API.PlayStory(11023, function()
			_GRAPH_API.GotoTag(11010604, 4)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 4)
		_GRAPH_API.ThingDestroy(40006)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 40004)

return var_0_0
