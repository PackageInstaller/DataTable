local var_0_0 = {
	trackingEntityIdList = {
		380001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(380001)
		_GRAPH_API.ThingCreate(380002)
		_GRAPH_API.ThingCreate(380016)
		_GRAPH_API.ThingCreate(380017)
		_GRAPH_API.ThingCreate(380018)
		_GRAPH_API.EntityInteractEnable(380001)
		_GRAPH_API.ZoneEnable(380015)
	end,
	OnEnterZone_380015 = function(arg_2_0)
		if _GRAPH_API.QuestGetProg(11106902) == 1 then
			_GRAPH_API.PlayStory(11221, function()
				_GRAPH_API.ZoneDisable(380015)
				_GRAPH_API.EntityInteractDisable(380001)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 380001)
		else
			_GRAPH_API.PlayStory(11121, function()
				_GRAPH_API.ZoneDisable(380015)
				_GRAPH_API.EntityInteractDisable(380001)
				_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
			end, 380001)
		end
	end
}

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 380015)

return var_0_0
