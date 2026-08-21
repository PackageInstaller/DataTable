local var_0_0 = class("WorldMapAttachment", import("...BaseEntity"))

var_0_0.Fields = {
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
var_0_0.EventUpdateFlag = "WorldMapAttachment.EventUpdateFlag"
var_0_0.EventUpdateData = "WorldMapAttachment.EventUpdateData"
var_0_0.EventUpdateLurk = "WorldMapAttachment.EventUpdateLurk"
var_0_0.TypeBox = 2
var_0_0.TypeEnemy = 6
var_0_0.TypeBoss = 8
var_0_0.TypeArtifact = 10
var_0_0.TypeEnemyAI = 12
var_0_0.TypeFleet = 13
var_0_0.TypeTransportFleet = 17
var_0_0.TypeEvent = 22
var_0_0.TypeTrap = 23
var_0_0.TypePort = -1
var_0_0.SortOrder = {
	[var_0_0.TypeArtifact] = -99,
	[var_0_0.TypeTrap] = -1,
	[var_0_0.TypePort] = 0,
	[var_0_0.TypeEvent] = 1,
	[var_0_0.TypeBox] = 2,
	[var_0_0.TypeEnemy] = 3,
	[var_0_0.TypeEnemyAI] = 4,
	[var_0_0.TypeBoss] = 5,
	[var_0_0.TypeTransportFleet] = 6
}

function var_0_0.IsEnemyType(arg_1_0)
	return arg_1_0 == var_0_0.TypeEnemy or arg_1_0 == var_0_0.TypeEnemyAI or arg_1_0 == var_0_0.TypeBoss
end

function var_0_0.IsHPEnemyType(arg_2_0)
	return arg_2_0 == var_0_0.TypeEnemyAI or arg_2_0 == var_0_0.TypeBoss
end

function var_0_0.IsFakeType(arg_3_0)
	return arg_3_0 == var_0_0.TypePort
end

function var_0_0.IsInteractiveType(arg_4_0)
	return var_0_0.IsEnemyType(arg_4_0) or arg_4_0 == var_0_0.TypeEvent or arg_4_0 == var_0_0.TypeBox
end

function var_0_0.MakeFakePort(arg_5_0, arg_5_1, arg_5_2)
	local var_5_0 = WPool:Get(WorldMapAttachment)

	var_5_0:Setup({
		item_data = 0,
		item_flag = 0,
		pos = {
			row = arg_5_0,
			column = arg_5_1
		},
		item_type = var_0_0.TypePort,
		item_id = arg_5_2,
		buff_list = {},
		effect_list = {}
	})

	return var_5_0
end

function var_0_0.IsClientType(arg_6_0)
	return arg_6_0 > 1000
end

var_0_0.EffectEventStory = 2
var_0_0.EffectEventTeleport = 3
var_0_0.EffectEventDrop = 7
var_0_0.EffectEventShipBuff = 8
var_0_0.EffectEventGuide = 13
var_0_0.EffectEventDropTreasure = 14
var_0_0.EffectEventBlink1 = 16
var_0_0.EffectEventBlink2 = 17
var_0_0.EffectEventAchieveCarry = 18
var_0_0.EffectEventConsumeCarry = 19
var_0_0.EffectEventTeleportEvent = 20
var_0_0.EffectEventConsumeItem = 24
var_0_0.EffectEventStoryOption = 27
var_0_0.EffectEventFleetShipHP = 30
var_0_0.EffectEventProgress = 32
var_0_0.EffectEventTeleportBack = 37
var_0_0.EffectEventDeleteTask = 40
var_0_0.EffectEventGlobalBuff = 44
var_0_0.EffectEventMapClearFlag = 45
var_0_0.EffectEventBrokenClean = 48
var_0_0.EffectEventCatSalvage = 49
var_0_0.EffectEventAddWorldBossFreeCount = 50
var_0_0.EffectSideText = 52
var_0_0.EffectEventFOV = 1001
var_0_0.EffectEventCameraMove = 1002
var_0_0.EffectEventShakePlane = 1003
var_0_0.EffectEventFlash = 1004
var_0_0.EffectEventHelp = 1005
var_0_0.EffectEventShowMapMark = 1006
var_0_0.EffectEventReturn2World = 1007
var_0_0.EffectEventStoryOptionClient = 1009
var_0_0.EffectEventShowPort = 1010
var_0_0.EffectEventSound = 1011
var_0_0.EffectEventHelpLayer = 1012
var_0_0.EffectEventMsgbox = 1013
var_0_0.EffectEventStoryBattle = 1014
var_0_0.CompassTypeNone = 0
var_0_0.CompassTypeBattle = 1
var_0_0.CompassTypeExploration = 2
var_0_0.CompassTypeTask = 3
var_0_0.CompassTypeBoss = 4
var_0_0.CompassTypeGuidePost = 5
var_0_0.CompassTypeTaskTrack = 6
var_0_0.CompassTypePort = 7
var_0_0.CompassTypeSalvage = 8
var_0_0.CompassTypeFile = 9
var_0_0.SpEventHaibao = 1
var_0_0.SpEventFufen = 2
var_0_0.SpEventEnemy = 3
var_0_0.SpEventConsumeItem = 4

function var_0_0.DebugPrint(arg_7_0)
	if arg_7_0.type == var_0_0.TypeEvent then
		local var_7_0 = 1
		local var_7_1 = 1

		while var_7_1 <= #pg.world_event_data[arg_7_0.id].effect do
			if arg_7_0.effects[#arg_7_0.effects - var_7_0 + 1] == pg.world_event_data[arg_7_0.id].effect[#pg.world_event_data[arg_7_0.id].effect - var_7_1 + 1] then
				table.insert({}, 1, arg_7_0.effects[#arg_7_0.effects - var_7_0 + 1])

				var_7_1 = var_7_1 + 1
				var_7_0 = var_7_0 + 1
			elseif not arg_7_0.effects[#arg_7_0.effects - var_7_0 + 1] then
				table.insert({}, 1, setColorStr(pg.world_event_data[arg_7_0.id].effect[#pg.world_event_data[arg_7_0.id].effect - var_7_1 + 1], COLOR_GREEN))

				var_7_1 = var_7_1 + 1
			else
				local var_7_2 = pg.world_effect_data[pg.world_event_data[arg_7_0.id].effect[#pg.world_event_data[arg_7_0.id].effect - var_7_1 + 1]].effect_type

				if pg.world_effect_data[pg.world_event_data[arg_7_0.id].effect[#pg.world_event_data[arg_7_0.id].effect - var_7_1 + 1]].effect_type == 27 or var_7_2 == 35 or var_7_2 == 36 or var_7_2 == 53 then
					table.insert({}, 1, setColorStr(arg_7_0.effects[#arg_7_0.effects - var_7_0 + 1], COLOR_BLUE))

					var_7_0 = var_7_0 + 1
				else
					table.insert({}, 1, setColorStr(arg_7_0.effects[#arg_7_0.effects - var_7_0 + 1], COLOR_RED))

					var_7_1 = var_7_1 + 1
					var_7_0 = var_7_0 + 1
				end
			end
		end

		local var_7_3 = "" .. table.concat({}, ", ")

		for iter_7_0, iter_7_1 in ipairs(arg_7_0.config.event_op) do
			if iter_7_0 <= #arg_7_0.config.event_op - arg_7_0.dataop then
				table.insert({}, setColorStr(iter_7_1, COLOR_GREEN))
			else
				table.insert({}, iter_7_1)
			end
		end

		return string.format("事件  [id: %d]  [%s]  [位置: %d, %d]  [flag: %s]  [data: %d]  [感染值：%s]  [自动优先级：%s] \n     [effect: %s] \n     [effect_op: %s] \n     [buff: %s]", arg_7_0.id, arg_7_0.config.name, arg_7_0.row, arg_7_0.column, arg_7_0.flag, arg_7_0.data, setColorStr(arg_7_0.config.infection_value, COLOR_RED), setColorStr(arg_7_0.config.auto_pri, COLOR_YELLOW), var_7_3, table.concat({}, ", "), table.concat(arg_7_0.buffList, ", "))
	elseif var_0_0.IsEnemyType(arg_7_0.type) then
		return string.format("敌人  [id: %s]  [%s]  [类型 %s]  [位置: %s, %s]  [flag: %s]  [data: %s]  [buff: %s]", arg_7_0.id, arg_7_0.config.name, arg_7_0.type, arg_7_0.row, arg_7_0.column, tostring(arg_7_0.flag), tostring(arg_7_0.data), table.concat(arg_7_0.buffList, ", "))
	elseif arg_7_0.type == var_0_0.TypeTrap then
		return string.format("陷阱  [id: %s]  [%s]  [位置: %s, %s]  [flag: %s]  [data: %s]", arg_7_0.id, arg_7_0.config.name, arg_7_0.row, arg_7_0.column, tostring(arg_7_0.flag), tostring(arg_7_0.data))
	elseif arg_7_0.type == var_0_0.TypeFleet then
		return string.format("舰队  [id: %s]  [%s]  [位置: %s, %s]  [flag: %s]  [data: %s]", arg_7_0.id, "我方舰队", arg_7_0.row, arg_7_0.column, tostring(arg_7_0.flag), tostring(arg_7_0.data))
	elseif arg_7_0.type == var_0_0.TypeArtifact then
		return string.format("场景物件  [id: %s]  [位置: %s, %s]  [flag: %s]  [data: %s]  [buff: %s]", arg_7_0.id, arg_7_0.row, arg_7_0.column, tostring(arg_7_0.flag), tostring(arg_7_0.data), table.concat(arg_7_0.buffList, ", "))
	end

	return
end

function var_0_0.Setup(arg_8_0, arg_8_1)
	arg_8_0.row = arg_8_1.pos.row
	arg_8_0.column = arg_8_1.pos.column
	arg_8_0.type = arg_8_1.item_type
	arg_8_0.id = arg_8_1.item_id
	arg_8_0.flag = arg_8_1.item_flag
	arg_8_0.data = arg_8_1.item_data
	arg_8_0.effects = underscore.rest(arg_8_1.effect_list, 1)
	arg_8_0.buffList = underscore.rest(arg_8_1.buff_list, 1)
	arg_8_0.hp = arg_8_1.boss_hp

	arg_8_0:InitConfig()
	arg_8_0:InitData()

	return
end

function var_0_0.InitConfig(arg_9_0)
	if arg_9_0.type == var_0_0.TypeBox then
		arg_9_0.config = pg.box_data_template[arg_9_0.id]

		assert(arg_9_0.config, "box_data_template not exist: " .. arg_9_0.id)
	elseif var_0_0.IsEnemyType(arg_9_0.type) then
		arg_9_0.config = pg.expedition_data_template[arg_9_0.id]

		assert(arg_9_0.config, "expedition_data_template not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_0.TypeEvent then
		arg_9_0.config = pg.world_event_data[arg_9_0.id]

		assert(arg_9_0.config, "world_event_data not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_0.TypePort then
		arg_9_0.config = pg.world_port_data[arg_9_0.id]

		assert(arg_9_0.config, "world_port_data not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_0.TypeTransportFleet then
		arg_9_0.config = pg.friendly_data_template[arg_9_0.id]

		assert(arg_9_0.config, "friendly_data_template not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_0.TypeTrap then
		arg_9_0.config = pg.world_trap_data[arg_9_0.id]

		assert(arg_9_0.config, "world_trap_data not exist: " .. arg_9_0.id)
	elseif arg_9_0.type == var_0_0.TypeArtifact then
		arg_9_0.config = pg.world_event_data[arg_9_0.id]

		assert(arg_9_0.config, "with out this atrifact: " .. arg_9_0.id)
	end

	return
end

function var_0_0.InitData(arg_10_0)
	if arg_10_0.type == var_0_0.TypeEvent then
		arg_10_0.dataop = #arg_10_0.config.event_op
	end

	return
end

function var_0_0.IsAlive(arg_11_0)
	if arg_11_0.type == var_0_0.TypeEvent then
		return true
	elseif var_0_0.IsEnemyType(arg_11_0.type) then
		return arg_11_0.flag ~= 1 and arg_11_0.data ~= 0
	elseif arg_11_0.type == var_0_0.TypeTransportFleet then
		return arg_11_0:GetHP() > 0
	elseif arg_11_0.type == var_0_0.TypeArtifact then
		return false
	end

	return arg_11_0.flag ~= 1
end

function var_0_0.IsVisible(arg_12_0)
	local var_12_0 = not arg_12_0.lurk

	if arg_12_0.type == var_0_0.TypeEvent then
		var_12_0 = var_12_0 and arg_12_0.config.discover_type == 2
	elseif var_0_0.IsEnemyType(arg_12_0.type) then
		var_12_0 = var_12_0 and arg_12_0:IsAlive()
	end

	return var_12_0
end

function var_0_0.IsFloating(arg_13_0)
	return arg_13_0.type == var_0_0.TypeEvent and arg_13_0.config.icontype == 1 or arg_13_0.type == var_0_0.TypeBox
end

function var_0_0.UpdateFlag(arg_14_0, arg_14_1)
	if arg_14_0.flag ~= arg_14_1 then
		arg_14_0.flag = arg_14_1

		arg_14_0:DispatchEvent(var_0_0.EventUpdateFlag)
	end

	return
end

function var_0_0.UpdateData(arg_15_0, arg_15_1, arg_15_2)
	arg_15_0.data = arg_15_1

	if arg_15_0.type == var_0_0.TypeEvent then
		arg_15_0.effects = underscore.rest(arg_15_2, 1)
	end

	arg_15_0:DispatchEvent(var_0_0.EventUpdateData)

	return
end

function var_0_0.UpdateLurk(arg_16_0, arg_16_1)
	if arg_16_0.lurk ~= arg_16_1 then
		arg_16_0.lurk = arg_16_1

		arg_16_0:DispatchEvent(var_0_0.EventUpdateLurk)
	end

	return
end

function var_0_0.UpdateDataOp(arg_17_0, arg_17_1)
	arg_17_0.dataop = arg_17_1

	return
end

function var_0_0.GetEventEffect(arg_18_0)
	assert(arg_18_0.type == var_0_0.TypeEvent, string.format("type error:%d", arg_18_0.type))

	return arg_18_0.effects[1] and pg.world_effect_data[arg_18_0.effects[1]]
end

function var_0_0.GetEventEffects(arg_19_0)
	assert(arg_19_0.type == var_0_0.TypeEvent, string.format("type error:%d", arg_19_0.type))

	return _.map(arg_19_0.effects, function(arg_20_0)
		return pg.world_effect_data[arg_20_0]
	end)
end

function var_0_0.RemainOpEffect(arg_21_0)
	return arg_21_0.dataop > 0
end

function var_0_0.GetOpEffect(arg_22_0)
	assert(pg.world_effect_data[arg_22_0.config.event_op[#arg_22_0.config.event_op - arg_22_0.dataop + 1]], "world_effect_data not exist: " .. arg_22_0.config.event_op[#arg_22_0.config.event_op - arg_22_0.dataop + 1])

	return pg.world_effect_data[arg_22_0.config.event_op[#arg_22_0.config.event_op - arg_22_0.dataop + 1]]
end

function var_0_0.GetBattleStageId(arg_23_0)
	assert(var_0_0.IsEnemyType(arg_23_0.type))

	return arg_23_0.id
end

function var_0_0.GetLimitDamageLevel(arg_24_0)
	return pg.world_expedition_data[arg_24_0:GetBattleStageId()].morale_limit
end

function var_0_0.ShouldMarkAsLurk(arg_25_0)
	return arg_25_0.type == var_0_0.TypeEvent and arg_25_0.config.visuality == 1 and arg_25_0.config.discover_type == 2
end

function var_0_0.CanLeave(arg_26_0)
	if var_0_0.IsEnemyType(arg_26_0.type) then
		return false
	elseif arg_26_0.type == var_0_0.TypeEvent or arg_26_0.type == var_0_0.TypeTrap then
		return WorldConst.GetObstacleConfig(arg_26_0.config.obstacle, "leave")
	else
		return true
	end

	return
end

function var_0_0.CanArrive(arg_27_0)
	if arg_27_0.type == var_0_0.TypeEvent or arg_27_0.type == var_0_0.TypeTrap then
		return WorldConst.GetObstacleConfig(arg_27_0.config.obstacle, "arrive")
	else
		return true
	end

	return
end

function var_0_0.CanPass(arg_28_0)
	if var_0_0.IsEnemyType(arg_28_0.type) then
		return false
	elseif arg_28_0.type == var_0_0.TypeEvent or arg_28_0.type == var_0_0.TypeTrap then
		return WorldConst.GetObstacleConfig(arg_28_0.config.obstacle, "pass")
	else
		return true
	end

	return
end

function var_0_0.IsAvatar(arg_29_0)
	if arg_29_0.type == var_0_0.TypeEvent then
		if arg_29_0:GetReplaceDisplayEnemyConfig() then
			return false
		end

		return math.floor(arg_29_0.config.enemyicon / 2) == 1
	elseif var_0_0.IsEnemyType(arg_29_0.type) then
		return arg_29_0.config.icon_type == 2
	end

	return false
end

function var_0_0.IsSign(arg_30_0)
	if arg_30_0.type == var_0_0.TypeEvent then
		return arg_30_0.config.is_guide == 1
	end

	return false
end

function var_0_0.IsBoss(arg_31_0)
	return var_0_0.IsEnemyType(arg_31_0.type) and WorldConst.EnemySize[arg_31_0.config.type] == 99
end

function var_0_0.GetBuffList(arg_32_0)
	return underscore.map(arg_32_0.buffList, function(arg_33_0)
		local var_33_0 = WorldBuff.New()

		var_33_0:Setup({
			floor = 1,
			id = arg_33_0
		})

		return var_33_0
	end)
end

function var_0_0.UpdateBuffList(arg_34_0, arg_34_1)
	local var_34_0 = arg_34_0:GetWeaknessBuffId()

	arg_34_0.buffList = arg_34_1

	if var_34_0 ~= arg_34_0:GetWeaknessBuffId() then
		return var_34_0 and {
			anim = "WorldWeaknessUpgradeWindow",
			hp = arg_34_0:GetMaxHP()
		} or {
			anim = "WorldWeaknessDiscoverWindow",
			hp = arg_34_0:GetMaxHP()
		}
	end

	return
end

function var_0_0.GetWeaknessBuffId(arg_35_0)
	if not var_0_0.IsEnemyType(arg_35_0.type) then
		return
	end

	local var_35_0 = {}

	underscore.each(underscore.flatten(pg.world_expedition_data[arg_35_0:GetBattleStageId()].weak_list), function(arg_36_0)
		var_35_0[arg_36_0] = true

		return
	end)

	for iter_35_0, iter_35_1 in ipairs(arg_35_0.buffList) do
		if var_35_0[iter_35_1] then
			return iter_35_1
		end
	end

	return
end

function var_0_0.GetBattleLuaBuffs(arg_37_0)
	local var_37_0 = {}

	underscore.each(arg_37_0:GetBuffList(), function(arg_38_0)
		if arg_38_0.config.lua_id > 0 then
			table.insert(var_37_0, arg_38_0.config.lua_id)
		end

		return
	end)

	return {}
end

function var_0_0.GetCompassType(arg_39_0)
	if arg_39_0.type == var_0_0.TypeEvent then
		return arg_39_0.config.compass_index
	elseif var_0_0.IsEnemyType(arg_39_0.type) then
		if arg_39_0:IsBoss() then
			return var_0_0.CompassTypeBoss
		else
			return var_0_0.CompassTypeBattle
		end
	elseif arg_39_0.type == var_0_0.TypeBox then
		return var_0_0.CompassTypeExploration
	elseif arg_39_0.type == var_0_0.TypePort then
		return var_0_0.CompassTypePort
	end

	return
end

function var_0_0.GetSpEventType(arg_40_0)
	if arg_40_0.type == var_0_0.TypeEvent then
		return arg_40_0.config.special_enemy
	end

	return
end

function var_0_0.GetDeviation(arg_41_0)
	if arg_41_0.type ~= var_0_0.TypeEvent then
		if arg_41_0.type == var_0_0.TypeArtifact then
			return Vector2(arg_41_0.config.deviation[1], arg_41_0.config.deviation[2])
		end

		return Vector2.zero
	end
end

function var_0_0.GetScale(arg_42_0, arg_42_1)
	local var_42_0 = 1

	if arg_42_0.type == var_0_0.TypeEvent then
		if arg_42_0.config.scale == 0 then
			return Vector3.one
		else
			var_42_0 = arg_42_0.config.scale / 100
		end
	elseif var_0_0.IsEnemyType(arg_42_0.type) then
		var_42_0 = 0.4 * arg_42_0.config.scale / 100
	elseif arg_42_0.type == var_0_0.TypeTrap and arg_42_0.id == 200 then
		arg_42_1 = arg_42_1 or arg_42_0.data
		var_42_0 = var_42_0 * (arg_42_1 + arg_42_1 - 1)
	end

	return Vector3(var_42_0, var_42_0, var_42_0)
end

function var_0_0.GetModelOrder(arg_43_0)
	if arg_43_0.type == var_0_0.TypeTrap then
		return WorldConst.LOEffectC
	end

	return WorldConst.LOCell
end

function var_0_0.GetMillor(arg_44_0)
	if arg_44_0.type == var_0_0.TypeEvent then
		return arg_44_0.config.enemyicon % 2 == 1
	elseif var_0_0.IsEnemyType(arg_44_0.type) then
		return true
	end

	return false
end

function var_0_0.GetDirType(arg_45_0)
	if arg_45_0:GetSpEventType() == var_0_0.SpEventFufen then
		return WorldConst.DirType4
	else
		return WorldConst.DirType2
	end

	return
end

function var_0_0.GetReplaceDisplayEnemyConfig(arg_46_0)
	assert(arg_46_0.type == var_0_0.TypeEvent)

	return pg.expedition_data_template[arg_46_0.config.expedition_icon]
end

function var_0_0.GetDebugName(arg_47_0)
	if arg_47_0.type == var_0_0.TypeEvent then
		return "event_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_0.TypeBox then
		return "box_" .. arg_47_0.id
	elseif var_0_0.IsEnemyType(arg_47_0.type) then
		return "enemy_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_0.TypeTransportFleet then
		return "transport_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_0.TypeTrap then
		return "trap_" .. arg_47_0.id
	elseif arg_47_0.type == var_0_0.TypePort then
		return "port_" .. arg_47_0.id
	end

	return
end

function var_0_0.IsTriggered(arg_48_0)
	return arg_48_0.triggered
end

function var_0_0.IsScannerAttachment(arg_49_0)
	return var_0_0.IsEnemyType(arg_49_0.type) and 4 or arg_49_0.type == var_0_0.TypeTrap and 3 or arg_49_0.type == var_0_0.TypeEvent and arg_49_0.config.is_scanevent > 0 and 2 or arg_49_0.type == var_0_0.TypePort and 1
end

function var_0_0.SetHP(arg_50_0, arg_50_1)
	if var_0_0.IsHPEnemyType(arg_50_0.type) then
		local var_50_0 = arg_50_0.hp

		if arg_50_0:IsPeriodEnemy() then
			local var_50_1 = nowWorld()

			var_50_0 = math.min(var_50_0, var_50_1:GetHistoryLowestHP(arg_50_0.id))

			var_50_1:SetHistoryLowestHP(arg_50_0.id, arg_50_1)
		end

		local var_50_2 = {}

		for iter_50_0, iter_50_1 in ipairs(pg.world_expedition_data[arg_50_0:GetBattleStageId()].phase_story) do
			if var_50_0 > iter_50_1[1] and arg_50_1 <= iter_50_1[1] then
				table.insert(var_50_2, {
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

function var_0_0.GetHP(arg_51_0)
	if arg_51_0.type == var_0_0.TypeTransportFleet then
		return arg_51_0.data
	elseif var_0_0.IsHPEnemyType(arg_51_0.type) then
		return arg_51_0.hp
	end

	return
end

function var_0_0.GetMaxHP(arg_52_0)
	if arg_52_0.type == var_0_0.TypeTransportFleet then
		return arg_52_0.config.hp
	elseif var_0_0.IsHPEnemyType(arg_52_0.type) then
		return 10000
	end

	return
end

function var_0_0.GetArtifaceInfo(arg_53_0)
	assert(arg_53_0.type == var_0_0.TypeArtifact, "type error from id: " .. arg_53_0.id)
	assert(math.floor(arg_53_0.config.enemyicon / 2) == 2, "enemyicon error from id: " .. arg_53_0.id)

	return {
		arg_53_0.row,
		arg_53_0.column,
		arg_53_0.config.icon
	}
end

function var_0_0.GetVisionRadius(arg_54_0)
	if arg_54_0.type == var_0_0.TypeEvent then
		return arg_54_0.config.event_sight
	else
		return -1
	end

	return
end

function var_0_0.GetRadiationBuffs(arg_55_0)
	if arg_55_0.type == var_0_0.TypeEvent then
		return arg_55_0.config.map_buff
	else
		return {}
	end

	return
end

function var_0_0.IsAttachmentFinish(arg_56_0)
	return arg_56_0.finishMark == arg_56_0.data
end

function var_0_0.GetEventAutoPri(arg_57_0)
	assert(arg_57_0.type == var_0_0.TypeEvent, "type error from id: " .. arg_57_0.id)

	return arg_57_0.config.auto_pri
end

function var_0_0.IsPeriodEnemy(arg_58_0)
	assert(var_0_0.IsHPEnemyType(arg_58_0.type), string.format("enemy %d type %d error", arg_58_0.id, arg_58_0.type))

	return pg.world_expedition_data[arg_58_0.id] and pg.world_expedition_data[arg_58_0.id].phase_limit == 1
end

return var_0_0
