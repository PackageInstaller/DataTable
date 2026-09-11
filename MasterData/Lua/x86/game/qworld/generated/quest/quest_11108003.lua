local var_0_0 = {
	trackingEntityIdList = {
		80002
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(80016)
		_GRAPH_API.ZoneEnable(80002)
	end,
	OnEnterZone_80002 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(80002)
		_GRAPH_API.PlayCommonStory(104180801, function()
			_GRAPH_API.AddTag(11010607, 4)
			_GRAPH_API.GotoTag(11010607, 4)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 80002)

return var_0_0
