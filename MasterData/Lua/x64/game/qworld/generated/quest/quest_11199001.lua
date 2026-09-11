local var_0_0 = {
	OnQuestUnmeet = function(arg_1_0)
		if _GRAPH_API.QuestGetProg(11104003) == 1 then
			_GRAPH_API.ThingDestroy(30002)
			_GRAPH_API.ThingDestroy(30013)
		end

		if _GRAPH_API.QuestGetProg(11104002) == 1 then
			_GRAPH_API.ThingDestroy(30004)
		end

		if _GRAPH_API.QuestGetProg(11107001) == 1 then
			_GRAPH_API.ThingCreate(60011)
			_GRAPH_API.ThingCreate(60012)
			_GRAPH_API.ThingCreate(60013)
			_GRAPH_API.ThingCreate(60014)
		end

		if _GRAPH_API.QuestGetProg(11108004) == 1 then
			_GRAPH_API.ThingDestroy(60011)
			_GRAPH_API.ThingDestroy(60012)
			_GRAPH_API.ThingDestroy(60013)
			_GRAPH_API.ThingDestroy(60014)
		end

		if _GRAPH_API.QuestGetProg(11105005) == 1 then
			_GRAPH_API.ThingDestroy(12)
		end

		if _GRAPH_API.QuestGetProg(11107009) == 1 then
			_GRAPH_API.ThingDestroy(14)
		end

		if _GRAPH_API.QuestGetProg(11103004) == 3 then
			_GRAPH_API.ThingDestroy(20005)
			_GRAPH_API.ThingDestroy(20006)
			_GRAPH_API.ThingDestroy(20007)
		end

		if _GRAPH_API.QuestGetProg(11106003) == 1 then
			_GRAPH_API.ThingDestroy(50003)
			_GRAPH_API.ThingDestroy(50011)
			_GRAPH_API.ThingDestroy(50012)
			_GRAPH_API.ThingDestroy(50013)
		end

		if _GRAPH_API.QuestGetProg(11103005) == 1 then
			_GRAPH_API.ThingDestroy(10)
		end

		if _GRAPH_API.QuestGetProg(11105002) == 1 then
			_GRAPH_API.ThingDestroy(40008)
		end

		if _GRAPH_API.QuestGetProg(11105006) == 1 then
			_GRAPH_API.ThingDestroy(50015)
		end

		if _GRAPH_API.QuestGetProg(11106008) == 1 then
			_GRAPH_API.ThingDestroy(350041)
		end

		if _GRAPH_API.QuestGetProg(11103002) == 1 then
			_GRAPH_API.ThingDestroy(20002)
		end

		if _GRAPH_API.QuestGetProg(11203001) == 1 then
			_GRAPH_API.ThingDestroy(390004)
		end

		_GRAPH_API.ZoneEnable(460002)
		_GRAPH_API.ZoneEnable(460004)
		_GRAPH_API.ZoneEnable(460006)
		_GRAPH_API.ZoneEnable(460008)
		_GRAPH_API.ZoneEnable(460010)
		_GRAPH_API.ZoneEnable(460012)
		_GRAPH_API.ZoneEnable(460014)
		_GRAPH_API.ZoneEnable(460016)
		_GRAPH_API.ZoneEnable(460018)
		_GRAPH_API.ZoneEnable(460020)
		_GRAPH_API.ZoneEnable(460022)
		_GRAPH_API.ZoneEnable(460024)
		_GRAPH_API.ZoneEnable(460026)
	end,
	OnClickBubble_460003 = function(arg_2_0)
		if _GRAPH_API.QuestGetProg(11106902) == 1 then
			_GRAPH_API.PlayStory(11351, function()
				return
			end, nil)
		else
			_GRAPH_API.PlayStory(11301, function()
				return
			end, nil)
		end
	end
}

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 460003)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[460003] = 1

function var_0_0.OnClickBubble_460011(arg_5_0)
	if _GRAPH_API.QuestGetProg(11106902) == 1 then
		_GRAPH_API.PlayStory(11352, function()
			return
		end, nil)
	else
		_GRAPH_API.PlayStory(11302, function()
			return
		end, nil)
	end
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 460011)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[460011] = 1

function var_0_0.OnClickBubble_460015(arg_8_0)
	if _GRAPH_API.QuestGetProg(11106902) == 1 then
		_GRAPH_API.PlayStory(11353, function()
			return
		end, nil)
	else
		_GRAPH_API.PlayStory(11303, function()
			return
		end, nil)
	end
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 460015)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[460015] = 1

function var_0_0.OnClickBubble_460017(arg_11_0)
	if _GRAPH_API.QuestGetProg(11106902) == 1 then
		_GRAPH_API.PlayStory(11354, function()
			return
		end, nil)
	else
		_GRAPH_API.PlayStory(11304, function()
			return
		end, nil)
	end
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 460017)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[460017] = 1

function var_0_0.OnClickBubble_460019(arg_14_0)
	if _GRAPH_API.QuestGetProg(11106902) == 1 then
		_GRAPH_API.PlayStory(11355, function()
			return
		end, nil)
	else
		_GRAPH_API.PlayStory(11305, function()
			return
		end, nil)
	end
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 460019)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[460019] = 1

function var_0_0.OnClickBubble_460023(arg_17_0)
	if _GRAPH_API.QuestGetProg(11106902) == 1 then
		_GRAPH_API.PlayStory(11357, function()
			return
		end, nil)
	else
		_GRAPH_API.PlayStory(11307, function()
			return
		end, nil)
	end
end

var_0_0.OnClickBubble = var_0_0.OnClickBubble or {}

table.insert(var_0_0.OnClickBubble, 460023)

var_0_0.OnClickBubbleWhen = var_0_0.OnClickBubbleWhen or {}
var_0_0.OnClickBubbleWhen[460023] = 1

function var_0_0.OnEnterZone_460002(arg_20_0)
	_GRAPH_API.ThingCreate(460001)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460001, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460002)

function var_0_0.OnExitZone_460002(arg_22_0)
	_GRAPH_API.EntityInteractDisable(460001, true)
	_GRAPH_API.ThingDestroy(460001)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460002)

function var_0_0.OnEnterZone_460004(arg_23_0)
	_GRAPH_API.ThingCreate(460003)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460003, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460004)

function var_0_0.OnExitZone_460004(arg_25_0)
	_GRAPH_API.EntityInteractDisable(460003, true)
	_GRAPH_API.ThingDestroy(460003)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460004)

function var_0_0.OnEnterZone_460006(arg_26_0)
	_GRAPH_API.ThingCreate(460005)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460005, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460006)

function var_0_0.OnExitZone_460006(arg_28_0)
	_GRAPH_API.EntityInteractDisable(460005, true)
	_GRAPH_API.ThingDestroy(460005)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460006)

function var_0_0.OnEnterZone_460008(arg_29_0)
	_GRAPH_API.ThingCreate(460007)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460007, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460008)

function var_0_0.OnExitZone_460008(arg_31_0)
	_GRAPH_API.EntityInteractDisable(460007, true)
	_GRAPH_API.ThingDestroy(460007)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460008)

function var_0_0.OnEnterZone_460010(arg_32_0)
	_GRAPH_API.ThingCreate(460009)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460009, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460010)

function var_0_0.OnExitZone_460010(arg_34_0)
	_GRAPH_API.EntityInteractDisable(460009, true)
	_GRAPH_API.ThingDestroy(460009)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460010)

function var_0_0.OnEnterZone_460012(arg_35_0)
	_GRAPH_API.ThingCreate(460011)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460011, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460012)

function var_0_0.OnExitZone_460012(arg_37_0)
	_GRAPH_API.EntityInteractDisable(460011, true)
	_GRAPH_API.ThingDestroy(460011)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460012)

function var_0_0.OnEnterZone_460014(arg_38_0)
	_GRAPH_API.ThingCreate(460013)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460013, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460014)

function var_0_0.OnExitZone_460014(arg_40_0)
	_GRAPH_API.EntityInteractDisable(460013, true)
	_GRAPH_API.ThingDestroy(460013)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460014)

function var_0_0.OnEnterZone_460016(arg_41_0)
	_GRAPH_API.ThingCreate(460015)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460015, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460016)

function var_0_0.OnExitZone_460016(arg_43_0)
	_GRAPH_API.EntityInteractDisable(460015, true)
	_GRAPH_API.ThingDestroy(460015)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460016)

function var_0_0.OnEnterZone_460018(arg_44_0)
	_GRAPH_API.ThingCreate(460017)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460017, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460018)

function var_0_0.OnExitZone_460018(arg_46_0)
	_GRAPH_API.EntityInteractDisable(460017, true)
	_GRAPH_API.ThingDestroy(460017)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460018)

function var_0_0.OnEnterZone_460020(arg_47_0)
	_GRAPH_API.ThingCreate(460019)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460019, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460020)

function var_0_0.OnExitZone_460020(arg_49_0)
	_GRAPH_API.EntityInteractDisable(460019, true)
	_GRAPH_API.ThingDestroy(460019)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460020)

function var_0_0.OnEnterZone_460022(arg_50_0)
	_GRAPH_API.ThingCreate(460021)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460021, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460022)

function var_0_0.OnExitZone_460022(arg_52_0)
	_GRAPH_API.EntityInteractDisable(460021, true)
	_GRAPH_API.ThingDestroy(460021)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460022)

function var_0_0.OnEnterZone_460024(arg_53_0)
	_GRAPH_API.ThingCreate(460023)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460023, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460024)

function var_0_0.OnExitZone_460024(arg_55_0)
	_GRAPH_API.EntityInteractDisable(460023, true)
	_GRAPH_API.ThingDestroy(460023)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460024)

function var_0_0.OnEnterZone_460026(arg_56_0)
	_GRAPH_API.ThingCreate(460025)
	_GRAPH_API.Delay(10, function()
		_GRAPH_API.EntityInteractEnable(460025, true)
	end)
end

var_0_0.OnEnterZone = var_0_0.OnEnterZone or {}

table.insert(var_0_0.OnEnterZone, 460026)

function var_0_0.OnExitZone_460026(arg_58_0)
	_GRAPH_API.EntityInteractDisable(460025, true)
	_GRAPH_API.ThingDestroy(460025)
end

var_0_0.OnExitZone = var_0_0.OnExitZone or {}

table.insert(var_0_0.OnExitZone, 460026)

return var_0_0
