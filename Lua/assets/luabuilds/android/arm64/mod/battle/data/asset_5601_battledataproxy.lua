ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleEvent
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleConst
local var_0_4 = ys.Battle.BattleConfig
local var_0_5 = ys.Battle.BattleDataFunction
local var_0_6 = ys.Battle.BattleAttr
local var_0_7 = ys.Battle.BattleVariable
local var_0_8 = ys.Battle.BattleCardPuzzleEvent
local var_0_9 = singletonClass("BattleDataProxy", ys.MVC.Proxy)

ys.Battle.BattleDataProxy = var_0_9
var_0_9.__name = "BattleDataProxy"

function var_0_9.Ctor(arg_1_0)
	var_0_9.super.Ctor(arg_1_0)

	return
end

function var_0_9:InitBattle(arg_2_1)
	self.Update = self.updateInit

	local var_2_0 = arg_2_1.battleType == SYSTEM_WORLD or arg_2_1.battleType == SYSTEM_WORLD_BOSS
	local var_2_1 = pg.SdkMgr.GetInstance():CheckPretest()

	if var_2_1 then
		var_2_1 = (PlayerPrefs.GetInt("stage_scratch") or 0) == 1

		local var_2_2

		if var_2_1 then
			var_2_2 = GodenFnger or var_0_2.CreateContextCalculateDamage(var_2_0)
		end
	end

	self:SetupCalculateDamage(var_2_2)
	self:SetupDamageKamikazeAir()
	self:SetupDamageKamikazeShip()
	self:SetupDamageCrush()
	var_0_7.Init()
	self:InitData(arg_2_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.STAGE_DATA_INIT_FINISH))
	self._cameraUtil:Initialize()

	self._cameraTop, self._cameraBottom, self._cameraLeft, self._cameraRight = self._cameraUtil:SetMapData(self:GetTotalBounds())

	self:InitWeatherData()
	self:InitUserShipsData(self._battleInitData.MainUnitList, self._battleInitData.VanguardUnitList, var_0_4.FRIENDLY_CODE, self._battleInitData.SubUnitList)
	self:InitUserSupportShipsData(var_0_4.FRIENDLY_CODE, self._battleInitData.SupportUnitList)
	self:InitUserAidData()
	self:SetSubmarinAidData()
	self._cameraUtil:SetFocusFleet(self:GetFleetByIFF(var_0_4.FRIENDLY_CODE))
	self:StatisticsInit(self._fleetList[var_0_4.FRIENDLY_CODE]:GetUnitList())
	self:SetFlagShipID(self:GetFleetByIFF(var_0_4.FRIENDLY_CODE):GetFlagShip())
	self:DispatchEvent(var_0_0.Event.New(var_0_1.COMMON_DATA_INIT_FINISH, {}))

	return
end

function var_0_9:OnCameraRatioUpdate()
	self._cameraTop, self._cameraBottom, self._cameraLeft, self._cameraRight = self._cameraUtil:SetMapData(self:GetTotalBounds())

	self._cameraUtil:setArrowPoint()

	return
end

function var_0_9.Start(arg_4_0)
	arg_4_0._startTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_9:TriggerBattleInitBuffs()
	for iter_5_0, iter_5_1 in pairs(self._fleetList) do
		local var_5_0 = iter_5_1:GetUnitList()

		iter_5_1:FleetBuffTrigger(var_0_3.BuffEffectType.ON_INIT_GAME)
	end

	return
end

function var_0_9:TirggerBattleStartBuffs()
	for iter_6_0, iter_6_1 in pairs(self._fleetList) do
		local var_6_0 = iter_6_1:GetUnitList()
		local var_6_1 = iter_6_1:GetScoutList()
		local var_6_2 = var_6_1[1]
		local var_6_3

		if #var_6_1 > 1 then
			var_6_3 = var_6_1[#var_6_1] or nil

			local var_6_4

			if #var_6_1 == 3 then
				var_6_4 = var_6_1[2] or nil
			end
		end

		local var_6_5 = iter_6_1:GetMainList()

		for iter_6_2, iter_6_3 in ipairs(var_6_0) do
			underscore.each(self._battleInitData.ChapterBuffIDs or {}, function(arg_7_0)
				iter_6_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(arg_7_0)))

				return
			end)
			underscore.each(self._battleInitData.GlobalBuffIDs or {}, function(arg_8_0)
				arg_8_0 = tonumber(arg_8_0)

				iter_6_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(arg_8_0)))

				return
			end)

			if self._battleInitData.MapAuraSkills then
				for iter_6_4, iter_6_5 in ipairs(self._battleInitData.MapAuraSkills) do
					iter_6_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_6_5.id, iter_6_5.level)))
				end
			end

			if self._battleInitData.MapAidSkills then
				for iter_6_6, iter_6_7 in ipairs(self._battleInitData.MapAidSkills) do
					iter_6_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_6_7.id, iter_6_7.level)))
				end
			end

			if self._currentStageData.stageBuff then
				for iter_6_8, iter_6_9 in ipairs(self._currentStageData.stageBuff) do
					iter_6_3:AddBuff((var_0_0.Battle.BattleBuffUnit.New(iter_6_9.id, iter_6_9.level)))
				end
			end

			iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_START_GAME)

			if iter_6_3 == var_6_5[1] then
				iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_FLAG_SHIP)
			elseif iter_6_3 == var_6_5[2] then
				iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_UPPER_CONSORT)
			elseif iter_6_3 == var_6_5[3] then
				iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_LOWER_CONSORT)
			elseif iter_6_3 == var_6_2 then
				iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_LEADER)
			elseif iter_6_3 == var_6_4 then
				iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_CENTER)
			elseif iter_6_3 == var_6_3 then
				iter_6_3:TriggerBuff(var_0_3.BuffEffectType.ON_REAR)
			end
		end

		for iter_6_10, iter_6_11 in ipairs((iter_6_1:GetSupportUnitList())) do
			underscore.each(self._battleInitData.ChapterBuffIDs or {}, function(arg_9_0)
				local var_9_0 = var_0_5.GetSLGStrategyBuffByCombatBuffID(arg_9_0)

				if var_9_0 and var_9_0.type == ChapterConst.AirDominanceStrategyBuffType then
					iter_6_11:AddBuff((var_0_0.Battle.BattleBuffUnit.New(arg_9_0)))
				end

				return
			end)
		end
	end

	return
end

function var_0_9:InitAllFleetUnitsWeaponCD()
	for iter_10_0, iter_10_1 in pairs(self._fleetList) do
		for iter_10_2, iter_10_3 in ipairs((iter_10_1:GetUnitList())) do
			var_0_9.InitUnitWeaponCD(iter_10_3)
		end
	end

	return
end

function var_0_9:InitUnitWeaponCD()
	self:CheckWeaponInitial()

	return
end

function var_0_9:StartCardPuzzle()
	for iter_12_0, iter_12_1 in pairs(self._fleetList) do
		iter_12_1:GetCardPuzzleComponent():Start()
	end

	return
end

function var_0_9:PausePuzzleComponent()
	for iter_13_0, iter_13_1 in pairs(self._fleetList) do
		local var_13_0 = iter_13_1:GetCardPuzzleComponent()

		if var_13_0 then
			var_13_0:BlockComponentByCard(true)
		end
	end

	return
end

function var_0_9.ResumePuzzleComponent(arg_14_0)
	onDelayTick(function()
		for iter_15_0, iter_15_1 in pairs(arg_14_0._fleetList) do
			local var_15_0 = iter_15_1:GetCardPuzzleComponent()

			if var_15_0 then
				var_15_0:BlockComponentByCard(false)
			end
		end

		return
	end, 0.06)

	return
end

function var_0_9:GetInitData()
	return self._battleInitData
end

function var_0_9:GetDungeonData()
	return self._dungeonInfo
end

function var_0_9:InitData(arg_18_1)
	self.FrameIndex = 1
	self._friendlyCode = 1
	self._foeCode = -1
	var_0_3.FRIENDLY_CODE = 1
	var_0_3.FOE_CODE = -1
	self._completelyRepress = false
	self._repressReduce = 1
	self._repressLevel = 0
	self._repressEnemyHpRant = 1
	self._friendlyShipList = {}
	self._foeShipList = {}
	self._friendlyAircraftList = {}
	self._foeAircraftList = {}
	self._minionShipList = {}
	self._spectreShipList = {}
	self._fleetList = {}
	self._freeShipList = {}
	self._teamList = {}
	self._waveSummonList = {}
	self._aidUnitList = {}
	self._unitList = {}
	self._unitCount = 0
	self._bulletList = {}
	self._bulletCount = 0
	self._aircraftList = {}
	self._aircraftCount = 0
	self._AOEList = {}
	self._AOECount = 0
	self._wallList = {}
	self._wallIndex = 0
	self._shelterList = {}
	self._shelterIndex = 0
	self._environmentList = {}
	self._environmentIndex = 0
	self._deadUnitList = {}
	self._enemySubmarineCount = 0
	self._airFighterList = {}
	self._currentStageIndex = 1
	self._battleInitData = arg_18_1
	self._expeditionID = arg_18_1.StageTmpId
	self._expeditionTmp = pg.expedition_data_template[self._expeditionID]

	self:SetDungeonLevel(arg_18_1.WorldLevel or self._expeditionTmp.level)

	self._dungeonID = self._expeditionTmp.dungeon_id
	self._dungeonInfo = var_0_5.GetDungeonTmpDataByID(self._dungeonID)

	if arg_18_1.WorldMapId then
		self._mapId = arg_18_1.WorldMapId
	elseif self._expeditionTmp.map_id then
		if #self._expeditionTmp.map_id == 1 then
			self._mapId = self._expeditionTmp.map_id[1][1]
		else
			local var_18_0 = {}

			for iter_18_0, iter_18_1 in ipairs(self._expeditionTmp.map_id) do
				table.insert(var_18_0, {
					rst = iter_18_1[1],
					weight = iter_18_1[2] * 100
				})
			end

			self._mapId = var_0_2.WeightRandom(var_18_0)
		end
	end

	self._weahter = arg_18_1.ChapterWeatherIDS or {}
	self._exposeSpeed = self._expeditionTmp.expose_speed
	self._airExpose = self._expeditionTmp.aircraft_expose[1]
	self._airExposeEX = self._expeditionTmp.aircraft_expose[2]
	self._shipExpose = self._expeditionTmp.ship_expose[1]
	self._shipExposeEX = self._expeditionTmp.ship_expose[2]
	self._commander = arg_18_1.CommanderList or {}
	self._subCommander = arg_18_1.SubCommanderList or {}
	self._commanderBuff = self.initCommanderBuff(self._commander)
	self._subCommanderBuff = self.initCommanderBuff(self._subCommander)

	if self._battleInitData.RepressInfo then
		if self._battleInitData.battleType == SYSTEM_SCENARIO then
			if self._battleInitData.RepressInfo.repressCount >= self._battleInitData.RepressInfo.repressMax then
				self._completelyRepress = true
			end

			self._repressReduce = var_0_2.ChapterRepressReduce(self._battleInitData.RepressInfo.repressReduce)
			self._repressLevel = self._battleInitData.RepressInfo.repressLevel
			self._repressEnemyHpRant = self._battleInitData.RepressInfo.repressEnemyHpRant
		elseif self._battleInitData.battleType == SYSTEM_WORLD or self._battleInitData.battleType == SYSTEM_WORLD_BOSS then
			self._repressEnemyHpRant = self._battleInitData.RepressInfo.repressEnemyHpRant
		end
	end

	self._chapterWinningStreak = self._battleInitData.DefeatCount or 0
	self._waveFlags = table.shallowCopy(arg_18_1.StageWaveFlags) or {}

	self:InitStageData()

	self._cldSystem = var_0_0.Battle.BattleCldSystem.New(self)
	self._cameraUtil = var_0_0.Battle.BattleCameraUtil.GetInstance()

	self:initBGM()

	return
end

function var_0_9:initBGM()
	self._initBGMList = {}
	self._otherBGMList = {}

	local var_19_0 = {}
	local var_19_1 = {}

	local function var_19_2(arg_20_0)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			local var_20_0 = {}

			if iter_20_1.skills then
				for iter_20_2, iter_20_3 in ipairs(iter_20_1.skills) do
					table.insert(var_20_0, iter_20_3)
				end
			end

			if iter_20_1.equipment then
				for iter_20_4, iter_20_5 in ipairs((var_0_5.GetEquipSkill(iter_20_1.equipment, self._battleInitData.battleType))) do
					var_20_0[iter_20_5.buffID] = {
						id = iter_20_5.buffID,
						level = iter_20_5.buffLV
					}
				end
			end

			local var_20_1 = var_0_5.GetSongList(var_20_0)

			for iter_20_6, iter_20_7 in pairs(var_20_1.initList) do
				var_19_0[iter_20_6] = true
			end

			for iter_20_8, iter_20_9 in pairs(var_20_1.otherList) do
				var_19_1[iter_20_8] = true
			end
		end

		return
	end

	var_19_2(self._battleInitData.MainUnitList)
	var_19_2(self._battleInitData.VanguardUnitList)
	var_19_2(self._battleInitData.SubUnitList)

	if self._battleInitData.RivalMainUnitList then
		var_19_2(self._battleInitData.RivalMainUnitList)
	end

	if self._battleInitData.RivalVanguardUnitList then
		var_19_2(self._battleInitData.RivalVanguardUnitList)
	end

	for iter_19_0, iter_19_1 in pairs(var_19_0) do
		table.insert(self._initBGMList, iter_19_0)
	end

	for iter_19_2, iter_19_3 in pairs(var_19_1) do
		table.insert(self._otherBGMList, iter_19_2)
	end

	return
end

function var_0_9.initCommanderBuff(arg_21_0)
	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
		local var_21_1 = iter_21_1[1]:getSkills()[1]:getLevel()

		for iter_21_2, iter_21_3 in ipairs(iter_21_1[2]) do
			table.insert(var_21_0, {
				id = iter_21_3,
				level = var_21_1,
				commander = iter_21_1[1]
			})
		end
	end

	return var_21_0
end

function var_0_9:Clear()
	for iter_22_0, iter_22_1 in pairs(self._teamList) do
		self:KillNPCTeam(iter_22_1)
	end

	self._teamList = nil

	for iter_22_2, iter_22_3 in pairs(self._bulletList) do
		self:RemoveBulletUnit(iter_22_2)
	end

	self._bulletList = nil

	for iter_22_4, iter_22_5 in pairs(self._unitList) do
		self:KillUnit(iter_22_4)
	end

	self._unitList = nil

	for iter_22_6, iter_22_7 in ipairs(self._deadUnitList) do
		iter_22_7:Dispose()
	end

	self._deadUnitList = nil

	for iter_22_8, iter_22_9 in pairs(self._aircraftList) do
		self:KillAircraft(iter_22_8)
	end

	self._aircraftList = nil

	for iter_22_10, iter_22_11 in pairs(self._fleetList) do
		iter_22_11:Dispose()

		self._fleetList[iter_22_10] = nil
	end

	self._fleetList = nil

	for iter_22_12, iter_22_13 in pairs(self._aidUnitList) do
		iter_22_13:Dispose()
	end

	self._aidUnitList = nil

	for iter_22_14, iter_22_15 in pairs(self._environmentList) do
		self:RemoveEnvironment(iter_22_15:GetUniqueID())
	end

	self._environmentList = nil

	for iter_22_16, iter_22_17 in pairs(self._AOEList) do
		self:RemoveAreaOfEffect(iter_22_16)
	end

	self._AOEList = nil

	self._cldSystem:Dispose()

	self._cldSystem = nil
	self._dungeonInfo = nil
	self._flagShipUnit = nil
	self._friendlyShipList = nil
	self._foeShipList = nil
	self._spectreShipList = nil
	self._friendlyAircraftList = nil
	self._foeAircraftList = nil
	self._fleetList = nil
	self._freeShipList = nil
	self._countDown = nil
	self._lastUpdateTime = nil
	self._statistics = nil
	self._battleInitData = nil
	self._currentStageData = nil

	self:ClearFormulas()
	var_0_5.ClearDungeonCfg(self._dungeonID)

	return
end

function var_0_9:DeactiveProxy()
	self._state = nil

	self:Clear()
	var_0_0.Battle.BattleDataProxy.super.DeactiveProxy(self)

	return
end

function var_0_9:InitUserShipsData(arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		local var_24_0 = self:SpawnVanguard(iter_24_1, arg_24_3)
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_1) do
		local var_24_1 = self:SpawnMain(iter_24_3, arg_24_3)
	end

	local var_24_2 = self:GetFleetByIFF(arg_24_3)

	var_24_2:FleetUnitSpwanFinish()

	if self._battleInitData.battleType == SYSTEM_SUBMARINE_RUN or self._battleInitData.battleType == SYSTEM_SUB_ROUTINE then
		for iter_24_4, iter_24_5 in ipairs(arg_24_4) do
			self:SpawnManualSub(iter_24_5, arg_24_3)
		end

		var_24_2:ShiftManualSub()
	else
		var_24_2:SetSubUnitData(arg_24_4)
	end

	if self._battleInitData.battleType == SYSTEM_DUEL then
		for iter_24_6, iter_24_7 in ipairs(var_24_2:GetCloakList()) do
			iter_24_7:GetCloak():SetRecoverySpeed(0)
		end
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_FLEET, {
		fleetVO = var_24_2
	}))

	return
end

function var_0_9:InitUserSupportShipsData(arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
		if table.contains(ShipType.BundleList.hang, var_0_5.GetPlayerShipTmpDataFromID(iter_25_1.tmpID).type) then
			local var_25_0 = self:SpawnSupportUnit(iter_25_1, arg_25_1)
		end
	end

	return
end

function var_0_9:InitUserAidData()
	for iter_26_0, iter_26_1 in ipairs(self._battleInitData.AidUnitList) do
		local var_26_0 = self:GenerateUnitID()

		iter_26_1.properties.level = iter_26_1.level
		iter_26_1.properties.formationID = var_0_4.FORMATION_ID
		iter_26_1.properties.id = iter_26_1.id

		var_0_2.AttrFixer(self._battleInitData.battleType, iter_26_1.properties)

		local var_26_1 = var_0_5.CreateBattleUnitData(var_26_0, var_0_3.UnitType.PLAYER_UNIT, var_0_4.FRIENDLY_CODE, iter_26_1.tmpID, iter_26_1.skinId, iter_26_1.equipment, iter_26_1.properties, iter_26_1.baseProperties, iter_26_1.proficiency or {
			1,
			1,
			1
		}, iter_26_1.baseList, iter_26_1.preloasList)

		self._aidUnitList[var_26_1:GetUniqueID()] = var_26_1
	end

	return
end

function var_0_9:SetSubmarinAidData()
	self:GetFleetByIFF(var_0_4.FRIENDLY_CODE):SetSubAidData(self._battleInitData.TotalSubAmmo, self._battleInitData.SubFlag)

	return
end

function var_0_9:AddWeather(arg_28_1)
	table.insert(self._weahter, arg_28_1)
	self:InitWeatherData()

	return
end

function var_0_9:InitWeatherData()
	for iter_29_0, iter_29_1 in ipairs(self._weahter) do
		if iter_29_1 == var_0_3.WEATHER.NIGHT then
			for iter_29_2, iter_29_3 in pairs(self._fleetList) do
				iter_29_3:AttachNightCloak()
			end

			for iter_29_4, iter_29_5 in pairs(self._unitList) do
				var_0_5.AttachWeather(iter_29_5, self._weahter)
			end
		end
	end

	return
end

function var_0_9:CelebrateVictory(arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_1 == self:GetFoeCode() and self._foeShipList or self._friendlyShipList) do
		iter_30_1:StateChange(var_0_0.Battle.UnitState.STATE_VICTORY)
	end

	return
end

function var_0_9:InitStageData()
	self._currentStageData = self._dungeonInfo.stages[self._currentStageIndex]
	self._countDown = self._currentStageData.timeCount
	self._totalLeftBound = self._currentStageData.totalArea[1]
	self._totalRightBound = self._currentStageData.totalArea[1] + self._currentStageData.totalArea[3]
	self._totalUpperBound = self._currentStageData.totalArea[2] + self._currentStageData.totalArea[4]
	self._totalLowerBound = self._currentStageData.totalArea[2]
	self._leftZoneLeftBound = self._currentStageData.playerArea[1]
	self._leftZoneRightBound = self._currentStageData.playerArea[1] + self._currentStageData.playerArea[3]
	self._leftZoneUpperBound = self._currentStageData.playerArea[2] + self._currentStageData.playerArea[4]
	self._leftZoneLowerBound = self._currentStageData.playerArea[2]
	self._rightZoneLeftBound = self._leftZoneRightBound
	self._rightZoneRightBound = self._totalRightBound
	self._rightZoneUpperBound = self._leftZoneUpperBound
	self._rightZoneLowerBound = self._leftZoneLowerBound
	self._bulletUpperBound = self._totalUpperBound + 3
	self._bulletLowerBound = self._totalLowerBound - 10
	self._bulletLeftBound = self._totalLeftBound - 10
	self._bulletRightBound = self._totalRightBound + 10
	self._bulletUpperBoundVision = self._totalUpperBound + var_0_4.BULLET_UPPER_BOUND_VISION_OFFSET
	self._bulletLowerBoundSplit = self._bulletLowerBound + var_0_4.BULLET_LOWER_BOUND_SPLIT_OFFSET
	self._bulletLeftBoundSplit = self._bulletLeftBound + var_0_4.BULLET_LEFT_BOUND_SPLIT_OFFSET

	if self._battleInitData.battleType == SYSTEM_DUEL then
		self._leftFieldBound = self._totalLeftBound
		self._rightFieldBound = self._totalRightBound
	else
		self._leftFieldBound = (self._currentStageData.mainUnitPosition and self._currentStageData.mainUnitPosition[var_0_4.FRIENDLY_CODE] and self._currentStageData.mainUnitPosition[var_0_4.FRIENDLY_CODE][1].x or var_0_4.MAIN_UNIT_POS[var_0_4.FRIENDLY_CODE][1].x) - 1
		self._rightFieldBound = self._totalRightBound + var_0_4.FIELD_RIGHT_BOUND_BIAS
	end

	return
end

function var_0_9:GetVanguardBornCoordinate(arg_32_1)
	if arg_32_1 == var_0_4.FRIENDLY_CODE then
		return self._currentStageData.fleetCorrdinate
	elseif arg_32_1 == var_0_4.FOE_CODE then
		return self._currentStageData.rivalCorrdinate
	end

	return
end

function var_0_9:GetTotalBounds()
	return self._totalUpperBound, self._totalLowerBound, self._totalLeftBound, self._totalRightBound
end

function var_0_9:GetTotalRightBound()
	return self._totalRightBound
end

function var_0_9:GetTotalLowerBound()
	return self._totalLowerBound
end

function var_0_9:GetUnitBoundByIFF(arg_36_1)
	if arg_36_1 == var_0_4.FRIENDLY_CODE then
		return self._leftZoneUpperBound, self._leftZoneLowerBound, self._leftZoneLeftBound, var_0_4.MaxRight, var_0_4.MaxLeft, self._leftZoneRightBound
	elseif arg_36_1 == var_0_4.FOE_CODE then
		return self._rightZoneUpperBound, self._rightZoneLowerBound, self._rightZoneLeftBound, self._rightZoneRightBound, self._rightZoneLeftBound, var_0_4.MaxRight
	end

	return
end

function var_0_9:GetFleetBoundByIFF(arg_37_1)
	if arg_37_1 == var_0_4.FRIENDLY_CODE then
		return self._leftZoneUpperBound, self._leftZoneLowerBound, self._leftZoneLeftBound, self._leftZoneRightBound
	elseif arg_37_1 == var_0_4.FOE_CODE then
		return self._rightZoneUpperBound, self._rightZoneLowerBound, self._rightZoneLeftBound, self._rightZoneRightBound
	end

	return
end

function var_0_9:ShiftFleetBound(arg_38_1, arg_38_2)
	arg_38_1:GetUnitBound():SwtichDuelAggressive()
	arg_38_1:SetAutobotBound(self:GetFleetBoundByIFF(arg_38_2))
	arg_38_1:UpdateScoutUnitBound()

	return
end

function var_0_9:GetFieldBound()
	if self._battleInitData and self._battleInitData.battleType == SYSTEM_DUEL then
		return self:GetTotalBounds()
	else
		return self._totalUpperBound, self._totalLowerBound, self._leftFieldBound, self._rightFieldBound
	end

	return
end

function var_0_9:GetFleetByIFF(arg_40_1)
	if self._fleetList[arg_40_1] == nil then
		local var_40_0 = var_0_0.Battle.BattleFleetVO.New(arg_40_1)

		self._fleetList[arg_40_1] = var_40_0

		var_40_0:SetAutobotBound(self:GetFleetBoundByIFF(arg_40_1))
		var_40_0:SetTotalBound(self:GetTotalBounds())
		var_40_0:SetUnitBound(self._currentStageData.totalArea, self._currentStageData.playerArea)
		var_40_0:SetExposeLine(self._expeditionTmp.horizon_line[arg_40_1], self._expeditionTmp.expose_line[arg_40_1])
		var_40_0:CalcSubmarineBaseLine(self._battleInitData.battleType)
		var_40_0:SetChapterPlayType(self._battleInitData.ChapterType)

		if self._battleInitData.battleType == SYSTEM_CARDPUZZLE then
			local var_40_1 = var_40_0:AttachCardPuzzleComponent()

			var_40_1:InitCardPuzzleData({
				cardList = self._battleInitData.CardPuzzleCardIDList,
				commonHP = self._battleInitData.CardPuzzleCommonHPValue,
				relicList = self._battleInitData.CardPuzzleRelicList
			})
			var_40_1:CustomConfigID(self._battleInitData.CardPuzzleCombatID)
			self:DispatchEvent(var_0_0.Event.New(var_0_8.CARD_PUZZLE_INIT))
		end
	end

	return self._fleetList[arg_40_1]
end

function var_0_9:GetAidUnit()
	return self._aidUnitList
end

function var_0_9:GetFleetList()
	return self._fleetList
end

function var_0_9:GetEnemySubmarineCount()
	return self._enemySubmarineCount
end

function var_0_9:GetCommander()
	return self._commander
end

function var_0_9:GetCommanderBuff()
	return self._commanderBuff, self._subCommanderBuff
end

function var_0_9:GetStageInfo()
	return self._currentStageData
end

function var_0_9:GetWinningStreak()
	return self._chapterWinningStreak
end

function var_0_9:GetBGMList(arg_48_1)
	if not arg_48_1 then
		return self._initBGMList
	else
		return self._otherBGMList
	end

	return
end

function var_0_9:GetDungeonLevel()
	return self._dungeonLevel
end

function var_0_9.SetDungeonLevel(arg_50_0, arg_50_1)
	arg_50_0._dungeonLevel = arg_50_1

	return
end

function var_0_9:IsCompletelyRepress()
	return self._completelyRepress
end

function var_0_9:GetRepressReduce()
	return self._repressReduce
end

function var_0_9:GetRepressLevel()
	return self._repressLevel
end

function var_0_9:updateInit(arg_54_1)
	self:TriggerBattleInitBuffs()

	self.checkCld = true

	self:updateLoop(arg_54_1)

	self.Update = self.updateLoop

	return
end

function var_0_9:updateLoop(arg_55_1)
	self.FrameIndex = self.FrameIndex + 1

	self:updateDeadList()
	self:UpdateCountDown(arg_55_1)
	self:UpdateWeather(arg_55_1)

	for iter_55_0, iter_55_1 in pairs(self._fleetList) do
		iter_55_1:UpdateMotion()
	end

	self.checkCld = not self.checkCld

	local var_55_0 = {
		[var_0_4.FRIENDLY_CODE] = self._totalLeftBound,
		[var_0_4.FOE_CODE] = self._totalRightBound
	}

	for iter_55_2, iter_55_3 in pairs(self._unitList) do
		if iter_55_3:IsSpectre() then
			if iter_55_3:GetAttrByName(var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) <= var_0_4.FUSION_ELEMENT_UNIT_TYPE then
				-- block empty
			else
				iter_55_3:Update(arg_55_1)
			end
		else
			if self.checkCld then
				self._cldSystem:UpdateShipCldTree(iter_55_3)
			end

			if iter_55_3:IsAlive() then
				iter_55_3:Update(arg_55_1)
			end

			local var_55_1 = iter_55_3:GetPosition().x
			local var_55_2 = iter_55_3:GetIFF()

			if var_55_2 == var_0_4.FRIENDLY_CODE then
				var_55_0[var_55_2] = math.max(var_55_0[var_55_2], var_55_1)
			elseif var_55_2 == var_0_4.FOE_CODE then
				var_55_0[var_55_2] = math.min(var_55_0[var_55_2], var_55_1)
			end
		end
	end

	local var_55_3 = self._fleetList[var_0_4.FRIENDLY_CODE]:GetFleetExposeLine()

	if var_55_3 and var_55_0[var_0_4.FOE_CODE] < var_55_3 then
		self._fleetList[var_0_4.FRIENDLY_CODE]:CloakFatalExpose()
	elseif var_55_0[var_0_4.FOE_CODE] < self._fleetList[var_0_4.FRIENDLY_CODE]:GetFleetVisionLine() then
		self._fleetList[var_0_4.FRIENDLY_CODE]:CloakInVision(self._exposeSpeed)
	else
		self._fleetList[var_0_4.FRIENDLY_CODE]:CloakOutVision()
	end

	if self._fleetList[var_0_4.FOE_CODE] then
		local var_55_4 = self._fleetList[var_0_4.FOE_CODE]:GetFleetExposeLine()

		if var_55_4 and var_55_4 < var_55_0[var_0_4.FRIENDLY_CODE] then
			self._fleetList[var_0_4.FOE_CODE]:CloakFatalExpose()
		elseif self._fleetList[var_0_4.FOE_CODE]:GetFleetVisionLine() < var_55_0[var_0_4.FRIENDLY_CODE] then
			self._fleetList[var_0_4.FOE_CODE]:CloakInVision(self._exposeSpeed)
		else
			self._fleetList[var_0_4.FOE_CODE]:CloakOutVision()
		end
	end

	for iter_55_4, iter_55_5 in pairs(self._bulletList) do
		local var_55_5 = iter_55_5:GetSpeed()
		local var_55_6 = iter_55_5:GetPosition()
		local var_55_7 = iter_55_5:GetType()
		local var_55_8 = iter_55_5:GetOutBound()

		if var_55_8 == var_0_3.BulletOutBound.SPLIT and var_55_7 == var_0_3.BulletType.SHRAPNEL and (var_55_6.x > self._bulletRightBound and var_55_5.x > 0 or var_55_6.x < self._bulletLeftBoundSplit and var_55_5.x < 0 or var_55_6.z > self._bulletUpperBound and var_55_5.z > 0 or var_55_6.z < self._bulletLowerBoundSplit and var_55_5.z < 0) then
			if iter_55_5:GetExist() then
				iter_55_5:OutRange()
			else
				self:RemoveBulletUnit(iter_55_5:GetUniqueID())
			end
		elseif (var_55_8 == var_0_3.BulletOutBound.COMMON or var_55_8 == var_0_3.BulletOutBound.SHIFT_SPLIT) and (var_55_6.x > self._bulletRightBound and var_55_5.x > 0 or var_55_6.z < self._bulletLowerBound and var_55_5.z < 0) then
			self:RemoveBulletUnit(iter_55_5:GetUniqueID())
		elseif var_55_6.x < self._bulletLeftBound and var_55_5.x < 0 and var_55_7 ~= var_0_3.BulletType.BOMB then
			if var_55_8 == var_0_3.BulletOutBound.RANDOM then
				local var_55_9 = self._fleetList[var_0_4.FRIENDLY_CODE]:RandomMainVictim()

				if var_55_9 then
					self:HandleDamage(iter_55_5, var_55_9)
				end
			end

			self:RemoveBulletUnit(iter_55_5:GetUniqueID())
		else
			iter_55_5:Update(arg_55_1)

			local var_55_10 = iter_55_5.GetCurrentState and iter_55_5:GetCurrentState() or nil

			if var_55_10 == var_0_0.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT then
				-- block empty
			elseif var_55_10 == var_0_0.Battle.BattleShrapnelBulletUnit.STATE_SPLIT and not iter_55_5:IsFragile() then
				-- block empty
			elseif (var_55_8 == var_0_3.BulletOutBound.COMMON or var_55_8 == var_0_3.BulletOutBound.SHIFT_SPLIT) and var_55_6.z > self._bulletUpperBound and var_55_5.z > 0 or var_55_8 == var_0_3.BulletOutBound.VISION and var_55_6.z > self._bulletUpperBoundVision and var_55_5.z > 0 or iter_55_5:IsOutRange(arg_55_1) then
				if iter_55_5:GetExist() then
					iter_55_5:OutRange()
				else
					self:RemoveBulletUnit(iter_55_5:GetUniqueID())
				end
			elseif self.checkCld then
				self._cldSystem:UpdateBulletCld(iter_55_5)
			end
		end
	end

	for iter_55_6, iter_55_7 in pairs(self._aircraftList) do
		iter_55_7:Update(arg_55_1)

		local var_55_11, var_55_12 = iter_55_7:GetIFF()

		if var_55_11 == var_0_4.FRIENDLY_CODE then
			var_55_12 = self._totalRightBound
		elseif var_55_11 == var_0_4.FOE_CODE then
			var_55_12 = self._totalLeftBound
		end

		if iter_55_7:GetPosition().x * var_55_11 > math.abs(var_55_12) and iter_55_7:GetSpeed().x * var_55_11 > 0 then
			iter_55_7:OutBound()
		else
			self._cldSystem:UpdateAircraftCld(iter_55_7)
		end

		if not iter_55_7:IsAlive() then
			self:KillAircraft(iter_55_7:GetUniqueID())
		end
	end

	for iter_55_8, iter_55_9 in pairs(self._AOEList) do
		self._cldSystem:UpdateAOECld(iter_55_9)
		iter_55_9:Settle()

		if iter_55_9:GetActiveFlag() == false then
			iter_55_9:SettleFinale()
			self:RemoveAreaOfEffect(iter_55_9:GetUniqueID())
		end
	end

	for iter_55_10, iter_55_11 in pairs(self._environmentList) do
		iter_55_11:Update()

		if iter_55_11:IsExpire(arg_55_1) then
			self:RemoveEnvironment(iter_55_11:GetUniqueID())
		end
	end

	if self.checkCld then
		for iter_55_12, iter_55_13 in pairs(self._shelterList) do
			if not iter_55_13:IsWallActive() then
				self:RemoveShelter(iter_55_13:GetUniqueID())
			else
				iter_55_13:Update(arg_55_1)
			end
		end

		for iter_55_14, iter_55_15 in pairs(self._wallList) do
			if iter_55_15:IsActive() then
				self._cldSystem:UpdateWallCld(iter_55_15)
			end
		end
	end

	if self._battleInitData.battleType ~= SYSTEM_DUEL then
		for iter_55_16, iter_55_17 in pairs(self._foeShipList) do
			if iter_55_17:GetPosition().x + iter_55_17:GetBoxSize().x < self._leftZoneLeftBound then
				iter_55_17:SetDeathReason(var_0_3.UnitDeathReason.TOUCHDOWN)
				iter_55_17:DeadAction()
				self:KillUnit(iter_55_17:GetUniqueID())
				self:HandleShipMissDamage(iter_55_17, self._fleetList[var_0_4.FRIENDLY_CODE])
			end
		end
	end

	return
end

function var_0_9:UpdateAutoComponent(arg_56_1)
	for iter_56_0, iter_56_1 in pairs(self._fleetList) do
		iter_56_1:UpdateAutoComponent(arg_56_1)
	end

	for iter_56_2, iter_56_3 in pairs(self._teamList) do
		if iter_56_3:IsFatalDamage() then
			self:KillNPCTeam(iter_56_2)
		else
			iter_56_3:UpdateMotion()
		end
	end

	for iter_56_4, iter_56_5 in pairs(self._freeShipList) do
		iter_56_5:UpdateOxygen(arg_56_1)
		iter_56_5:UpdateWeapon(arg_56_1)
		iter_56_5:UpdatePhaseSwitcher()
	end

	return
end

function var_0_9:UpdateWeather(arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(self._weahter) do
		if iter_57_1 == var_0_3.WEATHER.NIGHT then
			local var_57_0 = {
				[var_0_4.FRIENDLY_CODE] = 0,
				[var_0_4.FOE_CODE] = 0
			}
			local var_57_1 = {
				[var_0_4.FRIENDLY_CODE] = 0,
				[var_0_4.FOE_CODE] = 0
			}
			local var_57_2 = {
				[var_0_4.FRIENDLY_CODE] = 0,
				[var_0_4.FOE_CODE] = 0
			}

			for iter_57_2, iter_57_3 in pairs(self._unitList) do
				local var_57_3 = iter_57_3:GetAimBias()

				if not var_57_3 or var_57_3:GetCurrentState() ~= var_57_3.STATE_SUMMON_SICKNESS then
					local var_57_4 = iter_57_3:GetIFF()
					local var_57_5 = var_0_6.GetCurrent(iter_57_3, "attackRating")
					local var_57_6 = var_0_6.GetCurrent(iter_57_3, "aimBiasExtraACC")

					var_57_1[var_57_4] = math.max(var_57_1[var_57_4], var_57_5)
					var_57_2[var_57_4] = var_57_2[var_57_4] + var_57_6

					if ShipType.ContainInLimitBundle(ShipType.BundleAntiSubmarine, iter_57_3:GetTemplate().type) then
						var_57_0[var_57_4] = math.max(var_57_0[var_57_4], var_57_5)
					end
				end
			end

			for iter_57_4, iter_57_5 in pairs(self._fleetList) do
				local var_57_7 = iter_57_5:GetFleetBias()

				var_57_7:SetDecayFactor(var_57_1[iter_57_4 * -1], var_57_2[iter_57_4 * -1])
				var_57_7:Update(arg_57_1)

				for iter_57_6, iter_57_7 in ipairs(iter_57_5:GetSubList()) do
					local var_57_8 = iter_57_7:GetAimBias()

					if var_57_8:GetDecayFactorType() == var_57_8.DIVING then
						var_57_8:SetDecayFactor(var_57_0[iter_57_4 * -1], var_57_2[iter_57_4 * -1])
					else
						var_57_8:SetDecayFactor(var_57_1[iter_57_4 * -1], var_57_2[iter_57_4 * -1])
					end

					var_57_8:Update(arg_57_1)
				end
			end

			for iter_57_8, iter_57_9 in pairs(self._freeShipList) do
				local var_57_9 = iter_57_9:GetIFF() * -1
				local var_57_10 = iter_57_9:GetAimBias()

				if var_57_10:GetDecayFactorType() == var_57_10.DIVING then
					var_57_10:SetDecayFactor(var_57_0[var_57_9], var_57_2[var_57_9])
				else
					var_57_10:SetDecayFactor(var_57_1[var_57_9], var_57_2[var_57_9])
				end

				var_57_10:Update(arg_57_1)
			end
		end
	end

	return
end

function var_0_9:UpdateEscapeOnly(arg_58_1)
	for iter_58_0, iter_58_1 in pairs(self._foeShipList) do
		iter_58_1:Update(arg_58_1)
	end

	return
end

function var_0_9:UpdateCountDown(arg_59_1)
	self._lastUpdateTime = self._lastUpdateTime or arg_59_1

	local var_59_0 = self._countDown - (arg_59_1 - self._lastUpdateTime)

	if self._countDown - (arg_59_1 - self._lastUpdateTime) <= 0 then
		var_59_0 = 0
	end

	if math.floor(self._countDown - var_59_0) == 0 or var_59_0 == 0 then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_COUNT_DOWN, {}))
	end

	self._countDown = var_59_0
	self._totalTime = arg_59_1 - self._startTimeStamp
	self._lastUpdateTime = arg_59_1

	return
end

function var_0_9:SpawnMonster(arg_60_1, arg_60_2, arg_60_3, arg_60_4, arg_60_5)
	local var_60_0 = self:GenerateUnitID()
	local var_60_1 = var_0_5.GetMonsterTmpDataFromID(arg_60_1.monsterTemplateID)
	local var_60_2 = {}

	for iter_60_0, iter_60_1 in ipairs(var_60_1.equipment_list) do
		table.insert(var_60_2, {
			id = iter_60_1
		})
	end

	for iter_60_2, iter_60_3 in ipairs(var_60_1.random_equipment_list) do
		local var_60_3 = Clone(iter_60_3)

		for iter_60_4 = 1, var_60_1.random_nub[iter_60_2] do
			local var_60_4 = math.random(#var_60_3)

			table.insert(var_60_2, {
				id = var_60_3[var_60_4]
			})
			table.remove(var_60_3, var_60_4)
		end
	end

	local var_60_5 = var_0_5.CreateBattleUnitData(var_60_0, arg_60_3, arg_60_4, arg_60_1.monsterTemplateID, nil, var_60_2, arg_60_1.extraInfo, nil, nil, nil, nil, arg_60_1.level)

	var_0_6.MonsterAttrFixer(self._battleInitData.battleType, var_60_5)

	local var_60_6 = arg_60_1.immuneHPInherit and var_60_5:GetMaxHP() or math.ceil(var_60_5:GetMaxHP() * self._repressEnemyHpRant)

	if var_60_6 <= 0 then
		var_60_6 = 1
	end

	var_60_5:SetCurrentHP(var_60_6)
	var_60_5:SetPosition((var_0_2.RandomPos(arg_60_1.corrdinate)))
	var_60_5:SetAI(arg_60_1.pilotAITemplateID or var_60_1.pilot_ai_template_id)
	self:setShipUnitBound(var_60_5)

	if table.contains(ShipType.SubShipType, var_60_1.type) then
		var_60_5:InitOxygen()
		self:UpdateHostileSubmarine(true)
	end

	var_0_5.AttachWeather(var_60_5, self._weahter)

	self._freeShipList[var_60_0] = var_60_5
	self._unitList[var_60_0] = var_60_5

	if var_60_5:IsSpectre() then
		var_60_5:UpdateBlindInvisibleBySpectre()
	else
		self._cldSystem:InitShipCld(var_60_5)
	end

	var_60_5:SummonSickness(arg_60_1.sickness or var_0_3.SUMMONING_SICKNESS_DURATION)
	var_60_5:SetMoveCast(arg_60_1.moveCast == true)

	if var_60_5:GetIFF() == var_0_4.FRIENDLY_CODE then
		self._friendlyShipList[var_60_0] = var_60_5
	else
		if var_60_5:IsSpectre() then
			self._spectreShipList[var_60_0] = var_60_5
		else
			self._foeShipList[var_60_0] = var_60_5
		end

		var_60_5:SetWaveIndex(arg_60_2)
	end

	if arg_60_1.reinforce then
		var_60_5:Reinforce()
	end

	if arg_60_1.reinforceDelay then
		var_60_5:SetReinforceCastTime(arg_60_1.reinforceDelay)
	end

	if arg_60_1.team then
		self:GetNPCTeam(arg_60_1.team):AppendUnit(var_60_5)
	end

	if arg_60_1.phase then
		var_0_0.Battle.BattleUnitPhaseSwitcher.New(var_60_5):SetTemplateData(arg_60_1.phase)
	end

	if arg_60_5 then
		arg_60_5(var_60_5)
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = arg_60_3,
		unit = var_60_5,
		bossData = arg_60_1.bossData,
		extraInfo = arg_60_1.extraInfo
	}))

	local function var_60_7(arg_61_0)
		for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
			local var_61_1
			local var_61_2

			if type(iter_61_1) == "number" then
				var_61_1 = iter_61_1
				var_61_2 = 1
			else
				var_61_1 = iter_61_1.ID
				var_61_2 = iter_61_1.LV or 1
			end

			var_60_5:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_61_1, var_61_2, var_60_5)))
		end

		return
	end

	local var_60_8 = arg_60_1.buffList or {}
	local var_60_9 = self._battleInitData.ExtraBuffList or {}
	local var_60_10 = self._battleInitData.AffixBuffList or {}

	var_60_7(var_60_5:GetTemplate().buff_list)
	var_60_7(var_60_9)
	var_60_7(var_60_8)

	if arg_60_1.affix then
		var_60_7(var_60_10)
	end

	local var_60_11 = arg_60_1.summonWaveIndex

	if arg_60_1.summonWaveIndex then
		self._waveSummonList[var_60_11] = self._waveSummonList[var_60_11] or {}
		self._waveSummonList[var_60_11][var_60_5] = true
	end

	var_60_5:CheckWeaponInitial()

	if self._battleInitData.CMDArgs and var_60_5:GetTemplateID() == self._battleInitData.CMDArgs then
		self:InitSpecificEnemyStatistics(var_60_5)
	end

	var_60_5:OverrideDeadFX(arg_60_1.deadFX)

	if BATTLE_ENEMY_AIMBIAS_RANGE and var_60_5:GetAimBias() then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AIM_BIAS, {
			aimBias = var_60_5:GetAimBias()
		}))
	end

	return var_60_5
end

function var_0_9:UpdateHostileSubmarine(arg_62_1)
	self._enemySubmarineCount = arg_62_1 and self._enemySubmarineCount + 1 or self._enemySubmarineCount - 1

	self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_HOSTILE_SUBMARINE))

	return
end

function var_0_9:SpawnNPC(arg_63_1, arg_63_2)
	local var_63_0 = self:GenerateUnitID()
	local var_63_1 = var_0_3.UnitType.MINION_UNIT
	local var_63_2 = var_0_5.GetMonsterTmpDataFromID(arg_63_1.monsterTemplateID)
	local var_63_3 = {}

	for iter_63_0, iter_63_1 in ipairs(var_63_2.equipment_list) do
		table.insert(var_63_3, {
			id = iter_63_1
		})
	end

	local var_63_4 = var_0_5.CreateBattleUnitData(var_63_0, var_63_1, arg_63_2:GetIFF(), arg_63_1.monsterTemplateID, nil, var_63_3, arg_63_1.extraInfo, nil, nil, nil, nil, arg_63_1.level, arg_63_2)

	var_63_4:SetCurrentHP((var_63_4:GetMaxHP()))
	var_63_4:SetPosition(arg_63_1.corrdinate and var_0_2.RandomPos(arg_63_1.corrdinate) or Clone(arg_63_2:GetPosition()))
	var_63_4:SetAI(arg_63_1.pilotAITemplateID or var_63_2.pilot_ai_template_id)
	self:setShipUnitBound(var_63_4)

	if table.contains(ShipType.SubShipType, var_63_2.type) then
		var_63_4:InitOxygen()

		if var_63_4:GetIFF() ~= var_0_4.FRIENDLY_CODE then
			self:UpdateHostileSubmarine(true)
		end
	end

	var_0_5.AttachWeather(var_63_4, self._weahter)

	self._freeShipList[var_63_0] = var_63_4
	self._unitList[var_63_0] = var_63_4

	self._cldSystem:InitShipCld(var_63_4)
	var_63_4:SummonSickness(arg_63_1.sickness or var_0_3.SUMMONING_SICKNESS_DURATION)
	var_63_4:SetMoveCast(arg_63_1.moveCast == true)

	self._minionShipList[var_63_0] = var_63_4

	if arg_63_1.phase then
		var_0_0.Battle.BattleUnitPhaseSwitcher.New(var_63_4):SetTemplateData(arg_63_1.phase)
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_63_1,
		unit = var_63_4,
		bossData = arg_63_1.bossData,
		extraInfo = arg_63_1.extraInfo
	}))

	local function var_63_6(arg_64_0)
		for iter_64_0, iter_64_1 in ipairs(arg_64_0) do
			local var_64_1
			local var_64_2

			if type(iter_64_1) == "number" then
				var_64_1 = iter_64_1
				var_64_2 = 1
			else
				var_64_1 = iter_64_1.ID
				var_64_2 = iter_64_1.LV or 1
			end

			var_63_4:AddBuff((var_0_0.Battle.BattleBuffUnit.New(var_64_1, var_64_2, var_63_4)))
		end

		return
	end

	local var_63_7 = arg_63_1.buffList or {}

	var_63_6(var_63_4:GetTemplate().buff_list)
	var_63_6(var_63_7)
	var_63_4:CheckWeaponInitial()

	return var_63_4
end

function var_0_9:EnemyEscape()
	for iter_65_0, iter_65_1 in pairs(self._foeShipList) do
		if iter_65_1:ContainsLabelTag(var_0_4.ESCAPE_EXPLO_TAG) then
			iter_65_1:SetDeathReason(var_0_3.UnitDeathReason.CLS)
			iter_65_1:DeadAction()
		else
			iter_65_1:RemoveAllAutoWeapon()
			iter_65_1:SetAI(var_0_4.COUNT_DOWN_ESCAPE_AI_ID)
		end
	end

	return
end

function var_0_9:GetNPCTeam(arg_66_1)
	self._teamList[arg_66_1] = self._teamList[arg_66_1] or var_0_0.Battle.BattleTeamVO.New(arg_66_1)

	return self._teamList[arg_66_1]
end

function var_0_9:KillNPCTeam(arg_67_1)
	if self._teamList[arg_67_1] then
		self._teamList[arg_67_1]:Dispose()

		self._teamList[arg_67_1] = nil
	end

	return
end

function var_0_9:SpawnVanguard(arg_68_1, arg_68_2)
	local var_68_0 = self:generatePlayerUnit(arg_68_1, arg_68_2, BuildVector3((self:GetVanguardBornCoordinate(arg_68_2))), self._commanderBuff)

	self:GetFleetByIFF(arg_68_2):AppendPlayerUnit(var_68_0)
	self:setShipUnitBound(var_68_0)
	var_0_5.AttachWeather(var_68_0, self._weahter)
	self._cldSystem:InitShipCld(var_68_0)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_68_0
	}))

	return var_68_0
end

function var_0_9:SpawnMain(arg_69_1, arg_69_2)
	local var_69_0
	local var_69_1 = self:GetFleetByIFF(arg_69_2)
	local var_69_2 = #var_69_1:GetMainList() + 1

	var_69_0 = self._currentStageData.mainUnitPosition and self._currentStageData.mainUnitPosition[arg_69_2] and Clone(self._currentStageData.mainUnitPosition[arg_69_2][var_69_2]) or Clone(var_0_4.MAIN_UNIT_POS[arg_69_2][var_69_2])

	local var_69_3 = self:generatePlayerUnit(arg_69_1, arg_69_2, var_69_0, self._commanderBuff)

	var_69_3:SetBornPosition(var_69_0)
	var_69_3:SetMainFleetUnit()

	if var_69_0.x < self._totalLeftBound or var_69_0.x > self._totalRightBound then
		var_69_3:SetImmuneCommonBulletCLD()
	end

	var_69_1:AppendPlayerUnit(var_69_3)
	self:setShipUnitBound(var_69_3)
	var_0_5.AttachWeather(var_69_3, self._weahter)
	self._cldSystem:InitShipCld(var_69_3)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_69_3
	}))

	return var_69_3
end

function var_0_9:SpawnSub(arg_70_1, arg_70_2)
	local var_70_1 = self:GetFleetByIFF(arg_70_2)
	local var_70_2 = #var_70_1:GetSubList() + 1
	local var_70_3 = self:generatePlayerUnit(arg_70_1, arg_70_2, arg_70_2 == var_0_4.FRIENDLY_CODE and Vector3(var_0_4.SUB_UNIT_OFFSET_X + (var_0_5.GetPlayerShipTmpDataFromID(arg_70_1.tmpID).summon_offset or 0) + self._totalLeftBound, 0, var_0_4.SUB_UNIT_POS_Z[var_70_2]) or Vector3(self._totalRightBound - (var_0_4.SUB_UNIT_OFFSET_X + (var_0_5.GetPlayerShipTmpDataFromID(arg_70_1.tmpID).summon_offset or 0)), 0, var_0_4.SUB_UNIT_POS_Z[var_70_2]), self._subCommanderBuff)

	var_70_1:AddSubMarine(var_70_3)
	self:setShipUnitBound(var_70_3)
	var_0_5.AttachWeather(var_70_3, self._weahter)
	self._cldSystem:InitShipCld(var_70_3)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_70_3
	}))

	return var_70_3
end

function var_0_9:SpawnManualSub(arg_71_1, arg_71_2)
	local var_71_0 = self:generatePlayerUnit(arg_71_1, arg_71_2, BuildVector3((self:GetVanguardBornCoordinate(arg_71_2))), self._commanderBuff)

	self:GetFleetByIFF(arg_71_2):AddManualSubmarine(var_71_0)
	self:setShipUnitBound(var_71_0)
	self._cldSystem:InitShipCld(var_71_0)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_0_3.UnitType.SUB_UNIT,
		unit = var_71_0
	}))

	return var_71_0
end

function var_0_9:SpawnSupportUnit(arg_72_1, arg_72_2)
	local var_72_0 = self:generateSupportPlayerUnit(arg_72_1, arg_72_2)
	local var_72_1 = self:GetFleetByIFF(arg_72_2)

	var_72_1:AppendSupportUnit(var_72_0)

	if table.contains(ShipType.BundleList.qian, var_72_0:GetTemplate().type) then
		var_72_0:SetPosition(Clone(var_0_4.SubSupportUnitPosList[#var_72_1:GetSupportUnitList()]))
	else
		var_72_0:SetPosition(Clone(var_0_4.AirSupportUnitPos))
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_0_3.UnitType.SUPPORT_UNIT,
		unit = var_72_0
	}))

	return var_72_0
end

function var_0_9:ShutdownPlayerUnit(arg_73_1)
	local var_73_0 = self:GetFleetByIFF((self._unitList[arg_73_1]:GetIFF()))

	var_73_0:RemovePlayerUnit(self._unitList[arg_73_1])

	local var_73_1 = {}

	if var_73_0:GetFleetAntiAirWeapon():GetRange() == 0 then
		var_73_1.isShow = false
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ANTI_AIR_AREA, var_73_1))
	self:DispatchEvent(var_0_0.Event.New(var_0_1.SHUT_DOWN_PLAYER, {
		unit = self._unitList[arg_73_1]
	}))

	return
end

function var_0_9:updateDeadList()
	while #self._deadUnitList > 0 do
		self._deadUnitList[#self._deadUnitList]:Dispose()

		self._deadUnitList[#self._deadUnitList] = nil
	end

	return
end

function var_0_9:KillUnit(arg_75_1)
	local var_75_0 = self._unitList[arg_75_1]

	if self._unitList[arg_75_1] == nil then
		return
	end

	local var_75_1 = var_75_0:GetUnitType()

	self._cldSystem:DeleteShipCld(var_75_0)
	var_75_0:Clear()

	self._unitList[arg_75_1] = nil

	if self._freeShipList[arg_75_1] then
		self._freeShipList[arg_75_1] = nil
	end

	local var_75_2 = var_75_0:GetIFF()
	local var_75_3 = var_75_0:GetDeathReason()

	if var_75_0:GetAimBias() then
		local var_75_4 = var_75_0:GetAimBias()

		var_75_4:RemoveCrew(var_75_0)

		if var_75_4:GetCurrentState() == var_75_4.STATE_EXPIRE then
			self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIM_BIAS, {
				aimBias = var_75_0:GetAimBias()
			}))
		end
	end

	if var_75_0:IsSpectre() then
		self._spectreShipList[arg_75_1] = nil
	elseif var_75_2 == var_0_4.FOE_CODE then
		self._foeShipList[arg_75_1] = nil

		if var_75_1 == var_0_3.UnitType.ENEMY_UNIT or var_75_1 == var_0_3.UnitType.BOSS_UNIT then
			if var_75_0:GetTeam() then
				var_75_0:GetTeam():RemoveUnit(var_75_0)
			end

			if table.contains(ShipType.SubShipType, var_75_0:GetTemplate().type) then
				self:UpdateHostileSubmarine(false)
			end

			local var_75_5 = var_75_0:GetWaveIndex()

			if var_75_5 and self._waveSummonList[var_75_5] then
				self._waveSummonList[var_75_5][var_75_0] = nil
			end
		end
	elseif var_75_2 == var_0_4.FRIENDLY_CODE then
		self._friendlyShipList[arg_75_1] = nil
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_UNIT, {
		UID = arg_75_1,
		type = var_75_1,
		deadReason = var_75_3,
		unit = var_75_0
	}))
	table.insert(self._deadUnitList, var_75_0)

	return
end

function var_0_9:KillAllEnemy()
	for iter_76_0, iter_76_1 in pairs(self._unitList) do
		if iter_76_1:GetIFF() == var_0_4.FOE_CODE and iter_76_1:IsAlive() and not iter_76_1:IsBoss() then
			iter_76_1:DeadAction()
		end
	end

	return
end

function var_0_9:KillSubmarineByIFF(arg_77_1)
	for iter_77_0, iter_77_1 in pairs(self._unitList) do
		if iter_77_1:GetIFF() == arg_77_1 and iter_77_1:IsAlive() and table.contains(ShipType.SubShipType, iter_77_1:GetTemplate().type) and not iter_77_1:IsBoss() then
			iter_77_1:DeadAction()
		end
	end

	return
end

function var_0_9:KillAllAircraft()
	for iter_78_0, iter_78_1 in pairs(self._aircraftList) do
		iter_78_1:Clear()
		self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, {
			UID = iter_78_0
		}))

		self._aircraftList[iter_78_0] = nil
	end

	return
end

function var_0_9:KillWaveSummonMonster(arg_79_1)
	if self._waveSummonList[arg_79_1] then
		for iter_79_0, iter_79_1 in pairs(self._waveSummonList[arg_79_1]) do
			self:KillUnit((iter_79_0:GetUniqueID()))
		end
	end

	self._waveSummonList[arg_79_1] = nil

	return
end

function var_0_9:IsThereBoss()
	return self:GetActiveBossCount() > 0
end

function var_0_9:GetActiveBossCount()
	local var_81_0 = 0

	for iter_81_0, iter_81_1 in pairs(self:GetUnitList()) do
		if iter_81_1:IsBoss() and iter_81_1:IsAlive() then
			var_81_0 = var_81_0 + 1
		end
	end

	return var_81_0
end

function var_0_9:setShipUnitBound(arg_82_1)
	if arg_82_1:GetFleetVO() then
		arg_82_1:SetBound(arg_82_1:GetFleetVO():GetUnitBound():GetBound())
	else
		arg_82_1:SetBound(self:GetUnitBoundByIFF((arg_82_1:GetIFF())))
	end

	return
end

function var_0_9:generatePlayerUnit(arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	local var_83_0 = self:GenerateUnitID()
	local var_83_1 = arg_83_1.properties

	var_83_1.level = arg_83_1.level
	var_83_1.formationID = var_0_4.FORMATION_ID
	var_83_1.id = arg_83_1.id

	var_0_6.AttrFixer(self._battleInitData.battleType, var_83_1)

	local var_83_2 = var_0_3.UnitType.PLAYER_UNIT
	local var_83_3 = self._battleInitData.battleType

	if self._battleInitData.battleType == SYSTEM_SUBMARINE_RUN or var_83_3 == SYSTEM_SUB_ROUTINE then
		var_83_2 = var_0_3.UnitType.SUB_UNIT
	elseif var_83_3 == SYSTEM_AIRFIGHT then
		var_83_2 = var_0_3.UnitType.CONST_UNIT
	elseif var_83_3 == SYSTEM_CARDPUZZLE then
		var_83_2 = var_0_3.UnitType.CARDPUZZLE_PLAYER_UNIT
	end

	local var_83_4 = var_0_5.CreateBattleUnitData(var_83_0, var_83_2, arg_83_2, arg_83_1.tmpID, arg_83_1.skinId, arg_83_1.equipment, var_83_1, arg_83_1.baseProperties, arg_83_1.proficiency or {
		1,
		1,
		1
	}, arg_83_1.baseList, arg_83_1.preloasList)

	var_0_5.AttachUltimateBonus(var_83_4)
	var_83_4:InitCurrentHP(arg_83_1.initHPRate or 1)
	var_83_4:SetRarity(arg_83_1.rarity)
	var_83_4:SetIntimacy(arg_83_1.intimacy)
	var_83_4:SetShipName(arg_83_1.name)

	if arg_83_1.spWeapon then
		var_83_4:SetSpWeapon(arg_83_1.spWeapon)
		_.each(arg_83_1.spWeapon:GetLabel(), function(arg_84_0)
			var_83_4:AddLabelTag(arg_84_0)

			return
		end)
	end

	self._unitList[var_83_0] = var_83_4

	if var_83_4:GetIFF() == var_0_4.FRIENDLY_CODE then
		self._friendlyShipList[var_83_0] = var_83_4
	elseif var_83_4:GetIFF() == var_0_4.FOE_CODE then
		self._foeShipList[var_83_0] = var_83_4
	end

	if var_83_3 == SYSTEM_WORLD then
		var_0_6.SetCurrent(var_83_4, "healingRate", (var_0_2.WorldMapRewardHealingRate(self._battleInitData.EnemyMapRewards, self._battleInitData.FleetMapRewards)))
	end

	var_83_4:SetPosition(arg_83_3)
	var_0_5.InitUnitSkill(arg_83_1, var_83_4, var_83_3)
	var_0_5.InitEquipSkill(arg_83_1.equipment, var_83_4, var_83_3)
	var_0_5.InitCommanderSkill(arg_83_4, var_83_4, var_83_3)
	var_83_4:SetGearScore(arg_83_1.shipGS)

	if arg_83_1.deathMark then
		var_83_4:SetWorldDeathMark()
	end

	return var_83_4
end

function var_0_9:generateSupportPlayerUnit(arg_85_1, arg_85_2)
	local var_85_0 = self:GenerateUnitID()

	arg_85_1.properties.level = arg_85_1.level
	arg_85_1.properties.formationID = var_0_4.FORMATION_ID
	arg_85_1.properties.id = arg_85_1.id

	var_0_6.AttrFixer(self._battleInitData.battleType, arg_85_1.properties)

	local var_85_1 = var_0_5.CreateBattleUnitData(var_85_0, var_0_3.UnitType.SUPPORT_UNIT, arg_85_2, arg_85_1.tmpID, arg_85_1.skinId, arg_85_1.equipment, arg_85_1.properties, arg_85_1.baseProperties, arg_85_1.proficiency or {
		1,
		1,
		1
	}, arg_85_1.baseList, arg_85_1.preloasList)

	var_85_1:InitCurrentHP(1)
	var_85_1:SetShipName(arg_85_1.name)

	self._spectreShipList[var_85_0] = var_85_1

	return var_85_1
end

function var_0_9:SwitchSpectreUnit(arg_86_1)
	local var_86_0 = arg_86_1:GetUniqueID()
	local var_86_1

	if arg_86_1:GetIFF() == var_0_4.FRIENDLY_CODE then
		var_86_1 = self._friendlyShipList or self._foeShipList

		if arg_86_1:IsSpectre() then
			var_86_1[var_86_0] = nil
			self._spectreShipList[var_86_0] = arg_86_1

			for iter_86_0, iter_86_1 in pairs(self._AOEList) do
				iter_86_1:ForceExit(arg_86_1:GetUniqueID())
			end

			self._cldSystem:DeleteShipCld(arg_86_1)

			goto label_86_0
		end
	end

	self._spectreShipList[var_86_0] = nil
	var_86_1[var_86_0] = arg_86_1

	arg_86_1:ActiveCldBox()
	self._cldSystem:InitShipCld(arg_86_1)

	::label_86_0::

	return
end

function var_0_9:GetUnitList()
	return self._unitList
end

function var_0_9:GetFriendlyShipList()
	return self._friendlyShipList
end

function var_0_9:GetFoeShipList()
	return self._foeShipList
end

function var_0_9:GetFoeAircraftList()
	return self._foeAircraftList
end

function var_0_9:GetFreeShipList()
	return self._freeShipList
end

function var_0_9:GetSpectreShipList()
	return self._spectreShipList
end

function var_0_9:GenerateUnitID()
	self._unitCount = self._unitCount + 1

	return self._unitCount
end

function var_0_9:GetCountDown()
	return self._countDown
end

function var_0_9:SpawnAirFighter(arg_95_1)
	local var_95_0 = #self._airFighterList + 1
	local var_95_1 = var_0_5.GetFormationTmpDataFromID(arg_95_1.formation).pos_offset
	local var_95_2 = {
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}

	var_95_2.totalNumber = arg_95_1.totalNumber or 0
	var_95_2.onceNumber = arg_95_1.onceNumber
	var_95_2.timeDelay = arg_95_1.interval or 3
	var_95_2.maxTotalNumber = arg_95_1.maxTotalNumber or 15

	local function var_95_3(arg_96_0)
		if var_95_2.currentNumber < var_95_2.totalNumber then
			var_95_2.currentNumber = var_95_2.currentNumber + 1

			local var_96_0 = self:CreateAirFighter(arg_95_1)

			var_96_0:SetFormationOffset(var_95_1[arg_96_0])
			var_96_0:SetFormationIndex(arg_96_0)
			var_96_0:SetDeadCallBack(function()
				var_95_2.totalNumber = var_95_2.totalNumber - 1
				var_95_2.currentNumber = var_95_2.currentNumber - 1

				self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIR_FIGHTER_ICON, {
					index = var_95_0
				}))
				self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_AIR_SUPPORT_LABEL, {}))

				return
			end)
			var_96_0:SetLiveCallBack(function()
				var_95_2.currentNumber = var_95_2.currentNumber - 1

				return
			end)
		end

		return
	end

	self._airFighterList[#self._airFighterList + 1] = var_95_2

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AIR_FIGHTER_ICON, {
		index = #self._airFighterList + 1
	}))
	self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_AIR_SUPPORT_LABEL, {}))

	var_95_2.timer = pg.TimeMgr.GetInstance():AddBattleTimer("striker", -1, arg_95_1.interval, function()
		if var_95_2.totalNumber > 0 then
			for iter_99_0 = 1, var_95_2.onceNumber do
				var_95_3(iter_99_0)
			end
		else
			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_95_2.timer)

			var_95_2.timer = nil
		end

		return
	end)

	return
end

function var_0_9:ClearAirFighterTimer()
	for iter_100_0, iter_100_1 in ipairs(self._airFighterList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_100_1.timer)

		iter_100_1.timer = nil
	end

	self._airFighterList = {}

	return
end

function var_0_9:KillAllAirStrike()
	for iter_101_0, iter_101_1 in pairs(self._aircraftList) do
		if iter_101_1.__name == var_0_0.Battle.BattleAirFighterUnit.__name then
			self._cldSystem:DeleteAircraftCld(iter_101_1)

			iter_101_1._aliveState = false
			self._aircraftList[iter_101_0] = nil
			self._foeAircraftList[iter_101_0] = nil

			self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, {
				UID = iter_101_0
			}))
		end
	end

	local var_101_0 = true

	for iter_101_2, iter_101_3 in pairs(self._foeAircraftList) do
		var_101_0 = false

		break
	end

	if var_101_0 then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ANTI_AIR_AREA, {
			isShow = false
		}))
	end

	for iter_101_4, iter_101_5 in ipairs(self._airFighterList) do
		iter_101_5.totalNumber = 0

		self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIR_FIGHTER_ICON, {
			index = iter_101_4
		}))
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_101_5.timer)

		iter_101_5.timer = nil
	end

	self._airFighterList = {}

	return
end

function var_0_9:GetAirFighterInfo(arg_102_1)
	return self._airFighterList[arg_102_1]
end

function var_0_9:GetAirFighterList()
	return self._airFighterList
end

function var_0_9:CreateAircraft(arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	local var_104_0 = self:GenerateAircraftID()
	local var_104_1 = var_0_5.CreateAircraftUnit(var_104_0, arg_104_2, arg_104_1, arg_104_3)

	if arg_104_4 then
		var_104_1:SetSkinID(arg_104_4)
	end

	local var_104_2

	if arg_104_1:GetIFF() == var_0_4.FRIENDLY_CODE then
		-- block empty
	else
		var_104_2 = true
	end

	self:doCreateAirUnit(var_104_0, var_104_1, var_0_3.UnitType.AIRCRAFT_UNIT, var_104_2)

	return var_104_1
end

function var_0_9:CreateAirFighter(arg_105_1)
	local var_105_0 = self:GenerateAircraftID()
	local var_105_1 = var_0_5.CreateAirFighterUnit(var_105_0, arg_105_1)

	self:doCreateAirUnit(var_105_0, var_105_1, var_0_3.UnitType.AIRFIGHTER_UNIT, true)

	return var_105_1
end

function var_0_9:doCreateAirUnit(arg_106_1, arg_106_2, arg_106_3, arg_106_4)
	self._aircraftList[arg_106_1] = arg_106_2

	self._cldSystem:InitAircraftCld(arg_106_2)
	arg_106_2:SetBound(self._leftZoneUpperBound, self._leftZoneLowerBound)
	arg_106_2:SetViewBoundData(self._cameraTop, self._cameraBottom, self._cameraLeft, self._cameraRight)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		unit = arg_106_2,
		type = arg_106_3
	}))

	arg_106_4 = arg_106_4 or false

	if arg_106_4 then
		self._foeAircraftList[arg_106_1] = arg_106_2

		self:DispatchEvent(var_0_0.Event.New(var_0_1.ANTI_AIR_AREA, {
			isShow = true
		}))
	end

	return
end

function var_0_9:KillAircraft(arg_107_1)
	if self._aircraftList[arg_107_1] == nil then
		return
	end

	self._aircraftList[arg_107_1]:Clear()
	self._cldSystem:DeleteAircraftCld(self._aircraftList[arg_107_1])

	if self._aircraftList[arg_107_1]:IsUndefeated() and self._aircraftList[arg_107_1]:GetCurrentState() ~= self._aircraftList[arg_107_1].STRIKE_STATE_RECYCLE then
		self:HandleAircraftMissDamage(self._aircraftList[arg_107_1], self._fleetList[self._aircraftList[arg_107_1]:GetIFF() * -1])
	end

	self._aircraftList[arg_107_1]._aliveState = false
	self._aircraftList[arg_107_1] = nil
	self._foeAircraftList[arg_107_1] = nil

	local var_107_0 = true

	for iter_107_0, iter_107_1 in pairs(self._foeAircraftList) do
		var_107_0 = false

		break
	end

	if var_107_0 then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ANTI_AIR_AREA, {
			isShow = false
		}))
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, {
		UID = arg_107_1
	}))

	return
end

function var_0_9:GetAircraftList()
	return self._aircraftList
end

function var_0_9:GenerateAircraftID()
	self._aircraftCount = self._aircraftCount + 1

	return self._aircraftCount
end

function var_0_9:CreateBulletUnit(arg_110_1, arg_110_2, arg_110_3, arg_110_4)
	local var_110_0 = self:GenerateBulletID()
	local var_110_1, var_110_2 = var_0_5.CreateBattleBulletData(var_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)

	if var_110_2 then
		self._cldSystem:InitBulletCld(var_110_1)
	end

	local var_110_3, var_110_4 = arg_110_3:GetFixBulletRange()

	if var_110_3 or var_110_4 then
		var_110_1:FixRange(var_110_3, var_110_4)
	end

	self._bulletList[var_110_0] = var_110_1

	return var_110_1
end

function var_0_9:RemoveBulletUnit(arg_111_1)
	if self._bulletList[arg_111_1] == nil then
		return
	end

	self._bulletList[arg_111_1]:DamageUnitListWriteback()

	if self._bulletList[arg_111_1]:GetIsCld() then
		self._cldSystem:DeleteBulletCld(self._bulletList[arg_111_1])
	end

	self._bulletList[arg_111_1] = nil

	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_BULLET, {
		UID = arg_111_1
	}))
	self._bulletList[arg_111_1]:Dispose()

	return
end

function var_0_9:GetBulletList()
	return self._bulletList
end

function var_0_9:GenerateBulletID()
	self._bulletCount = self._bulletCount + 1

	return self._bulletCount + 1
end

function var_0_9:CLSBullet(arg_114_1, arg_114_2)
	if self._battleInitData.battleType ~= SYSTEM_DUEL then
		for iter_114_0, iter_114_1 in pairs(self._bulletList) do
			if iter_114_1:GetIFF() ~= arg_114_1 or not iter_114_1:GetExist() or iter_114_1:ImmuneCLS() or iter_114_1:ImmuneBombCLS() and arg_114_2 then
				-- block empty
			else
				self:RemoveBulletUnit(iter_114_0)
			end
		end
	end

	return
end

function var_0_9:CLSAircraft(arg_115_1)
	for iter_115_0, iter_115_1 in pairs(self._aircraftList) do
		if iter_115_1:GetIFF() == arg_115_1 then
			iter_115_1:Clear()
			self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, {
				UID = iter_115_0
			}))

			self._aircraftList[iter_115_0] = nil
		end
	end

	return
end

function var_0_9:CLSMinion()
	for iter_116_0, iter_116_1 in pairs(self._unitList) do
		if iter_116_1:GetIFF() == var_0_4.FOE_CODE and iter_116_1:IsAlive() and not iter_116_1:IsBoss() then
			iter_116_1:SetDeathReason(var_0_3.UnitDeathReason.CLS)
			iter_116_1:DeadAction()
		end
	end

	return
end

function var_0_9:CLSAOE()
	for iter_117_0, iter_117_1 in pairs(self._AOEList) do
		if iter_117_1:GetSource() == iter_117_1.SOURCE_BULLET_9 then
			self:RemoveAreaOfEffect(iter_117_0)
		end
	end

	return
end

function var_0_9:SpawnColumnArea(arg_118_1, arg_118_2, arg_118_3, arg_118_4, arg_118_5, arg_118_6, arg_118_7, arg_118_8)
	arg_118_7 = arg_118_7 or false

	local var_118_0 = var_0_0.Battle.BattleAOEData.New(self:GenerateAreaID(), arg_118_2, arg_118_6, arg_118_8)

	var_118_0:SetPosition((Clone(arg_118_3)))
	var_118_0:SetRange(arg_118_4)
	var_118_0:SetAreaType(var_0_3.AreaType.COLUMN)
	var_118_0:SetLifeTime(arg_118_5)
	var_118_0:SetFieldType(arg_118_1)
	var_118_0:SetOpponentAffected(not arg_118_7)
	self:CreateAreaOfEffect(var_118_0)

	return var_118_0
end

function var_0_9:SpawnCubeArea(arg_119_1, arg_119_2, arg_119_3, arg_119_4, arg_119_5, arg_119_6, arg_119_7, arg_119_8, arg_119_9)
	arg_119_8 = arg_119_8 or false

	local var_119_0 = var_0_0.Battle.BattleAOEData.New(self:GenerateAreaID(), arg_119_2, arg_119_7, arg_119_9)

	var_119_0:SetPosition((Clone(arg_119_3)))
	var_119_0:SetWidth(arg_119_4)
	var_119_0:SetHeight(arg_119_5)
	var_119_0:SetAreaType(var_0_3.AreaType.CUBE)
	var_119_0:SetLifeTime(arg_119_6)
	var_119_0:SetFieldType(arg_119_1)
	var_119_0:SetOpponentAffected(not arg_119_8)
	self:CreateAreaOfEffect(var_119_0)

	return var_119_0
end

function var_0_9:SpawnLastingColumnArea(arg_120_1, arg_120_2, arg_120_3, arg_120_4, arg_120_5, arg_120_6, arg_120_7, arg_120_8, arg_120_9, arg_120_10, arg_120_11)
	arg_120_8 = arg_120_8 or false

	local var_120_0 = var_0_0.Battle.BattleLastingAOEData.New(self:GenerateAreaID(), arg_120_2, arg_120_6, arg_120_7, arg_120_10, arg_120_11)

	var_120_0:SetPosition((Clone(arg_120_3)))
	var_120_0:SetRange(arg_120_4)
	var_120_0:SetAreaType(var_0_3.AreaType.COLUMN)
	var_120_0:SetLifeTime(arg_120_5)
	var_120_0:SetFieldType(arg_120_1)
	var_120_0:SetOpponentAffected(not arg_120_8)
	self:CreateAreaOfEffect(var_120_0)

	if arg_120_9 and arg_120_9 ~= "" then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AREA, {
			area = var_120_0,
			FXID = arg_120_9
		}))
	end

	return var_120_0
end

function var_0_9:SpawnLastingEllipseArea(arg_121_1, arg_121_2, arg_121_3, arg_121_4, arg_121_5, arg_121_6, arg_121_7, arg_121_8, arg_121_9, arg_121_10, arg_121_11, arg_121_12)
	arg_121_9 = arg_121_9 or false

	local var_121_0 = var_0_0.Battle.BattleLastingAOEData.New(self:GenerateAreaID(), arg_121_2, arg_121_7, arg_121_8, arg_121_11, arg_121_12)

	var_121_0:SetPosition((Clone(arg_121_3)))
	var_121_0:SetWidth(arg_121_4)
	var_121_0:SetHeight(arg_121_5)
	var_121_0:SetAreaType(var_0_3.AreaType.ELLIPSE)
	var_121_0:SetLifeTime(arg_121_6)
	var_121_0:SetFieldType(arg_121_1)
	var_121_0:SetOpponentAffected(not arg_121_9)
	self:CreateAreaOfEffect(var_121_0)

	if arg_121_10 and arg_121_10 ~= "" then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AREA, {
			area = var_121_0,
			FXID = arg_121_10
		}))
	end

	return var_121_0
end

function var_0_9:SpawnLastingCubeArea(arg_122_1, arg_122_2, arg_122_3, arg_122_4, arg_122_5, arg_122_6, arg_122_7, arg_122_8, arg_122_9, arg_122_10, arg_122_11, arg_122_12)
	arg_122_9 = arg_122_9 or false

	local var_122_0 = var_0_0.Battle.BattleLastingAOEData.New(self:GenerateAreaID(), arg_122_2, arg_122_7, arg_122_8, arg_122_11, arg_122_12)

	var_122_0:SetPosition((Clone(arg_122_3)))
	var_122_0:SetWidth(arg_122_4)
	var_122_0:SetHeight(arg_122_5)
	var_122_0:SetAreaType(var_0_3.AreaType.CUBE)
	var_122_0:SetLifeTime(arg_122_6)
	var_122_0:SetFieldType(arg_122_1)
	var_122_0:SetOpponentAffected(not arg_122_9)
	self:CreateAreaOfEffect(var_122_0)

	if arg_122_10 and arg_122_10 ~= "" then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AREA, {
			area = var_122_0,
			FXID = arg_122_10
		}))
	end

	return var_122_0
end

function var_0_9:SpawnTriggerColumnArea(arg_123_1, arg_123_2, arg_123_3, arg_123_4, arg_123_5, arg_123_6, arg_123_7, arg_123_8)
	arg_123_6 = arg_123_6 or false

	local var_123_0 = var_0_0.Battle.BattleTriggerAOEData.New(self:GenerateAreaID(), arg_123_2, arg_123_8)

	var_123_0:SetPosition((Clone(arg_123_3)))
	var_123_0:SetRange(arg_123_4)
	var_123_0:SetAreaType(var_0_3.AreaType.COLUMN)
	var_123_0:SetLifeTime(arg_123_5)
	var_123_0:SetFieldType(arg_123_1)
	var_123_0:SetOpponentAffected(not arg_123_6)
	self:CreateAreaOfEffect(var_123_0)

	if arg_123_7 and arg_123_7 ~= "" then
		self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AREA, {
			area = var_123_0,
			FXID = arg_123_7
		}))
	end

	return var_123_0
end

function var_0_9:CreateAreaOfEffect(arg_124_1)
	self._AOEList[arg_124_1:GetUniqueID()] = arg_124_1

	self._cldSystem:InitAOECld(arg_124_1)
	arg_124_1:StartTimer()

	return
end

function var_0_9:RemoveAreaOfEffect(arg_125_1)
	if not self._AOEList[arg_125_1] then
		return
	end

	self._AOEList[arg_125_1]:Dispose()

	self._AOEList[arg_125_1] = nil

	self._cldSystem:DeleteAOECld(self._AOEList[arg_125_1])
	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AREA, {
		id = arg_125_1
	}))

	return
end

function var_0_9:GetAOEList()
	return self._AOEList
end

function var_0_9:GenerateAreaID()
	self._AOECount = self._AOECount + 1

	return self._AOECount
end

function var_0_9:SpawnWall(arg_128_1, arg_128_2, arg_128_3, arg_128_4)
	local var_128_0 = self:GenerateWallID()
	local var_128_1 = var_0_0.Battle.BattleWallData.New(var_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)

	self._wallList[var_128_0] = var_128_1

	self._cldSystem:InitWallCld(var_128_1)

	return var_128_1
end

function var_0_9:RemoveWall(arg_129_1)
	self._wallList[arg_129_1] = nil

	self._cldSystem:DeleteWallCld(self._wallList[arg_129_1])

	return
end

function var_0_9:SpawnShelter(arg_130_1, arg_130_2)
	local var_130_0 = self:GernerateShelterID()
	local var_130_1 = var_0_0.Battle.BattleShelterData.New(var_130_0)

	self._shelterList[var_130_0] = var_130_1

	return var_130_1
end

function var_0_9:RemoveShelter(arg_131_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_SHELTER, {
		uid = arg_131_1
	}))
	self._shelterList[arg_131_1]:Deactive()

	self._shelterList[arg_131_1] = nil

	return
end

function var_0_9:GetWallList()
	return self._wallList
end

function var_0_9:GenerateWallID()
	self._wallIndex = self._wallIndex + 1

	return self._wallIndex
end

function var_0_9:GernerateShelterID()
	self._shelterIndex = self._shelterIndex + 1

	return self._shelterIndex
end

function var_0_9:SpawnEnvironment(arg_135_1)
	local var_135_0 = self:GernerateEnvironmentID()
	local var_135_1 = var_0_0.Battle.BattleEnvironmentUnit.New(var_135_0, var_0_4.FOE_CODE)

	var_135_1:SetTemplate(arg_135_1)

	local var_135_2 = var_135_1:GetBehaviours()
	local var_135_3 = Vector3(arg_135_1.coordinate[1], arg_135_1.coordinate[2], arg_135_1.coordinate[3])

	local function var_135_4(arg_136_0)
		local var_136_0 = {}

		for iter_136_0, iter_136_1 in ipairs(arg_136_0) do
			if iter_136_1.Active then
				if not self._unitList[iter_136_1.UID]:IsSpectre() then
					table.insert(var_136_0, self._unitList[iter_136_1.UID])
				end
			end
		end

		var_135_1:UpdateFrequentlyCollide(var_136_0)

		return
	end

	local function var_135_5()
		return
	end

	local function var_135_6()
		return
	end

	local var_135_7 = arg_135_1.field_type or var_0_3.BulletField.SURFACE
	local var_135_8 = arg_135_1.IFF or var_0_4.FOE_CODE
	local var_135_9 = 0

	var_135_1:SetAOEData(#arg_135_1.cld_data == 1 and self:SpawnLastingColumnArea(var_135_7, var_135_8, var_135_3, arg_135_1.cld_data[1], var_135_9, var_135_4, var_135_5, false, arg_135_1.prefab, var_135_6, true) or self:SpawnLastingCubeArea(var_135_7, var_135_8, var_135_3, arg_135_1.cld_data[1], arg_135_1.cld_data[2], var_135_9, var_135_4, var_135_5, false, arg_135_1.prefab, var_135_6, true))

	self._environmentList[var_135_0] = var_135_1

	return var_135_1
end

function var_0_9:RemoveEnvironment(arg_139_1)
	self:RemoveAreaOfEffect(self._environmentList[arg_139_1]:GetAOEData():GetUniqueID())
	self._environmentList[arg_139_1]:Dispose()

	self._environmentList[arg_139_1] = nil

	return
end

function var_0_9:DispatchWarning(arg_140_1, arg_140_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.UPDATE_ENVIRONMENT_WARNING, {
		isActive = arg_140_1
	}))

	return
end

function var_0_9:GetEnvironmentList()
	return self._environmentList
end

function var_0_9:GernerateEnvironmentID()
	self._environmentIndex = self._environmentIndex + 1

	return self._environmentIndex
end

function var_0_9:SpawnEffect(arg_143_1, arg_143_2, arg_143_3)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_EFFECT, {
		FXID = arg_143_1,
		position = arg_143_2,
		localScale = arg_143_3
	}))

	return
end

function var_0_9:SpawnUIFX(arg_144_1, arg_144_2, arg_144_3, arg_144_4)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UI_FX, {
		FXID = arg_144_1,
		position = arg_144_2,
		localScale = arg_144_3,
		orderDiff = arg_144_4
	}))

	return
end

function var_0_9:SpawnCameraFX(arg_145_1, arg_145_2, arg_145_3, arg_145_4)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_CAMERA_FX, {
		FXID = arg_145_1,
		position = arg_145_2,
		localScale = arg_145_3,
		orderDiff = arg_145_4
	}))

	return
end

function var_0_9:GetFriendlyCode()
	return self._friendlyCode
end

function var_0_9:GetFoeCode()
	return self._foeCode
end

function var_0_9.GetOppoSideCode(arg_148_0)
	if arg_148_0 == var_0_4.FRIENDLY_CODE then
		return var_0_4.FOE_CODE
	elseif arg_148_0 == var_0_4.FOE_CODE then
		return var_0_4.FRIENDLY_CODE
	end

	return
end

function var_0_9:GetStatistics()
	return self._statistics
end

function var_0_9:BlockManualCast(arg_150_1)
	local var_150_0 = arg_150_1 and 1 or -1

	for iter_150_0, iter_150_1 in pairs(self._fleetList) do
		iter_150_1:SetWeaponBlock(var_150_0)
	end

	return
end

function var_0_9:JamManualCast(arg_151_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.JAMMING, {
		jammingFlag = arg_151_1
	}))

	return
end

function var_0_9:SubmarineStrike(arg_152_1)
	local var_152_0 = self:GetFleetByIFF(arg_152_1)
	local var_152_1 = var_152_0:GetSubAidVO()

	if self._battleInitData.battleType ~= SYSTEM_SCENARIO_SUB_STRIKE and (var_152_0:GetWeaponBlock() or var_152_1:GetCurrent() < 1) then
		return
	end

	for iter_152_0, iter_152_1 in ipairs((var_152_0:GetSubUnitData())) do
		self:InitAidUnitStatistics((self:SpawnSub(iter_152_1, arg_152_1)))
	end

	var_152_0:SubWarcry()

	for iter_152_2, iter_152_3 in ipairs((var_152_0:GetSubList())) do
		if iter_152_2 == 1 then
			iter_152_3:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_LEADER)
		elseif iter_152_2 == 2 then
			iter_152_3:TriggerBuff(var_0_3.BuffEffectType.ON_UPPER_SUB_CONSORT)
		elseif iter_152_2 == 3 then
			iter_152_3:TriggerBuff(var_0_3.BuffEffectType.ON_LOWER_SUB_CONSORT)
		end

		if iter_152_3:GetAimBias() then
			self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_AIM_BIAS, {
				aimBias = iter_152_3:GetAimBias()
			}))
		end
	end

	var_152_1:Cast()

	return
end

function var_0_9:GetWaveFlags()
	return self._waveFlags
end

function var_0_9:AddWaveFlag(arg_154_1)
	if not arg_154_1 then
		return
	end

	local var_154_0 = self:GetWaveFlags()

	if table.contains(var_154_0, arg_154_1) then
		return
	end

	table.insert(var_154_0, arg_154_1)

	return
end

function var_0_9:RemoveFlag(arg_155_1)
	if not arg_155_1 then
		return
	end

	local var_155_0 = self:GetWaveFlags()

	if not table.contains(var_155_0, arg_155_1) then
		return
	end

	table.removebyvalue(var_155_0, arg_155_1)

	return
end

function var_0_9:DispatchCustomWarning(arg_156_1)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.EDIT_CUSTOM_WARNING_LABEL, {
		labelData = arg_156_1
	}))

	return
end

function var_0_9:DispatchGridmanSkill(arg_157_1, arg_157_2)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.GRIDMAN_SKILL_FLOAT, {
		type = arg_157_1,
		IFF = arg_157_2
	}))

	return
end

function var_0_9:SpawnFusionUnit(arg_158_1, arg_158_2, arg_158_3, arg_158_4)
	local var_158_0 = self:generatePlayerUnit(arg_158_2, arg_158_1:GetIFF(), Clone(arg_158_1:GetPosition()), self._commanderBuff)

	var_0_6.SetFusionAttrFromElement(var_158_0, arg_158_1, arg_158_3, arg_158_4)
	var_158_0:SetCurrentHP(var_158_0:GetMaxHP())
	arg_158_1:GetFleetVO():AppendPlayerUnit(var_158_0)
	self:setShipUnitBound(var_158_0)
	var_0_5.AttachWeather(var_158_0, self._weahter)
	self._cldSystem:InitShipCld(var_158_0)
	self:DispatchEvent(var_0_0.Event.New(var_0_1.ADD_UNIT, {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_158_0
	}))

	return var_158_0
end

function var_0_9:DefusionUnit(arg_159_1)
	local var_159_0 = self:GetFleetByIFF((arg_159_1:GetIFF()))

	var_159_0:RemovePlayerUnit(arg_159_1)

	local var_159_1 = {}

	if var_159_0:GetFleetAntiAirWeapon():GetRange() == 0 then
		var_159_1.isShow = false
	end

	self:DispatchEvent(var_0_0.Event.New(var_0_1.ANTI_AIR_AREA, var_159_1))
	arg_159_1:SetDeathReason(var_0_3.UnitDeathReason.DEFUSION)
	self:KillUnit(arg_159_1:GetUniqueID())

	return
end

function var_0_9:FreezeUnit(arg_160_1)
	var_0_6.SetCurrent(arg_160_1, var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY, var_0_4.FUSION_ELEMENT_UNIT_TYPE)
	arg_160_1:UpdateBlindInvisibleBySpectre()
	self:SwitchSpectreUnit(arg_160_1)

	if arg_160_1:GetAimBias() then
		local var_160_0 = arg_160_1:GetAimBias()

		var_160_0:RemoveCrew(arg_160_1)

		if var_160_0:GetCurrentState() == var_160_0.STATE_EXPIRE then
			self:DispatchEvent(var_0_0.Event.New(var_0_1.REMOVE_AIM_BIAS, {
				aimBias = arg_160_1:GetAimBias()
			}))
		end
	end

	arg_160_1:Freeze()

	local var_160_1 = arg_160_1:GetFleetVO()

	if var_160_1 then
		var_160_1:FreezeUnit(arg_160_1)
	end

	return
end

function var_0_9:ActiveFreezeUnit(arg_161_1)
	var_0_6.SetCurrent(arg_161_1, var_0_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY, var_0_4.PLAYER_DEFAULT)
	arg_161_1:UpdateBlindInvisibleBySpectre()
	self:SwitchSpectreUnit(arg_161_1)
	var_0_5.AttachWeather(arg_161_1, self._weahter)
	arg_161_1:ActiveFreeze()

	local var_161_0 = arg_161_1:GetFleetVO()

	if var_161_0 then
		var_161_0:ActiveFreezeUnit(arg_161_1)
	end

	return
end

function var_0_9:GetFleetLegal(arg_162_1, arg_162_2)
	if arg_162_2 == SYSTEM_DUEL or arg_162_2 == SYSTEM_PERFORM or arg_162_2 == SYSTEM_SUB_ROUTINE or arg_162_2 == SYSTEM_CARDPUZZLE or arg_162_2 == SYSTEM_PROLOGUE or arg_162_2 == SYSTEM_DODGEM or arg_162_2 == SYSTEM_SIMULATION or arg_162_2 == SYSTEM_SUBMARINE_RUN or arg_162_2 == SYSTEM_SCENARIO_SUB_STRIKE or arg_162_2 == SYSTEM_DEBUG or arg_162_2 == SYSTEM_AIRFIGHT then
		return true
	else
		local var_162_0 = self:GetFleetByIFF(arg_162_1)

		if #var_162_0:GetScoutList() ~= 0 then
			if not var_162_0:GetFlagShip():IsAlive() then
				do return false end

				goto label_162_0
			end
		end

		return true
	end

	::label_162_0::

	return
end

function var_0_9:TriggerFinishBattle()
	for iter_163_0, iter_163_1 in pairs(self._fleetList) do
		for iter_163_2, iter_163_3 in ipairs((iter_163_1:GetUnitList())) do
			iter_163_3:TriggerBuff(var_0_3.BuffEffectType.ON_FINISH_GAME)
		end
	end

	for iter_163_4, iter_163_5 in pairs(self._minionShipList) do
		iter_163_5:TriggerBuff(var_0_3.BuffEffectType.ON_FINISH_GAME)
	end

	return
end

function var_0_9.ChapterSupportBarrage(arg_164_0, arg_164_1, arg_164_2)
	local var_164_0

	local function var_164_1(...)
		for iter_165_0, iter_165_1 in ipairs(arg_164_0._battleInitData.SupportUnitList) do
			if table.contains(ShipType.BundleList.qian, var_0_5.GetPlayerShipTmpDataFromID(iter_165_1.tmpID).type) then
				var_0_6.SetCurrent(arg_164_0:SpawnSupportUnit(iter_165_1, arg_164_1), "loadSpeed", 0)
			end
		end

		pg.TimeMgr.GetInstance():RemoveBattleTimer(var_164_0)

		return
	end

	if arg_164_2 then
		var_164_0 = pg.TimeMgr.GetInstance():AddBattleTimer("supportBarrageTimer", -1, arg_164_2, var_164_1)
	else
		var_164_1()
	end

	return
end

return
