local var_0_0 = {
	trackingEntityIdList = {
		150034
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(80006)
		_GRAPH_API.ThingCreate(80007)
		_GRAPH_API.ThingCreate(80008)
		_GRAPH_API.ThingCreate(150001)
		_GRAPH_API.ThingCreate(150034)
		_GRAPH_API.ThingCreate(80019)
		_GRAPH_API.ZoneEnable(150033)
	end,
	OnQuestFinish = function(arg_2_0)
		_GRAPH_API.ThingDestroy(80006)
		_GRAPH_API.ThingDestroy(80007)
		_GRAPH_API.ThingDestroy(80008)
	end,
	OnMiniGameFinish_150001 = function(arg_3_0)
		_GRAPH_API.ThingDestroy(150001)
		_GRAPH_API.PlayStory(11043, function()
			_GRAPH_API.ZoneDisable(150033)
			_GRAPH_API.QuestSetFinish(arg_3_0.questId_, arg_3_0.questId_)
		end, nil)
	end
}

var_0_0.OnMiniGameFinish = var_0_0.OnMiniGameFinish or {}

table.insert(var_0_0.OnMiniGameFinish, 150001)

function var_0_0.OnEnterZone_150033(arg_5_0)
	_GRAPH_API.ThingDestroy(150034)
	_GRAPH_API.ThingDestroy(80019)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 150033)

function var_0_0.OnExitZone_150033(arg_6_0)
	_GRAPH_API.ThingCreate(150034)
	_GRAPH_API.ThingCreate(80019)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 150033)

return var_0_0
