local var_0_0 = {
	trackingEntityIdList = {
		150001
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(150001)
	end,
	OnClickBubble_150002 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(150002)
		_GRAPH_API.ThingCreate(180001)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(180001)
		end)
		_GRAPH_API.PlayStory(10025, function()
			return
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150002] = 1

function var_0_0.OnClickBubble_150003(arg_5_0)
	_GRAPH_API.ThingDestroy(150003)
	_GRAPH_API.ThingCreate(180002)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180002)
	end)
	_GRAPH_API.PlayStory(10025, function()
		return
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150003] = 1

function var_0_0.OnClickBubble_150004(arg_8_0)
	_GRAPH_API.ThingDestroy(150004)
	_GRAPH_API.ThingCreate(180003)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180003)
	end)
	_GRAPH_API.PlayStory(10026, function()
		_GRAPH_API.QuestSetFinish(arg_8_0.questId_, arg_8_0.questId_)
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150004] = 1

function var_0_0.OnQuestFinish(arg_11_0)
	_GRAPH_API.ThingDestroy(150001)
	_GRAPH_API.ThingDestroy(150004)
	_GRAPH_API.ThingDestroy(150002)
	_GRAPH_API.ThingDestroy(150003)
end

function var_0_0.OnEnterZone_150001(arg_12_0)
	if not arg_12_0.__var_do_once_2139915560 then
		arg_12_0.__var_do_once_2139915560 = true

		_GRAPH_API.ThingCreate(150002)
		_GRAPH_API.ThingCreate(150003)
		_GRAPH_API.ThingCreate(150004)
	end
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 150001)

return var_0_0
