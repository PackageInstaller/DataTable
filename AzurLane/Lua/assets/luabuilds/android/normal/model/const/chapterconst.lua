class = var_0_10000

local var_0_0 = var_0_10000("ChapterConst")

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
	table = var_1_10001

	return var_1_10001.contains(var_0_0.AttachEnemyTypes, arg_1_0)
end

function var_0_0.IsBossCell(arg_2_0)
	if arg_2_0.attachment == var_0_0.AttachBoss then
		return true
	end

	if not var_0_0.IsEnemyAttach(arg_2_0.attachment) then
		return false
	end

	pg = var_1

	if not var_1.expedition_data_template[arg_2_0.attachmentId] then
		return
	end

	return var_1.type == var_0_0.ExpeditionTypeBoss or var_1.type == var_0_0.ExpeditionTypeMulBoss
end

function var_0_0.GetDestroyFX(arg_3_0)
	pg = var_1_10001

	if not var_1_10001.expedition_data_template[arg_3_0.attachmentId] or var_1.SLG_destroy_FX == "" then
		return "huoqiubaozha"
	else
		return var_1.SLG_destroy_FX
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
Color = var_1
var_0_0.CellNormalColor = var_1.white
Color = var_1
var_0_0.CellTargetColor = var_1.green
var_0_0.ChildItem = "item"
var_0_0.ChildAttachment = "attachment"
var_0_0.TraitNone = 0
var_0_0.TraitLurk = 1
var_0_0.TraitVirgin = 2

function var_0_0.NeedMarkAsLurk(arg_4_0)
	local var_4_0 = arg_4_0.flag

	ChapterConst = var_1_10002

	if var_4_0 ~= var_1_10002.CellFlagActive then
		return false
	end

	if arg_4_0.attachment == var_0_0.AttachBox then
		pg = var_1

		local var_4_1 = var_1.box_data_template[arg_4_0.attachmentId]

		assert = var_2

		var_2(var_4_1, "box_data_template not exist: " .. arg_4_0.attachmentId)

		if var_4_1.type == var_0_0.BoxStrategy then
			pg = var_2

			local var_4_2 = var_2.strategy_data_template[var_4_1.effect_id].type

			ChapterConst = var_4

			if var_4_2 == var_4.StgTypeBindFleetPassive then
				return nil
			end
		end

		return var_4_1.type == var_0_0.BoxDrop or var_4_1.type == var_0_0.BoxStrategy or var_4_1.type == var_0_0.BoxSupply or var_4_1.type == var_0_0.BoxEnemy
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
		local var_5_0 = arg_5_0.flag

		ChapterConst = var_2

		if var_5_0 ~= var_2.CellFlagActive then
			return true
		end
	elseif arg_5_0.attachment == var_0_0.AttachEnemy or arg_5_0.attachment == var_0_0.AttachElite then
		local var_5_1 = arg_5_0.flag

		ChapterConst = var_2

		if var_5_1 == var_2.CellFlagDisabled then
			return true
		end
	elseif arg_5_0.attachment == var_0_0.AttachSupply and arg_5_0.attachmentId <= 0 then
		return true
	elseif arg_5_0.attachment == var_0_0.AttachBox then
		pg = var_1

		local var_5_2 = var_1.box_data_template[arg_5_0.attachmentId]

		assert = var_2

		var_2(var_5_2, "box_data_template not exist: " .. arg_5_0.attachmentId)

		if var_5_2.type == var_0_0.BoxAirStrike or var_5_2.type == var_0_0.BoxTorpedo then
			return true
		elseif var_5_2.type == var_0_0.BoxDrop or var_5_2.type == var_0_0.BoxStrategy or var_5_2.type == var_0_0.BoxEnemy or var_5_2.type == var_0_0.BoxSupply then
			local var_5_3 = arg_5_0.flag

			ChapterConst = var_3

			if var_5_3 == var_3.CellFlagDisabled then
				return true
			end
		end
	elseif arg_5_0.attachment == var_0_0.AttachStory then
		local var_5_4 = arg_5_0.flag

		ChapterConst = var_2

		if var_5_4 ~= var_2.CellFlagActive then
			local var_5_5 = arg_5_0.flag

			ChapterConst = var_2

			if var_5_5 ~= var_2.CellFlagTriggerActive or arg_5_0.data ~= var_0_0.StoryObstacle then
				return true
			end
		end
	elseif arg_5_0.attachment == var_0_0.AttachBarrier then
		return true
	end

	return false
end

function var_0_0.NeedClearStep(arg_6_0)
	if arg_6_0.attachment == var_0_0.AttachAmbush then
		local var_6_0 = arg_6_0.flag

		ChapterConst = var_2

		if var_6_0 == var_2.CellFlagAmbush then
			return true
		end
	end

	if arg_6_0.attachment == var_0_0.AttachBox then
		pg = var_1

		local var_6_1 = var_1.box_data_template[arg_6_0.attachmentId]

		assert = var_2

		var_2(var_6_1, "box_data_template not exist: " .. arg_6_0.attachmentId)

		if var_6_1.type == var_0_0.BoxAirStrike then
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
	local var_7_0 = false

	if arg_7_0.type == var_0_0.AchieveType4 or arg_7_0.type == var_0_0.AchieveType5 then
		var_7_0 = arg_7_0.count >= 1
	else
		var_7_0 = arg_7_0.count >= arg_7_0.config
	end

	return var_7_0
end

function var_0_0.GetAchieveDesc(arg_8_0, arg_8_1)
	local var_8_0 = false

	_ = var_1_10003

	if var_1_10003.detect(arg_8_1.achieves, function(arg_9_0)
		return arg_9_0.type == arg_8_0
	end).type == var_0_0.AchieveType1 then
		return "击破敌方旗舰"
	elseif var_3.type == var_0_0.AchieveType2 then
		string = var_4

		local var_8_1 = var_4.format
		local var_8_2 = "击破护卫舰队（%d/%d）"

		math = var_1_10006

		return var_8_1(var_8_2, var_1_10006.min(var_3.count, var_3.config), var_3.config)
	elseif var_3.type == var_0_0.AchieveType3 then
		return "击破所有敌舰"
	elseif var_3.type == var_0_0.AchieveType4 then
		string = var_4

		return var_4.format("出击人数不多于%d", var_3.config)
	elseif var_3.type == var_0_0.AchieveType5 then
		string = var_4

		local var_8_3 = var_4.format
		local var_8_4 = "出击舰娘不包含XX"

		ShipType = var_1_10006

		return var_8_3(var_8_4, var_1_10006.Type2Name(var_3.config))
	elseif var_3.type == var_0_0.AchieveType6 then
		return "Full Combo完成关卡"
	end

	return var_8_0
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
setmetatable = var_1
var_0_0.Status2Stg = var_1({}, {
	__index = function(arg_10_0, arg_10_1)
		pg = var_1_10002

		local var_10_0

		if not var_1_10002.chapter_status_effect[arg_10_1] or not var_2.strategy then
			var_10_0 = 0
		end

		return var_10_0 ~= 0 and var_10_0 or nil
	end
})
var_0_0.Buff2Stg = {}

local function var_0_1(arg_11_0, arg_11_1)
	if arg_11_1.buff_id == 0 then
		return
	end

	var_0_0.Buff2Stg[arg_11_1.buff_id] = arg_11_0

	return
end

ipairs = var_2
pg = var_3

for iter_0_0, iter_0_1 in var_2(var_3.strategy_data_template.all) do
	local var_0_2 = var_0_1
	local var_0_3 = iter_0_1

	pg = var_0_10009

	var_0_2(var_0_3, var_0_10009.strategy_data_template[iter_0_1])
end

var_0_0.HpGreen = 3000

function var_0_0.GetAmbushDisplay(arg_12_0)
	local var_12_0
	local var_12_1

	if not arg_12_0 then
		pg = var_1_10003
		var_12_0 = var_1_10003.gametip.ambush_display_0.tip
		Color = var_3
		var_12_1 = var_3.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	elseif arg_12_0 <= 0 then
		pg = var_3
		var_12_0 = var_3.gametip.ambush_display_1.tip
		Color = var_3
		var_12_1 = var_3.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif arg_12_0 < 0.1 then
		pg = var_3
		var_12_0 = var_3.gametip.ambush_display_2.tip
		Color = var_3
		var_12_1 = var_3.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif arg_12_0 < 0.2 then
		pg = var_3
		var_12_0 = var_3.gametip.ambush_display_3.tip
		Color = var_3
		var_12_1 = var_3.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif arg_12_0 < 0.33 then
		pg = var_3
		var_12_0 = var_3.gametip.ambush_display_4.tip
		Color = var_3
		var_12_1 = var_3.New(0.984313725490196, 0.788235294117647, 0.21568627450980393)
	elseif arg_12_0 < 0.5 then
		pg = var_3
		var_12_0 = var_3.gametip.ambush_display_5.tip
		Color = var_3
		var_12_1 = var_3.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	else
		pg = var_3
		var_12_0 = var_3.gametip.ambush_display_6.tip
		Color = var_3
		var_12_1 = var_3.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
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

local var_0_4 = "AirDominance"
local var_0_5 = {}
local var_0_6 = {}

pg = iter_0_0

local var_0_7 = iter_0_0.gametip.no_airspace_competition.tip

var_0_6.name = var_0_7
Color = var_0_7

local var_0_8 = var_0_7.New(1, 1, 1)

var_0_6.color = var_0_8
var_0_5[0] = var_0_6

local var_0_9 = {}

pg = var_0_8

local var_0_10 = var_0_8.strategy_data_template

pg = var_6

local var_0_11 = var_0_10[var_6.gameset.air_dominance_level_5.key_value].name

var_0_9.name = var_0_11
pg = var_0_11

local var_0_12 = var_0_11.gameset.air_dominance_level_5.key_value

var_0_9.StgId = var_0_12
Color = var_0_12

local var_0_13 = var_0_12.New(0.9921568627450981, 0.4, 0.39215686274509803)

var_0_9.color = var_0_13
var_0_5[1] = var_0_9

local var_0_14 = {}

pg = var_0_13

local var_0_15 = var_0_13.strategy_data_template

pg = var_6

local var_0_16 = var_0_15[var_6.gameset.air_dominance_level_4.key_value].name

var_0_14.name = var_0_16
pg = var_0_16

local var_0_17 = var_0_16.gameset.air_dominance_level_4.key_value

var_0_14.StgId = var_0_17
Color = var_0_17

local var_0_18 = var_0_17.New(0.9568627450980393, 0.5647058823529412, 0.34901960784313724)

var_0_14.color = var_0_18
var_0_5[2] = var_0_14

local var_0_19 = {}

pg = var_0_18

local var_0_20 = var_0_18.strategy_data_template

pg = var_6

local var_0_21 = var_0_20[var_6.gameset.air_dominance_level_3.key_value].name

var_0_19.name = var_0_21
pg = var_0_21

local var_0_22 = var_0_21.gameset.air_dominance_level_3.key_value

var_0_19.StgId = var_0_22
Color = var_0_22

local var_0_23 = var_0_22.New(0.9568627450980393, 0.8470588235294118, 0.23921568627450981)

var_0_19.color = var_0_23
var_0_5[3] = var_0_19

local var_0_24 = {}

pg = var_0_23

local var_0_25 = var_0_23.strategy_data_template

pg = var_6

local var_0_26 = var_0_25[var_6.gameset.air_dominance_level_2.key_value].name

var_0_24.name = var_0_26
pg = var_0_26

local var_0_27 = var_0_26.gameset.air_dominance_level_2.key_value

var_0_24.StgId = var_0_27
Color = var_0_27

local var_0_28 = var_0_27.New(0.7333333333333333, 0.7725490196078432, 0.2)

var_0_24.color = var_0_28
var_0_5[4] = var_0_24

local var_0_29 = {}

pg = var_0_28

local var_0_30 = var_0_28.strategy_data_template

pg = var_6

local var_0_31 = var_0_30[var_6.gameset.air_dominance_level_1.key_value].name

var_0_29.name = var_0_31
pg = var_0_31

local var_0_32 = var_0_31.gameset.air_dominance_level_1.key_value

var_0_29.StgId = var_0_32
Color = var_0_32

local var_0_33 = var_0_32.New(0.615686274509804, 0.9215686274509803, 0.14901960784313725)

var_0_29.color = var_0_33
var_0_5[5] = var_0_29
var_0_0[var_0_4] = var_0_5

function var_0_0.IsAtelierMap(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.getConfig(var_15_0, "on_activity")

	ActivityConst = var_15_0

	return var_15_1 == var_15_0.RYZA_MAP_ACT_ID
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
PlayerPrefs = var_2

if not var_2.GetInt("chapter_skip_battle") then
	local var_0_34 = 0
end

local var_0_35 = chapter_skip_battle

local function var_0_36()
	chapter_skip_battle = var_1_10000

	local var_16_0 = 1 - var_1_10000

	PlayerPrefs = chapter_skip_battle

	local var_16_1 = var_0.SetInt
	local var_16_2 = "chapter_skip_battle"

	chapter_skip_battle = var_1_10002

	var_16_1(var_16_2, var_1_10002)

	PlayerPrefs = var_16_1

	var_16_1.Save()

	pg = var_0

	local var_16_3 = var_0.TipsMgr.GetInstance()
	local var_16_4 = var_0.ShowTips

	chapter_skip_battle = var_1_10002

	var_16_4(var_16_3, var_1_10002 == 1 and "已开启战斗跳略" or "已关闭战斗跳略")

	return
end

local var_0_37 = switch_chapter_skip_battle

return var_0_0
