local var_0_0 = {
	trackingEntityIdList = {
		440006
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(440006)
		_GRAPH_API.ThingCreate(440008)
		_GRAPH_API.ThingCreate(170001)
		_GRAPH_API.ZoneEnable(440003)
	end,
	OnMiniGameFinish_170001 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(170001)
		_GRAPH_API.ZoneDisable(440003)
		_GRAPH_API.PlayStory(11196, function()
			_GRAPH_API.PlayTalk(11193002, function()
				return
			end)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 170001)

function var_0_0.OnEnterZone_440003(arg_5_0)
	_GRAPH_API.ThingDestroy(440006)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 440003)

function var_0_0.OnExitZone_440003(arg_6_0)
	_GRAPH_API.ThingCreate(440006)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 440003)

return var_0_0
