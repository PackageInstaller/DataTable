local var_0_0 = class("ChapterConst")

var_0_0.ExitFromChapter = 0
var_0_0.ExitFromMap = 1
var_0_0.TypeLagacy = 1
var_0_0.TypeRange = 2
var_0_0.TypeTransport = 3
var_0_0.TypeMainSub = 4
var_0_0.TypeExtra = 5
var_0_0.TypeSpHunt = 7
var_0_0.TypeSpBomb = 8
var_0_0.TypeDefence = 10
var_0_0.TypeDOALink = 11
var_0_0.TypeMultiStageBoss = 12
var_0_0.TypeChapterSixteen = 13
var_0_0.SubjectPlayer = 1
var_0_0.SubjectChampion = 2
var_0_0.MaxRow = 10
var_0_0.MaxColumn = 20
var_0_0.MaxStep = 10000
var_0_0.AttachNone = 0
var_0_0.AttachBorn = 1
var_0_0.AttachBox = 2
var_0_0.AttachSupply = 3
var_0_0.AttachElite = 4
var_0_0.AttachAmbush = 5
var_0_0.AttachEnemy = 6
var_0_0.AttachTorpedo_Enemy = 7
var_0_0.AttachBoss = 8
var_0_0.AttachStory = 9
var_0_0.AttachAreaBoss = 11
var_0_0.AttachChampion = 12
var_0_0.AttachTorpedo_Fleet = 14
var_0_0.AttachChampionPatrol = 15
var_0_0.AttachBorn_Sub = 16
var_0_0.AttachTransport = 17
var_0_0.AttachTransport_Target = 18
var_0_0.AttachChampionSub = 19
var_0_0.AttachOni = 20
var_0_0.AttachOni_Target = 21
var_0_0.AttachBomb_Enemy = 24
var_0_0.AttachBarrier = 25
var_0_0.AttachHugeSupply = 26
var_0_0.AttachLandbase = 100
var_0_0.AttachEnemyTypes = {
	var_0_0.AttachEnemy,
	var_0_0.AttachAmbush,
	var_0_0.AttachElite,
	var_0_0.AttachBoss,
	var_0_0.AttachAreaBoss,
	var_0_0.AttachBomb_Enemy,
	var_0_0.AttachChampion
}

function var_0_0.IsEnemyAttach(arg_1_0)
	return table.contains(var_0_0.AttachEnemyTypes, arg_1_0)
end

function var_0_0.IsBossCell(arg_2_0)
	if arg_2_0.attachment == var_0_0.AttachBoss then
		return true
	end

	if not var_0_0.IsEnemyAttach(arg_2_0.attachment) then
		return false
	end

	local var_2_0 = pg.expedition_data_template[arg_2_0.attachmentId]

	if not pg.expedition_data_template[arg_2_0.attachmentId] then
		return
	end

	return var_2_0.type == var_0_0.ExpeditionTypeBoss or var_2_0.type == var_0_0.ExpeditionTypeMulBoss
end

function var_0_0.GetDestroyFX(arg_3_0)
	if not pg.expedition_data_template[arg_3_0.attachmentId] or pg.expedition_data_template[arg_3_0.attachmentId].SLG_destroy_FX == "" then
		return "huoqiubaozha"
	else
		return pg.expedition_data_template[arg_3_0.attachmentId].SLG_destroy_FX
	end

	return
end

var_0_0.Story = 1
var_0_0.StoryObstacle = 2
var_0_0.StoryTrigger = 3
var_0_0.EventTeleport = 4
var_0_0.CellFlagActive = 0
var_0_0.CellFlagDisabled = 1
var_0_0.CellFlagAmbush = 2
var_0_0.CellFlagTriggerActive = 3
var_0_0.CellFlagTriggerDisabled = 4
var_0_0.CellFlagDiving = 5
var_0_0.EvtType_Poison = 1
var_0_0.EvtType_AdditionalFloor = 2
var_0_0.FlagBanaiAirStrike = 4
var_0_0.FlagPoison = 5
var_0_0.FlagLava = 10
var_0_0.FlagNightmare = 9
var_0_0.FlagMissleAiming = 12
var_0_0.FlagWeatherNight = 101
var_0_0.FlagWeatherFog = 102
var_0_0.FlagWeatherFogVisible = 103
var_0_0.ActType_Poison = 1
var_0_0.ActType_SubmarineHunting = 2
var_0_0.ActType_TargetDown = 3
var_0_0.ActType_Expel = 4
var_0_0.BoxBarrier = 0
var_0_0.BoxDrop = 1
var_0_0.BoxStrategy = 2
var_0_0.BoxAirStrike = 4
var_0_0.BoxEnemy = 5
var_0_0.BoxSupply = 6
var_0_0.BoxTorpedo = 7
var_0_0.BoxBanaiDamage = 8
var_0_0.BoxLavaDamage = 9
var_0_0.LBIdle = 0
var_0_0.LBCoastalGun = 1
var_0_0.LBHarbor = 2
var_0_0.LBDock = 3
var_0_0.LBAntiAir = 4
var_0_0.LBFogLightBase = 5
var_0_0.LBIDAirport = 13
var_0_0.RoundPlayer = 0
var_0_0.RoundEnemy = 1
var_0_0.AIEasy = 1
var_0_0.AIStayAround = 2
var_0_0.AIPatrol = 3
var_0_0.AIProtect = 4
var_0_0.AIDog = 5
var_0_0.StgTypeForm = 1
var_0_0.StgTypeConsume = 2
var_0_0.StgTypeConst = 3
var_0_0.StgTypePassive = 4
var_0_0.StgTypeBindChapter = 5
var_0_0.StgTypeBindFleetPassive = 6
var_0_0.StgTypeBindSupportConsume = 7
var_0_0.StgTypeStatus = 10
var_0_0.StrategyAmmoRich = 10001
var_0_0.StrategyAmmoPoor = 10002
var_0_0.StrategyHuntingRange = -1
var_0_0.StrategySubAutoAttack = -2
var_0_0.StrategyFormSignleLine = 1
var_0_0.StrategyFormDoubleLine = 2
var_0_0.StrategyFormCircular = 3
var_0_0.StrategyRepair = 4
var_0_0.StrategyExchange = 9
var_0_0.StrategyCallSubOutofRange = 10
var_0_0.StrategySubTeleport = 11
var_0_0.StrategySonarDetect = 12
var_0_0.StrategyMissileStrike = 18
var_0_0.StrategyAirSupport = 1000
var_0_0.StrategyExpel = 1001
var_0_0.StrategyAirSupportFoe = 94
var_0_0.StrategyAirSupportFriendly = 95
var_0_0.StrategyIntelligenceRecorded = 96
var_0_0.StrategyBuffTypeNormal = 0
var_0_0.StrategyBuffTypeOnlyBoss = 1
var_0_0.StrategyForms = {
	var_0_0.StrategyFormSignleLine,
	var_0_0.StrategyFormDoubleLine,
	var_0_0.StrategyFormCircular
}
var_0_0.StrategyPresents = {
	var_0_0.StrategyRepair
}
var_0_0.QuadStateFrozen = 1
var_0_0.QuadStateNormal = 2
var_0_0.QuadStateBarrierSetting = 3
var_0_0.QuadStateTeleportSub = 4
var_0_0.QuadStateMissileStrike = 5
var_0_0.QuadStateAirSuport = 6
var_0_0.QuadStateExpel = 7
var_0_0.PlaneName = "plane"
var_0_0.LineCross = 2
var_0_0.CellEaseOutAlpha = 0.01
var_0_0.CellNormalColor = Color.white
var_0_0.CellTargetColor = Color.green
var_0_0.ChildItem = "item"
var_0_0.ChildAttachment = "attachment"
var_0_0.TraitNone = 0
var_0_0.TraitLurk = 1
var_0_0.TraitVirgin = 2

function var_0_0.NeedMarkAsLurk(arg_4_0)
	if arg_4_0.flag ~= ChapterConst.CellFlagActive then
		return false
	end

	if arg_4_0.attachment == var_0_0.AttachBox then
		local var_4_0 = pg.box_data_template[arg_4_0.attachmentId]

		assert(pg.box_data_template[arg_4_0.attachmentId], "box_data_template not exist: " .. arg_4_0.attachmentId)

		if var_4_0.type == var_0_0.BoxStrategy and pg.strategy_data_template[var_4_0.effect_id].type == ChapterConst.StgTypeBindFleetPassive then
			return nil
		end

		return var_4_0.type == var_0_0.BoxDrop or var_4_0.type == var_0_0.BoxStrategy or var_4_0.type == var_0_0.BoxSupply or var_4_0.type == var_0_0.BoxEnemy
	elseif var_0_0.IsBossCell(arg_4_0) then
		return true
	elseif arg_4_0.attachment == var_0_0.AttachAmbush then
		return false
	elseif var_0_0.IsEnemyAttach(arg_4_0.attachment) then
		return true
	end

	return
end

function var_0_0.NeedEasePathCell(arg_5_0)
	if arg_5_0.attachment == var_0_0.AttachNone then
		return true
	elseif arg_5_0.attachment == var_0_0.AttachAmbush then
		if arg_5_0.flag ~= ChapterConst.CellFlagActive then
			return true
		end
	elseif arg_5_0.attachment == var_0_0.AttachEnemy or arg_5_0.attachment == var_0_0.AttachElite then
		if arg_5_0.flag == ChapterConst.CellFlagDisabled then
			return true
		end
	elseif arg_5_0.attachment == var_0_0.AttachSupply and arg_5_0.attachmentId <= 0 then
		return true
	elseif arg_5_0.attachment == var_0_0.AttachBox then
		assert(pg.box_data_template[arg_5_0.attachmentId], "box_data_template not exist: " .. arg_5_0.attachmentId)

		if pg.box_data_template[arg_5_0.attachmentId].type == var_0_0.BoxAirStrike or pg.box_data_template[arg_5_0.attachmentId].type == var_0_0.BoxTorpedo then
			return true
		elseif (pg.box_data_template[arg_5_0.attachmentId].type == var_0_0.BoxDrop or pg.box_data_template[arg_5_0.attachmentId].type == var_0_0.BoxStrategy or pg.box_data_template[arg_5_0.attachmentId].type == var_0_0.BoxEnemy or pg.box_data_template[arg_5_0.attachmentId].type == var_0_0.BoxSupply) and arg_5_0.flag == ChapterConst.CellFlagDisabled then
			return true
		end
	elseif arg_5_0.attachment == var_0_0.AttachStory then
		if arg_5_0.flag ~= ChapterConst.CellFlagActive and (arg_5_0.flag ~= ChapterConst.CellFlagTriggerActive or arg_5_0.data ~= var_0_0.StoryObstacle) then
			return true
		end
	elseif arg_5_0.attachment == var_0_0.AttachBarrier then
		return true
	end

	return false
end

function var_0_0.NeedClearStep(arg_6_0)
	if arg_6_0.attachment == var_0_0.AttachAmbush and arg_6_0.flag == ChapterConst.CellFlagAmbush then
		return true
	end

	if arg_6_0.attachment == var_0_0.AttachBox then
		assert(pg.box_data_template[arg_6_0.attachmentId], "box_data_template not exist: " .. arg_6_0.attachmentId)

		if pg.box_data_template[arg_6_0.attachmentId].type == var_0_0.BoxAirStrike then
			return true
		end
	end

	return false
end

var_0_0.AchieveType1 = 1
var_0_0.AchieveType2 = 2
var_0_0.AchieveType3 = 3
var_0_0.AchieveType4 = 4
var_0_0.AchieveType5 = 5
var_0_0.AchieveType6 = 6

function var_0_0.IsAchieved(arg_7_0)
	return (arg_7_0.type == var_0_0.AchieveType4 or arg_7_0.type == var_0_0.AchieveType5) and arg_7_0.count >= 1 or arg_7_0.count >= arg_7_0.config
end

function var_0_0.GetAchieveDesc(arg_8_0, arg_8_1)
	local var_8_0 = _.detect(arg_8_1.achieves, function(arg_9_0)
		return arg_9_0.type == arg_8_0
	end)

	if var_8_0.type == var_0_0.AchieveType1 then
		return "击破敌方旗舰"
	elseif var_8_0.type == var_0_0.AchieveType2 then
		return string.format("击破护卫舰队（%d/%d）", math.min(var_8_0.count, var_8_0.config), var_8_0.config)
	elseif var_8_0.type == var_0_0.AchieveType3 then
		return "击破所有敌舰"
	elseif var_8_0.type == var_0_0.AchieveType4 then
		return string.format("出击人数不多于%d", var_8_0.config)
	elseif var_8_0.type == var_0_0.AchieveType5 then
		return string.format("出击舰娘不包含XX", ShipType.Type2Name(var_8_0.config))
	elseif var_8_0.type == var_0_0.AchieveType6 then
		return "Full Combo完成关卡"
	end

	return false
end

var_0_0.OpRetreat = 0
var_0_0.OpMove = 1
var_0_0.OpBox = 2
var_0_0.OpAmbush = 4
var_0_0.OpStrategy = 5
var_0_0.OpRepair = 6
var_0_0.OpSupply = 7
var_0_0.OpEnemyRound = 8
var_0_0.OpSubState = 9
var_0_0.OpStory = 10
var_0_0.OpBarrier = 16
var_0_0.OpSubTeleport = 19
var_0_0.OpPreClear = 30
var_0_0.OPSubStrike = 31
var_0_0.OpRequest = 49
var_0_0.OpSwitch = 98
var_0_0.OpSkipBattle = 99
var_0_0.DirtyAchieve = 1
var_0_0.DirtyFleet = 2
var_0_0.DirtyAttachment = 4
var_0_0.DirtyStrategy = 8
var_0_0.DirtyChampion = 16
var_0_0.DirtyAutoAction = 32
var_0_0.DirtyCellFlag = 64
var_0_0.DirtyBase = 128
var_0_0.DirtyChampionPosition = 256
var_0_0.DirtyFloatItems = 512
var_0_0.DirtyWeather = 1024
var_0_0.KizunaJammingEngage = 1
var_0_0.KizunaJammingDodge = 2
var_0_0.StatusDay = 3
var_0_0.StatusNight = 4
var_0_0.StatusAirportOutControl = 5
var_0_0.StatusAirportUnderControl = 6
var_0_0.StatusSunrise = 7
var_0_0.StatusSunset = 8
var_0_0.StatusMaze1 = 9
var_0_0.StatusMaze2 = 10
var_0_0.StatusMaze3 = 11
var_0_0.StatusDPM_KASTHA_FOE = 12
var_0_0.StatusDPM_KASTHA_FRIEND = 13
var_0_0.StatusDPM_PANYIA_FOE = 14
var_0_0.StatusDPM_PANYIA_FRIEND = 15
var_0_0.StatusDPM_MRD_FOE = 16
var_0_0.StatusDPM_MRD_FRIEND = 17
var_0_0.StatusDPM_VITA_FOE = 18
var_0_0.StatusDPM_VITA_FRIEND = 19
var_0_0.StatusLIGHTHOUSEACTIVE = 20
var_0_0.StatusSSSSSyberSquadSupportIdle = 21
var_0_0.StatusSSSSSyberSquadSupportActive = 22
var_0_0.StatusSSSSKaijuSupportIdle = 23
var_0_0.StatusSSSSKaijuSupportActive = 24
var_0_0.StatusMissile1 = 30
var_0_0.StatusMissile2 = 31
var_0_0.StatusMissile3 = 32
var_0_0.StatusMissileInit = 33
var_0_0.StatusMissile1B = 34
var_0_0.StatusMissile2B = 35
var_0_0.StatusMissile3B = 36
var_0_0.StatusMissileInitB = 37
var_0_0.StatusMaoxiv3 = 38
var_0_0.StatusGonghai = 39
var_0_0.StatusGonghai = 40
var_0_0.StatusGonghai = 41
var_0_0.StatusMusashiGame1 = 42
var_0_0.StatusMusashiGame2 = 43
var_0_0.StatusMusashiGame3 = 44
var_0_0.StatusMusashiGame4 = 45
var_0_0.StatusMusashiGame5 = 46
var_0_0.StatusMusashiGame6 = 47
var_0_0.StatusMusashiGame7 = 48
var_0_0.StatusMusashiGame8 = 49
var_0_0.StatusSupportSubmarineFinish = 104
var_0_0.Status2Stg = setmetatable({}, {
	__index = function(arg_10_0, arg_10_1)
		if pg.chapter_status_effect[arg_10_1] then
			local var_10_0 = pg.chapter_status_effect[arg_10_1].strategy or 0

			return var_10_0 ~= 0 and var_10_0 or nil
		end
	end
})
var_0_0.Buff2Stg = {}

for iter_0_0, iter_0_1 in ipairs(pg.strategy_data_template.all) do
	(function(arg_11_0, arg_11_1)
		if arg_11_1.buff_id == 0 then
			return
		end

		var_0_0.Buff2Stg[arg_11_1.buff_id] = arg_11_0

		return
	end)(iter_0_1, pg.strategy_data_template[iter_0_1])
end

var_0_0.HpGreen = 3000

function var_0_0.GetAmbushDisplay(arg_12_0)
	local var_12_0
	local var_12_1

	if not arg_12_0 then
		var_12_0 = pg.gametip.ambush_display_0.tip
		var_12_1 = Color.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	elseif arg_12_0 <= 0 then
		var_12_0 = pg.gametip.ambush_display_1.tip
		var_12_1 = Color.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif arg_12_0 < 0.1 then
		var_12_0 = pg.gametip.ambush_display_2.tip
		var_12_1 = Color.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif arg_12_0 < 0.2 then
		var_12_0 = pg.gametip.ambush_display_3.tip
		var_12_1 = Color.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif arg_12_0 < 0.33 then
		var_12_0 = pg.gametip.ambush_display_4.tip
		var_12_1 = Color.New(0.984313725490196, 0.788235294117647, 0.21568627450980393)
	elseif arg_12_0 < 0.5 then
		var_12_0 = pg.gametip.ambush_display_5.tip
		var_12_1 = Color.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	else
		var_12_0 = pg.gametip.ambush_display_6.tip
		var_12_1 = Color.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	end

	return var_12_0, var_12_1
end

var_0_0.ShipMoveAction = "move"
var_0_0.ShipIdleAction = "normal"
var_0_0.ShipSwimAction = "swim"
var_0_0.ShipStepDuration = 0.5
var_0_0.ShipStepQuickPlayScale = 0.5
var_0_0.ShipMoveTailLength = 2

function var_0_0.GetRepairParams()
	return 1, 3, 100
end

function var_0_0.GetShamRepairParams()
	return 1, 3, 100
end

var_0_0.AmmoRich = 4
var_0_0.AmmoPoor = 0
var_0_0.ExpeditionAILair = 6
var_0_0.ExpeditionTypeMulBoss = 94
var_0_0.ExpeditionTypeUnTouchable = 97
var_0_0.ExpeditionTypeBoss = 99
var_0_0.EnemySize = {
	[0] = 3,
	3,
	96,
	100,
	98,
	100,
	99,
	99,
	95,
	98,
	97,
	100,
	94,
	99,
	[nil] = 1,
	[2] = 3,
	[1] = 2,
	[3] = 1,
	[2] = 3,
	[1] = 2
}
var_0_0.EnemyPreference = {
	[0] = 1,
	1,
	96,
	1,
	98,
	9,
	99,
	99,
	95,
	8,
	97,
	100,
	94,
	99,
	[nil] = 1,
	[1] = 1,
	[1] = 1,
	[1] = 1,
	[1] = 1,
	[1] = 1
}
var_0_0.ShamMoneyItem = 59900
var_0_0.MarkHuntingRange = 1
var_0_0.MarkBomb = 2
var_0_0.MarkCoastalGun = 3
var_0_0.MarkEscapeGrid = 4
var_0_0.MarkBanaiAirStrike = 5
var_0_0.MarkMovePathArrow = 6
var_0_0.MarkLava = 7
var_0_0.MarkHideNight = 8
var_0_0.MarkNightMare = 9
var_0_0.ReasonVictory = 1
var_0_0.ReasonDefeat = 2
var_0_0.ReasonVictoryOni = 3
var_0_0.ReasonDefeatOni = 4
var_0_0.ReasonDefeatBomb = 5
var_0_0.ReasonOutTime = 8
var_0_0.ReasonActivityOutTime = 9
var_0_0.ReasonDefeatDefense = 10
var_0_0.ForbiddenNone = 0
var_0_0.ForbiddenRight = 1
var_0_0.ForbiddenLeft = 2
var_0_0.ForbiddenDown = 4
var_0_0.ForbiddenUp = 8
var_0_0.ForbiddenRow = 3
var_0_0.ForbiddenColumn = 12
var_0_0.ForbiddenAll = 15
var_0_0.PriorityPerRow = 100
var_0_0.PriorityMin = -10000
var_0_0.CellPriorityNone = 0 + var_0_0.PriorityMin
var_0_0.CellPriorityAttachment = 1 + var_0_0.PriorityMin
var_0_0.CellPriorityLittle = 2 + var_0_0.PriorityMin
var_0_0.CellPriorityEnemy = 3 + var_0_0.PriorityMin
var_0_0.CellPriorityFleet = 3 + var_0_0.PriorityMin
var_0_0.CellPriorityUpperEffect = 5 + var_0_0.PriorityMin
var_0_0.CellPriorityTopMark = 6 + var_0_0.PriorityMin
var_0_0.PriorityMax = 16 + var_0_0.PriorityMin
var_0_0.LayerWeightMap = -999
var_0_0.LayerWeightMapAnimation = var_0_0.LayerWeightMap + 1
var_0_0.TemplateChampion = "tpl_champion"
var_0_0.TemplateEnemy = "tpl_enemy"
var_0_0.TemplateOni = "tpl_oni"
var_0_0.TemplateFleet = "tpl_ship"
var_0_0.TemplateSub = "tpl_sub"
var_0_0.TemplateTransport = "tpl_transport"
var_0_0.AirDominanceStrategyBuffType = 1001
var_0_0.AirDominance = {
	[0] = {
		name = pg.gametip.no_airspace_competition.tip,
		color = Color.New(1, 1, 1)
	},
	{
		name = pg.strategy_data_template[pg.gameset.air_dominance_level_5.key_value].name,
		StgId = pg.gameset.air_dominance_level_5.key_value,
		color = Color.New(0.9921568627450981, 0.4, 0.39215686274509803)
	},
	{
		name = pg.strategy_data_template[pg.gameset.air_dominance_level_4.key_value].name,
		StgId = pg.gameset.air_dominance_level_4.key_value,
		color = Color.New(0.9568627450980393, 0.5647058823529412, 0.34901960784313724)
	},
	{
		name = pg.strategy_data_template[pg.gameset.air_dominance_level_3.key_value].name,
		StgId = pg.gameset.air_dominance_level_3.key_value,
		color = Color.New(0.9568627450980393, 0.8470588235294118, 0.23921568627450981)
	},
	{
		name = pg.strategy_data_template[pg.gameset.air_dominance_level_2.key_value].name,
		StgId = pg.gameset.air_dominance_level_2.key_value,
		color = Color.New(0.7333333333333333, 0.7725490196078432, 0.2)
	},
	{
		name = pg.strategy_data_template[pg.gameset.air_dominance_level_1.key_value].name,
		StgId = pg.gameset.air_dominance_level_1.key_value,
		color = Color.New(0.615686274509804, 0.9215686274509803, 0.14901960784313725)
	}
}

function var_0_0.IsAtelierMap(arg_15_0)
	return arg_15_0:getConfig("on_activity") == ActivityConst.RYZA_MAP_ACT_ID
end

var_0_0.AUTOFIGHT_STOP_REASON = {
	DOCK_OVERLOADED = 2,
	OIL_LACK = 3,
	SHIP_ENERGY_LOW = 6,
	MANUAL = 1,
	GOLD_MAX = 4,
	BATTLE_FAILED = 5,
	SETTLEMENT = 7,
	UNKNOWN = 0
}
chapter_skip_battle = PlayerPrefs.GetInt("chapter_skip_battle") or 0

function switch_chapter_skip_battle()
	chapter_skip_battle = 1 - chapter_skip_battle

	PlayerPrefs.SetInt("chapter_skip_battle", chapter_skip_battle)
	PlayerPrefs.Save()
	pg.TipsMgr.GetInstance():ShowTips(chapter_skip_battle == 1 and "已开启战斗跳略" or "已关闭战斗跳略")

	return
end

return var_0_0
