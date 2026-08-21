local var_0_0 = {
	trackingEntityIdList = {
		440005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(440005)
		_GRAPH_API.ThingCreate(440008)
		_GRAPH_API.ThingCreate(180001)
		_GRAPH_API.ZoneEnable(440002)
	end,
	OnMiniGameFinish_180001 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(180001)
		_GRAPH_API.ZoneDisable(440002)
		_GRAPH_API.PlayStory(11194, function()
			_GRAPH_API.PlayTalk(11193003, function()
				return
			end)
			_GRAPH_API.QuestSetFinish(arg_2_0.questId_, arg_2_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 180001)

function var_0_0.OnEnterZone_440002(arg_5_0)
	_GRAPH_API.ThingDestroy(440005)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 440002)

function var_0_0.OnExitZone_440002(arg_6_0)
	_GRAPH_API.ThingCreate(440005)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 440002)

return var_0_0
