local var_0_0 = {
	trackingEntityIdList = {
		10003
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(10003)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ZoneDisable(10003)
	end,
	OnEnterZone_10003 = function(arg_3_0)
		_GRAPH_API.ZoneDisable(10003)
		_GRAPH_API.PlayTalkList({
			11002011,
			11002012,
			11002013,
			11002014
		}, function()
			return
		end)
		_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 10003)

return var_0_0
