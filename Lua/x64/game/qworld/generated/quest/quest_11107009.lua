local var_0_0 = {
	trackingEntityIdList = {
		60007
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(60007)
	end,
	OnEnterZone_60007 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(60007)
		_GRAPH_API.ThingCreate(15)
		_GRAPH_API.AddTag(11010606, 4)
		_GRAPH_API.PlayStory(11040, function()
			_GRAPH_API.GotoTag(11010606, 4)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, 4)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 60007)

return var_0_0
