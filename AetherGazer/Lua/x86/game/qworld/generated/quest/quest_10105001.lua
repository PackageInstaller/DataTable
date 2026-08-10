local var_0_0 = {
	trackingEntityIdList = {
		30005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(30003)
		_GRAPH_API.ThingCreate(40002)
		_GRAPH_API.ZoneEnable(20005)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ZoneDisable(20005)
	end,
	OnEnterZone_20005 = function(arg_3_0)
		_GRAPH_API.PlayStory(10009, function()
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, 30005)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 20005)

return var_0_0
