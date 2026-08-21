ys = ys or {}

local var_0_0 = ys.Battle.BattleEvent
local var_0_1 = ys.Battle.BattleFormulas
local var_0_2 = ys.Battle.BattleConst
local var_0_3 = ys.Battle.BattleConfig
local var_0_4 = ys.Battle.BattleDataFunction
local var_0_5 = ys.Battle.BattleAttr
local var_0_6 = ys.Battle.BattleVariable
local var_0_7 = ys.Battle.BattleCardPuzzleEvent
local var_0_8 = singletonClass("BattleDataProxy", ys.MVC.Proxy)

ys.Battle.BattleDataProxy = var_0_8
var_0_8.__name = "BattleDataProxy"

function var_0_8.Ctor(arg_1_0)
	var_0_8.super.Ctor(arg_1_0)

	return
end

function var_0_8.InitBattle(arg_2_0, arg_2_1)
	arg_2_0.Update = arg_2_0.updateInit

	local var_2_0 = arg_2_1.battleType == SYSTEM_WORLD or arg_2_1.battleType == SYSTEM_WORLD_BOSS
	local var_2_1 = pg.SdkMgr.GetInstance():CheckPretest()

	if var_2_1 then
		local var_2_2 = PlayerPrefs.GetInt("stage_scratch") or 0

		var_2_1 = var_2_2 == 1
	end

	local var_2_3 = arg_2_0

	if var_2_1 then
		local var_2_5 = GodenFnger or var_0_1.CreateContextCalculateDamage(var_2_0)

		var_2_4(var_2_3, var_2_5)
		arg_2_0:SetupDamageKamikazeAir()
		arg_2_0:SetupDamageKamikazeShip()
		arg_2_0:SetupDamageCrush()
		var_0_6.Init()
		arg_2_0:InitData(arg_2_1)
		arg_2_0:DispatchEvent(var_0.Event.New(var_0_0.STAGE_DATA_INIT_FINISH))
		arg_2_0._cameraUtil:Initialize()

		arg_2_0._cameraTop, arg_2_0._cameraBottom, arg_2_0._cameraLeft, arg_2_0._cameraRight = arg_2_0._cameraUtil:SetMapData(arg_2_0:GetTotalBounds())

		arg_2_0:InitWeatherData()
		arg_2_0:InitUserShipsData(arg_2_0._battleInitData.MainUnitList, arg_2_0._battleInitData.VanguardUnitList, var_0_3.FRIENDLY_CODE, arg_2_0._battleInitData.SubUnitList)
		arg_2_0:InitUserSupportShipsData(var_0_3.FRIENDLY_CODE, arg_2_0._battleInitData.SupportUnitList)
		arg_2_0:InitUserAidData()
		arg_2_0:SetSubmarinAidData()
		arg_2_0._cameraUtil:SetFocusFleet(arg_2_0:GetFleetByIFF(var_0_3.FRIENDLY_CODE))
		arg_2_0:StatisticsInit(arg_2_0._fleetList[var_0_3.FRIENDLY_CODE]:GetUnitList())
		arg_2_0:SetFlagShipID(arg_2_0:GetFleetByIFF(var_0_3.FRIENDLY_CODE):GetFlagShip())
		arg_2_0:DispatchEvent(var_0.Event.New(var_0_0.COMMON_DATA_INIT_FINISH, {}))

		return
	end
end

function var_0_8.OnCameraRatioUpdate(arg_3_0)
	arg_3_0._cameraTop, arg_3_0._cameraBottom, arg_3_0._cameraLeft, arg_3_0._cameraRight = arg_3_0._cameraUtil:SetMapData(arg_3_0:GetTotalBounds())

	arg_3_0._cameraUtil:setArrowPoint()

	return
end

function var_0_8.Start(arg_4_0)
	arg_4_0._startTimeStamp = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function var_0_8.TriggerBattleInitBuffs(arg_5_0)
	for iter_5_0, iter_5_1 in pairs(arg_5_0._fleetList) do
		local var_5_0 = iter_5_1:GetUnitList()

		iter_5_1:FleetBuffTrigger(var_0_2.BuffEffectType.ON_INIT_GAME)
	end

	return
end

function var_0_8.TirggerBattleStartBuffs(arg_6_0)
	for iter_6_0, iter_6_1 in pairs(arg_6_0._fleetList) do
		local var_6_0 = iter_6_1:GetUnitList()
		local var_6_1 = iter_6_1:GetScoutList()
		local var_6_2 = var_6_1[1]

		if #var_6_1 > 1 then
			local var_6_3 = var_6_1[#var_6_1] or nil

			if #var_6_1 == 3 then
				local var_6_4 = var_6_1[2] or nil
				local var_6_5 = iter_6_1:GetMainList()

				for iter_6_2, iter_6_3 in ipairs(var_6_0) do
					local var_6_6 = arg_6_0._battleInitData.ChapterBuffIDs or {}

					underscore.each(var_6_6, function(arg_7_0)
						iter_6_3:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_7_0)))

						return
					end)

					local var_6_7 = arg_6_0._battleInitData.GlobalBuffIDs or {}

					underscore.each(var_6_7, function(arg_8_0)
						arg_8_0 = tonumber(arg_8_0)

						iter_6_3:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_8_0)))

						return
					end)

					if arg_6_0._battleInitData.MapAuraSkills then
						for iter_6_4, iter_6_5 in ipairs(arg_6_0._battleInitData.MapAuraSkills) do
							iter_6_3:AddBuff((var_0.Battle.BattleBuffUnit.New(iter_6_5.id, iter_6_5.level)))
						end
					end

					if arg_6_0._battleInitData.MapAidSkills then
						for iter_6_6, iter_6_7 in ipairs(arg_6_0._battleInitData.MapAidSkills) do
							iter_6_3:AddBuff((var_0.Battle.BattleBuffUnit.New(iter_6_7.id, iter_6_7.level)))
						end
					end

					if arg_6_0._currentStageData.stageBuff then
						for iter_6_8, iter_6_9 in ipairs(arg_6_0._currentStageData.stageBuff) do
							iter_6_3:AddBuff((var_0.Battle.BattleBuffUnit.New(iter_6_9.id, iter_6_9.level)))
						end
					end

					iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_START_GAME)

					if iter_6_3 == var_6_5[1] then
						iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_FLAG_SHIP)
					elseif iter_6_3 == var_6_5[2] then
						iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_UPPER_CONSORT)
					elseif iter_6_3 == var_6_5[3] then
						iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_LOWER_CONSORT)
					elseif iter_6_3 == var_6_2 then
						iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_LEADER)
					elseif iter_6_3 == var_6_4 then
						iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_CENTER)
					elseif iter_6_3 == var_6_3 then
						iter_6_3:TriggerBuff(var_0_2.BuffEffectType.ON_REAR)
					end
				end

				for iter_6_10, iter_6_11 in ipairs((iter_6_1:GetSupportUnitList())) do
					local var_6_8 = arg_6_0._battleInitData.ChapterBuffIDs or {}

					underscore.each(var_6_8, function(arg_9_0)
						local var_9_0 = var_0_4.GetSLGStrategyBuffByCombatBuffID(arg_9_0)

						if var_9_0 and var_9_0.type == ChapterConst.AirDominanceStrategyBuffType then
							iter_6_11:AddBuff((var_0.Battle.BattleBuffUnit.New(arg_9_0)))
						end

						return
					end)
				end
			end
		end
	end

	return
end

function var_0_8.InitAllFleetUnitsWeaponCD(arg_10_0)
	for iter_10_0, iter_10_1 in pairs(arg_10_0._fleetList) do
		for iter_10_2, iter_10_3 in ipairs((iter_10_1:GetUnitList())) do
			var_0_8.InitUnitWeaponCD(iter_10_3)
		end
	end

	return
end

function var_0_8.InitUnitWeaponCD(arg_11_0)
	arg_11_0:CheckWeaponInitial()

	return
end

function var_0_8.StartCardPuzzle(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0._fleetList) do
		iter_12_1:GetCardPuzzleComponent():Start()
	end

	return
end

function var_0_8.PausePuzzleComponent(arg_13_0)
	for iter_13_0, iter_13_1 in pairs(arg_13_0._fleetList) do
		local var_13_0 = iter_13_1:GetCardPuzzleComponent()

		if var_13_0 then
			var_13_0:BlockComponentByCard(true)
		end
	end

	return
end

function var_0_8.ResumePuzzleComponent(arg_14_0)
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

function var_0_8.GetInitData(arg_16_0)
	return arg_16_0._battleInitData
end

function var_0_8.GetDungeonData(arg_17_0)
	return arg_17_0._dungeonInfo
end

function var_0_8.InitData(arg_18_0, arg_18_1)
	arg_18_0.FrameIndex = 1
	arg_18_0._friendlyCode = 1
	arg_18_0._foeCode = -1
	var_0_2.FRIENDLY_CODE = 1
	var_0_2.FOE_CODE = -1
	arg_18_0._completelyRepress = false
	arg_18_0._repressReduce = 1
	arg_18_0._repressLevel = 0
	arg_18_0._repressEnemyHpRant = 1
	arg_18_0._friendlyShipList = {}
	arg_18_0._foeShipList = {}
	arg_18_0._friendlyAircraftList = {}
	arg_18_0._foeAircraftList = {}
	arg_18_0._minionShipList = {}
	arg_18_0._spectreShipList = {}
	arg_18_0._fleetList = {}
	arg_18_0._freeShipList = {}
	arg_18_0._teamList = {}
	arg_18_0._waveSummonList = {}
	arg_18_0._aidUnitList = {}
	arg_18_0._unitList = {}
	arg_18_0._unitCount = 0
	arg_18_0._bulletList = {}
	arg_18_0._bulletCount = 0
	arg_18_0._aircraftList = {}
	arg_18_0._aircraftCount = 0
	arg_18_0._AOEList = {}
	arg_18_0._AOECount = 0
	arg_18_0._wallList = {}
	arg_18_0._wallIndex = 0
	arg_18_0._shelterList = {}
	arg_18_0._shelterIndex = 0
	arg_18_0._environmentList = {}
	arg_18_0._environmentIndex = 0
	arg_18_0._deadUnitList = {}
	arg_18_0._enemySubmarineCount = 0
	arg_18_0._airFighterList = {}
	arg_18_0._currentStageIndex = 1
	arg_18_0._battleInitData = arg_18_1
	arg_18_0._expeditionID = arg_18_1.StageTmpId
	arg_18_0._expeditionTmp = pg.expedition_data_template[arg_18_0._expeditionID]

	local var_18_0 = arg_18_1.WorldLevel or arg_18_0._expeditionTmp.level

	arg_18_0:SetDungeonLevel(var_18_0)

	arg_18_0._dungeonID = arg_18_0._expeditionTmp.dungeon_id
	arg_18_0._dungeonInfo = var_0_4.GetDungeonTmpDataByID(arg_18_0._dungeonID)

	if arg_18_1.WorldMapId then
		arg_18_0._mapId = arg_18_1.WorldMapId
	elseif arg_18_0._expeditionTmp.map_id then
		if #arg_18_0._expeditionTmp.map_id == 1 then
			arg_18_0._mapId = arg_18_0._expeditionTmp.map_id[1][1]
		else
			local var_18_1 = {}

			for iter_18_0, iter_18_1 in ipairs(arg_18_0._expeditionTmp.map_id) do
				table.insert(var_18_1, {
					rst = iter_18_1[1],
					weight = iter_18_1[2] * 100
				})
			end

			arg_18_0._mapId = var_0_1.WeightRandom(var_18_1)
		end
	end

	arg_18_0._weahter = arg_18_1.ChapterWeatherIDS or {}
	arg_18_0._exposeSpeed = arg_18_0._expeditionTmp.expose_speed
	arg_18_0._airExpose = arg_18_0._expeditionTmp.aircraft_expose[1]
	arg_18_0._airExposeEX = arg_18_0._expeditionTmp.aircraft_expose[2]
	arg_18_0._shipExpose = arg_18_0._expeditionTmp.ship_expose[1]
	arg_18_0._shipExposeEX = arg_18_0._expeditionTmp.ship_expose[2]
	arg_18_0._commander = arg_18_1.CommanderList or {}
	arg_18_0._subCommander = arg_18_1.SubCommanderList or {}
	arg_18_0._commanderBuff = arg_18_0.initCommanderBuff(arg_18_0._commander)
	arg_18_0._subCommanderBuff = arg_18_0.initCommanderBuff(arg_18_0._subCommander)

	if arg_18_0._battleInitData.RepressInfo then
		if arg_18_0._battleInitData.battleType == SYSTEM_SCENARIO then
			if arg_18_0._battleInitData.RepressInfo.repressCount >= arg_18_0._battleInitData.RepressInfo.repressMax then
				arg_18_0._completelyRepress = true
			end

			arg_18_0._repressReduce = var_0_1.ChapterRepressReduce(arg_18_0._battleInitData.RepressInfo.repressReduce)
			arg_18_0._repressLevel = arg_18_0._battleInitData.RepressInfo.repressLevel
			arg_18_0._repressEnemyHpRant = arg_18_0._battleInitData.RepressInfo.repressEnemyHpRant
		elseif arg_18_0._battleInitData.battleType == SYSTEM_WORLD or arg_18_0._battleInitData.battleType == SYSTEM_WORLD_BOSS then
			arg_18_0._repressEnemyHpRant = arg_18_0._battleInitData.RepressInfo.repressEnemyHpRant
		end
	end

	arg_18_0._chapterWinningStreak = arg_18_0._battleInitData.DefeatCount or 0
	arg_18_0._waveFlags = table.shallowCopy(arg_18_1.StageWaveFlags) or {}

	arg_18_0:InitStageData()

	arg_18_0._cldSystem = var_0.Battle.BattleCldSystem.New(arg_18_0)
	arg_18_0._cameraUtil = var_0.Battle.BattleCameraUtil.GetInstance()

	arg_18_0:initBGM()

	return
end

function var_0_8.initBGM(arg_19_0)
	arg_19_0._initBGMList = {}
	arg_19_0._otherBGMList = {}

	local var_19_0 = {}
	local var_19_1 = {}

	;(function(arg_20_0)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			if iter_20_1.skills then
				for iter_20_2, iter_20_3 in ipairs(iter_20_1.skills) do
					table.insert({}, iter_20_3)
				end
			end

			if iter_20_1.equipment then
				for iter_20_4, iter_20_5 in ipairs((var_0_4.GetEquipSkill(iter_20_1.equipment, arg_19_0._battleInitData.battleType))) do
					({})[iter_20_5.buffID] = {
						id = iter_20_5.buffID,
						level = iter_20_5.buffLV
					}
				end
			end

			local var_20_0 = var_0_4.GetSongList({})

			for iter_20_6, iter_20_7 in pairs(var_20_0.initList) do
				var_19_0[iter_20_6] = true
			end

			for iter_20_8, iter_20_9 in pairs(var_20_0.otherList) do
				var_19_1[iter_20_8] = true
			end
		end

		return
	end)(arg_19_0._battleInitData.MainUnitList)
	;(function(arg_20_0)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			if iter_20_1.skills then
				for iter_20_2, iter_20_3 in ipairs(iter_20_1.skills) do
					table.insert({}, iter_20_3)
				end
			end

			if iter_20_1.equipment then
				for iter_20_4, iter_20_5 in ipairs((var_0_4.GetEquipSkill(iter_20_1.equipment, arg_19_0._battleInitData.battleType))) do
					({})[iter_20_5.buffID] = {
						id = iter_20_5.buffID,
						level = iter_20_5.buffLV
					}
				end
			end

			local var_20_0 = var_0_4.GetSongList({})

			for iter_20_6, iter_20_7 in pairs(var_20_0.initList) do
				var_19_0[iter_20_6] = true
			end

			for iter_20_8, iter_20_9 in pairs(var_20_0.otherList) do
				var_19_1[iter_20_8] = true
			end
		end

		return
	end)(arg_19_0._battleInitData.VanguardUnitList)
	;(function(arg_20_0)
		for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
			if iter_20_1.skills then
				for iter_20_2, iter_20_3 in ipairs(iter_20_1.skills) do
					table.insert({}, iter_20_3)
				end
			end

			if iter_20_1.equipment then
				for iter_20_4, iter_20_5 in ipairs((var_0_4.GetEquipSkill(iter_20_1.equipment, arg_19_0._battleInitData.battleType))) do
					({})[iter_20_5.buffID] = {
						id = iter_20_5.buffID,
						level = iter_20_5.buffLV
					}
				end
			end

			local var_20_0 = var_0_4.GetSongList({})

			for iter_20_6, iter_20_7 in pairs(var_20_0.initList) do
				var_19_0[iter_20_6] = true
			end

			for iter_20_8, iter_20_9 in pairs(var_20_0.otherList) do
				var_19_1[iter_20_8] = true
			end
		end

		return
	end)(arg_19_0._battleInitData.SubUnitList)

	if arg_19_0._battleInitData.RivalMainUnitList then
		(function(arg_20_0)
			for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
				if iter_20_1.skills then
					for iter_20_2, iter_20_3 in ipairs(iter_20_1.skills) do
						table.insert({}, iter_20_3)
					end
				end

				if iter_20_1.equipment then
					for iter_20_4, iter_20_5 in ipairs((var_0_4.GetEquipSkill(iter_20_1.equipment, arg_19_0._battleInitData.battleType))) do
						({})[iter_20_5.buffID] = {
							id = iter_20_5.buffID,
							level = iter_20_5.buffLV
						}
					end
				end

				local var_20_0 = var_0_4.GetSongList({})

				for iter_20_6, iter_20_7 in pairs(var_20_0.initList) do
					var_19_0[iter_20_6] = true
				end

				for iter_20_8, iter_20_9 in pairs(var_20_0.otherList) do
					var_19_1[iter_20_8] = true
				end
			end

			return
		end)(arg_19_0._battleInitData.RivalMainUnitList)
	end

	if arg_19_0._battleInitData.RivalVanguardUnitList then
		(function(arg_20_0)
			for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
				if iter_20_1.skills then
					for iter_20_2, iter_20_3 in ipairs(iter_20_1.skills) do
						table.insert({}, iter_20_3)
					end
				end

				if iter_20_1.equipment then
					for iter_20_4, iter_20_5 in ipairs((var_0_4.GetEquipSkill(iter_20_1.equipment, arg_19_0._battleInitData.battleType))) do
						({})[iter_20_5.buffID] = {
							id = iter_20_5.buffID,
							level = iter_20_5.buffLV
						}
					end
				end

				local var_20_0 = var_0_4.GetSongList({})

				for iter_20_6, iter_20_7 in pairs(var_20_0.initList) do
					var_19_0[iter_20_6] = true
				end

				for iter_20_8, iter_20_9 in pairs(var_20_0.otherList) do
					var_19_1[iter_20_8] = true
				end
			end

			return
		end)(arg_19_0._battleInitData.RivalVanguardUnitList)
	end

	for iter_19_0, iter_19_1 in pairs({}) do
		table.insert(arg_19_0._initBGMList, iter_19_0)
	end

	for iter_19_2, iter_19_3 in pairs({}) do
		table.insert(arg_19_0._otherBGMList, iter_19_2)
	end

	return
end

function var_0_8.initCommanderBuff(arg_21_0)
	for iter_21_0, iter_21_1 in ipairs(arg_21_0) do
		local var_21_0 = iter_21_1[1]:getSkills()[1]:getLevel()

		for iter_21_2, iter_21_3 in ipairs(iter_21_1[2]) do
			table.insert({}, {
				id = iter_21_3,
				level = var_21_0,
				commander = iter_21_1[1]
			})
		end
	end

	return {}
end

function var_0_8.Clear(arg_22_0)
	for iter_22_0, iter_22_1 in pairs(arg_22_0._teamList) do
		arg_22_0:KillNPCTeam(iter_22_1)
	end

	arg_22_0._teamList = nil

	for iter_22_2, iter_22_3 in pairs(arg_22_0._bulletList) do
		arg_22_0:RemoveBulletUnit(iter_22_2)
	end

	arg_22_0._bulletList = nil

	for iter_22_4, iter_22_5 in pairs(arg_22_0._unitList) do
		arg_22_0:KillUnit(iter_22_4)
	end

	arg_22_0._unitList = nil

	for iter_22_6, iter_22_7 in ipairs(arg_22_0._deadUnitList) do
		iter_22_7:Dispose()
	end

	arg_22_0._deadUnitList = nil

	for iter_22_8, iter_22_9 in pairs(arg_22_0._aircraftList) do
		arg_22_0:KillAircraft(iter_22_8)
	end

	arg_22_0._aircraftList = nil

	for iter_22_10, iter_22_11 in pairs(arg_22_0._fleetList) do
		iter_22_11:Dispose()

		arg_22_0._fleetList[iter_22_10] = nil
	end

	arg_22_0._fleetList = nil

	for iter_22_12, iter_22_13 in pairs(arg_22_0._aidUnitList) do
		iter_22_13:Dispose()
	end

	arg_22_0._aidUnitList = nil

	for iter_22_14, iter_22_15 in pairs(arg_22_0._environmentList) do
		arg_22_0:RemoveEnvironment(iter_22_15:GetUniqueID())
	end

	arg_22_0._environmentList = nil

	for iter_22_16, iter_22_17 in pairs(arg_22_0._AOEList) do
		arg_22_0:RemoveAreaOfEffect(iter_22_16)
	end

	arg_22_0._AOEList = nil

	arg_22_0._cldSystem:Dispose()

	arg_22_0._cldSystem = nil
	arg_22_0._dungeonInfo = nil
	arg_22_0._flagShipUnit = nil
	arg_22_0._friendlyShipList = nil
	arg_22_0._foeShipList = nil
	arg_22_0._spectreShipList = nil
	arg_22_0._friendlyAircraftList = nil
	arg_22_0._foeAircraftList = nil
	arg_22_0._fleetList = nil
	arg_22_0._freeShipList = nil
	arg_22_0._countDown = nil
	arg_22_0._lastUpdateTime = nil
	arg_22_0._statistics = nil
	arg_22_0._battleInitData = nil
	arg_22_0._currentStageData = nil

	arg_22_0:ClearFormulas()
	var_0_4.ClearDungeonCfg(arg_22_0._dungeonID)

	return
end

function var_0_8.DeactiveProxy(arg_23_0)
	arg_23_0._state = nil

	arg_23_0:Clear()
	var_0.Battle.BattleDataProxy.super.DeactiveProxy(arg_23_0)

	return
end

function var_0_8.InitUserShipsData(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	for iter_24_0, iter_24_1 in ipairs(arg_24_2) do
		local var_24_0 = arg_24_0:SpawnVanguard(iter_24_1, arg_24_3)
	end

	for iter_24_2, iter_24_3 in ipairs(arg_24_1) do
		local var_24_1 = arg_24_0:SpawnMain(iter_24_3, arg_24_3)
	end

	local var_24_2 = arg_24_0:GetFleetByIFF(arg_24_3)

	var_24_2:FleetUnitSpwanFinish()

	if arg_24_0._battleInitData.battleType == SYSTEM_SUBMARINE_RUN or arg_24_0._battleInitData.battleType == SYSTEM_SUB_ROUTINE then
		for iter_24_4, iter_24_5 in ipairs(arg_24_4) do
			arg_24_0:SpawnManualSub(iter_24_5, arg_24_3)
		end

		var_24_2:ShiftManualSub()
	else
		var_24_2:SetSubUnitData(arg_24_4)
	end

	if arg_24_0._battleInitData.battleType == SYSTEM_DUEL then
		for iter_24_6, iter_24_7 in ipairs(var_24_2:GetCloakList()) do
			iter_24_7:GetCloak():SetRecoverySpeed(0)
		end
	end

	arg_24_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_FLEET, {
		fleetVO = var_24_2
	}))

	return
end

function var_0_8.InitUserSupportShipsData(arg_25_0, arg_25_1, arg_25_2)
	for iter_25_0, iter_25_1 in ipairs(arg_25_2) do
		if table.contains(ShipType.BundleList.hang, var_0_4.GetPlayerShipTmpDataFromID(iter_25_1.tmpID).type) then
			local var_25_0 = arg_25_0:SpawnSupportUnit(iter_25_1, arg_25_1)
		end
	end

	return
end

function var_0_8.InitUserAidData(arg_26_0)
	for iter_26_0, iter_26_1 in ipairs(arg_26_0._battleInitData.AidUnitList) do
		local var_26_0 = arg_26_0:GenerateUnitID()

		iter_26_1.properties.level = iter_26_1.level
		iter_26_1.properties.formationID = var_0_3.FORMATION_ID
		iter_26_1.properties.id = iter_26_1.id

		var_0_1.AttrFixer(arg_26_0._battleInitData.battleType, iter_26_1.properties)

		local var_26_1 = iter_26_1.proficiency or {
			1,
			1,
			1
		}
		local var_26_2 = var_0_4.CreateBattleUnitData(var_26_0, var_0_2.UnitType.PLAYER_UNIT, var_0_3.FRIENDLY_CODE, iter_26_1.tmpID, iter_26_1.skinId, iter_26_1.equipment, iter_26_1.properties, iter_26_1.baseProperties, var_26_1, iter_26_1.baseList, iter_26_1.preloasList)
		local var_26_3 = var_26_2:GetUniqueID()

		arg_26_0._aidUnitList[var_26_3] = var_26_2
	end

	return
end

function var_0_8.SetSubmarinAidData(arg_27_0)
	arg_27_0:GetFleetByIFF(var_0_3.FRIENDLY_CODE):SetSubAidData(arg_27_0._battleInitData.TotalSubAmmo, arg_27_0._battleInitData.SubFlag)

	return
end

function var_0_8.AddWeather(arg_28_0, arg_28_1)
	table.insert(arg_28_0._weahter, arg_28_1)
	arg_28_0:InitWeatherData()

	return
end

function var_0_8.InitWeatherData(arg_29_0)
	for iter_29_0, iter_29_1 in ipairs(arg_29_0._weahter) do
		if iter_29_1 == var_0_2.WEATHER.NIGHT then
			for iter_29_2, iter_29_3 in pairs(arg_29_0._fleetList) do
				iter_29_3:AttachNightCloak()
			end

			for iter_29_4, iter_29_5 in pairs(arg_29_0._unitList) do
				var_0_4.AttachWeather(iter_29_5, arg_29_0._weahter)
			end
		end
	end

	return
end

function var_0_8.CelebrateVictory(arg_30_0, arg_30_1)
	local var_30_0 = arg_30_1 == arg_30_0:GetFoeCode() and arg_30_0._foeShipList or arg_30_0._friendlyShipList

	for iter_30_0, iter_30_1 in pairs(var_30_0) do
		iter_30_1:StateChange(var_0.Battle.UnitState.STATE_VICTORY)
	end

	return
end

function var_0_8.InitStageData(arg_31_0)
	arg_31_0._currentStageData = arg_31_0._dungeonInfo.stages[arg_31_0._currentStageIndex]
	arg_31_0._countDown = arg_31_0._currentStageData.timeCount
	arg_31_0._totalLeftBound = arg_31_0._currentStageData.totalArea[1]
	arg_31_0._totalRightBound = arg_31_0._currentStageData.totalArea[1] + arg_31_0._currentStageData.totalArea[3]
	arg_31_0._totalUpperBound = arg_31_0._currentStageData.totalArea[2] + arg_31_0._currentStageData.totalArea[4]
	arg_31_0._totalLowerBound = arg_31_0._currentStageData.totalArea[2]
	arg_31_0._leftZoneLeftBound = arg_31_0._currentStageData.playerArea[1]
	arg_31_0._leftZoneRightBound = arg_31_0._currentStageData.playerArea[1] + arg_31_0._currentStageData.playerArea[3]
	arg_31_0._leftZoneUpperBound = arg_31_0._currentStageData.playerArea[2] + arg_31_0._currentStageData.playerArea[4]
	arg_31_0._leftZoneLowerBound = arg_31_0._currentStageData.playerArea[2]
	arg_31_0._rightZoneLeftBound = arg_31_0._leftZoneRightBound
	arg_31_0._rightZoneRightBound = arg_31_0._totalRightBound
	arg_31_0._rightZoneUpperBound = arg_31_0._leftZoneUpperBound
	arg_31_0._rightZoneLowerBound = arg_31_0._leftZoneLowerBound
	arg_31_0._bulletUpperBound = arg_31_0._totalUpperBound + 3
	arg_31_0._bulletLowerBound = arg_31_0._totalLowerBound - 10
	arg_31_0._bulletLeftBound = arg_31_0._totalLeftBound - 10
	arg_31_0._bulletRightBound = arg_31_0._totalRightBound + 10
	arg_31_0._bulletUpperBoundVision = arg_31_0._totalUpperBound + var_0_3.BULLET_UPPER_BOUND_VISION_OFFSET
	arg_31_0._bulletLowerBoundSplit = arg_31_0._bulletLowerBound + var_0_3.BULLET_LOWER_BOUND_SPLIT_OFFSET
	arg_31_0._bulletLeftBoundSplit = arg_31_0._bulletLeftBound + var_0_3.BULLET_LEFT_BOUND_SPLIT_OFFSET

	if arg_31_0._battleInitData.battleType == SYSTEM_DUEL then
		arg_31_0._leftFieldBound = arg_31_0._totalLeftBound
		arg_31_0._rightFieldBound = arg_31_0._totalRightBound
	else
		local var_31_0 = arg_31_0._currentStageData.mainUnitPosition and arg_31_0._currentStageData.mainUnitPosition[var_0_3.FRIENDLY_CODE] and arg_31_0._currentStageData.mainUnitPosition[var_0_3.FRIENDLY_CODE][1].x or var_0_3.MAIN_UNIT_POS[var_0_3.FRIENDLY_CODE][1].x

		arg_31_0._leftFieldBound = var_31_0 - 1
		arg_31_0._rightFieldBound = arg_31_0._totalRightBound + var_0_3.FIELD_RIGHT_BOUND_BIAS
	end

	return
end

function var_0_8.GetVanguardBornCoordinate(arg_32_0, arg_32_1)
	if arg_32_1 == var_0_3.FRIENDLY_CODE then
		return arg_32_0._currentStageData.fleetCorrdinate
	elseif arg_32_1 == var_0_3.FOE_CODE then
		return arg_32_0._currentStageData.rivalCorrdinate
	end

	return
end

function var_0_8.GetTotalBounds(arg_33_0)
	return arg_33_0._totalUpperBound, arg_33_0._totalLowerBound, arg_33_0._totalLeftBound, arg_33_0._totalRightBound
end

function var_0_8.GetTotalRightBound(arg_34_0)
	return arg_34_0._totalRightBound
end

function var_0_8.GetTotalLowerBound(arg_35_0)
	return arg_35_0._totalLowerBound
end

function var_0_8.GetUnitBoundByIFF(arg_36_0, arg_36_1)
	if arg_36_1 == var_0_3.FRIENDLY_CODE then
		return arg_36_0._leftZoneUpperBound, arg_36_0._leftZoneLowerBound, arg_36_0._leftZoneLeftBound, var_0_3.MaxRight, var_0_3.MaxLeft, arg_36_0._leftZoneRightBound
	elseif arg_36_1 == var_0_3.FOE_CODE then
		return arg_36_0._rightZoneUpperBound, arg_36_0._rightZoneLowerBound, arg_36_0._rightZoneLeftBound, arg_36_0._rightZoneRightBound, arg_36_0._rightZoneLeftBound, var_0_3.MaxRight
	end

	return
end

function var_0_8.GetFleetBoundByIFF(arg_37_0, arg_37_1)
	if arg_37_1 == var_0_3.FRIENDLY_CODE then
		return arg_37_0._leftZoneUpperBound, arg_37_0._leftZoneLowerBound, arg_37_0._leftZoneLeftBound, arg_37_0._leftZoneRightBound
	elseif arg_37_1 == var_0_3.FOE_CODE then
		return arg_37_0._rightZoneUpperBound, arg_37_0._rightZoneLowerBound, arg_37_0._rightZoneLeftBound, arg_37_0._rightZoneRightBound
	end

	return
end

function var_0_8.ShiftFleetBound(arg_38_0, arg_38_1, arg_38_2)
	arg_38_1:GetUnitBound():SwtichDuelAggressive()
	arg_38_1:SetAutobotBound(arg_38_0:GetFleetBoundByIFF(arg_38_2))
	arg_38_1:UpdateScoutUnitBound()

	return
end

function var_0_8.GetFieldBound(arg_39_0)
	if arg_39_0._battleInitData and arg_39_0._battleInitData.battleType == SYSTEM_DUEL then
		return arg_39_0:GetTotalBounds()
	else
		return arg_39_0._totalUpperBound, arg_39_0._totalLowerBound, arg_39_0._leftFieldBound, arg_39_0._rightFieldBound
	end

	return
end

function var_0_8.GetFleetByIFF(arg_40_0, arg_40_1)
	if arg_40_0._fleetList[arg_40_1] == nil then
		local var_40_0 = var_0.Battle.BattleFleetVO.New(arg_40_1)

		arg_40_0._fleetList[arg_40_1] = var_40_0

		var_40_0:SetAutobotBound(arg_40_0:GetFleetBoundByIFF(arg_40_1))
		var_40_0:SetTotalBound(arg_40_0:GetTotalBounds())
		var_40_0:SetUnitBound(arg_40_0._currentStageData.totalArea, arg_40_0._currentStageData.playerArea)
		var_40_0:SetExposeLine(arg_40_0._expeditionTmp.horizon_line[arg_40_1], arg_40_0._expeditionTmp.expose_line[arg_40_1])
		var_40_0:CalcSubmarineBaseLine(arg_40_0._battleInitData.battleType)
		var_40_0:SetChapterPlayType(arg_40_0._battleInitData.ChapterType)

		if arg_40_0._battleInitData.battleType == SYSTEM_CARDPUZZLE then
			local var_40_1 = var_40_0:AttachCardPuzzleComponent()

			var_40_1:InitCardPuzzleData({
				cardList = arg_40_0._battleInitData.CardPuzzleCardIDList,
				commonHP = arg_40_0._battleInitData.CardPuzzleCommonHPValue,
				relicList = arg_40_0._battleInitData.CardPuzzleRelicList
			})
			var_40_1:CustomConfigID(arg_40_0._battleInitData.CardPuzzleCombatID)
			arg_40_0:DispatchEvent(var_0.Event.New(var_0_7.CARD_PUZZLE_INIT))
		end
	end

	return arg_40_0._fleetList[arg_40_1]
end

function var_0_8.GetAidUnit(arg_41_0)
	return arg_41_0._aidUnitList
end

function var_0_8.GetFleetList(arg_42_0)
	return arg_42_0._fleetList
end

function var_0_8.GetEnemySubmarineCount(arg_43_0)
	return arg_43_0._enemySubmarineCount
end

function var_0_8.GetCommander(arg_44_0)
	return arg_44_0._commander
end

function var_0_8.GetCommanderBuff(arg_45_0)
	return arg_45_0._commanderBuff, arg_45_0._subCommanderBuff
end

function var_0_8.GetStageInfo(arg_46_0)
	return arg_46_0._currentStageData
end

function var_0_8.GetWinningStreak(arg_47_0)
	return arg_47_0._chapterWinningStreak
end

function var_0_8.GetBGMList(arg_48_0, arg_48_1)
	if not arg_48_1 then
		return arg_48_0._initBGMList
	else
		return arg_48_0._otherBGMList
	end

	return
end

function var_0_8.GetDungeonLevel(arg_49_0)
	return arg_49_0._dungeonLevel
end

function var_0_8.SetDungeonLevel(arg_50_0, arg_50_1)
	arg_50_0._dungeonLevel = arg_50_1

	return
end

function var_0_8.IsCompletelyRepress(arg_51_0)
	return arg_51_0._completelyRepress
end

function var_0_8.GetRepressReduce(arg_52_0)
	return arg_52_0._repressReduce
end

function var_0_8.GetRepressLevel(arg_53_0)
	return arg_53_0._repressLevel
end

function var_0_8.updateInit(arg_54_0, arg_54_1)
	arg_54_0:TriggerBattleInitBuffs()

	arg_54_0.checkCld = true

	arg_54_0:updateLoop(arg_54_1)

	arg_54_0.Update = arg_54_0.updateLoop

	return
end

function var_0_8.updateLoop(arg_55_0, arg_55_1)
	arg_55_0.FrameIndex = arg_55_0.FrameIndex + 1

	arg_55_0:updateDeadList()
	arg_55_0:UpdateCountDown(arg_55_1)
	arg_55_0:UpdateWeather(arg_55_1)

	for iter_55_0, iter_55_1 in pairs(arg_55_0._fleetList) do
		iter_55_1:UpdateMotion()
	end

	arg_55_0.checkCld = not arg_55_0.checkCld

	local var_55_0 = {
		[var_0_3.FRIENDLY_CODE] = arg_55_0._totalLeftBound,
		[var_0_3.FOE_CODE] = arg_55_0._totalRightBound
	}

	for iter_55_2, iter_55_3 in pairs(arg_55_0._unitList) do
		if iter_55_3:IsSpectre() then
			if iter_55_3:GetAttrByName(var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) <= var_0_3.FUSION_ELEMENT_UNIT_TYPE then
				-- block empty
			else
				iter_55_3:Update(arg_55_1)
			end
		else
			if arg_55_0.checkCld then
				arg_55_0._cldSystem:UpdateShipCldTree(iter_55_3)
			end

			if iter_55_3:IsAlive() then
				iter_55_3:Update(arg_55_1)
			end

			local var_55_1 = iter_55_3:GetPosition().x
			local var_55_2 = iter_55_3:GetIFF()

			if var_55_2 == var_0_3.FRIENDLY_CODE then
				var_55_0[var_55_2] = math.max(var_55_0[var_55_2], var_55_1)
			elseif var_55_2 == var_0_3.FOE_CODE then
				var_55_0[var_55_2] = math.min(var_55_0[var_55_2], var_55_1)
			end
		end
	end

	local var_55_3 = arg_55_0._fleetList[var_0_3.FRIENDLY_CODE]:GetFleetExposeLine()

	if var_55_3 and var_55_0[var_0_3.FOE_CODE] < var_55_3 then
		arg_55_0._fleetList[var_0_3.FRIENDLY_CODE]:CloakFatalExpose()
	elseif var_55_0[var_0_3.FOE_CODE] < arg_55_0._fleetList[var_0_3.FRIENDLY_CODE]:GetFleetVisionLine() then
		arg_55_0._fleetList[var_0_3.FRIENDLY_CODE]:CloakInVision(arg_55_0._exposeSpeed)
	else
		arg_55_0._fleetList[var_0_3.FRIENDLY_CODE]:CloakOutVision()
	end

	if arg_55_0._fleetList[var_0_3.FOE_CODE] then
		local var_55_4 = arg_55_0._fleetList[var_0_3.FOE_CODE]:GetFleetExposeLine()

		if var_55_4 and var_55_4 < var_55_0[var_0_3.FRIENDLY_CODE] then
			arg_55_0._fleetList[var_0_3.FOE_CODE]:CloakFatalExpose()
		elseif arg_55_0._fleetList[var_0_3.FOE_CODE]:GetFleetVisionLine() < var_55_0[var_0_3.FRIENDLY_CODE] then
			arg_55_0._fleetList[var_0_3.FOE_CODE]:CloakInVision(arg_55_0._exposeSpeed)
		else
			arg_55_0._fleetList[var_0_3.FOE_CODE]:CloakOutVision()
		end
	end

	for iter_55_4, iter_55_5 in pairs(arg_55_0._bulletList) do
		local var_55_5 = iter_55_5:GetSpeed()
		local var_55_6 = iter_55_5:GetPosition()
		local var_55_7 = iter_55_5:GetType()
		local var_55_8 = iter_55_5:GetOutBound()

		if var_55_8 == var_0_2.BulletOutBound.SPLIT and var_55_7 == var_0_2.BulletType.SHRAPNEL and (var_55_6.x > arg_55_0._bulletRightBound and var_55_5.x > 0 or var_55_6.x < arg_55_0._bulletLeftBoundSplit and var_55_5.x < 0 or var_55_6.z > arg_55_0._bulletUpperBound and var_55_5.z > 0 or var_55_6.z < arg_55_0._bulletLowerBoundSplit and var_55_5.z < 0) then
			if iter_55_5:GetExist() then
				iter_55_5:OutRange()
			else
				arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
			end
		elseif (var_55_8 == var_0_2.BulletOutBound.COMMON or var_55_8 == var_0_2.BulletOutBound.SHIFT_SPLIT) and (var_55_6.x > arg_55_0._bulletRightBound and var_55_5.x > 0 or var_55_6.z < arg_55_0._bulletLowerBound and var_55_5.z < 0) then
			arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
		elseif var_55_6.x < arg_55_0._bulletLeftBound and var_55_5.x < 0 and var_55_7 ~= var_0_2.BulletType.BOMB then
			if var_55_8 == var_0_2.BulletOutBound.RANDOM then
				local var_55_9 = arg_55_0._fleetList[var_0_3.FRIENDLY_CODE]:RandomMainVictim()

				if var_55_9 then
					arg_55_0:HandleDamage(iter_55_5, var_55_9)
				end
			end

			arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
		else
			iter_55_5:Update(arg_55_1)

			local var_55_10 = iter_55_5.GetCurrentState and iter_55_5:GetCurrentState() or nil

			if var_55_10 == var_0.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT then
				-- block empty
			elseif var_55_10 == var_0.Battle.BattleShrapnelBulletUnit.STATE_SPLIT and not iter_55_5:IsFragile() then
				-- block empty
			elseif (var_55_8 == var_0_2.BulletOutBound.COMMON or var_55_8 == var_0_2.BulletOutBound.SHIFT_SPLIT) and var_55_6.z > arg_55_0._bulletUpperBound and var_55_5.z > 0 or var_55_8 == var_0_2.BulletOutBound.VISION and var_55_6.z > arg_55_0._bulletUpperBoundVision and var_55_5.z > 0 or iter_55_5:IsOutRange(arg_55_1) then
				if iter_55_5:GetExist() then
					iter_55_5:OutRange()
				else
					arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
				end
			elseif arg_55_0.checkCld then
				arg_55_0._cldSystem:UpdateBulletCld(iter_55_5)
			end
		end
	end

	for iter_55_6, iter_55_7 in pairs(arg_55_0._aircraftList) do
		iter_55_7:Update(arg_55_1)

		local var_55_11, var_55_12 = iter_55_7:GetIFF()

		if var_55_11 == var_0_3.FRIENDLY_CODE then
			var_55_12 = arg_55_0._totalRightBound
		elseif var_55_11 == var_0_3.FOE_CODE then
			var_55_12 = arg_55_0._totalLeftBound
		end

		if iter_55_7:GetPosition().x * var_55_11 > math.abs(var_55_12) and iter_55_7:GetSpeed().x * var_55_11 > 0 then
			iter_55_7:OutBound()
		else
			arg_55_0._cldSystem:UpdateAircraftCld(iter_55_7)
		end

		if not iter_55_7:IsAlive() then
			arg_55_0:KillAircraft(iter_55_7:GetUniqueID())
		end
	end

	for iter_55_8, iter_55_9 in pairs(arg_55_0._AOEList) do
		arg_55_0._cldSystem:UpdateAOECld(iter_55_9)
		iter_55_9:Settle()

		if iter_55_9:GetActiveFlag() == false then
			iter_55_9:SettleFinale()
			arg_55_0:RemoveAreaOfEffect(iter_55_9:GetUniqueID())
		end
	end

	for iter_55_10, iter_55_11 in pairs(arg_55_0._environmentList) do
		iter_55_11:Update()

		if iter_55_11:IsExpire(arg_55_1) then
			arg_55_0:RemoveEnvironment(iter_55_11:GetUniqueID())
		end
	end

	if arg_55_0.checkCld then
		for iter_55_12, iter_55_13 in pairs(arg_55_0._shelterList) do
			if not iter_55_13:IsWallActive() then
				arg_55_0:RemoveShelter(iter_55_13:GetUniqueID())
			else
				iter_55_13:Update(arg_55_1)
			end
		end

		for iter_55_14, iter_55_15 in pairs(arg_55_0._wallList) do
			if iter_55_15:IsActive() then
				arg_55_0._cldSystem:UpdateWallCld(iter_55_15)
			end
		end
	end

	if arg_55_0._battleInitData.battleType ~= SYSTEM_DUEL then
		for iter_55_16, iter_55_17 in pairs(arg_55_0._foeShipList) do
			if iter_55_17:GetPosition().x + iter_55_17:GetBoxSize().x < arg_55_0._leftZoneLeftBound then
				iter_55_17:SetDeathReason(var_0_2.UnitDeathReason.TOUCHDOWN)
				iter_55_17:DeadAction()
				arg_55_0:KillUnit(iter_55_17:GetUniqueID())
				arg_55_0:HandleShipMissDamage(iter_55_17, arg_55_0._fleetList[var_0_3.FRIENDLY_CODE])
			end
		end
	end

	return
end

function var_0_8.UpdateAutoComponent(arg_56_0, arg_56_1)
	for iter_56_0, iter_56_1 in pairs(arg_56_0._fleetList) do
		iter_56_1:UpdateAutoComponent(arg_56_1)
	end

	for iter_56_2, iter_56_3 in pairs(arg_56_0._teamList) do
		if iter_56_3:IsFatalDamage() then
			arg_56_0:KillNPCTeam(iter_56_2)
		else
			iter_56_3:UpdateMotion()
		end
	end

	for iter_56_4, iter_56_5 in pairs(arg_56_0._freeShipList) do
		iter_56_5:UpdateOxygen(arg_56_1)
		iter_56_5:UpdateWeapon(arg_56_1)
		iter_56_5:UpdatePhaseSwitcher()
	end

	return
end

function var_0_8.UpdateWeather(arg_57_0, arg_57_1)
	for iter_57_0, iter_57_1 in ipairs(arg_57_0._weahter) do
		if iter_57_1 == var_0_2.WEATHER.NIGHT then
			for iter_57_2, iter_57_3 in pairs(arg_57_0._unitList) do
				local var_57_0 = iter_57_3:GetAimBias()

				if not var_57_0 or var_57_0:GetCurrentState() ~= var_57_0.STATE_SUMMON_SICKNESS then
					local var_57_1 = iter_57_3:GetIFF()
					local var_57_2 = var_0_5.GetCurrent(iter_57_3, "attackRating")
					local var_57_3 = var_0_5.GetCurrent(iter_57_3, "aimBiasExtraACC")

					;({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_1] = math.max(({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_1], var_57_2)
					;({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_1] = ({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_1] + var_57_3

					if ShipType.ContainInLimitBundle(ShipType.BundleAntiSubmarine, iter_57_3:GetTemplate().type) then
						({
							[var_0_3.FRIENDLY_CODE] = 0,
							[var_0_3.FOE_CODE] = 0
						})[var_57_1] = math.max(({
							[var_0_3.FRIENDLY_CODE] = 0,
							[var_0_3.FOE_CODE] = 0
						})[var_57_1], var_57_2)
					end
				end
			end

			for iter_57_4, iter_57_5 in pairs(arg_57_0._fleetList) do
				local var_57_4 = iter_57_5:GetFleetBias()

				var_57_4:SetDecayFactor(({
					[var_0_3.FRIENDLY_CODE] = 0,
					[var_0_3.FOE_CODE] = 0
				})[iter_57_4 * -1], ({
					[var_0_3.FRIENDLY_CODE] = 0,
					[var_0_3.FOE_CODE] = 0
				})[iter_57_4 * -1])
				var_57_4:Update(arg_57_1)

				for iter_57_6, iter_57_7 in ipairs(iter_57_5:GetSubList()) do
					local var_57_5 = iter_57_7:GetAimBias()

					if var_57_5:GetDecayFactorType() == var_57_5.DIVING then
						var_57_5:SetDecayFactor(({
							[var_0_3.FRIENDLY_CODE] = 0,
							[var_0_3.FOE_CODE] = 0
						})[iter_57_4 * -1], ({
							[var_0_3.FRIENDLY_CODE] = 0,
							[var_0_3.FOE_CODE] = 0
						})[iter_57_4 * -1])
					else
						var_57_5:SetDecayFactor(({
							[var_0_3.FRIENDLY_CODE] = 0,
							[var_0_3.FOE_CODE] = 0
						})[iter_57_4 * -1], ({
							[var_0_3.FRIENDLY_CODE] = 0,
							[var_0_3.FOE_CODE] = 0
						})[iter_57_4 * -1])
					end

					var_57_5:Update(arg_57_1)
				end
			end

			for iter_57_8, iter_57_9 in pairs(arg_57_0._freeShipList) do
				local var_57_6 = iter_57_9:GetIFF() * -1
				local var_57_7 = iter_57_9:GetAimBias()

				if var_57_7:GetDecayFactorType() == var_57_7.DIVING then
					var_57_7:SetDecayFactor(({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_6], ({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_6])
				else
					var_57_7:SetDecayFactor(({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_6], ({
						[var_0_3.FRIENDLY_CODE] = 0,
						[var_0_3.FOE_CODE] = 0
					})[var_57_6])
				end

				var_57_7:Update(arg_57_1)
			end
		end
	end

	return
end

function var_0_8.UpdateEscapeOnly(arg_58_0, arg_58_1)
	for iter_58_0, iter_58_1 in pairs(arg_58_0._foeShipList) do
		iter_58_1:Update(arg_58_1)
	end

	return
end

function var_0_8.UpdateCountDown(arg_59_0, arg_59_1)
	arg_59_0._lastUpdateTime = arg_59_0._lastUpdateTime or arg_59_1

	local var_59_0 = arg_59_0._countDown - (arg_59_1 - arg_59_0._lastUpdateTime)

	if arg_59_0._countDown - (arg_59_1 - arg_59_0._lastUpdateTime) <= 0 then
		var_59_0 = 0
	end

	if math.floor(arg_59_0._countDown - var_59_0) == 0 or var_59_0 == 0 then
		arg_59_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_COUNT_DOWN, {}))
	end

	arg_59_0._countDown = var_59_0
	arg_59_0._totalTime = arg_59_1 - arg_59_0._startTimeStamp
	arg_59_0._lastUpdateTime = arg_59_1

	return
end

function var_0_8.SpawnMonster(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4, arg_60_5)
	local var_60_0 = arg_60_0:GenerateUnitID()
	local var_60_1 = var_0_4.GetMonsterTmpDataFromID(arg_60_1.monsterTemplateID)

	for iter_60_0, iter_60_1 in ipairs(var_60_1.equipment_list) do
		table.insert({}, {
			id = iter_60_1
		})
	end

	for iter_60_2, iter_60_3 in ipairs(var_60_1.random_equipment_list) do
		local var_60_2 = Clone(iter_60_3)

		for iter_60_4 = 1, var_60_1.random_nub[iter_60_2] do
			local var_60_3 = math.random(#var_60_2)

			table.insert({}, {
				id = var_60_2[var_60_3]
			})
			table.remove(var_60_2, var_60_3)
		end
	end

	local var_60_4 = var_0_4.CreateBattleUnitData(var_60_0, arg_60_3, arg_60_4, arg_60_1.monsterTemplateID, nil, {}, arg_60_1.extraInfo, nil, nil, nil, nil, arg_60_1.level)

	var_0_5.MonsterAttrFixer(arg_60_0._battleInitData.battleType, var_60_4)

	local var_60_5 = arg_60_1.immuneHPInherit and var_60_4:GetMaxHP() or math.ceil(var_60_4:GetMaxHP() * arg_60_0._repressEnemyHpRant)

	if var_60_5 <= 0 then
		var_60_5 = 1
	end

	var_60_4:SetCurrentHP(var_60_5)
	var_60_4:SetPosition((var_0_1.RandomPos(arg_60_1.corrdinate)))

	local var_60_6 = arg_60_1.pilotAITemplateID or var_60_1.pilot_ai_template_id

	var_60_4:SetAI(var_60_6)
	arg_60_0:setShipUnitBound(var_60_4)

	if table.contains(ShipType.SubShipType, var_60_1.type) then
		var_60_4:InitOxygen()
		arg_60_0:UpdateHostileSubmarine(true)
	end

	var_0_4.AttachWeather(var_60_4, arg_60_0._weahter)

	arg_60_0._freeShipList[var_60_0] = var_60_4
	arg_60_0._unitList[var_60_0] = var_60_4

	if var_60_4:IsSpectre() then
		var_60_4:UpdateBlindInvisibleBySpectre()
	else
		arg_60_0._cldSystem:InitShipCld(var_60_4)
	end

	local var_60_7 = arg_60_1.sickness or var_0_2.SUMMONING_SICKNESS_DURATION

	var_60_4:SummonSickness(var_60_7)
	var_60_4:SetMoveCast(arg_60_1.moveCast == true)

	if var_60_4:GetIFF() == var_0_3.FRIENDLY_CODE then
		arg_60_0._friendlyShipList[var_60_0] = var_60_4
	else
		if var_60_4:IsSpectre() then
			arg_60_0._spectreShipList[var_60_0] = var_60_4
		else
			arg_60_0._foeShipList[var_60_0] = var_60_4
		end

		var_60_4:SetWaveIndex(arg_60_2)
	end

	if arg_60_1.reinforce then
		var_60_4:Reinforce()
	end

	if arg_60_1.reinforceDelay then
		var_60_4:SetReinforceCastTime(arg_60_1.reinforceDelay)
	end

	if arg_60_1.team then
		arg_60_0:GetNPCTeam(arg_60_1.team):AppendUnit(var_60_4)
	end

	if arg_60_1.phase then
		var_0.Battle.BattleUnitPhaseSwitcher.New(var_60_4):SetTemplateData(arg_60_1.phase)
	end

	if arg_60_5 then
		arg_60_5(var_60_4)
	end

	arg_60_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = arg_60_3,
		unit = var_60_4,
		bossData = arg_60_1.bossData,
		extraInfo = arg_60_1.extraInfo
	}))

	local var_60_8 = arg_60_1.buffList or {}
	local var_60_9 = arg_60_0._battleInitData.ExtraBuffList or {}
	local var_60_10 = arg_60_0._battleInitData.AffixBuffList or {}

	;(function(arg_61_0)
		for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
			local var_61_1
			local var_61_2

			if type(iter_61_1) == "number" then
				var_61_1 = iter_61_1
				var_61_2 = 1
			else
				var_61_1 = iter_61_1.ID

				if not iter_61_1.LV then
					::label_61_0::

					var_61_2 = 1
				end
			end

			var_60_4:AddBuff((var_0.Battle.BattleBuffUnit.New(var_61_1, var_61_2, var_60_4)))
		end

		return
	end)(var_60_4:GetTemplate().buff_list)
	;(function(arg_61_0)
		for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
			local var_61_1
			local var_61_2

			if type(iter_61_1) == "number" then
				var_61_1 = iter_61_1
				var_61_2 = 1
			else
				var_61_1 = iter_61_1.ID

				if not iter_61_1.LV then
					::label_61_0::

					var_61_2 = 1
				end
			end

			var_60_4:AddBuff((var_0.Battle.BattleBuffUnit.New(var_61_1, var_61_2, var_60_4)))
		end

		return
	end)(var_60_9)
	;(function(arg_61_0)
		for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
			local var_61_1
			local var_61_2

			if type(iter_61_1) == "number" then
				var_61_1 = iter_61_1
				var_61_2 = 1
			else
				var_61_1 = iter_61_1.ID

				if not iter_61_1.LV then
					::label_61_0::

					var_61_2 = 1
				end
			end

			var_60_4:AddBuff((var_0.Battle.BattleBuffUnit.New(var_61_1, var_61_2, var_60_4)))
		end

		return
	end)(var_60_8)

	if arg_60_1.affix then
		(function(arg_61_0)
			for iter_61_0, iter_61_1 in ipairs(arg_61_0) do
				local var_61_1
				local var_61_2

				if type(iter_61_1) == "number" then
					var_61_1 = iter_61_1
					var_61_2 = 1
				else
					var_61_1 = iter_61_1.ID

					if not iter_61_1.LV then
						::label_61_0::

						var_61_2 = 1
					end
				end

				var_60_4:AddBuff((var_0.Battle.BattleBuffUnit.New(var_61_1, var_61_2, var_60_4)))
			end

			return
		end)(var_60_10)
	end

	local var_60_11 = arg_60_1.summonWaveIndex

	if arg_60_1.summonWaveIndex then
		arg_60_0._waveSummonList[var_60_11] = arg_60_0._waveSummonList[var_60_11] or {}
		arg_60_0._waveSummonList[var_60_11][var_60_4] = true
	end

	var_60_4:CheckWeaponInitial()

	if arg_60_0._battleInitData.CMDArgs and var_60_4:GetTemplateID() == arg_60_0._battleInitData.CMDArgs then
		arg_60_0:InitSpecificEnemyStatistics(var_60_4)
	end

	var_60_4:OverrideDeadFX(arg_60_1.deadFX)

	if BATTLE_ENEMY_AIMBIAS_RANGE and var_60_4:GetAimBias() then
		arg_60_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AIM_BIAS, {
			aimBias = var_60_4:GetAimBias()
		}))
	end

	return var_60_4
end

function var_0_8.UpdateHostileSubmarine(arg_62_0, arg_62_1)
	arg_62_0._enemySubmarineCount = arg_62_1 and arg_62_0._enemySubmarineCount + 1 or arg_62_0._enemySubmarineCount - 1

	arg_62_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_HOSTILE_SUBMARINE))

	return
end

function var_0_8.SpawnNPC(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0:GenerateUnitID()
	local var_63_1 = var_0_2.UnitType.MINION_UNIT
	local var_63_2 = var_0_4.GetMonsterTmpDataFromID(arg_63_1.monsterTemplateID)

	for iter_63_0, iter_63_1 in ipairs(var_63_2.equipment_list) do
		table.insert({}, {
			id = iter_63_1
		})
	end

	local var_63_3 = var_0_4.CreateBattleUnitData(var_63_0, var_63_1, arg_63_2:GetIFF(), arg_63_1.monsterTemplateID, nil, {}, arg_63_1.extraInfo, nil, nil, nil, nil, arg_63_1.level, arg_63_2)

	var_63_3:SetCurrentHP((var_63_3:GetMaxHP()))

	local var_63_4 = arg_63_1.corrdinate and var_0_1.RandomPos(arg_63_1.corrdinate) or Clone(arg_63_2:GetPosition())

	var_63_3:SetPosition(var_63_4)

	local var_63_5 = arg_63_1.pilotAITemplateID or var_63_2.pilot_ai_template_id

	var_63_3:SetAI(var_63_5)
	arg_63_0:setShipUnitBound(var_63_3)

	if table.contains(ShipType.SubShipType, var_63_2.type) then
		var_63_3:InitOxygen()

		if var_63_3:GetIFF() ~= var_0_3.FRIENDLY_CODE then
			arg_63_0:UpdateHostileSubmarine(true)
		end
	end

	var_0_4.AttachWeather(var_63_3, arg_63_0._weahter)

	arg_63_0._freeShipList[var_63_0] = var_63_3
	arg_63_0._unitList[var_63_0] = var_63_3

	arg_63_0._cldSystem:InitShipCld(var_63_3)

	local var_63_6 = arg_63_1.sickness or var_0_2.SUMMONING_SICKNESS_DURATION

	var_63_3:SummonSickness(var_63_6)
	var_63_3:SetMoveCast(arg_63_1.moveCast == true)

	arg_63_0._minionShipList[var_63_0] = var_63_3

	if arg_63_1.phase then
		var_0.Battle.BattleUnitPhaseSwitcher.New(var_63_3):SetTemplateData(arg_63_1.phase)
	end

	arg_63_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_63_1,
		unit = var_63_3,
		bossData = arg_63_1.bossData,
		extraInfo = arg_63_1.extraInfo
	}))

	local var_63_7 = arg_63_1.buffList or {}

	;(function(arg_64_0)
		for iter_64_0, iter_64_1 in ipairs(arg_64_0) do
			local var_64_1
			local var_64_2

			if type(iter_64_1) == "number" then
				var_64_1 = iter_64_1
				var_64_2 = 1
			else
				var_64_1 = iter_64_1.ID

				if not iter_64_1.LV then
					::label_64_0::

					var_64_2 = 1
				end
			end

			var_63_3:AddBuff((var_0.Battle.BattleBuffUnit.New(var_64_1, var_64_2, var_63_3)))
		end

		return
	end)(var_63_3:GetTemplate().buff_list)
	;(function(arg_64_0)
		for iter_64_0, iter_64_1 in ipairs(arg_64_0) do
			local var_64_1
			local var_64_2

			if type(iter_64_1) == "number" then
				var_64_1 = iter_64_1
				var_64_2 = 1
			else
				var_64_1 = iter_64_1.ID

				if not iter_64_1.LV then
					::label_64_0::

					var_64_2 = 1
				end
			end

			var_63_3:AddBuff((var_0.Battle.BattleBuffUnit.New(var_64_1, var_64_2, var_63_3)))
		end

		return
	end)(var_63_7)
	var_63_3:CheckWeaponInitial()

	return var_63_3
end

function var_0_8.EnemyEscape(arg_65_0)
	for iter_65_0, iter_65_1 in pairs(arg_65_0._foeShipList) do
		if iter_65_1:ContainsLabelTag(var_0_3.ESCAPE_EXPLO_TAG) then
			iter_65_1:SetDeathReason(var_0_2.UnitDeathReason.CLS)
			iter_65_1:DeadAction()
		else
			iter_65_1:RemoveAllAutoWeapon()
			iter_65_1:SetAI(var_0_3.COUNT_DOWN_ESCAPE_AI_ID)
		end
	end

	return
end

function var_0_8.GetNPCTeam(arg_66_0, arg_66_1)
	arg_66_0._teamList[arg_66_1] = arg_66_0._teamList[arg_66_1] or var_0.Battle.BattleTeamVO.New(arg_66_1)

	return arg_66_0._teamList[arg_66_1]
end

function var_0_8.KillNPCTeam(arg_67_0, arg_67_1)
	if arg_67_0._teamList[arg_67_1] then
		arg_67_0._teamList[arg_67_1]:Dispose()

		arg_67_0._teamList[arg_67_1] = nil
	end

	return
end

function var_0_8.SpawnVanguard(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = arg_68_0:generatePlayerUnit(arg_68_1, arg_68_2, BuildVector3((arg_68_0:GetVanguardBornCoordinate(arg_68_2))), arg_68_0._commanderBuff)

	arg_68_0:GetFleetByIFF(arg_68_2):AppendPlayerUnit(var_68_0)
	arg_68_0:setShipUnitBound(var_68_0)
	var_0_4.AttachWeather(var_68_0, arg_68_0._weahter)
	arg_68_0._cldSystem:InitShipCld(var_68_0)
	arg_68_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_0_2.UnitType.PLAYER_UNIT,
		unit = var_68_0
	}))

	return var_68_0
end

function var_0_8.SpawnMain(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0
	local var_69_1 = arg_69_0:GetFleetByIFF(arg_69_2)
	local var_69_2 = #var_69_1:GetMainList() + 1

	var_69_0 = arg_69_0._currentStageData.mainUnitPosition and arg_69_0._currentStageData.mainUnitPosition[arg_69_2] and Clone(arg_69_0._currentStageData.mainUnitPosition[arg_69_2][var_69_2]) or Clone(var_0_3.MAIN_UNIT_POS[arg_69_2][var_69_2])

	local var_69_3 = arg_69_0:generatePlayerUnit(arg_69_1, arg_69_2, var_69_0, arg_69_0._commanderBuff)

	var_69_3:SetBornPosition(var_69_0)
	var_69_3:SetMainFleetUnit()

	if var_69_0.x < arg_69_0._totalLeftBound or var_69_0.x > arg_69_0._totalRightBound then
		var_69_3:SetImmuneCommonBulletCLD()
	end

	var_69_1:AppendPlayerUnit(var_69_3)
	arg_69_0:setShipUnitBound(var_69_3)
	var_0_4.AttachWeather(var_69_3, arg_69_0._weahter)
	arg_69_0._cldSystem:InitShipCld(var_69_3)
	arg_69_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_0_2.UnitType.PLAYER_UNIT,
		unit = var_69_3
	}))

	return var_69_3
end

function var_0_8.SpawnSub(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0
	local var_70_1 = arg_70_0:GetFleetByIFF(arg_70_2)
	local var_70_2 = #var_70_1:GetSubList() + 1
	local var_70_3 = var_0_4.GetPlayerShipTmpDataFromID(arg_70_1.tmpID).summon_offset or 0

	var_70_0 = arg_70_2 == var_0_3.FRIENDLY_CODE and Vector3(var_0_3.SUB_UNIT_OFFSET_X + var_70_3 + arg_70_0._totalLeftBound, 0, var_0_3.SUB_UNIT_POS_Z[var_70_2]) or Vector3(arg_70_0._totalRightBound - (var_0_3.SUB_UNIT_OFFSET_X + var_70_3), 0, var_0_3.SUB_UNIT_POS_Z[var_70_2])

	local var_70_4 = arg_70_0:generatePlayerUnit(arg_70_1, arg_70_2, var_70_0, arg_70_0._subCommanderBuff)

	var_70_1:AddSubMarine(var_70_4)
	arg_70_0:setShipUnitBound(var_70_4)
	var_0_4.AttachWeather(var_70_4, arg_70_0._weahter)
	arg_70_0._cldSystem:InitShipCld(var_70_4)
	arg_70_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_0_2.UnitType.PLAYER_UNIT,
		unit = var_70_4
	}))

	return var_70_4
end

function var_0_8.SpawnManualSub(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = arg_71_0:generatePlayerUnit(arg_71_1, arg_71_2, BuildVector3((arg_71_0:GetVanguardBornCoordinate(arg_71_2))), arg_71_0._commanderBuff)

	arg_71_0:GetFleetByIFF(arg_71_2):AddManualSubmarine(var_71_0)
	arg_71_0:setShipUnitBound(var_71_0)
	arg_71_0._cldSystem:InitShipCld(var_71_0)
	arg_71_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_0_2.UnitType.SUB_UNIT,
		unit = var_71_0
	}))

	return var_71_0
end

function var_0_8.SpawnSupportUnit(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_0:generateSupportPlayerUnit(arg_72_1, arg_72_2)
	local var_72_1 = arg_72_0:GetFleetByIFF(arg_72_2)

	var_72_1:AppendSupportUnit(var_72_0)

	if table.contains(ShipType.BundleList.qian, var_72_0:GetTemplate().type) then
		var_72_0:SetPosition(Clone(var_0_3.SubSupportUnitPosList[#var_72_1:GetSupportUnitList()]))
	else
		var_72_0:SetPosition(Clone(var_0_3.AirSupportUnitPos))
	end

	arg_72_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_0_2.UnitType.SUPPORT_UNIT,
		unit = var_72_0
	}))

	return var_72_0
end

function var_0_8.ShutdownPlayerUnit(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0:GetFleetByIFF((arg_73_0._unitList[arg_73_1]:GetIFF()))

	var_73_0:RemovePlayerUnit(arg_73_0._unitList[arg_73_1])

	if var_73_0:GetFleetAntiAirWeapon():GetRange() == 0 then
		({}).isShow = false
	end

	arg_73_0:DispatchEvent(var_0.Event.New(var_0_0.ANTI_AIR_AREA, {}))
	arg_73_0:DispatchEvent(var_0.Event.New(var_0_0.SHUT_DOWN_PLAYER, {
		unit = arg_73_0._unitList[arg_73_1]
	}))

	return
end

function var_0_8.updateDeadList(arg_74_0)
	while #arg_74_0._deadUnitList > 0 do
		arg_74_0._deadUnitList[#arg_74_0._deadUnitList]:Dispose()

		arg_74_0._deadUnitList[#arg_74_0._deadUnitList] = nil
	end

	return
end

function var_0_8.KillUnit(arg_75_0, arg_75_1)
	local var_75_0 = arg_75_0._unitList[arg_75_1]

	if arg_75_0._unitList[arg_75_1] == nil then
		return
	end

	local var_75_1 = var_75_0:GetUnitType()

	arg_75_0._cldSystem:DeleteShipCld(var_75_0)
	var_75_0:Clear()

	arg_75_0._unitList[arg_75_1] = nil

	if arg_75_0._freeShipList[arg_75_1] then
		arg_75_0._freeShipList[arg_75_1] = nil
	end

	local var_75_2 = var_75_0:GetIFF()
	local var_75_3 = var_75_0:GetDeathReason()

	if var_75_0:GetAimBias() then
		local var_75_4 = var_75_0:GetAimBias()

		var_75_4:RemoveCrew(var_75_0)

		if var_75_4:GetCurrentState() == var_75_4.STATE_EXPIRE then
			arg_75_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIM_BIAS, {
				aimBias = var_75_0:GetAimBias()
			}))
		end
	end

	if var_75_0:IsSpectre() then
		arg_75_0._spectreShipList[arg_75_1] = nil
	elseif var_75_2 == var_0_3.FOE_CODE then
		arg_75_0._foeShipList[arg_75_1] = nil

		if var_75_1 == var_0_2.UnitType.ENEMY_UNIT or var_75_1 == var_0_2.UnitType.BOSS_UNIT then
			if var_75_0:GetTeam() then
				var_75_0:GetTeam():RemoveUnit(var_75_0)
			end

			if table.contains(ShipType.SubShipType, var_75_0:GetTemplate().type) then
				arg_75_0:UpdateHostileSubmarine(false)
			end

			local var_75_5 = var_75_0:GetWaveIndex()

			if var_75_5 and arg_75_0._waveSummonList[var_75_5] then
				arg_75_0._waveSummonList[var_75_5][var_75_0] = nil
			end
		end
	elseif var_75_2 == var_0_3.FRIENDLY_CODE then
		arg_75_0._friendlyShipList[arg_75_1] = nil
	end

	arg_75_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_UNIT, {
		UID = arg_75_1,
		type = var_75_1,
		deadReason = var_75_3,
		unit = var_75_0
	}))
	table.insert(arg_75_0._deadUnitList, var_75_0)

	return
end

function var_0_8.KillAllEnemy(arg_76_0)
	for iter_76_0, iter_76_1 in pairs(arg_76_0._unitList) do
		if iter_76_1:GetIFF() == var_0_3.FOE_CODE and iter_76_1:IsAlive() and not iter_76_1:IsBoss() then
			iter_76_1:DeadAction()
		end
	end

	return
end

function var_0_8.KillSubmarineByIFF(arg_77_0, arg_77_1)
	for iter_77_0, iter_77_1 in pairs(arg_77_0._unitList) do
		if iter_77_1:GetIFF() == arg_77_1 and iter_77_1:IsAlive() and table.contains(ShipType.SubShipType, iter_77_1:GetTemplate().type) and not iter_77_1:IsBoss() then
			iter_77_1:DeadAction()
		end
	end

	return
end

function var_0_8.KillAllAircraft(arg_78_0)
	for iter_78_0, iter_78_1 in pairs(arg_78_0._aircraftList) do
		iter_78_1:Clear()
		arg_78_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIR_CRAFT, {
			UID = iter_78_0
		}))

		arg_78_0._aircraftList[iter_78_0] = nil
	end

	return
end

function var_0_8.KillWaveSummonMonster(arg_79_0, arg_79_1)
	if arg_79_0._waveSummonList[arg_79_1] then
		for iter_79_0, iter_79_1 in pairs(arg_79_0._waveSummonList[arg_79_1]) do
			arg_79_0:KillUnit((iter_79_0:GetUniqueID()))
		end
	end

	arg_79_0._waveSummonList[arg_79_1] = nil

	return
end

function var_0_8.IsThereBoss(arg_80_0)
	return arg_80_0:GetActiveBossCount() > 0
end

function var_0_8.GetActiveBossCount(arg_81_0)
	local var_81_0 = 0

	for iter_81_0, iter_81_1 in pairs(arg_81_0:GetUnitList()) do
		if iter_81_1:IsBoss() and iter_81_1:IsAlive() then
			var_81_0 = var_81_0 + 1
		end
	end

	return var_81_0
end

function var_0_8.setShipUnitBound(arg_82_0, arg_82_1)
	if arg_82_1:GetFleetVO() then
		arg_82_1:SetBound(arg_82_1:GetFleetVO():GetUnitBound():GetBound())
	else
		arg_82_1:SetBound(arg_82_0:GetUnitBoundByIFF((arg_82_1:GetIFF())))
	end

	return
end

function var_0_8.generatePlayerUnit(arg_83_0, arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	local var_83_0 = arg_83_0:GenerateUnitID()
	local var_83_1 = arg_83_1.properties

	var_83_1.level = arg_83_1.level
	var_83_1.formationID = var_0_3.FORMATION_ID
	var_83_1.id = arg_83_1.id

	var_0_5.AttrFixer(arg_83_0._battleInitData.battleType, var_83_1)

	local var_83_2 = arg_83_1.proficiency or {
		1,
		1,
		1
	}
	local var_83_3 = var_0_2.UnitType.PLAYER_UNIT
	local var_83_4 = arg_83_0._battleInitData.battleType

	if arg_83_0._battleInitData.battleType == SYSTEM_SUBMARINE_RUN or var_83_4 == SYSTEM_SUB_ROUTINE then
		var_83_3 = var_0_2.UnitType.SUB_UNIT
	elseif var_83_4 == SYSTEM_AIRFIGHT then
		var_83_3 = var_0_2.UnitType.CONST_UNIT
	elseif var_83_4 == SYSTEM_CARDPUZZLE then
		var_83_3 = var_0_2.UnitType.CARDPUZZLE_PLAYER_UNIT
	end

	local var_83_5 = var_0_4.CreateBattleUnitData(var_83_0, var_83_3, arg_83_2, arg_83_1.tmpID, arg_83_1.skinId, arg_83_1.equipment, var_83_1, arg_83_1.baseProperties, var_83_2, arg_83_1.baseList, arg_83_1.preloasList)

	var_0_4.AttachUltimateBonus(var_83_5)

	local var_83_6 = arg_83_1.initHPRate or 1

	var_83_5:InitCurrentHP(var_83_6)
	var_83_5:SetRarity(arg_83_1.rarity)
	var_83_5:SetIntimacy(arg_83_1.intimacy)
	var_83_5:SetShipName(arg_83_1.name)

	if arg_83_1.spWeapon then
		var_83_5:SetSpWeapon(arg_83_1.spWeapon)
		_.each(arg_83_1.spWeapon:GetLabel(), function(arg_84_0)
			var_83_5:AddLabelTag(arg_84_0)

			return
		end)
	end

	arg_83_0._unitList[var_83_0] = var_83_5

	if var_83_5:GetIFF() == var_0_3.FRIENDLY_CODE then
		arg_83_0._friendlyShipList[var_83_0] = var_83_5
	elseif var_83_5:GetIFF() == var_0_3.FOE_CODE then
		arg_83_0._foeShipList[var_83_0] = var_83_5
	end

	if var_83_4 == SYSTEM_WORLD then
		var_0_5.SetCurrent(var_83_5, "healingRate", (var_0_1.WorldMapRewardHealingRate(arg_83_0._battleInitData.EnemyMapRewards, arg_83_0._battleInitData.FleetMapRewards)))
	end

	var_83_5:SetPosition(arg_83_3)
	var_0_4.InitUnitSkill(arg_83_1, var_83_5, var_83_4)
	var_0_4.InitEquipSkill(arg_83_1.equipment, var_83_5, var_83_4)
	var_0_4.InitCommanderSkill(arg_83_4, var_83_5, var_83_4)
	var_83_5:SetGearScore(arg_83_1.shipGS)

	if arg_83_1.deathMark then
		var_83_5:SetWorldDeathMark()
	end

	return var_83_5
end

function var_0_8.generateSupportPlayerUnit(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = arg_85_0:GenerateUnitID()

	arg_85_1.properties.level = arg_85_1.level
	arg_85_1.properties.formationID = var_0_3.FORMATION_ID
	arg_85_1.properties.id = arg_85_1.id

	var_0_5.AttrFixer(arg_85_0._battleInitData.battleType, arg_85_1.properties)

	local var_85_1 = arg_85_1.proficiency or {
		1,
		1,
		1
	}
	local var_85_2 = var_0_4.CreateBattleUnitData(var_85_0, var_0_2.UnitType.SUPPORT_UNIT, arg_85_2, arg_85_1.tmpID, arg_85_1.skinId, arg_85_1.equipment, arg_85_1.properties, arg_85_1.baseProperties, var_85_1, arg_85_1.baseList, arg_85_1.preloasList)

	var_85_2:InitCurrentHP(1)
	var_85_2:SetShipName(arg_85_1.name)

	arg_85_0._spectreShipList[var_85_0] = var_85_2

	return var_85_2
end

function var_0_8.SwitchSpectreUnit(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1:GetUniqueID()

	if arg_86_1:GetIFF() == var_0_3.FRIENDLY_CODE then
		local var_86_1 = arg_86_0._friendlyShipList or arg_86_0._foeShipList

		if arg_86_1:IsSpectre() then
			var_86_1[var_86_0] = nil
			arg_86_0._spectreShipList[var_86_0] = arg_86_1

			for iter_86_0, iter_86_1 in pairs(arg_86_0._AOEList) do
				iter_86_1:ForceExit(arg_86_1:GetUniqueID())
			end

			arg_86_0._cldSystem:DeleteShipCld(arg_86_1)
		else
			arg_86_0._spectreShipList[var_86_0] = nil
			var_86_1[var_86_0] = arg_86_1

			arg_86_1:ActiveCldBox()
			arg_86_0._cldSystem:InitShipCld(arg_86_1)
		end

		return
	end
end

function var_0_8.GetUnitList(arg_87_0)
	return arg_87_0._unitList
end

function var_0_8.GetFriendlyShipList(arg_88_0)
	return arg_88_0._friendlyShipList
end

function var_0_8.GetFoeShipList(arg_89_0)
	return arg_89_0._foeShipList
end

function var_0_8.GetFoeAircraftList(arg_90_0)
	return arg_90_0._foeAircraftList
end

function var_0_8.GetFreeShipList(arg_91_0)
	return arg_91_0._freeShipList
end

function var_0_8.GetSpectreShipList(arg_92_0)
	return arg_92_0._spectreShipList
end

function var_0_8.GenerateUnitID(arg_93_0)
	arg_93_0._unitCount = arg_93_0._unitCount + 1

	return arg_93_0._unitCount
end

function var_0_8.GetCountDown(arg_94_0)
	return arg_94_0._countDown
end

function var_0_8.SpawnAirFighter(arg_95_0, arg_95_1)
	local var_95_0 = #arg_95_0._airFighterList + 1
	local var_95_1 = var_0_4.GetFormationTmpDataFromID(arg_95_1.formation).pos_offset
	local var_95_2 = {
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}

	;({
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}).totalNumber = arg_95_1.totalNumber or 0
	;({
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}).onceNumber = arg_95_1.onceNumber
	;({
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}).timeDelay = arg_95_1.interval or 3
	;({
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}).maxTotalNumber = arg_95_1.maxTotalNumber or 15

	local function var_95_3(arg_96_0)
		if var_95_2.currentNumber < var_95_2.totalNumber then
			var_95_2.currentNumber = var_95_2.currentNumber + 1

			local var_96_0 = arg_95_0:CreateAirFighter(arg_95_1)

			var_96_0:SetFormationOffset(var_95_1[arg_96_0])
			var_96_0:SetFormationIndex(arg_96_0)
			var_96_0:SetDeadCallBack(function()
				var_95_2.totalNumber = var_95_2.totalNumber - 1
				var_95_2.currentNumber = var_95_2.currentNumber - 1

				arg_95_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIR_FIGHTER_ICON, {
					index = var_95_0
				}))
				arg_95_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_AIR_SUPPORT_LABEL, {}))

				return
			end)
			var_96_0:SetLiveCallBack(function()
				var_95_2.currentNumber = var_95_2.currentNumber - 1

				return
			end)
		end

		return
	end

	arg_95_0._airFighterList[#arg_95_0._airFighterList + 1] = {
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}

	arg_95_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AIR_FIGHTER_ICON, {
		index = #arg_95_0._airFighterList + 1
	}))
	arg_95_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_AIR_SUPPORT_LABEL, {}))

	;({
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}).timer = pg.TimeMgr.GetInstance():AddBattleTimer("striker", -1, arg_95_1.interval, function()
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

function var_0_8.ClearAirFighterTimer(arg_100_0)
	for iter_100_0, iter_100_1 in ipairs(arg_100_0._airFighterList) do
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_100_1.timer)

		iter_100_1.timer = nil
	end

	arg_100_0._airFighterList = {}

	return
end

function var_0_8.KillAllAirStrike(arg_101_0)
	for iter_101_0, iter_101_1 in pairs(arg_101_0._aircraftList) do
		if iter_101_1.__name == var_0.Battle.BattleAirFighterUnit.__name then
			arg_101_0._cldSystem:DeleteAircraftCld(iter_101_1)

			iter_101_1._aliveState = false
			arg_101_0._aircraftList[iter_101_0] = nil
			arg_101_0._foeAircraftList[iter_101_0] = nil

			arg_101_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIR_CRAFT, {
				UID = iter_101_0
			}))
		end
	end

	local var_101_0 = true

	for iter_101_2, iter_101_3 in pairs(arg_101_0._foeAircraftList) do
		var_101_0 = false

		break
	end

	if var_101_0 then
		arg_101_0:DispatchEvent(var_0.Event.New(var_0_0.ANTI_AIR_AREA, {
			isShow = false
		}))
	end

	for iter_101_4, iter_101_5 in ipairs(arg_101_0._airFighterList) do
		iter_101_5.totalNumber = 0

		arg_101_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIR_FIGHTER_ICON, {
			index = iter_101_4
		}))
		pg.TimeMgr.GetInstance():RemoveBattleTimer(iter_101_5.timer)

		iter_101_5.timer = nil
	end

	arg_101_0._airFighterList = {}

	return
end

function var_0_8.GetAirFighterInfo(arg_102_0, arg_102_1)
	return arg_102_0._airFighterList[arg_102_1]
end

function var_0_8.GetAirFighterList(arg_103_0)
	return arg_103_0._airFighterList
end

function var_0_8.CreateAircraft(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	local var_104_0 = arg_104_0:GenerateAircraftID()
	local var_104_1 = var_0_4.CreateAircraftUnit(var_104_0, arg_104_2, arg_104_1, arg_104_3)

	if arg_104_4 then
		var_104_1:SetSkinID(arg_104_4)
	end

	local var_104_2

	if arg_104_1:GetIFF() == var_0_3.FRIENDLY_CODE then
		-- block empty
	else
		var_104_2 = true
	end

	arg_104_0:doCreateAirUnit(var_104_0, var_104_1, var_0_2.UnitType.AIRCRAFT_UNIT, var_104_2)

	return var_104_1
end

function var_0_8.CreateAirFighter(arg_105_0, arg_105_1)
	local var_105_0 = arg_105_0:GenerateAircraftID()
	local var_105_1 = var_0_4.CreateAirFighterUnit(var_105_0, arg_105_1)

	arg_105_0:doCreateAirUnit(var_105_0, var_105_1, var_0_2.UnitType.AIRFIGHTER_UNIT, true)

	return var_105_1
end

function var_0_8.doCreateAirUnit(arg_106_0, arg_106_1, arg_106_2, arg_106_3, arg_106_4)
	arg_106_0._aircraftList[arg_106_1] = arg_106_2

	arg_106_0._cldSystem:InitAircraftCld(arg_106_2)
	arg_106_2:SetBound(arg_106_0._leftZoneUpperBound, arg_106_0._leftZoneLowerBound)
	arg_106_2:SetViewBoundData(arg_106_0._cameraTop, arg_106_0._cameraBottom, arg_106_0._cameraLeft, arg_106_0._cameraRight)
	arg_106_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		unit = arg_106_2,
		type = arg_106_3
	}))

	arg_106_4 = arg_106_4 or false

	if arg_106_4 then
		arg_106_0._foeAircraftList[arg_106_1] = arg_106_2

		arg_106_0:DispatchEvent(var_0.Event.New(var_0_0.ANTI_AIR_AREA, {
			isShow = true
		}))
	end

	return
end

function var_0_8.KillAircraft(arg_107_0, arg_107_1)
	if arg_107_0._aircraftList[arg_107_1] == nil then
		return
	end

	arg_107_0._aircraftList[arg_107_1]:Clear()
	arg_107_0._cldSystem:DeleteAircraftCld(arg_107_0._aircraftList[arg_107_1])

	if arg_107_0._aircraftList[arg_107_1]:IsUndefeated() and arg_107_0._aircraftList[arg_107_1]:GetCurrentState() ~= arg_107_0._aircraftList[arg_107_1].STRIKE_STATE_RECYCLE then
		arg_107_0:HandleAircraftMissDamage(arg_107_0._aircraftList[arg_107_1], arg_107_0._fleetList[arg_107_0._aircraftList[arg_107_1]:GetIFF() * -1])
	end

	arg_107_0._aircraftList[arg_107_1]._aliveState = false
	arg_107_0._aircraftList[arg_107_1] = nil
	arg_107_0._foeAircraftList[arg_107_1] = nil

	local var_107_0 = true

	for iter_107_0, iter_107_1 in pairs(arg_107_0._foeAircraftList) do
		var_107_0 = false

		break
	end

	if var_107_0 then
		arg_107_0:DispatchEvent(var_0.Event.New(var_0_0.ANTI_AIR_AREA, {
			isShow = false
		}))
	end

	arg_107_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIR_CRAFT, {
		UID = arg_107_1
	}))

	return
end

function var_0_8.GetAircraftList(arg_108_0)
	return arg_108_0._aircraftList
end

function var_0_8.GenerateAircraftID(arg_109_0)
	arg_109_0._aircraftCount = arg_109_0._aircraftCount + 1

	return arg_109_0._aircraftCount
end

function var_0_8.CreateBulletUnit(arg_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)
	local var_110_0 = arg_110_0:GenerateBulletID()
	local var_110_1, var_110_2 = var_0_4.CreateBattleBulletData(var_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)

	if var_110_2 then
		arg_110_0._cldSystem:InitBulletCld(var_110_1)
	end

	local var_110_3, var_110_4 = arg_110_3:GetFixBulletRange()

	if var_110_3 or var_110_4 then
		var_110_1:FixRange(var_110_3, var_110_4)
	end

	arg_110_0._bulletList[var_110_0] = var_110_1

	return var_110_1
end

function var_0_8.RemoveBulletUnit(arg_111_0, arg_111_1)
	if arg_111_0._bulletList[arg_111_1] == nil then
		return
	end

	arg_111_0._bulletList[arg_111_1]:DamageUnitListWriteback()

	if arg_111_0._bulletList[arg_111_1]:GetIsCld() then
		arg_111_0._cldSystem:DeleteBulletCld(arg_111_0._bulletList[arg_111_1])
	end

	arg_111_0._bulletList[arg_111_1] = nil

	arg_111_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_BULLET, {
		UID = arg_111_1
	}))
	arg_111_0._bulletList[arg_111_1]:Dispose()

	return
end

function var_0_8.GetBulletList(arg_112_0)
	return arg_112_0._bulletList
end

function var_0_8.GenerateBulletID(arg_113_0)
	arg_113_0._bulletCount = arg_113_0._bulletCount + 1

	return arg_113_0._bulletCount + 1
end

function var_0_8.CLSBullet(arg_114_0, arg_114_1, arg_114_2)
	local var_114_0 = true

	if arg_114_0._battleInitData.battleType == SYSTEM_DUEL then
		var_114_0 = false
	end

	if var_114_0 then
		for iter_114_0, iter_114_1 in pairs(arg_114_0._bulletList) do
			if iter_114_1:GetIFF() ~= arg_114_1 or not iter_114_1:GetExist() or iter_114_1:ImmuneCLS() or iter_114_1:ImmuneBombCLS() and arg_114_2 then
				-- block empty
			else
				arg_114_0:RemoveBulletUnit(iter_114_0)
			end
		end
	end

	return
end

function var_0_8.CLSAircraft(arg_115_0, arg_115_1)
	for iter_115_0, iter_115_1 in pairs(arg_115_0._aircraftList) do
		if iter_115_1:GetIFF() == arg_115_1 then
			iter_115_1:Clear()
			arg_115_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIR_CRAFT, {
				UID = iter_115_0
			}))

			arg_115_0._aircraftList[iter_115_0] = nil
		end
	end

	return
end

function var_0_8.CLSMinion(arg_116_0)
	for iter_116_0, iter_116_1 in pairs(arg_116_0._unitList) do
		if iter_116_1:GetIFF() == var_0_3.FOE_CODE and iter_116_1:IsAlive() and not iter_116_1:IsBoss() then
			iter_116_1:SetDeathReason(var_0_2.UnitDeathReason.CLS)
			iter_116_1:DeadAction()
		end
	end

	return
end

function var_0_8.CLSAOE(arg_117_0)
	for iter_117_0, iter_117_1 in pairs(arg_117_0._AOEList) do
		if iter_117_1:GetSource() == iter_117_1.SOURCE_BULLET_9 then
			arg_117_0:RemoveAreaOfEffect(iter_117_0)
		end
	end

	return
end

function var_0_8.SpawnColumnArea(arg_118_0, arg_118_1, arg_118_2, arg_118_3, arg_118_4, arg_118_5, arg_118_6, arg_118_7, arg_118_8)
	arg_118_7 = arg_118_7 or false

	local var_118_0 = var_0.Battle.BattleAOEData.New(arg_118_0:GenerateAreaID(), arg_118_2, arg_118_6, arg_118_8)

	var_118_0:SetPosition((Clone(arg_118_3)))
	var_118_0:SetRange(arg_118_4)
	var_118_0:SetAreaType(var_0_2.AreaType.COLUMN)
	var_118_0:SetLifeTime(arg_118_5)
	var_118_0:SetFieldType(arg_118_1)
	var_118_0:SetOpponentAffected(not arg_118_7)
	arg_118_0:CreateAreaOfEffect(var_118_0)

	return var_118_0
end

function var_0_8.SpawnCubeArea(arg_119_0, arg_119_1, arg_119_2, arg_119_3, arg_119_4, arg_119_5, arg_119_6, arg_119_7, arg_119_8, arg_119_9)
	arg_119_8 = arg_119_8 or false

	local var_119_0 = var_0.Battle.BattleAOEData.New(arg_119_0:GenerateAreaID(), arg_119_2, arg_119_7, arg_119_9)

	var_119_0:SetPosition((Clone(arg_119_3)))
	var_119_0:SetWidth(arg_119_4)
	var_119_0:SetHeight(arg_119_5)
	var_119_0:SetAreaType(var_0_2.AreaType.CUBE)
	var_119_0:SetLifeTime(arg_119_6)
	var_119_0:SetFieldType(arg_119_1)
	var_119_0:SetOpponentAffected(not arg_119_8)
	arg_119_0:CreateAreaOfEffect(var_119_0)

	return var_119_0
end

function var_0_8.SpawnLastingColumnArea(arg_120_0, arg_120_1, arg_120_2, arg_120_3, arg_120_4, arg_120_5, arg_120_6, arg_120_7, arg_120_8, arg_120_9, arg_120_10, arg_120_11)
	arg_120_8 = arg_120_8 or false

	local var_120_0 = var_0.Battle.BattleLastingAOEData.New(arg_120_0:GenerateAreaID(), arg_120_2, arg_120_6, arg_120_7, arg_120_10, arg_120_11)

	var_120_0:SetPosition((Clone(arg_120_3)))
	var_120_0:SetRange(arg_120_4)
	var_120_0:SetAreaType(var_0_2.AreaType.COLUMN)
	var_120_0:SetLifeTime(arg_120_5)
	var_120_0:SetFieldType(arg_120_1)
	var_120_0:SetOpponentAffected(not arg_120_8)
	arg_120_0:CreateAreaOfEffect(var_120_0)

	if arg_120_9 and arg_120_9 ~= "" then
		arg_120_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AREA, {
			area = var_120_0,
			FXID = arg_120_9
		}))
	end

	return var_120_0
end

function var_0_8.SpawnLastingEllipseArea(arg_121_0, arg_121_1, arg_121_2, arg_121_3, arg_121_4, arg_121_5, arg_121_6, arg_121_7, arg_121_8, arg_121_9, arg_121_10, arg_121_11, arg_121_12)
	arg_121_9 = arg_121_9 or false

	local var_121_0 = var_0.Battle.BattleLastingAOEData.New(arg_121_0:GenerateAreaID(), arg_121_2, arg_121_7, arg_121_8, arg_121_11, arg_121_12)

	var_121_0:SetPosition((Clone(arg_121_3)))
	var_121_0:SetWidth(arg_121_4)
	var_121_0:SetHeight(arg_121_5)
	var_121_0:SetAreaType(var_0_2.AreaType.ELLIPSE)
	var_121_0:SetLifeTime(arg_121_6)
	var_121_0:SetFieldType(arg_121_1)
	var_121_0:SetOpponentAffected(not arg_121_9)
	arg_121_0:CreateAreaOfEffect(var_121_0)

	if arg_121_10 and arg_121_10 ~= "" then
		arg_121_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AREA, {
			area = var_121_0,
			FXID = arg_121_10
		}))
	end

	return var_121_0
end

function var_0_8.SpawnLastingCubeArea(arg_122_0, arg_122_1, arg_122_2, arg_122_3, arg_122_4, arg_122_5, arg_122_6, arg_122_7, arg_122_8, arg_122_9, arg_122_10, arg_122_11, arg_122_12)
	arg_122_9 = arg_122_9 or false

	local var_122_0 = var_0.Battle.BattleLastingAOEData.New(arg_122_0:GenerateAreaID(), arg_122_2, arg_122_7, arg_122_8, arg_122_11, arg_122_12)

	var_122_0:SetPosition((Clone(arg_122_3)))
	var_122_0:SetWidth(arg_122_4)
	var_122_0:SetHeight(arg_122_5)
	var_122_0:SetAreaType(var_0_2.AreaType.CUBE)
	var_122_0:SetLifeTime(arg_122_6)
	var_122_0:SetFieldType(arg_122_1)
	var_122_0:SetOpponentAffected(not arg_122_9)
	arg_122_0:CreateAreaOfEffect(var_122_0)

	if arg_122_10 and arg_122_10 ~= "" then
		arg_122_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AREA, {
			area = var_122_0,
			FXID = arg_122_10
		}))
	end

	return var_122_0
end

function var_0_8.SpawnTriggerColumnArea(arg_123_0, arg_123_1, arg_123_2, arg_123_3, arg_123_4, arg_123_5, arg_123_6, arg_123_7, arg_123_8)
	arg_123_6 = arg_123_6 or false

	local var_123_0 = var_0.Battle.BattleTriggerAOEData.New(arg_123_0:GenerateAreaID(), arg_123_2, arg_123_8)

	var_123_0:SetPosition((Clone(arg_123_3)))
	var_123_0:SetRange(arg_123_4)
	var_123_0:SetAreaType(var_0_2.AreaType.COLUMN)
	var_123_0:SetLifeTime(arg_123_5)
	var_123_0:SetFieldType(arg_123_1)
	var_123_0:SetOpponentAffected(not arg_123_6)
	arg_123_0:CreateAreaOfEffect(var_123_0)

	if arg_123_7 and arg_123_7 ~= "" then
		arg_123_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AREA, {
			area = var_123_0,
			FXID = arg_123_7
		}))
	end

	return var_123_0
end

function var_0_8.CreateAreaOfEffect(arg_124_0, arg_124_1)
	arg_124_0._AOEList[arg_124_1:GetUniqueID()] = arg_124_1

	arg_124_0._cldSystem:InitAOECld(arg_124_1)
	arg_124_1:StartTimer()

	return
end

function var_0_8.RemoveAreaOfEffect(arg_125_0, arg_125_1)
	if not arg_125_0._AOEList[arg_125_1] then
		return
	end

	arg_125_0._AOEList[arg_125_1]:Dispose()

	arg_125_0._AOEList[arg_125_1] = nil

	arg_125_0._cldSystem:DeleteAOECld(arg_125_0._AOEList[arg_125_1])
	arg_125_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AREA, {
		id = arg_125_1
	}))

	return
end

function var_0_8.GetAOEList(arg_126_0)
	return arg_126_0._AOEList
end

function var_0_8.GenerateAreaID(arg_127_0)
	arg_127_0._AOECount = arg_127_0._AOECount + 1

	return arg_127_0._AOECount
end

function var_0_8.SpawnWall(arg_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)
	local var_128_0 = arg_128_0:GenerateWallID()
	local var_128_1 = var_0.Battle.BattleWallData.New(var_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)

	arg_128_0._wallList[var_128_0] = var_128_1

	arg_128_0._cldSystem:InitWallCld(var_128_1)

	return var_128_1
end

function var_0_8.RemoveWall(arg_129_0, arg_129_1)
	arg_129_0._wallList[arg_129_1] = nil

	arg_129_0._cldSystem:DeleteWallCld(arg_129_0._wallList[arg_129_1])

	return
end

function var_0_8.SpawnShelter(arg_130_0, arg_130_1, arg_130_2)
	local var_130_0 = arg_130_0:GernerateShelterID()
	local var_130_1 = var_0.Battle.BattleShelterData.New(var_130_0)

	arg_130_0._shelterList[var_130_0] = var_130_1

	return var_130_1
end

function var_0_8.RemoveShelter(arg_131_0, arg_131_1)
	arg_131_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_SHELTER, {
		uid = arg_131_1
	}))
	arg_131_0._shelterList[arg_131_1]:Deactive()

	arg_131_0._shelterList[arg_131_1] = nil

	return
end

function var_0_8.GetWallList(arg_132_0)
	return arg_132_0._wallList
end

function var_0_8.GenerateWallID(arg_133_0)
	arg_133_0._wallIndex = arg_133_0._wallIndex + 1

	return arg_133_0._wallIndex
end

function var_0_8.GernerateShelterID(arg_134_0)
	arg_134_0._shelterIndex = arg_134_0._shelterIndex + 1

	return arg_134_0._shelterIndex
end

function var_0_8.SpawnEnvironment(arg_135_0, arg_135_1)
	local var_135_0 = arg_135_0:GernerateEnvironmentID()
	local var_135_1 = var_0.Battle.BattleEnvironmentUnit.New(var_135_0, var_0_3.FOE_CODE)

	var_135_1:SetTemplate(arg_135_1)

	local var_135_2 = var_135_1:GetBehaviours()
	local var_135_3 = Vector3(arg_135_1.coordinate[1], arg_135_1.coordinate[2], arg_135_1.coordinate[3])
	local var_135_4 = arg_135_1.field_type or var_0_2.BulletField.SURFACE
	local var_135_5 = arg_135_1.IFF or var_0_3.FOE_CODE
	local var_135_6 = 0
	local var_135_7 = #arg_135_1.cld_data == 1 and arg_135_0:SpawnLastingColumnArea(var_135_4, var_135_5, var_135_3, arg_135_1.cld_data[1], var_135_6, function(arg_136_0)
		for iter_136_0, iter_136_1 in ipairs(arg_136_0) do
			if iter_136_1.Active then
				if not arg_135_0._unitList[iter_136_1.UID]:IsSpectre() then
					table.insert({}, arg_135_0._unitList[iter_136_1.UID])
				end
			end
		end

		var_135_1:UpdateFrequentlyCollide({})

		return
	end, function()
		return
	end, false, arg_135_1.prefab, function()
		return
	end, true) or arg_135_0:SpawnLastingCubeArea(var_135_4, var_135_5, var_135_3, arg_135_1.cld_data[1], arg_135_1.cld_data[2], var_135_6, function(arg_136_0)
		for iter_136_0, iter_136_1 in ipairs(arg_136_0) do
			if iter_136_1.Active then
				if not arg_135_0._unitList[iter_136_1.UID]:IsSpectre() then
					table.insert({}, arg_135_0._unitList[iter_136_1.UID])
				end
			end
		end

		var_135_1:UpdateFrequentlyCollide({})

		return
	end, function()
		return
	end, false, arg_135_1.prefab, function()
		return
	end, true)

	var_135_1:SetAOEData(var_135_7)

	arg_135_0._environmentList[var_135_0] = var_135_1

	return var_135_1
end

function var_0_8.RemoveEnvironment(arg_139_0, arg_139_1)
	arg_139_0:RemoveAreaOfEffect(arg_139_0._environmentList[arg_139_1]:GetAOEData():GetUniqueID())
	arg_139_0._environmentList[arg_139_1]:Dispose()

	arg_139_0._environmentList[arg_139_1] = nil

	return
end

function var_0_8.DispatchWarning(arg_140_0, arg_140_1, arg_140_2)
	arg_140_0:DispatchEvent(var_0.Event.New(var_0_0.UPDATE_ENVIRONMENT_WARNING, {
		isActive = arg_140_1
	}))

	return
end

function var_0_8.GetEnvironmentList(arg_141_0)
	return arg_141_0._environmentList
end

function var_0_8.GernerateEnvironmentID(arg_142_0)
	arg_142_0._environmentIndex = arg_142_0._environmentIndex + 1

	return arg_142_0._environmentIndex
end

function var_0_8.SpawnEffect(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	arg_143_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_EFFECT, {
		FXID = arg_143_1,
		position = arg_143_2,
		localScale = arg_143_3
	}))

	return
end

function var_0_8.SpawnUIFX(arg_144_0, arg_144_1, arg_144_2, arg_144_3, arg_144_4)
	arg_144_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UI_FX, {
		FXID = arg_144_1,
		position = arg_144_2,
		localScale = arg_144_3,
		orderDiff = arg_144_4
	}))

	return
end

function var_0_8.SpawnCameraFX(arg_145_0, arg_145_1, arg_145_2, arg_145_3, arg_145_4)
	arg_145_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_CAMERA_FX, {
		FXID = arg_145_1,
		position = arg_145_2,
		localScale = arg_145_3,
		orderDiff = arg_145_4
	}))

	return
end

function var_0_8.GetFriendlyCode(arg_146_0)
	return arg_146_0._friendlyCode
end

function var_0_8.GetFoeCode(arg_147_0)
	return arg_147_0._foeCode
end

function var_0_8.GetOppoSideCode(arg_148_0)
	if arg_148_0 == var_0_3.FRIENDLY_CODE then
		return var_0_3.FOE_CODE
	elseif arg_148_0 == var_0_3.FOE_CODE then
		return var_0_3.FRIENDLY_CODE
	end

	return
end

function var_0_8.GetStatistics(arg_149_0)
	return arg_149_0._statistics
end

function var_0_8.BlockManualCast(arg_150_0, arg_150_1)
	local var_150_0 = arg_150_1 and 1 or -1

	for iter_150_0, iter_150_1 in pairs(arg_150_0._fleetList) do
		iter_150_1:SetWeaponBlock(var_150_0)
	end

	return
end

function var_0_8.JamManualCast(arg_151_0, arg_151_1)
	arg_151_0:DispatchEvent(var_0.Event.New(var_0_0.JAMMING, {
		jammingFlag = arg_151_1
	}))

	return
end

function var_0_8.SubmarineStrike(arg_152_0, arg_152_1)
	local var_152_0 = arg_152_0:GetFleetByIFF(arg_152_1)
	local var_152_1 = var_152_0:GetSubAidVO()

	if arg_152_0._battleInitData.battleType ~= SYSTEM_SCENARIO_SUB_STRIKE and (var_152_0:GetWeaponBlock() or var_152_1:GetCurrent() < 1) then
		return
	end

	for iter_152_0, iter_152_1 in ipairs((var_152_0:GetSubUnitData())) do
		arg_152_0:InitAidUnitStatistics((arg_152_0:SpawnSub(iter_152_1, arg_152_1)))
	end

	var_152_0:SubWarcry()

	local var_152_2 = var_152_0:GetSubList()

	for iter_152_2, iter_152_3 in ipairs(var_152_2) do
		if iter_152_2 == 1 then
			iter_152_3:TriggerBuff(var_0_2.BuffEffectType.ON_SUB_LEADER)
		elseif iter_152_2 == 2 then
			iter_152_3:TriggerBuff(var_0_2.BuffEffectType.ON_UPPER_SUB_CONSORT)
		elseif iter_152_2 == 3 then
			iter_152_3:TriggerBuff(var_0_2.BuffEffectType.ON_LOWER_SUB_CONSORT)
		end

		if iter_152_3:GetAimBias() then
			arg_152_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_AIM_BIAS, {
				aimBias = iter_152_3:GetAimBias()
			}))
		end
	end

	var_152_1:Cast()

	return
end

function var_0_8.GetWaveFlags(arg_153_0)
	return arg_153_0._waveFlags
end

function var_0_8.AddWaveFlag(arg_154_0, arg_154_1)
	if not arg_154_1 then
		return
	end

	local var_154_0 = arg_154_0:GetWaveFlags()

	if table.contains(var_154_0, arg_154_1) then
		return
	end

	table.insert(var_154_0, arg_154_1)

	return
end

function var_0_8.RemoveFlag(arg_155_0, arg_155_1)
	if not arg_155_1 then
		return
	end

	local var_155_0 = arg_155_0:GetWaveFlags()

	if not table.contains(var_155_0, arg_155_1) then
		return
	end

	table.removebyvalue(var_155_0, arg_155_1)

	return
end

function var_0_8.DispatchCustomWarning(arg_156_0, arg_156_1)
	arg_156_0:DispatchEvent(var_0.Event.New(var_0_0.EDIT_CUSTOM_WARNING_LABEL, {
		labelData = arg_156_1
	}))

	return
end

function var_0_8.DispatchGridmanSkill(arg_157_0, arg_157_1, arg_157_2)
	arg_157_0:DispatchEvent(var_0.Event.New(var_0_0.GRIDMAN_SKILL_FLOAT, {
		type = arg_157_1,
		IFF = arg_157_2
	}))

	return
end

function var_0_8.SpawnFusionUnit(arg_158_0, arg_158_1, arg_158_2, arg_158_3, arg_158_4)
	local var_158_0 = arg_158_0:generatePlayerUnit(arg_158_2, arg_158_1:GetIFF(), Clone(arg_158_1:GetPosition()), arg_158_0._commanderBuff)

	var_0_5.SetFusionAttrFromElement(var_158_0, arg_158_1, arg_158_3, arg_158_4)
	var_158_0:SetCurrentHP(var_158_0:GetMaxHP())
	arg_158_1:GetFleetVO():AppendPlayerUnit(var_158_0)
	arg_158_0:setShipUnitBound(var_158_0)
	var_0_4.AttachWeather(var_158_0, arg_158_0._weahter)
	arg_158_0._cldSystem:InitShipCld(var_158_0)
	arg_158_0:DispatchEvent(var_0.Event.New(var_0_0.ADD_UNIT, {
		type = var_0_2.UnitType.PLAYER_UNIT,
		unit = var_158_0
	}))

	return var_158_0
end

function var_0_8.DefusionUnit(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_0:GetFleetByIFF((arg_159_1:GetIFF()))

	var_159_0:RemovePlayerUnit(arg_159_1)

	if var_159_0:GetFleetAntiAirWeapon():GetRange() == 0 then
		({}).isShow = false
	end

	arg_159_0:DispatchEvent(var_0.Event.New(var_0_0.ANTI_AIR_AREA, {}))
	arg_159_1:SetDeathReason(var_0_2.UnitDeathReason.DEFUSION)
	arg_159_0:KillUnit(arg_159_1:GetUniqueID())

	return
end

function var_0_8.FreezeUnit(arg_160_0, arg_160_1)
	var_0_5.SetCurrent(arg_160_1, var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY, var_0_3.FUSION_ELEMENT_UNIT_TYPE)
	arg_160_1:UpdateBlindInvisibleBySpectre()
	arg_160_0:SwitchSpectreUnit(arg_160_1)

	if arg_160_1:GetAimBias() then
		local var_160_0 = arg_160_1:GetAimBias()

		var_160_0:RemoveCrew(arg_160_1)

		if var_160_0:GetCurrentState() == var_160_0.STATE_EXPIRE then
			arg_160_0:DispatchEvent(var_0.Event.New(var_0_0.REMOVE_AIM_BIAS, {
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

function var_0_8.ActiveFreezeUnit(arg_161_0, arg_161_1)
	var_0_5.SetCurrent(arg_161_1, var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY, var_0_3.PLAYER_DEFAULT)
	arg_161_1:UpdateBlindInvisibleBySpectre()
	arg_161_0:SwitchSpectreUnit(arg_161_1)
	var_0_4.AttachWeather(arg_161_1, arg_161_0._weahter)
	arg_161_1:ActiveFreeze()

	local var_161_0 = arg_161_1:GetFleetVO()

	if var_161_0 then
		var_161_0:ActiveFreezeUnit(arg_161_1)
	end

	return
end

function var_0_8.GetFleetLegal(arg_162_0, arg_162_1, arg_162_2)
	local var_162_0 = arg_162_0:GetFleetByIFF(arg_162_1)

	if arg_162_2 == SYSTEM_DUEL or arg_162_2 == SYSTEM_PERFORM or arg_162_2 == SYSTEM_SUB_ROUTINE or arg_162_2 == SYSTEM_CARDPUZZLE or arg_162_2 == SYSTEM_PROLOGUE or arg_162_2 == SYSTEM_DODGEM or arg_162_2 == SYSTEM_SIMULATION or arg_162_2 == SYSTEM_SUBMARINE_RUN or arg_162_2 == SYSTEM_SCENARIO_SUB_STRIKE or arg_162_2 == SYSTEM_DEBUG or arg_162_2 == SYSTEM_AIRFIGHT then
		do return true end

		goto label_162_0
	end

	::label_162_0::

	if #var_162_0:GetScoutList() ~= 0 then
		if not var_162_0:GetFlagShip():IsAlive() then
			return false
		else
			return true
		end

		return
	end
end

function var_0_8.TriggerFinishBattle(arg_163_0)
	for iter_163_0, iter_163_1 in pairs(arg_163_0._fleetList) do
		for iter_163_2, iter_163_3 in ipairs((iter_163_1:GetUnitList())) do
			iter_163_3:TriggerBuff(var_0_2.BuffEffectType.ON_FINISH_GAME)
		end
	end

	for iter_163_4, iter_163_5 in pairs(arg_163_0._minionShipList) do
		iter_163_5:TriggerBuff(var_0_2.BuffEffectType.ON_FINISH_GAME)
	end

	return
end

function var_0_8.ChapterSupportBarrage(arg_164_0, arg_164_1, arg_164_2)
	local var_164_0

	if arg_164_2 then
		var_164_0 = pg.TimeMgr.GetInstance():AddBattleTimer("supportBarrageTimer", -1, arg_164_2, function(...)
			for iter_165_0, iter_165_1 in ipairs(arg_164_0._battleInitData.SupportUnitList) do
				if table.contains(ShipType.BundleList.qian, var_0_4.GetPlayerShipTmpDataFromID(iter_165_1.tmpID).type) then
					var_0_5.SetCurrent(arg_164_0:SpawnSupportUnit(iter_165_1, arg_164_1), "loadSpeed", 0)
				end
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_164_0)

			return
		end)
	else
		(function(...)
			for iter_165_0, iter_165_1 in ipairs(arg_164_0._battleInitData.SupportUnitList) do
				if table.contains(ShipType.BundleList.qian, var_0_4.GetPlayerShipTmpDataFromID(iter_165_1.tmpID).type) then
					var_0_5.SetCurrent(arg_164_0:SpawnSupportUnit(iter_165_1, arg_164_1), "loadSpeed", 0)
				end
			end

			pg.TimeMgr.GetInstance():RemoveBattleTimer(var_164_0)

			return
		end)()
	end

	return
end

return
