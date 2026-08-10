local var_0_0 = {
	trackingEntityIdList = {
		370010
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(370001)
		_GRAPH_API.ZoneEnable(370010)
	end,
	OnClickBubble_370006 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(370006)
		_GRAPH_API.ThingDestroy(370008)
		_GRAPH_API.ThingCreate(370007)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(370007)
		end)
		_GRAPH_API.PlayStory(11113, function()
			return
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 370006)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[370006] = 1

function var_0_0.OnClickBubble_370002(arg_5_0)
	_GRAPH_API.ThingDestroy(370002)
	_GRAPH_API.ThingDestroy(370004)
	_GRAPH_API.ThingCreate(370003)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(370003)
	end)
	_GRAPH_API.PlayStory(11114, function()
		_GRAPH_API.QuestSetFinish(arg_5_0.questId_, arg_5_0.questId_)
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 370002)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[370002] = 1

function var_0_0.OnQuestFinish(arg_8_0)
	_GRAPH_API.ThingDestroy(370010)
	_GRAPH_API.ThingDestroy(370002)
	_GRAPH_API.ThingDestroy(370004)
	_GRAPH_API.ThingDestroy(370006)
	_GRAPH_API.ThingDestroy(370008)
end

function var_0_0.OnEnterZone_370010(arg_9_0)
	if not arg_9_0.__var_do_once_2139914108 then
		arg_9_0.__var_do_once_2139914108 = true

		_GRAPH_API.ThingCreate(370002)
		_GRAPH_API.ThingCreate(370004)
		_GRAPH_API.ThingCreate(370006)
		_GRAPH_API.ThingCreate(370008)
	end
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 370010)

return var_0_0
