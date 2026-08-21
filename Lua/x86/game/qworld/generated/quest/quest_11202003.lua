local var_0_0 = {
	trackingEntityIdList = {
		380003,
		380004,
		380005
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ThingCreate(380003)
		_GRAPH_API.ThingCreate(380001)
		_GRAPH_API.ThingCreate(380002)
		_GRAPH_API.ThingCreate(380004)
		_GRAPH_API.ThingCreate(380005)
	end,
	OnClickBubble_380003 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(380003)
		_GRAPH_API.ThingCreate(380006)
		_GRAPH_API.Delay(1.5, function()
			_GRAPH_API.ThingDestroy(380006)
		end)
		_GRAPH_API.QuestIncLocalProgress(arg_2_0.questId_, 1)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380003] = 1

function var_0_0.OnQuestProgUpdate_11202003(arg_4_0, arg_4_1)
	if arg_4_1 == 1 then
		_GRAPH_API.PlayStory(11123, function()
			return
		end, nil)
	elseif arg_4_1 == 2 then
		_GRAPH_API.PlayStory(11124, function()
			return
		end, nil)
	elseif arg_4_1 == 3 then
		_GRAPH_API.PlayStory(11125, function()
			return
		end, nil)
	end
end

var_0_0.OnQuestProgUpdate = var_0_0.OnQuestProgUpdate or {}

table.insert(var_0_0.OnQuestProgUpdate, 11202003)

function var_0_0.OnClickBubble_380004(arg_8_0)
	_GRAPH_API.ThingDestroy(380004)
	_GRAPH_API.ThingCreate(380007)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(380007)
	end)
	_GRAPH_API.QuestIncLocalProgress(arg_8_0.questId_, 1)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380004)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380004] = 1

function var_0_0.OnClickBubble_380005(arg_10_0)
	_GRAPH_API.ThingDestroy(380005)
	_GRAPH_API.ThingCreate(380008)
	_GRAPH_API.Delay(1.5, function()
		_GRAPH_API.ThingDestroy(380008)
	end)
	_GRAPH_API.QuestIncLocalProgress(arg_10_0.questId_, 1)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 380005)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[380005] = 1

return var_0_0
