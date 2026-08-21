local var_0_0 = {
	trackingEntityIdList = {
		150009
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(150009)
	end,
	OnClickBubble_150010 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(150010)
		_GRAPH_API.ThingCreate(180007)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(180007)
		end)
		_GRAPH_API.PlayStory(10029, function()
			return
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150010)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150010] = 1

function var_0_0.OnClickBubble_150011(arg_5_0)
	_GRAPH_API.ThingDestroy(150011)
	_GRAPH_API.ThingCreate(180008)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180008)
	end)
	_GRAPH_API.PlayStory(10029, function()
		return
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150011)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150011] = 1

function var_0_0.OnClickBubble_150012(arg_8_0)
	_GRAPH_API.ThingDestroy(150012)
	_GRAPH_API.ThingCreate(180009)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180009)
	end)
	_GRAPH_API.PlayStory(10030, function()
		_GRAPH_API.QuestSetFinish(arg_8_0.questId_, arg_8_0.questId_)
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150012)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150012] = 1

function var_0_0.OnQuestFinish(arg_11_0)
	_GRAPH_API.ThingDestroy(150009)
	_GRAPH_API.ThingDestroy(150012)
	_GRAPH_API.ThingDestroy(150010)
	_GRAPH_API.ThingDestroy(150011)
end

function var_0_0.OnEnterZone_150009(arg_12_0)
	if not arg_12_0.__var_do_once_2139915384 then
		arg_12_0.__var_do_once_2139915384 = true

		_GRAPH_API.ThingCreate(150010)
		_GRAPH_API.ThingCreate(150011)
		_GRAPH_API.ThingCreate(150012)
	end
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 150009)

return var_0_0
