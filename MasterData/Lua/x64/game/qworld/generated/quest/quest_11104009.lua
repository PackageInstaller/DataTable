local var_0_0 = {
	trackingEntityIdList = {
		30010,
		30011
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(30010)
	end,
	OnEnterZone_30010 = function(arg_2_0)
		_GRAPH_API.ZoneDisable(30010)
		_GRAPH_API.PlayTalk(11019001, function()
			_GRAPH_API.PlayStory(11019, function()
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, nil)
		end)
		_GRAPH_API.ThingCreate(30011)
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 30010)

return var_0_0
