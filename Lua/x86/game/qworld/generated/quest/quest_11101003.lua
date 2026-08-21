local var_0_0 = {
	trackingEntityIdList = {
		10002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(10002)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ZoneDisable(10002)
	end,
	OnEnterZone_10002 = function(arg_3_0)
		_GRAPH_API.ZoneDisable(10002)
		_GRAPH_API.PlayTalkList({
			11002001,
			11002002,
			11002003,
			11002004
		}, function()
			return
		end)
		_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 10002)

return var_0_0
