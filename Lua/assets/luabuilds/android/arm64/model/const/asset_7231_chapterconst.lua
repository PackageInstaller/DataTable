local ChapterConst = class("ChapterConst")

ChapterConst.ExitFromChapter = 0
ChapterConst.ExitFromMap = 1
ChapterConst.TypeLagacy = 1
ChapterConst.TypeRange = 2
ChapterConst.TypeTransport = 3
ChapterConst.TypeMainSub = 4
ChapterConst.TypeExtra = 5
ChapterConst.TypeSpHunt = 7
ChapterConst.TypeSpBomb = 8
ChapterConst.TypeDefence = 10
ChapterConst.TypeDOALink = 11
ChapterConst.TypeMultiStageBoss = 12
ChapterConst.TypeChapterSixteen = 13
ChapterConst.SubjectPlayer = 1
ChapterConst.SubjectChampion = 2
ChapterConst.MaxRow = 10
ChapterConst.MaxColumn = 20
ChapterConst.MaxStep = 10000
ChapterConst.AttachNone = 0
ChapterConst.AttachBorn = 1
ChapterConst.AttachBox = 2
ChapterConst.AttachSupply = 3
ChapterConst.AttachElite = 4
ChapterConst.AttachAmbush = 5
ChapterConst.AttachEnemy = 6
ChapterConst.AttachTorpedo_Enemy = 7
ChapterConst.AttachBoss = 8
ChapterConst.AttachStory = 9
ChapterConst.AttachAreaBoss = 11
ChapterConst.AttachChampion = 12
ChapterConst.AttachTorpedo_Fleet = 14
ChapterConst.AttachChampionPatrol = 15
ChapterConst.AttachBorn_Sub = 16
ChapterConst.AttachTransport = 17
ChapterConst.AttachTransport_Target = 18
ChapterConst.AttachChampionSub = 19
ChapterConst.AttachOni = 20
ChapterConst.AttachOni_Target = 21
ChapterConst.AttachBomb_Enemy = 24
ChapterConst.AttachBarrier = 25
ChapterConst.AttachHugeSupply = 26
ChapterConst.AttachLandbase = 100
ChapterConst.AttachEnemyTypes = {
	ChapterConst.AttachEnemy,
	ChapterConst.AttachAmbush,
	ChapterConst.AttachElite,
	ChapterConst.AttachBoss,
	ChapterConst.AttachAreaBoss,
	ChapterConst.AttachBomb_Enemy,
	ChapterConst.AttachChampion
}

function ChapterConst:IsEnemyAttach()
	return table.contains(ChapterConst.AttachEnemyTypes, self)
end

function ChapterConst:IsBossCell()
	if self.attachment == ChapterConst.AttachBoss then
		return true
	end

	if not ChapterConst.IsEnemyAttach(self.attachment) then
		return false
	end

	local var_2_0 = pg.expedition_data_template[self.attachmentId]

	if not pg.expedition_data_template[self.attachmentId] then
		return
	end

	return var_2_0.type == ChapterConst.ExpeditionTypeBoss or var_2_0.type == ChapterConst.ExpeditionTypeMulBoss
end

function ChapterConst:GetDestroyFX()
	if not pg.expedition_data_template[self.attachmentId] or pg.expedition_data_template[self.attachmentId].SLG_destroy_FX == "" then
		return "huoqiubaozha"
	else
		return pg.expedition_data_template[self.attachmentId].SLG_destroy_FX
	end

	return
end

ChapterConst.Story = 1
ChapterConst.StoryObstacle = 2
ChapterConst.StoryTrigger = 3
ChapterConst.EventTeleport = 4
ChapterConst.CellFlagActive = 0
ChapterConst.CellFlagDisabled = 1
ChapterConst.CellFlagAmbush = 2
ChapterConst.CellFlagTriggerActive = 3
ChapterConst.CellFlagTriggerDisabled = 4
ChapterConst.CellFlagDiving = 5
ChapterConst.EvtType_Poison = 1
ChapterConst.EvtType_AdditionalFloor = 2
ChapterConst.FlagBanaiAirStrike = 4
ChapterConst.FlagPoison = 5
ChapterConst.FlagLava = 10
ChapterConst.FlagNightmare = 9
ChapterConst.FlagMissleAiming = 12
ChapterConst.FlagWeatherNight = 101
ChapterConst.FlagWeatherFog = 102
ChapterConst.FlagWeatherFogVisible = 103
ChapterConst.ActType_Poison = 1
ChapterConst.ActType_SubmarineHunting = 2
ChapterConst.ActType_TargetDown = 3
ChapterConst.ActType_Expel = 4
ChapterConst.BoxBarrier = 0
ChapterConst.BoxDrop = 1
ChapterConst.BoxStrategy = 2
ChapterConst.BoxAirStrike = 4
ChapterConst.BoxEnemy = 5
ChapterConst.BoxSupply = 6
ChapterConst.BoxTorpedo = 7
ChapterConst.BoxBanaiDamage = 8
ChapterConst.BoxLavaDamage = 9
ChapterConst.LBIdle = 0
ChapterConst.LBCoastalGun = 1
ChapterConst.LBHarbor = 2
ChapterConst.LBDock = 3
ChapterConst.LBAntiAir = 4
ChapterConst.LBFogLightBase = 5
ChapterConst.LBIDAirport = 13
ChapterConst.RoundPlayer = 0
ChapterConst.RoundEnemy = 1
ChapterConst.AIEasy = 1
ChapterConst.AIStayAround = 2
ChapterConst.AIPatrol = 3
ChapterConst.AIProtect = 4
ChapterConst.AIDog = 5
ChapterConst.StgTypeForm = 1
ChapterConst.StgTypeConsume = 2
ChapterConst.StgTypeConst = 3
ChapterConst.StgTypePassive = 4
ChapterConst.StgTypeBindChapter = 5
ChapterConst.StgTypeBindFleetPassive = 6
ChapterConst.StgTypeBindSupportConsume = 7
ChapterConst.StgTypeStatus = 10
ChapterConst.StrategyAmmoRich = 10001
ChapterConst.StrategyAmmoPoor = 10002
ChapterConst.StrategyHuntingRange = -1
ChapterConst.StrategySubAutoAttack = -2
ChapterConst.StrategyFormSignleLine = 1
ChapterConst.StrategyFormDoubleLine = 2
ChapterConst.StrategyFormCircular = 3
ChapterConst.StrategyRepair = 4
ChapterConst.StrategyExchange = 9
ChapterConst.StrategyCallSubOutofRange = 10
ChapterConst.StrategySubTeleport = 11
ChapterConst.StrategySonarDetect = 12
ChapterConst.StrategyMissileStrike = 18
ChapterConst.StrategyAirSupport = 1000
ChapterConst.StrategyExpel = 1001
ChapterConst.StrategyAirSupportFoe = 94
ChapterConst.StrategyAirSupportFriendly = 95
ChapterConst.StrategyIntelligenceRecorded = 96
ChapterConst.StrategyBuffTypeNormal = 0
ChapterConst.StrategyBuffTypeOnlyBoss = 1
ChapterConst.StrategyForms = {
	ChapterConst.StrategyFormSignleLine,
	ChapterConst.StrategyFormDoubleLine,
	ChapterConst.StrategyFormCircular
}
ChapterConst.StrategyPresents = {
	ChapterConst.StrategyRepair
}
ChapterConst.QuadStateFrozen = 1
ChapterConst.QuadStateNormal = 2
ChapterConst.QuadStateBarrierSetting = 3
ChapterConst.QuadStateTeleportSub = 4
ChapterConst.QuadStateMissileStrike = 5
ChapterConst.QuadStateAirSuport = 6
ChapterConst.QuadStateExpel = 7
ChapterConst.PlaneName = "plane"
ChapterConst.LineCross = 2
ChapterConst.CellEaseOutAlpha = 0.01
ChapterConst.CellNormalColor = Color.white
ChapterConst.CellTargetColor = Color.green
ChapterConst.ChildItem = "item"
ChapterConst.ChildAttachment = "attachment"
ChapterConst.TraitNone = 0
ChapterConst.TraitLurk = 1
ChapterConst.TraitVirgin = 2

function ChapterConst:NeedMarkAsLurk()
	if self.flag ~= ChapterConst.CellFlagActive then
		return false
	end

	if self.attachment == ChapterConst.AttachBox then
		local var_4_0 = pg.box_data_template[self.attachmentId]

		assert(pg.box_data_template[self.attachmentId], "box_data_template not exist: " .. self.attachmentId)

		if var_4_0.type == ChapterConst.BoxStrategy and pg.strategy_data_template[var_4_0.effect_id].type == ChapterConst.StgTypeBindFleetPassive then
			return nil
		end

		return var_4_0.type == ChapterConst.BoxDrop or var_4_0.type == ChapterConst.BoxStrategy or var_4_0.type == ChapterConst.BoxSupply or var_4_0.type == ChapterConst.BoxEnemy
	elseif ChapterConst.IsBossCell(self) then
		return true
	elseif self.attachment == ChapterConst.AttachAmbush then
		return false
	elseif ChapterConst.IsEnemyAttach(self.attachment) then
		return true
	end

	return
end

function ChapterConst:NeedEasePathCell()
	if self.attachment == ChapterConst.AttachNone then
		return true
	elseif self.attachment == ChapterConst.AttachAmbush then
		if self.flag ~= ChapterConst.CellFlagActive then
			return true
		end
	elseif self.attachment == ChapterConst.AttachEnemy or self.attachment == ChapterConst.AttachElite then
		if self.flag == ChapterConst.CellFlagDisabled then
			return true
		end
	elseif self.attachment == ChapterConst.AttachSupply and self.attachmentId <= 0 then
		return true
	elseif self.attachment == ChapterConst.AttachBox then
		assert(pg.box_data_template[self.attachmentId], "box_data_template not exist: " .. self.attachmentId)

		if pg.box_data_template[self.attachmentId].type == ChapterConst.BoxAirStrike or pg.box_data_template[self.attachmentId].type == ChapterConst.BoxTorpedo then
			return true
		elseif (pg.box_data_template[self.attachmentId].type == ChapterConst.BoxDrop or pg.box_data_template[self.attachmentId].type == ChapterConst.BoxStrategy or pg.box_data_template[self.attachmentId].type == ChapterConst.BoxEnemy or pg.box_data_template[self.attachmentId].type == ChapterConst.BoxSupply) and self.flag == ChapterConst.CellFlagDisabled then
			return true
		end
	elseif self.attachment == ChapterConst.AttachStory then
		if self.flag ~= ChapterConst.CellFlagActive and (self.flag ~= ChapterConst.CellFlagTriggerActive or self.data ~= ChapterConst.StoryObstacle) then
			return true
		end
	elseif self.attachment == ChapterConst.AttachBarrier then
		return true
	end

	return false
end

function ChapterConst:NeedClearStep()
	if self.attachment == ChapterConst.AttachAmbush and self.flag == ChapterConst.CellFlagAmbush then
		return true
	end

	if self.attachment == ChapterConst.AttachBox then
		assert(pg.box_data_template[self.attachmentId], "box_data_template not exist: " .. self.attachmentId)

		if pg.box_data_template[self.attachmentId].type == ChapterConst.BoxAirStrike then
			return true
		end
	end

	return false
end

ChapterConst.AchieveType1 = 1
ChapterConst.AchieveType2 = 2
ChapterConst.AchieveType3 = 3
ChapterConst.AchieveType4 = 4
ChapterConst.AchieveType5 = 5
ChapterConst.AchieveType6 = 6

function ChapterConst:IsAchieved()
	return (self.type == ChapterConst.AchieveType4 or self.type == ChapterConst.AchieveType5) and self.count >= 1 or self.count >= self.config
end

function ChapterConst:GetAchieveDesc(arg_8_1)
	local var_8_0 = _.detect(arg_8_1.achieves, function(arg_9_0)
		return arg_9_0.type == self
	end)

	if var_8_0.type == ChapterConst.AchieveType1 then
		return "击破敌方旗舰"
	elseif var_8_0.type == ChapterConst.AchieveType2 then
		return string.format("击破护卫舰队（%d/%d）", math.min(var_8_0.count, var_8_0.config), var_8_0.config)
	elseif var_8_0.type == ChapterConst.AchieveType3 then
		return "击破所有敌舰"
	elseif var_8_0.type == ChapterConst.AchieveType4 then
		return string.format("出击人数不多于%d", var_8_0.config)
	elseif var_8_0.type == ChapterConst.AchieveType5 then
		return string.format("出击舰娘不包含XX", ShipType.Type2Name(var_8_0.config))
	elseif var_8_0.type == ChapterConst.AchieveType6 then
		return "Full Combo完成关卡"
	end

	return false
end

ChapterConst.OpRetreat = 0
ChapterConst.OpMove = 1
ChapterConst.OpBox = 2
ChapterConst.OpAmbush = 4
ChapterConst.OpStrategy = 5
ChapterConst.OpRepair = 6
ChapterConst.OpSupply = 7
ChapterConst.OpEnemyRound = 8
ChapterConst.OpSubState = 9
ChapterConst.OpStory = 10
ChapterConst.OpBarrier = 16
ChapterConst.OpSubTeleport = 19
ChapterConst.OpPreClear = 30
ChapterConst.OPSubStrike = 31
ChapterConst.OpRequest = 49
ChapterConst.OpSwitch = 98
ChapterConst.OpSkipBattle = 99
ChapterConst.DirtyAchieve = 1
ChapterConst.DirtyFleet = 2
ChapterConst.DirtyAttachment = 4
ChapterConst.DirtyStrategy = 8
ChapterConst.DirtyChampion = 16
ChapterConst.DirtyAutoAction = 32
ChapterConst.DirtyCellFlag = 64
ChapterConst.DirtyBase = 128
ChapterConst.DirtyChampionPosition = 256
ChapterConst.DirtyFloatItems = 512
ChapterConst.DirtyWeather = 1024
ChapterConst.KizunaJammingEngage = 1
ChapterConst.KizunaJammingDodge = 2
ChapterConst.StatusDay = 3
ChapterConst.StatusNight = 4
ChapterConst.StatusAirportOutControl = 5
ChapterConst.StatusAirportUnderControl = 6
ChapterConst.StatusSunrise = 7
ChapterConst.StatusSunset = 8
ChapterConst.StatusMaze1 = 9
ChapterConst.StatusMaze2 = 10
ChapterConst.StatusMaze3 = 11
ChapterConst.StatusDPM_KASTHA_FOE = 12
ChapterConst.StatusDPM_KASTHA_FRIEND = 13
ChapterConst.StatusDPM_PANYIA_FOE = 14
ChapterConst.StatusDPM_PANYIA_FRIEND = 15
ChapterConst.StatusDPM_MRD_FOE = 16
ChapterConst.StatusDPM_MRD_FRIEND = 17
ChapterConst.StatusDPM_VITA_FOE = 18
ChapterConst.StatusDPM_VITA_FRIEND = 19
ChapterConst.StatusLIGHTHOUSEACTIVE = 20
ChapterConst.StatusSSSSSyberSquadSupportIdle = 21
ChapterConst.StatusSSSSSyberSquadSupportActive = 22
ChapterConst.StatusSSSSKaijuSupportIdle = 23
ChapterConst.StatusSSSSKaijuSupportActive = 24
ChapterConst.StatusMissile1 = 30
ChapterConst.StatusMissile2 = 31
ChapterConst.StatusMissile3 = 32
ChapterConst.StatusMissileInit = 33
ChapterConst.StatusMissile1B = 34
ChapterConst.StatusMissile2B = 35
ChapterConst.StatusMissile3B = 36
ChapterConst.StatusMissileInitB = 37
ChapterConst.StatusMaoxiv3 = 38
ChapterConst.StatusGonghai = 39
ChapterConst.StatusGonghai = 40
ChapterConst.StatusGonghai = 41
ChapterConst.StatusMusashiGame1 = 42
ChapterConst.StatusMusashiGame2 = 43
ChapterConst.StatusMusashiGame3 = 44
ChapterConst.StatusMusashiGame4 = 45
ChapterConst.StatusMusashiGame5 = 46
ChapterConst.StatusMusashiGame6 = 47
ChapterConst.StatusMusashiGame7 = 48
ChapterConst.StatusMusashiGame8 = 49
ChapterConst.StatusSupportSubmarineFinish = 104
ChapterConst.Status2Stg = setmetatable({}, {
	__index = function(arg_10_0, arg_10_1)
		local var_10_0

		if pg.chapter_status_effect[arg_10_1] then
			var_10_0 = pg.chapter_status_effect[arg_10_1].strategy or 0
		end

		return var_10_0 ~= 0 and var_10_0 or nil
	end
})
ChapterConst.Buff2Stg = {}

local function var_0_1(arg_11_0, arg_11_1)
	if arg_11_1.buff_id == 0 then
		return
	end

	ChapterConst.Buff2Stg[arg_11_1.buff_id] = arg_11_0

	return
end

for iter_0_0, iter_0_1 in ipairs(pg.strategy_data_template.all) do
	var_0_1(iter_0_1, pg.strategy_data_template[iter_0_1])
end

ChapterConst.HpGreen = 3000

function ChapterConst:GetAmbushDisplay()
	local var_12_0
	local var_12_1

	if not self then
		var_12_0 = pg.gametip.ambush_display_0.tip
		var_12_1 = Color.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	elseif self <= 0 then
		var_12_0 = pg.gametip.ambush_display_1.tip
		var_12_1 = Color.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif self < 0.1 then
		var_12_0 = pg.gametip.ambush_display_2.tip
		var_12_1 = Color.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif self < 0.2 then
		var_12_0 = pg.gametip.ambush_display_3.tip
		var_12_1 = Color.New(0.6627450980392157, 0.9607843137254902, 0.2823529411764706)
	elseif self < 0.33 then
		var_12_0 = pg.gametip.ambush_display_4.tip
		var_12_1 = Color.New(0.984313725490196, 0.788235294117647, 0.21568627450980393)
	elseif self < 0.5 then
		var_12_0 = pg.gametip.ambush_display_5.tip
		var_12_1 = Color.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	else
		var_12_0 = pg.gametip.ambush_display_6.tip
		var_12_1 = Color.New(0.9607843137254902, 0.3764705882352941, 0.2823529411764706)
	end

	return var_12_0, var_12_1
end

ChapterConst.ShipMoveAction = "move"
ChapterConst.ShipIdleAction = "normal"
ChapterConst.ShipSwimAction = "swim"
ChapterConst.ShipStepDuration = 0.5
ChapterConst.ShipStepQuickPlayScale = 0.5
ChapterConst.ShipMoveTailLength = 2

function ChapterConst.GetRepairParams()
	return 1, 3, 100
end

function ChapterConst.GetShamRepairParams()
	return 1, 3, 100
end

ChapterConst.AmmoRich = 4
ChapterConst.AmmoPoor = 0
ChapterConst.ExpeditionAILair = 6
ChapterConst.ExpeditionTypeMulBoss = 94
ChapterConst.ExpeditionTypeUnTouchable = 97
ChapterConst.ExpeditionTypeBoss = 99
ChapterConst.EnemySize = {
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
ChapterConst.EnemyPreference = {
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
ChapterConst.ShamMoneyItem = 59900
ChapterConst.MarkHuntingRange = 1
ChapterConst.MarkBomb = 2
ChapterConst.MarkCoastalGun = 3
ChapterConst.MarkEscapeGrid = 4
ChapterConst.MarkBanaiAirStrike = 5
ChapterConst.MarkMovePathArrow = 6
ChapterConst.MarkLava = 7
ChapterConst.MarkHideNight = 8
ChapterConst.MarkNightMare = 9
ChapterConst.ReasonVictory = 1
ChapterConst.ReasonDefeat = 2
ChapterConst.ReasonVictoryOni = 3
ChapterConst.ReasonDefeatOni = 4
ChapterConst.ReasonDefeatBomb = 5
ChapterConst.ReasonOutTime = 8
ChapterConst.ReasonActivityOutTime = 9
ChapterConst.ReasonDefeatDefense = 10
ChapterConst.ForbiddenNone = 0
ChapterConst.ForbiddenRight = 1
ChapterConst.ForbiddenLeft = 2
ChapterConst.ForbiddenDown = 4
ChapterConst.ForbiddenUp = 8
ChapterConst.ForbiddenRow = 3
ChapterConst.ForbiddenColumn = 12
ChapterConst.ForbiddenAll = 15
ChapterConst.PriorityPerRow = 100
ChapterConst.PriorityMin = -10000
ChapterConst.CellPriorityNone = 0 + ChapterConst.PriorityMin
ChapterConst.CellPriorityAttachment = 1 + ChapterConst.PriorityMin
ChapterConst.CellPriorityLittle = 2 + ChapterConst.PriorityMin
ChapterConst.CellPriorityEnemy = 3 + ChapterConst.PriorityMin
ChapterConst.CellPriorityFleet = 3 + ChapterConst.PriorityMin
ChapterConst.CellPriorityUpperEffect = 5 + ChapterConst.PriorityMin
ChapterConst.CellPriorityTopMark = 6 + ChapterConst.PriorityMin
ChapterConst.PriorityMax = 16 + ChapterConst.PriorityMin
ChapterConst.LayerWeightMap = -999
ChapterConst.LayerWeightMapAnimation = ChapterConst.LayerWeightMap + 1
ChapterConst.TemplateChampion = "tpl_champion"
ChapterConst.TemplateEnemy = "tpl_enemy"
ChapterConst.TemplateOni = "tpl_oni"
ChapterConst.TemplateFleet = "tpl_ship"
ChapterConst.TemplateSub = "tpl_sub"
ChapterConst.TemplateTransport = "tpl_transport"
ChapterConst.AirDominanceStrategyBuffType = 1001
ChapterConst.AirDominance = {
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

function ChapterConst:IsAtelierMap()
	return self:getConfig("on_activity") == ActivityConst.RYZA_MAP_ACT_ID
end

ChapterConst.AUTOFIGHT_STOP_REASON = {
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

function ChapterConst:GetActivityIDByReChapterID()
	for iter_17_0, iter_17_1 in ipairs(pg.re_map_template.all) do
		if table.contains(pg.re_map_template[iter_17_1].config_data, chapterID) then
			return pg.re_map_template[iter_17_1].activity_id
		end
	end

	return 0
end

return ChapterConst
