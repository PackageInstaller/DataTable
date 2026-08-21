local var_0_0 = {
	trackingEntityIdList = {
		10001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(10004)
		_GRAPH_API.ZoneEnable(10001)
	end,
	OnEnterZone_10001 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(10001)
		_GRAPH_API.PlayCommonStory(104180301, function()
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 10001)

return var_0_0
