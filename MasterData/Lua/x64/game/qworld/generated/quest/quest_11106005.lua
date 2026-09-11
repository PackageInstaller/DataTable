local var_0_0 = {
	trackingEntityIdList = {
		50004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(50004)
		_GRAPH_API.ThingCreate(50006)
		_GRAPH_API.ThingCreate(50007)
		_GRAPH_API.ThingCreate(50008)
		_GRAPH_API.ThingCreate(50010)
	end,
	OnEnterZone_50004 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(50004)
		_GRAPH_API.AddTag(11010605, 4)
		_GRAPH_API.PlayStory(11030, function()
			_GRAPH_API.GotoTag(11010605, 4)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 4)
		_GRAPH_API.ThingDestroy(50006)
		_GRAPH_API.ThingDestroy(50007)
		_GRAPH_API.ThingDestroy(50008)
		_GRAPH_API.ThingDestroy(50010)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 50004)

return var_0_0
