class = var_0_10000

local var_0_0 = "WorldMapAttachment"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...BaseEntity"))

var_0_1.Fields = {
	config = "table",
	dataop = "number",
	buffList = "table",
	type = "number",
	row = "number",
	data = "number",
	column = "number",
	flag = "number",
	effects = "table",
	triggered = "boolean",
	hp = "number",
	finishMark = "number",
	id = "number",
	lurk = "boolean"
}
var_0_1.EventUpdateFlag = "WorldMapAttachment.EventUpdateFlag"
var_0_1.EventUpdateData = "WorldMapAttachment.EventUpdateData"
var_0_1.EventUpdateLurk = "WorldMapAttachment.EventUpdateLurk"
var_0_1.TypeBox = 2
var_0_1.TypeEnemy = 6
var_0_1.TypeBoss = 8
var_0_1.TypeArtifact = 10
var_0_1.TypeEnemyAI = 12
var_0_1.TypeFleet = 13
var_0_1.TypeTransportFleet = 17
var_0_1.TypeEvent = 22
var_0_1.TypeTrap = 23
var_0_1.TypePort = -1
var_0_1.SortOrder = {
	[var_0_1.TypeArtifact] = -99,
	[var_0_1.TypeTrap] = -1,
	[var_0_1.TypePort] = 0,
	[var_0_1.TypeEvent] = 1,
	[var_0_1.TypeBox] = 2,
	[var_0_1.TypeEnemy] = 3,
	[var_0_1.TypeEnemyAI] = 4,
	[var_0_1.TypeBoss] = 5,
	[var_0_1.TypeTransportFleet] = 6
}

function var_0_1.IsEnemyType(arg_1_0)
	return arg_1_0 == var_0_1.TypeEnemy or arg_1_0 == var_0_1.TypeEnemyAI or arg_1_0 == var_0_1.TypeBoss
end

function var_0_1.IsHPEnemyType(arg_2_0)
	return arg_2_0 == var_0_1.TypeEnemyAI or arg_2_0 == var_0_1.TypeBoss
end

function var_0_1.IsFakeType(arg_3_0)
	return arg_3_0 == var_0_1.TypePort
end

function var_0_1.IsInteractiveType(arg_4_0)
	local var_4_0

	if not var_0_1.IsEnemyType(arg_4_0) then
		var_4_0 = arg_4_0 == var_0_1.TypeEvent or arg_4_0 == var_0_1.TypeBox
	end

	return var_4_0
end

function var_0_1.MakeFakePort(arg_5_0, arg_5_1, arg_5_2)
	WPool = var_1_10003

	local var_5_0 = var_1_10003
	local var_5_1 = var_1_10003.Get

	WorldMapAttachment = var_1_10006

	local var_5_2 = var_5_1(var_5_0, var_1_10006)

	var_3.Setup(var_5_2, {
		item_data = 0,
		item_flag = 0,
		pos = {
			row = arg_5_0,
			column = arg_5_1
		},
		item_type = var_0_1.TypePort,
		item_id = arg_5_2,
		buff_list = {},
		effect_list = {}
	})

	return var_3
end

function var_0_1.IsClientType(arg_6_0)
	return arg_6_0 > 1000
end

var_0_1.EffectEventStory = 2
var_0_1.EffectEventTeleport = 3
var_0_1.EffectEventDrop = 7
var_0_1.EffectEventShipBuff = 8
var_0_1.EffectEventGuide = 13
var_0_1.EffectEventDropTreasure = 14
var_0_1.EffectEventBlink1 = 16
var_0_1.EffectEventBlink2 = 17
var_0_1.EffectEventAchieveCarry = 18
var_0_1.EffectEventConsumeCarry = 19
var_0_1.EffectEventTeleportEvent = 20
var_0_1.EffectEventConsumeItem = 24
var_0_1.EffectEventStoryOption = 27
var_0_1.EffectEventFleetShipHP = 30
var_0_1.EffectEventProgress = 32
var_0_1.EffectEventTeleportBack = 37
var_0_1.EffectEventDeleteTask = 40
var_0_1.EffectEventGlobalBuff = 44
var_0_1.EffectEventMapClearFlag = 45
var_0_1.EffectEventBrokenClean = 48
var_0_1.EffectEventCatSalvage = 49
var_0_1.EffectEventAddWorldBossFreeCount = 50
var_0_1.EffectSideText = 52
var_0_1.EffectEventFOV = 1001
var_0_1.EffectEventCameraMove = 1002
var_0_1.EffectEventShakePlane = 1003
var_0_1.EffectEventFlash = 1004
var_0_1.EffectEventHelp = 1005
var_0_1.EffectEventShowMapMark = 1006
var_0_1.EffectEventReturn2World = 1007
var_0_1.EffectEventStoryOptionClient = 1009
var_0_1.EffectEventShowPort = 1010
var_0_1.EffectEventSound = 1011
var_0_1.EffectEventHelpLayer = 1012
var_0_1.EffectEventMsgbox = 1013
var_0_1.EffectEventStoryBattle = 1014
var_0_1.CompassTypeNone = 0
var_0_1.CompassTypeBattle = 1
var_0_1.CompassTypeExploration = 2
var_0_1.CompassTypeTask = 3
var_0_1.CompassTypeBoss = 4
var_0_1.CompassTypeGuidePost = 5
var_0_1.CompassTypeTaskTrack = 6
var_0_1.CompassTypePort = 7
var_0_1.CompassTypeSalvage = 8
var_0_1.CompassTypeFile = 9
var_0_1.SpEventHaibao = 1
var_0_1.SpEventFufen = 2
var_0_1.SpEventEnemy = 3
var_0_1.SpEventConsumeItem = 4

function var_0_1.DebugPrint(arg_7_0)
	if arg_7_0.type == var_0_1.TypeEvent then
		local var_7_0 = {}

		pg = var_2

		local var_7_1 = var_2.world_event_data[arg_7_0.id].effect
		local var_7_2 = ""
		local var_7_3 = {}
		local var_7_4 = 1
		local var_7_5 = 1

		while var_7_5 <= #var_7_1 do
			if arg_7_0.effects[#arg_7_0.effects - var_7_4 + 1] == var_7_1[#var_7_1 - var_7_5 + 1] then
				table = var_1_10009

				var_1_10009.insert(var_7_3, 1, var_1_10007)

				var_1_10009 = var_7_4 + 1
				var_7_5 = var_7_5 + 1
				var_7_4 = var_1_10009
			elseif not var_1_10007 then
				table = var_1_10009
				var_1_10009 = var_1_10009.insert

				local var_7_6 = var_7_3
				local var_7_7 = 1

				setColorStr = var_1_10013
				var_1_10015 = var_1_10008
				COLOR_GREEN = var_1_10016

				var_1_10009(var_7_6, var_7_7, var_1_10013(var_1_10015, var_1_10016))

				var_7_5 = var_7_5 + 1
			else
				pg = var_1_10009

				if var_1_10009.world_effect_data[var_1_10008].effect_type == 27 or var_1_10009 == 35 or var_1_10009 == 36 or var_1_10009 == 53 then
					table = iter_7_0
					iter_7_0 = iter_7_0.insert

					local var_7_8 = var_7_3

					var_1_10013 = 1
					setColorStr = var_1_10014
					var_1_10016 = var_1_10007
					COLOR_BLUE = var_1_10017

					iter_7_0(var_7_8, var_1_10013, var_1_10014(var_1_10016, var_1_10017))

					var_7_4 = var_7_4 + 1
				else
					table = iter_7_0
					iter_7_0 = iter_7_0.insert

					local var_7_9 = var_7_3

					var_1_10013 = 1
					setColorStr = var_1_10014
					var_1_10016 = var_1_10007
					COLOR_RED = var_1_10017

					iter_7_0(var_7_9, var_1_10013, var_1_10014(var_1_10016, var_1_10017))

					iter_7_0 = var_7_4 + 1
					var_7_5 = var_7_5 + 1
					var_7_4 = iter_7_0
				end
			end
		end

		var_1_10007 = var_7_2
		table = var_1_10008

		local var_7_10 = var_1_10007 .. var_1_10008.concat(var_7_3, ", ")

		ipairs = var_1_10007

		for iter_7_0, iter_7_1 in var_1_10007(arg_7_0.config.event_op) do
			local var_7_11

			if iter_7_0 <= #arg_7_0.config.event_op - arg_7_0.dataop then
				table = var_7_11
				var_7_11 = var_7_11.insert

				local var_7_12 = var_7_0

				setColorStr = var_1_10015
				var_1_10017 = iter_7_1
				COLOR_GREEN = var_1_10018

				var_7_11(var_7_12, var_1_10015(var_1_10017, var_1_10018))
			else
				table = var_7_11

				var_7_11.insert(var_7_0, iter_7_1)
			end
		end

		string = var_1_10007
		var_1_10007 = var_1_10007.format
		var_1_10009 = "事件  [id: %d]  [%s]  [位置: %d, %d]  [flag: %s]  [data: %d]  [感染值：%s]  [自动优先级：%s] \n     [effect: %s] \n     [effect_op: %s] \n     [buff: %s]"
		iter_7_0 = arg_7_0.id

		local var_7_13 = arg_7_0.config.name
		local var_7_14 = arg_7_0.row
		local var_7_15 = arg_7_0.column
		local var_7_16 = arg_7_0.flag
		local var_7_17 = arg_7_0.data

		setColorStr = var_1_10016

		local var_7_18 = arg_7_0.config.infection_value

		COLOR_RED = var_1_10019

		local var_7_19 = var_1_10016(var_7_18, var_1_10019)

		setColorStr = var_1_10017

		local var_7_20 = arg_7_0.config.auto_pri

		COLOR_YELLOW = var_1_10020

		local var_7_21 = var_1_10017(var_7_20, var_1_10020)
		local var_7_22 = var_7_10

		table = var_7_20

		local var_7_23 = var_7_20.concat(var_7_0, ", ")

		table = var_1_10020

		return var_1_10007(var_1_10009, iter_7_0, var_7_13, var_7_14, var_7_15, var_7_16, var_7_17, var_7_19, var_7_21, var_7_22, var_7_23, var_1_10020.concat(arg_7_0.buffList, ", "))
	elseif var_0_1.IsEnemyType(arg_7_0.type) then
		string = var_1

		local var_7_24 = var_1.format
		local var_7_25 = "敌人  [id: %s]  [%s]  [类型 %s]  [位置: %s, %s]  [flag: %s]  [data: %s]  [buff: %s]"
		local var_7_26 = arg_7_0.id
		local var_7_27 = arg_7_0.config.name
		local var_7_28 = arg_7_0.type

		var_1_10007 = arg_7_0.row
		var_1_10008 = arg_7_0.column
		tostring = var_1_10009
		var_1_10009 = var_1_10009(arg_7_0.flag)
		tostring = iter_7_0

		local var_7_29 = iter_7_0(arg_7_0.data)

		table = var_11

		return var_7_24(var_7_25, var_7_26, var_7_27, var_7_28, var_1_10007, var_1_10008, var_1_10009, var_7_29, var_11.concat(arg_7_0.buffList, ", "))
	elseif arg_7_0.type == var_0_1.TypeTrap then
		string = var_1

		local var_7_30 = var_1.format
		local var_7_31 = "陷阱  [id: %s]  [%s]  [位置: %s, %s]  [flag: %s]  [data: %s]"
		local var_7_32 = arg_7_0.id
		local var_7_33 = arg_7_0.config.name
		local var_7_34 = arg_7_0.row

		var_1_10007 = arg_7_0.column
		tostring = var_1_10008
		var_1_10008 = var_1_10008(arg_7_0.flag)
		tostring = var_1_10009

		return var_7_30(var_7_31, var_7_32, var_7_33, var_7_34, var_1_10007, var_1_10008, var_1_10009(arg_7_0.data))
	elseif arg_7_0.type == var_0_1.TypeFleet then
		string = var_1

		local var_7_35 = var_1.format
		local var_7_36 = "舰队  [id: %s]  [%s]  [位置: %s, %s]  [flag: %s]  [data: %s]"
		local var_7_37 = arg_7_0.id
		local var_7_38 = "我方舰队"
		local var_7_39 = arg_7_0.row

		var_1_10007 = arg_7_0.column
		tostring = var_1_10008
		var_1_10008 = var_1_10008(arg_7_0.flag)
		tostring = var_1_10009

		return var_7_35(var_7_36, var_7_37, var_7_38, var_7_39, var_1_10007, var_1_10008, var_1_10009(arg_7_0.data))
	elseif arg_7_0.type == var_0_1.TypeArtifact then
		string = var_1

		local var_7_40 = var_1.format
		local var_7_41 = "场景物件  [id: %s]  [位置: %s, %s]  [flag: %s]  [data: %s]  [buff: %s]"
		local var_7_42 = arg_7_0.id
		local var_7_43 = arg_7_0.row
		local var_7_44 = arg_7_0.column

		tostring = var_1_10007

		local var_7_45 = var_1_10007(arg_7_0.flag)

		tostring = var_1_10008

		local var_7_46 = var_1_10008(arg_7_0.data)

		table = var_9

		return var_7_40(var_7_41, var_7_42, var_7_43, var_7_44, var_7_45, var_7_46, var_9.concat(arg_7_0.buffList, ", "))
	end

	return
end

function var_0_1.Setup(arg_8_0, arg_8_1)
	arg_8_0.row = arg_8_1.pos.row
	arg_8_0.column = arg_8_1.pos.column
	arg_8_0.type = arg_8_1.item_type
	arg_8_0.id = arg_8_1.item_id
	arg_8_0.flag = arg_8_1.item_flag
	arg_8_0.data = arg_8_1.item_data
	underscore = var_2
	arg_8_0.effects = var_2.rest(arg_8_1.effect_list, 1)
	underscore = var_2
	arg_8_0.buffList = var_2.rest(arg_8_1.buff_list, 1)
	arg_8_0.hp = arg_8_1.boss_hp

	arg_8_0:InitConfig()
	arg_8_0:InitData()

	return
end

function var_0_1.InitConfig(arg_9_0)
	if arg_9_0.type == var_0_1.TypeBox then
		pg = var_1
		arg_9_0.config = var_1.box_data_template[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "box_data_template not exist: " .. arg_9_0.id)
	elseif var_0_1.IsEnemyType(arg_9_0.type) then
		pg = var_1
		arg_9_0.config = var_1.expedition_data_template[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "expedition_data_template not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_1.TypeEvent then
		pg = var_1
		arg_9_0.config = var_1.world_event_data[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "world_event_data not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_1.TypePort then
		pg = var_1
		arg_9_0.config = var_1.world_port_data[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "world_port_data not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_1.TypeTransportFleet then
		pg = var_1
		arg_9_0.config = var_1.friendly_data_template[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "friendly_data_template not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_1.TypeTrap then
		pg = var_1
		arg_9_0.config = var_1.world_trap_data[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "world_trap_data not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_1.TypeArtifact then
		pg = var_1
		arg_9_0.config = var_1.world_event_data[arg_9_0.id]
		assert = var_1

		var_1(arg_9_0.config, "with out this atrifact: " .. arg_9_0.id)
	end

	return
end

function var_0_1.InitData(arg_10_0)
	if arg_10_0.type == var_0_1.TypeEvent then
		arg_10_0.dataop = #arg_10_0.config.event_op
	end

	return
end

function var_0_1.IsAlive(arg_11_0)
	if arg_11_0.type == var_0_1.TypeEvent then
		return true
	elseif var_0_1.IsEnemyType(arg_11_0.type) then
		return arg_11_0.flag ~= 1 and arg_11_0.data ~= 0
	elseif arg_11_0.type == var_0_1.TypeTransportFleet then
		return arg_11_0:GetHP() > 0
	elseif arg_11_0.type == var_0_1.TypeArtifact then
		return false
	end

	return arg_11_0.flag ~= 1
end

function var_0_1.IsVisible(arg_12_0)
	local var_12_0 = not arg_12_0.lurk

	if arg_12_0.type == var_0_1.TypeEvent then
		var_12_0 = var_12_0 and arg_12_0.config.discover_type == 2
	elseif var_0_1.IsEnemyType(arg_12_0.type) then
		var_12_0 = var_12_0 and arg_12_0:IsAlive()
	end

	return var_12_0
end

function var_0_1.IsFloating(arg_13_0)
	return arg_13_0.type == var_0_1.TypeEvent and arg_13_0.config.icontype == 1 or arg_13_0.type == var_0_1.TypeBox
end

function var_0_1.UpdateFlag(arg_14_0, arg_14_1)
	if arg_14_0.flag ~= arg_14_1 then
		arg_14_0.flag = arg_14_1

		arg_14_0:DispatchEvent(var_0_1.EventUpdateFlag)
	end

	return
end

function var_0_1.UpdateData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.data = arg_15_1

	if arg_15_0.type == var_0_1.TypeEvent then
		underscore = var_3
		arg_15_0.effects = var_3.rest(arg_15_2, 1)
	end

	arg_15_0:DispatchEvent(var_0_1.EventUpdateData)

	return
end

function var_0_1.UpdateLurk(arg_16_0, arg_16_1)
	if arg_16_0.lurk ~= arg_16_1 then
		arg_16_0.lurk = arg_16_1

		arg_16_0:DispatchEvent(var_0_1.EventUpdateLurk)
	end

	return
end

function var_0_1.UpdateDataOp(arg_17_0, arg_17_1)
	arg_17_0.dataop = arg_17_1

	return
end

function var_0_1.GetEventEffect(arg_18_0)
	assert = var_1_10001

	local var_18_0 = arg_18_0.type == var_0_1.TypeEvent

	string = var_4

	var_1_10001(var_18_0, var_4.format("type error:%d", arg_18_0.type))

	if arg_18_0.effects[1] then
		::label_18_0::

		pg = var_1_10002
		var_1_10002 = var_1_10002.world_effect_data[var_1]
	end

	return var_1_10002
end

function var_0_1.GetEventEffects(arg_19_0)
	assert = var_1_10001

	local var_19_0 = arg_19_0.type == var_0_1.TypeEvent

	string = var_4

	var_1_10001(var_19_0, var_4.format("type error:%d", arg_19_0.type))

	_ = var_1_10001

	return var_1_10001.map(arg_19_0.effects, function(arg_20_0)
		pg = var_2_10001

		return var_2_10001.world_effect_data[arg_20_0]
	end)
end

function var_0_1.RemainOpEffect(arg_21_0)
	return arg_21_0.dataop > 0
end

function var_0_1.GetOpEffect(arg_22_0)
	local var_22_0 = var_1[#arg_22_0.config.event_op - arg_22_0.dataop + 1]

	assert = var_3
	pg = var_1_10005

	var_3(var_1_10005.world_effect_data[var_22_0], "world_effect_data not exist: " .. var_22_0)

	pg = var_3

	return var_3.world_effect_data[var_22_0]
end

function var_0_1.GetBattleStageId(arg_23_0)
	assert = var_1_10001

	var_1_10001(var_0_1.IsEnemyType(arg_23_0.type))

	return arg_23_0.id
end

function var_0_1.GetLimitDamageLevel(arg_24_0)
	pg = var_1_10001

	return var_1_10001.world_expedition_data[arg_24_0:GetBattleStageId()].morale_limit
end

function var_0_1.ShouldMarkAsLurk(arg_25_0)
	return arg_25_0.type == var_0_1.TypeEvent and arg_25_0.config.visuality == 1 and arg_25_0.config.discover_type == 2
end

function var_0_1.CanLeave(arg_26_0)
	if var_0_1.IsEnemyType(arg_26_0.type) then
		return false
	elseif arg_26_0.type == var_0_1.TypeEvent or arg_26_0.type == var_0_1.TypeTrap then
		WorldConst = var_1

		return var_1.GetObstacleConfig(arg_26_0.config.obstacle, "leave")
	else
		return true
	end

	return
end

function var_0_1.CanArrive(arg_27_0)
	if arg_27_0.type == var_0_1.TypeEvent or arg_27_0.type == var_0_1.TypeTrap then
		WorldConst = var_1

		return var_1.GetObstacleConfig(arg_27_0.config.obstacle, "arrive")
	else
		return true
	end

	return
end

function var_0_1.CanPass(arg_28_0)
	if var_0_1.IsEnemyType(arg_28_0.type) then
		return false
	elseif arg_28_0.type == var_0_1.TypeEvent or arg_28_0.type == var_0_1.TypeTrap then
		WorldConst = var_1

		return var_1.GetObstacleConfig(arg_28_0.config.obstacle, "pass")
	else
		return true
	end

	return
end

function var_0_1.IsAvatar(arg_29_0)
	if arg_29_0.type == var_0_1.TypeEvent then
		if arg_29_0:GetReplaceDisplayEnemyConfig() then
			return false
		end

		math = var_1

		return var_1.floor(arg_29_0.config.enemyicon / 2) == 1
	elseif var_0_1.IsEnemyType(arg_29_0.type) then
		return arg_29_0.config.icon_type == 2
	end

	return false
end

function var_0_1.IsSign(arg_30_0)
	if arg_30_0.type == var_0_1.TypeEvent then
		return arg_30_0.config.is_guide == 1
	end

	return false
end

function var_0_1.IsBoss(arg_31_0)
	local var_31_0

	if var_0_1.IsEnemyType(arg_31_0.type) then
		WorldConst = var_31_0
		var_31_0 = var_31_0.EnemySize[arg_31_0.config.type] == 99
	end

	return var_31_0
end

function var_0_1.GetBuffList(arg_32_0)
	underscore = var_1_10001

	return var_1_10001.map(arg_32_0.buffList, function(arg_33_0)
		WorldBuff = var_2_10001

		local var_33_0 = var_2_10001.New()

		var_1.Setup(var_33_0, {
			floor = 1,
			id = arg_33_0
		})

		return var_1
	end)
end

function var_0_1.UpdateBuffList(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetWeaknessBuffId()

	arg_34_0.buffList = arg_34_1

	if var_34_0 ~= arg_34_0:GetWeaknessBuffId() then
		local var_34_1

		if not var_34_0 or not {
			anim = "WorldWeaknessUpgradeWindow",
			hp = arg_34_0:GetMaxHP()
		} then
			var_34_1 = {
				anim = "WorldWeaknessDiscoverWindow",
				hp = arg_34_0:GetMaxHP()
			}
		end

		return var_34_1
	end

	return
end

function var_0_1.GetWeaknessBuffId(arg_35_0)
	if not var_0_1.IsEnemyType(arg_35_0.type) then
		return
	end

	local var_35_0 = {}

	underscore = var_1_10002

	local var_35_1 = var_1_10002.each

	underscore = var_1_10004

	local var_35_2 = var_1_10004.flatten

	pg = var_1_10006

	var_35_1(var_35_2(var_1_10006.world_expedition_data[arg_35_0:GetBattleStageId()].weak_list), function(arg_36_0)
		var_35_0[arg_36_0] = true

		return
	end)

	ipairs = var_35_1

	for iter_35_0, iter_35_1 in var_35_1(arg_35_0.buffList) do
		if var_35_0[iter_35_1] then
			return iter_35_1
		end
	end

	return
end

function var_0_1.GetBattleLuaBuffs(arg_37_0)
	local var_37_0 = {}

	underscore = var_1_10002

	var_1_10002.each(arg_37_0:GetBuffList(), function(arg_38_0)
		if arg_38_0.config.lua_id > 0 then
			table = var_1

			var_1.insert(var_37_0, arg_38_0.config.lua_id)
		end

		return
	end)

	return var_37_0
end

function var_0_1.GetCompassType(arg_39_0)
	if arg_39_0.type == var_0_1.TypeEvent then
		return arg_39_0.config.compass_index
	elseif var_0_1.IsEnemyType(arg_39_0.type) then
		if arg_39_0:IsBoss() then
			return var_0_1.CompassTypeBoss
		else
			return var_0_1.CompassTypeBattle
		end
	elseif arg_39_0.type == var_0_1.TypeBox then
		return var_0_1.CompassTypeExploration
	elseif arg_39_0.type == var_0_1.TypePort then
		return var_0_1.CompassTypePort
	end

	return
end

function var_0_1.GetSpEventType(arg_40_0)
	if arg_40_0.type == var_0_1.TypeEvent then
		return arg_40_0.config.special_enemy
	end

	return
end

function var_0_1.GetDeviation(arg_41_0)
	local var_41_0

	if arg_41_0.type == var_0_1.TypeEvent or arg_41_0.type == var_0_1.TypeArtifact then
		var_41_0 = arg_41_0.config
		Vector2 = var_2

		return var_2(var_41_0.deviation[1], var_41_0.deviation[2])
	end

	Vector2 = var_41_0

	return var_41_0.zero
end

function var_0_1.GetScale(arg_42_0, arg_42_1)
	local var_42_0 = 1

	if arg_42_0.type == var_0_1.TypeEvent then
		if arg_42_0.config.scale == 0 then
			Vector3 = var_3

			return var_3.one
		else
			var_42_0 = arg_42_0.config.scale / 100
		end
	elseif var_0_1.IsEnemyType(arg_42_0.type) then
		var_42_0 = 0.4 * arg_42_0.config.scale / 100
	elseif arg_42_0.type == var_0_1.TypeTrap and arg_42_0.id == 200 then
		arg_42_1 = arg_42_1 or arg_42_0.data
		var_42_0 = var_42_0 * (arg_42_1 + arg_42_1 - 1)
	end

	Vector3 = var_3

	return var_3(var_42_0, var_42_0, var_42_0)
end

function var_0_1.GetModelOrder(arg_43_0)
	if arg_43_0.type == var_0_1.TypeTrap then
		WorldConst = var_1

		return var_1.LOEffectC
	end

	WorldConst = var_1

	return var_1.LOCell
end

function var_0_1.GetMillor(arg_44_0)
	if arg_44_0.type == var_0_1.TypeEvent then
		return arg_44_0.config.enemyicon % 2 == 1
	elseif var_0_1.IsEnemyType(arg_44_0.type) then
		return true
	end

	return false
end

function var_0_1.GetDirType(arg_45_0)
	if arg_45_0:GetSpEventType() == var_0_1.SpEventFufen then
		WorldConst = var_1

		return var_1.DirType4
	else
		WorldConst = var_1

		return var_1.DirType2
	end

	return
end

function var_0_1.GetReplaceDisplayEnemyConfig(arg_46_0)
	assert = var_1_10001

	var_1_10001(arg_46_0.type == var_0_1.TypeEvent)

	pg = var_1_10001

	return var_1_10001.expedition_data_template[arg_46_0.config.expedition_icon]
end

function var_0_1.GetDebugName(arg_47_0)
	if arg_47_0.type == var_0_1.TypeEvent then
		return "event_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_1.TypeBox then
		return "box_" .. arg_47_0.id
	elseif var_0_1.IsEnemyType(arg_47_0.type) then
		return "enemy_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_1.TypeTransportFleet then
		return "transport_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_1.TypeTrap then
		return "trap_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_1.TypePort then
		return "port_" .. arg_47_0.id
	end

	return
end

function var_0_1.IsTriggered(arg_48_0)
	return arg_48_0.triggered
end

function var_0_1.IsScannerAttachment(arg_49_0)
	return var_0_1.IsEnemyType(arg_49_0.type) and 4 or arg_49_0.type == var_0_1.TypeTrap and 3 or arg_49_0.type == var_0_1.TypeEvent and arg_49_0.config.is_scanevent > 0 and 2 or arg_49_0.type == var_0_1.TypePort and 1
end

function var_0_1.SetHP(arg_50_0, arg_50_1)
	if var_0_1.IsHPEnemyType(arg_50_0.type) then
		local var_50_0 = arg_50_0.hp

		if arg_50_0:IsPeriodEnemy() then
			nowWorld = var_3

			local var_50_1 = var_3()

			math = var_4
			var_50_0 = var_4.min(var_50_0, var_50_1:GetHistoryLowestHP(arg_50_0.id))
			var_1_10006 = var_50_1

			var_50_1.SetHistoryLowestHP(var_1_10006, arg_50_0.id, arg_50_1)
		end

		local var_50_2 = {}

		ipairs = var_4
		pg = var_1_10006

		for iter_50_0, iter_50_1 in var_4(var_1_10006.world_expedition_data[arg_50_0:GetBattleStageId()].phase_story) do
			if var_50_0 > iter_50_1[1] and arg_50_1 <= iter_50_1[1] then
				table = var_9

				var_9.insert(var_50_2, {
					hp = iter_50_1[1],
					story = iter_50_1[2]
				})
			end
		end

		arg_50_0.hp = arg_50_1

		return var_50_2
	else
		return {}
	end

	return
end

function var_0_1.GetHP(arg_51_0)
	if arg_51_0.type == var_0_1.TypeTransportFleet then
		return arg_51_0.data
	elseif var_0_1.IsHPEnemyType(arg_51_0.type) then
		return arg_51_0.hp
	end

	return
end

function var_0_1.GetMaxHP(arg_52_0)
	if arg_52_0.type == var_0_1.TypeTransportFleet then
		return arg_52_0.config.hp
	elseif var_0_1.IsHPEnemyType(arg_52_0.type) then
		return 10000
	end

	return
end

function var_0_1.GetArtifaceInfo(arg_53_0)
	local var_53_0 = arg_53_0.config

	assert = var_1_10002

	var_1_10002(arg_53_0.type == var_0_1.TypeArtifact, "type error from id: " .. arg_53_0.id)

	assert = var_1_10002
	math = var_4

	var_1_10002(var_4.floor(var_53_0.enemyicon / 2) == 2, "enemyicon error from id: " .. arg_53_0.id)

	return {
		arg_53_0.row,
		arg_53_0.column,
		var_53_0.icon
	}
end

function var_0_1.GetVisionRadius(arg_54_0)
	if arg_54_0.type == var_0_1.TypeEvent then
		return arg_54_0.config.event_sight
	else
		return -1
	end

	return
end

function var_0_1.GetRadiationBuffs(arg_55_0)
	if arg_55_0.type == var_0_1.TypeEvent then
		return arg_55_0.config.map_buff
	else
		return {}
	end

	return
end

function var_0_1.IsAttachmentFinish(arg_56_0)
	return arg_56_0.finishMark == arg_56_0.data
end

function var_0_1.GetEventAutoPri(arg_57_0)
	assert = var_1_10001

	var_1_10001(arg_57_0.type == var_0_1.TypeEvent, "type error from id: " .. arg_57_0.id)

	return arg_57_0.config.auto_pri
end

function var_0_1.IsPeriodEnemy(arg_58_0)
	assert = var_1_10001

	local var_58_0 = var_0_1.IsHPEnemyType(arg_58_0.type)

	string = var_1_10004

	var_1_10001(var_58_0, var_1_10004.format("enemy %d type %d error", arg_58_0.id, arg_58_0.type))

	pg = var_1_10001

	return var_1_10001.world_expedition_data[arg_58_0.id] and var_1.phase_limit == 1
end

return var_0_1
