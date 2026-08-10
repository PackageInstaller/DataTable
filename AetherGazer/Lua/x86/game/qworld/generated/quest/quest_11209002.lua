local var_0_0 = {
	trackingEntityIdList = {
		440007
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(440007)
		_GRAPH_API.ThingCreate(440008)
		_GRAPH_API.ThingCreate(160001)
		_GRAPH_API.ZoneEnable(440004)
	end,
	OnMiniGameFinish_160001 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(160001)
		_GRAPH_API.ZoneDisable(440004)
		_GRAPH_API.PlayStory(11195, function()
			_GRAPH_API.PlayTalk(11193001, function()
				return
			end)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 160001)

function var_0_0.OnEnterZone_440004(arg_5_0)
	_GRAPH_API.ThingDestroy(440007)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 440004)

function var_0_0.OnExitZone_440004(arg_6_0)
	_GRAPH_API.ThingCreate(440007)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 440004)

return var_0_0
