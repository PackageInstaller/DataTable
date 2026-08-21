local var_0_0 = {
	trackingEntityIdList = {
		150005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(150005)
	end,
	OnClickBubble_150006 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(150006)
		_GRAPH_API.ThingCreate(180004)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(180004)
		end)
		_GRAPH_API.PlayStory(10021, function()
			return
		end, nil)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150006)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150006] = 1

function var_0_0.OnClickBubble_150007(arg_5_0)
	_GRAPH_API.ThingDestroy(150007)
	_GRAPH_API.ThingCreate(180005)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180005)
	end)
	_GRAPH_API.PlayStory(10021, function()
		return
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150007)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150007] = 1

function var_0_0.OnClickBubble_150008(arg_8_0)
	_GRAPH_API.ThingDestroy(150008)
	_GRAPH_API.ThingCreate(180006)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(180006)
	end)
	_GRAPH_API.PlayStory(10022, function()
		_GRAPH_API.QuestSetFinish(arg_8_0.questId_, arg_8_0.questId_)
	end, nil)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 150008)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[150008] = 1

function var_0_0.OnQuestFinish(arg_11_0)
	_GRAPH_API.ThingDestroy(150005)
	_GRAPH_API.ThingDestroy(150008)
	_GRAPH_API.ThingDestroy(150007)
	_GRAPH_API.ThingDestroy(150006)
end

function var_0_0.OnEnterZone_150005(arg_12_0)
	if not arg_12_0.__var_do_once_2139915472 then
		arg_12_0.__var_do_once_2139915472 = true

		_GRAPH_API.ThingCreate(150006)
		_GRAPH_API.ThingCreate(150007)
		_GRAPH_API.ThingCreate(150008)
	end
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 150005)

return var_0_0
