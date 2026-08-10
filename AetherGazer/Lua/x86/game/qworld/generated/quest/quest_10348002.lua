local var_0_0 = {
	trackingEntityIdList = {
		150013
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(150013)
	end,
	OnClickBubble_150014 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(150014)
		_GRAPH_API.ThingCreate(180010)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(180010)
		end)
		_GRAPH_API.PlayStory(10033, function()
			return
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150014)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150014] = 1

function var_0_0.OnClickBubble_150015(arg_5_0)
	_GRAPH_API.ThingDestroy(150015)
	_GRAPH_API.ThingCreate(180011)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180011)
	end)
	_GRAPH_API.PlayStory(10033, function()
		return
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150015)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150015] = 1

function var_0_0.OnClickBubble_150016(arg_8_0)
	_GRAPH_API.ThingDestroy(150016)
	_GRAPH_API.ThingCreate(180012)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180012)
	end)
	_GRAPH_API.PlayStory(10034, function()
		_GRAPH_API.QuestSetFinish(arg_8_0.questId_, arg_8_0.questId_)
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150016)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150016] = 1

function var_0_0.OnQuestFinish(arg_11_0)
	_GRAPH_API.ThingDestroy(150013)
	_GRAPH_API.ThingDestroy(150016)
	_GRAPH_API.ThingDestroy(150014)
	_GRAPH_API.ThingDestroy(150015)
end

function var_0_0.OnEnterZone_150013(arg_12_0)
	if not arg_12_0.__var_do_once_2139915296 then
		arg_12_0.__var_do_once_2139915296 = true

		_GRAPH_API.ThingCreate(150014)
		_GRAPH_API.ThingCreate(150015)
		_GRAPH_API.ThingCreate(150016)
	end
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 150013)

return var_0_0
