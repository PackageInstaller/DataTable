local var_0_0 = {
	trackingEntityIdList = {
		20004
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30003)
		_GRAPH_API.ZoneEnable(20004)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ZoneDisable(20004)
		_GRAPH_API.ThingDestroy(30003)
	end,
	OnEnterZone_20004 = function(arg_3_0)
		_GRAPH_API.PlayStory(10011, function()
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, 30004)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 20004)

return var_0_0
