local var_0_0 = {
	trackingEntityIdList = {
		80003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(80003)
	end,
	OnEnterZone_80003 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(80003)
		_GRAPH_API.PlayStory(11044, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 80003)

return var_0_0
