local var_0_0 = {
	trackingEntityIdList = {
		40002
	},
	OnQuestFinish = function(arg_1_0)
		return
	end,
	OnQuestUnmeet = function(arg_2_0)
		_GRAPH_API.ThingCreate(40007)
		_GRAPH_API.ThingCreate(40008)
		_GRAPH_API.ZoneEnable(40002)
	end,
	OnEnterZone_40002 = function(arg_3_0)
		_GRAPH_API.ZoneDisable(40002)
		_GRAPH_API.PlayStory(11022, function()
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, nil)
		_GRAPH_API.ThingDestroy(40008)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 40002)

return var_0_0
