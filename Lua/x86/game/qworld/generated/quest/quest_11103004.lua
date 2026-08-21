local var_0_0 = {
	trackingEntityIdList = {
		20008
	},
	OnQuestUnmeet = function(arg_1_0)
		_GRAPH_API.ZoneEnable(20008)
		_GRAPH_API.ThingCreate(20009)
		_GRAPH_API.ThingCreate(20010)
		_GRAPH_API.ThingCreate(20011)
		_GRAPH_API.ThingCreate(20004)
		_GRAPH_API.ThingCreate(20014)
	end,
	OnClickBubble_20009 = function(arg_2_0)
		_GRAPH_API.ThingDestroy(20005)
		_GRAPH_API.ThingDestroy(20009)
		_GRAPH_API.QuestIncLocalProgress(arg_2_0.questId_, 1)
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 20009)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[20009] = 1

function var_0_0.OnClickBubble_20010(arg_3_0)
	_GRAPH_API.ThingDestroy(20006)
	_GRAPH_API.ThingDestroy(20010)
	_GRAPH_API.QuestIncLocalProgress(arg_3_0.questId_, 1)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 20010)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[20010] = 1

function var_0_0.OnClickBubble_20011(arg_4_0)
	_GRAPH_API.ThingDestroy(20007)
	_GRAPH_API.ThingDestroy(20011)
	_GRAPH_API.QuestIncLocalProgress(arg_4_0.questId_, 1)
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 20011)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[20011] = 1

function var_0_0.OnQuestProgUpdate_11103004(arg_5_0, arg_5_1)
	if arg_5_1 == 1 then
		_GRAPH_API.PlayTalk(11008001, function()
			return
		end)
	elseif arg_5_1 == 2 then
		_GRAPH_API.PlayTalk(11008002, function()
			return
		end)
	elseif arg_5_1 == 3 then
		_GRAPH_API.PlayTalk(11008003, function()
			return
		end)
		_GRAPH_API.ZoneDisable(20008)
	end
end

var_0_0.OnQuestProgUpdate = var_0_0.OnQuestProgUpdate or {}

table.insert(var_0_0.OnQuestProgUpdate, 11103004)

return var_0_0
