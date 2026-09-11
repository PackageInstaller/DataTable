local var_0_0 = {
	trackingEntityIdList = {
		30006
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30006)
		_GRAPH_API.ZoneEnable(20002)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(30006)
	end,
	OnEnterZone_20002 = function(arg_3_0)
		_GRAPH_API.ZoneDisable(20002)
		_GRAPH_API.PlayStory(10015, function()
			_GRAPH_API.ThingDestroy(30006)
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, nil)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingCreate(30048)
		end)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 20002)

return var_0_0
