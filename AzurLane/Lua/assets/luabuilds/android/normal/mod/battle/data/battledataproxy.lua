ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleEvent
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleConst
local var_0_4 = var_0.Battle.BattleConfig
local var_0_5 = var_0.Battle.BattleDataFunction
local var_0_6 = var_0.Battle.BattleAttr
local var_0_7 = var_0.Battle.BattleVariable
local var_0_8 = var_0.Battle.BattleCardPuzzleEvent

singletonClass = var_0_10009

local var_0_9 = var_0_10009("BattleDataProxy", var_0.MVC.Proxy)

var_0.Battle.BattleDataProxy = var_0_9
var_0_9.__name = "BattleDataProxy"

function var_0_9.Ctor(arg_1_0)
	var_0_9.super.Ctor(arg_1_0)

	return
end

function var_0_9.InitBattle(arg_2_0, arg_2_1)
	arg_2_0.Update = arg_2_0.updateInit

	local var_2_0 = arg_2_1.battleType

	SYSTEM_WORLD = var_1_10003

	local var_2_1

	if var_2_0 ~= var_1_10003 then
		SYSTEM_WORLD_BOSS = var_1_10003

		if var_2_0 ~= var_1_10003 then
			var_2_1 = false

			goto label_2_0
		end
	end

	var_2_1 = true

	::label_2_0::

	pg = var_1_10004

	local var_2_2 = var_1_10004.SdkMgr.GetInstance()
	local var_2_3

	if var_4.CheckPretest(var_2_2) then
		PlayerPrefs = var_2_3

		if not var_2_3.GetInt("stage_scratch") then
			var_2_3 = 0
		end

		var_2_3 = var_2_3 == 1
	end

	local var_2_4 = arg_2_0
	local var_2_5 = arg_2_0.SetupCalculateDamage

	if var_2_3 then
		GodenFnger = var_1_10007

		if not var_1_10007 then
			var_1_10007 = var_0_2.CreateContextCalculateDamage(var_2_1)
		end

		var_2_5(var_2_4, var_1_10007)
		arg_2_0:SetupDamageKamikazeAir()
		arg_2_0:SetupDamageKamikazeShip()
		arg_2_0:SetupDamageCrush()
		var_0_7.Init()
		arg_2_0:InitData(arg_2_1)
		arg_2_0:DispatchEvent(var_0.Event.New(var_0_1.STAGE_DATA_INIT_FINISH))

		local var_2_6 = arg_2_0._cameraUtil

		var_5.Initialize(var_2_6)

		local var_2_7 = arg_2_0._cameraUtil

		arg_2_0._cameraTop, arg_2_0._cameraBottom, arg_2_0._cameraLeft, arg_2_0._cameraRight = var_5.SetMapData(var_2_7, arg_2_0:GetTotalBounds())

		arg_2_0:InitWeatherData()
		arg_2_0:InitUserShipsData(arg_2_0._battleInitData.MainUnitList, arg_2_0._battleInitData.VanguardUnitList, var_0_4.FRIENDLY_CODE, arg_2_0._battleInitData.SubUnitList)
		arg_2_0:InitUserSupportShipsData(var_0_4.FRIENDLY_CODE, arg_2_0._battleInitData.SupportUnitList)
		arg_2_0:InitUserAidData()
		arg_2_0:SetSubmarinAidData()

		local var_2_8 = arg_2_0._cameraUtil

		var_5.SetFocusFleet(var_2_8, arg_2_0:GetFleetByIFF(var_0_4.FRIENDLY_CODE))

		local var_2_9 = arg_2_0
		local var_2_10 = arg_2_0.StatisticsInit
		local var_2_11 = arg_2_0._fleetList[var_0_4.FRIENDLY_CODE]

		var_2_10(var_2_9, var_7.GetUnitList(var_2_11))

		local var_2_12 = arg_2_0
		local var_2_13 = arg_2_0.SetFlagShipID
		local var_2_14 = arg_2_0:GetFleetByIFF(var_0_4.FRIENDLY_CODE)

		var_2_13(var_2_12, var_7.GetFlagShip(var_2_14))
		arg_2_0:DispatchEvent(var_0.Event.New(var_0_1.COMMON_DATA_INIT_FINISH, {}))

		return
	end
end

function var_0_9.OnCameraRatioUpdate(arg_3_0)
	local var_3_0 = arg_3_0._cameraUtil

	arg_3_0._cameraTop, arg_3_0._cameraBottom, arg_3_0._cameraLeft, arg_3_0._cameraRight = var_1.SetMapData(var_3_0, arg_3_0:GetTotalBounds())

	local var_3_1 = arg_3_0._cameraUtil

	var_1.setArrowPoint(var_3_1)

	return
end

function var_0_9.Start(arg_4_0)
	pg = var_1_10001

	local var_4_0 = var_1_10001.TimeMgr.GetInstance()

	arg_4_0._startTimeStamp = var_1.GetCombatTime(var_4_0)

	return
end

function var_0_9.TriggerBattleInitBuffs(arg_5_0)
	pairs = var_1_10001

	for iter_5_0, iter_5_1 in var_1_10001(arg_5_0._fleetList) do
		local var_5_0 = iter_5_1:GetUnitList()

		iter_5_1:FleetBuffTrigger(var_0_3.BuffEffectType.ON_INIT_GAME)
	end

	return
end

function var_0_9.TirggerBattleStartBuffs(arg_6_0)
	pairs = var_1_10001

	for iter_6_0, iter_6_1 in var_1_10001(arg_6_0._fleetList) do
		local var_6_0 = iter_6_1:GetUnitList()
		local var_6_1 = iter_6_1:GetScoutList()[1]
		local var_6_2

		if not (#var_7 > 1) or not var_7[#var_7] then
			var_6_2 = nil
		end

		local var_6_3

		if #var_7 ~= 3 or not var_7[2] then
			var_6_3 = nil
		end

		local var_6_4 = iter_6_1:GetMainList()[1]
		local var_6_5 = var_11[2]
		local var_6_6 = var_11[3]

		ipairs = var_1_10015

		for iter_6_2, iter_6_3 in var_1_10015(var_6_0) do
			underscore = iter_6_11
			iter_6_11 = iter_6_11.each

			if not arg_6_0._battleInitData.ChapterBuffIDs then
				var_1_10021 = {}
			end

			iter_6_11(var_1_10021, function(arg_7_0)
				local var_7_0 = var_0.Battle.BattleBuffUnit.New(arg_7_0)
				local var_7_1 = iter_6_3

				var_2.AddBuff(var_7_1, var_7_0)

				return
			end)

			underscore = iter_6_11
			iter_6_11 = iter_6_11.each

			if not arg_6_0._battleInitData.GlobalBuffIDs then
				var_1_10021 = {}
			end

			iter_6_11(var_1_10021, function(arg_8_0)
				tonumber = var_2_10001
				arg_8_0 = var_2_10001(arg_8_0)

				local var_8_0 = var_0.Battle.BattleBuffUnit.New(arg_8_0)
				local var_8_1 = iter_6_3

				var_2.AddBuff(var_8_1, var_8_0)

				return
			end)

			if arg_6_0._battleInitData.MapAuraSkills then
				ipairs = iter_6_11

				for iter_6_4, iter_6_5 in iter_6_11(arg_6_0._battleInitData.MapAuraSkills) do
					local var_6_7 = var_0.Battle.BattleBuffUnit.New(iter_6_5.id, iter_6_5.level)

					iter_6_3:AddBuff(var_6_7)
				end
			end

			if arg_6_0._battleInitData.MapAidSkills then
				ipairs = iter_6_11

				for iter_6_6, iter_6_7 in iter_6_11(arg_6_0._battleInitData.MapAidSkills) do
					local var_6_8 = var_0.Battle.BattleBuffUnit.New(iter_6_7.id, iter_6_7.level)

					iter_6_3:AddBuff(var_6_8)
				end
			end

			if arg_6_0._currentStageData.stageBuff then
				ipairs = iter_6_11

				for iter_6_8, iter_6_9 in iter_6_11(arg_6_0._currentStageData.stageBuff) do
					local var_6_9 = var_0.Battle.BattleBuffUnit.New(iter_6_9.id, iter_6_9.level)

					iter_6_3:AddBuff(var_6_9)
				end
			end

			var_1_10021 = iter_6_3

			iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_START_GAME)

			if iter_6_3 == var_6_4 then
				var_1_10021 = iter_6_3

				iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_FLAG_SHIP)
			elseif iter_6_3 == var_6_5 then
				var_1_10021 = iter_6_3

				iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_UPPER_CONSORT)
			elseif iter_6_3 == var_6_6 then
				var_1_10021 = iter_6_3

				iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_LOWER_CONSORT)
			elseif iter_6_3 == var_6_1 then
				var_1_10021 = iter_6_3

				iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_LEADER)
			elseif iter_6_3 == var_6_3 then
				var_1_10021 = iter_6_3

				iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_CENTER)
			elseif iter_6_3 == var_6_2 then
				var_1_10021 = iter_6_3

				iter_6_3.TriggerBuff(var_1_10021, var_0_3.BuffEffectType.ON_REAR)
			end
		end

		local var_6_10 = iter_6_1

		var_1_10015 = iter_6_1.GetSupportUnitList(var_6_10)
		ipairs = var_6_10

		for iter_6_10, iter_6_11 in var_6_10(var_1_10015) do
			underscore = var_1_10021
			var_1_10021 = var_1_10021.each

			local var_6_11

			if not arg_6_0._battleInitData.ChapterBuffIDs then
				var_6_11 = {}
			end

			var_1_10021(var_6_11, function(arg_9_0)
				if var_0_5.GetSLGStrategyBuffByCombatBuffID(arg_9_0) then
					local var_9_0 = var_1.type

					ChapterConst = var_2_10003

					if var_9_0 == var_2_10003.AirDominanceStrategyBuffType then
						local var_9_1 = var_0.Battle.BattleBuffUnit.New(arg_9_0)
						local var_9_2 = iter_6_11

						var_3.AddBuff(var_9_2, var_9_1)
					end
				end

				return
			end)
		end
	end

	return
end

function var_0_9.InitAllFleetUnitsWeaponCD(arg_10_0)
	pairs = var_1_10001

	for iter_10_0, iter_10_1 in var_1_10001(arg_10_0._fleetList) do
		local var_10_0 = iter_10_1
		local var_10_1 = iter_10_1.GetUnitList(var_10_0)

		ipairs = var_10_0

		for iter_10_2, iter_10_3 in var_10_0(var_10_1) do
			var_0_9.InitUnitWeaponCD(iter_10_3)
		end
	end

	return
end

function var_0_9.InitUnitWeaponCD(arg_11_0)
	arg_11_0:CheckWeaponInitial()

	return
end

function var_0_9.StartCardPuzzle(arg_12_0)
	pairs = var_1_10001

	for iter_12_0, iter_12_1 in var_1_10001(arg_12_0._fleetList) do
		local var_12_0 = iter_12_1:GetCardPuzzleComponent()

		var_6.Start(var_12_0)
	end

	return
end

function var_0_9.PausePuzzleComponent(arg_13_0)
	pairs = var_1_10001

	for iter_13_0, iter_13_1 in var_1_10001(arg_13_0._fleetList) do
		if iter_13_1:GetCardPuzzleComponent() then
			var_6:BlockComponentByCard(true)
		end
	end

	return
end

function var_0_9.ResumePuzzleComponent(arg_14_0)
	onDelayTick = var_1_10001

	var_1_10001(function()
		pairs = var_2_10000

		for iter_15_0, iter_15_1 in var_2_10000(arg_14_0._fleetList) do
			if iter_15_1:GetCardPuzzleComponent() then
				var_5:BlockComponentByCard(false)
			end
		end

		return
	end, 0.06)

	return
end

function var_0_9.GetInitData(arg_16_0)
	return arg_16_0._battleInitData
end

function var_0_9.GetDungeonData(arg_17_0)
	return arg_17_0._dungeonInfo
end

function var_0_9.InitData(arg_18_0, arg_18_1)
	arg_18_0.FrameIndex = 1
	arg_18_0._friendlyCode = 1
	arg_18_0._foeCode = -1
	var_0_3.FRIENDLY_CODE = 1
	var_0_3.FOE_CODE = -1
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
	pg = var_2
	arg_18_0._expeditionTmp = var_2.expedition_data_template[arg_18_0._expeditionID]

	local var_18_0 = arg_18_0
	local var_18_1 = arg_18_0.SetDungeonLevel
	local var_18_2

	if not arg_18_1.WorldLevel then
		var_18_2 = arg_18_0._expeditionTmp.level
	end

	var_18_1(var_18_0, var_18_2)

	arg_18_0._dungeonID = arg_18_0._expeditionTmp.dungeon_id
	arg_18_0._dungeonInfo = var_0_5.GetDungeonTmpDataByID(arg_18_0._dungeonID)

	if arg_18_1.WorldMapId then
		arg_18_0._mapId = arg_18_1.WorldMapId
	elseif arg_18_0._expeditionTmp.map_id then
		if #arg_18_0._expeditionTmp.map_id == 1 then
			arg_18_0._mapId = var_2[1][1]
		else
			local var_18_3 = {}

			ipairs = var_18_2

			for iter_18_0, iter_18_1 in var_18_2(var_2) do
				local var_18_4 = iter_18_1[2] * 100

				table = var_1_10010

				var_1_10010.insert(var_18_3, {
					rst = iter_18_1[1],
					weight = var_18_4
				})
			end

			arg_18_0._mapId = var_0_2.WeightRandom(var_18_3)
		end
	end

	local var_18_5

	if not arg_18_1.ChapterWeatherIDS then
		var_18_5 = {}
	end

	arg_18_0._weahter = var_18_5
	arg_18_0._exposeSpeed = arg_18_0._expeditionTmp.expose_speed
	arg_18_0._airExpose = arg_18_0._expeditionTmp.aircraft_expose[1]
	arg_18_0._airExposeEX = arg_18_0._expeditionTmp.aircraft_expose[2]
	arg_18_0._shipExpose = arg_18_0._expeditionTmp.ship_expose[1]
	arg_18_0._shipExposeEX = arg_18_0._expeditionTmp.ship_expose[2]

	local var_18_6

	if not arg_18_1.CommanderList then
		var_18_6 = {}
	end

	arg_18_0._commander = var_18_6

	local var_18_7

	if not arg_18_1.SubCommanderList then
		var_18_7 = {}
	end

	arg_18_0._subCommander = var_18_7
	arg_18_0._commanderBuff = arg_18_0.initCommanderBuff(arg_18_0._commander)
	arg_18_0._subCommanderBuff = arg_18_0.initCommanderBuff(arg_18_0._subCommander)

	if arg_18_0._battleInitData.RepressInfo then
		local var_18_8 = arg_18_0._battleInitData.RepressInfo
		local var_18_9 = arg_18_0._battleInitData.battleType

		SYSTEM_SCENARIO = var_18_2

		if var_18_9 == var_18_2 then
			local var_18_10 = var_18_8.repressCount

			if var_18_8.repressMax <= var_18_10 then
				arg_18_0._completelyRepress = true
			end

			arg_18_0._repressReduce = var_0_2.ChapterRepressReduce(var_18_8.repressReduce)
			arg_18_0._repressLevel = var_18_8.repressLevel
			arg_18_0._repressEnemyHpRant = var_18_8.repressEnemyHpRant

			goto label_18_0
		end

		local var_18_11 = arg_18_0._battleInitData.battleType

		SYSTEM_WORLD = var_18_2

		if var_18_11 ~= var_18_2 then
			do
				local var_18_12 = arg_18_0._battleInitData.battleType

				SYSTEM_WORLD_BOSS = var_18_2

				if var_18_12 == var_18_2 then
					arg_18_0._repressEnemyHpRant = var_18_8.repressEnemyHpRant
				end

				local var_18_13
			end

			::label_18_0::

			if not arg_18_0._battleInitData.DefeatCount then
				var_18_13 = 0
			end

			arg_18_0._chapterWinningStreak = var_18_13
			table = var_18_13

			local var_18_14

			if not var_18_13.shallowCopy(arg_18_1.StageWaveFlags) then
				var_18_14 = {}
			end

			arg_18_0._waveFlags = var_18_14

			arg_18_0:InitStageData()

			arg_18_0._cldSystem = var_0.Battle.BattleCldSystem.New(arg_18_0)
			arg_18_0._cameraUtil = var_0.Battle.BattleCameraUtil.GetInstance()

			arg_18_0:initBGM()

			return
		end
	end
end

function var_0_9.initBGM(arg_19_0)
	arg_19_0._initBGMList = {}
	arg_19_0._otherBGMList = {}

	local var_19_0 = {}
	local var_19_1 = {}

	;(function(arg_20_0)
		ipairs = var_2_10001

		for iter_20_0, iter_20_1 in var_2_10001(arg_20_0) do
			local var_20_0 = {}

			if iter_20_1.skills then
				ipairs = var_7

				for iter_20_2, iter_20_3 in var_7(iter_20_1.skills) do
					table = iter_20_9

					iter_20_9.insert(var_20_0, iter_20_3)
				end
			end

			if iter_20_1.equipment then
				local var_20_1 = var_0_5.GetEquipSkill(iter_20_1.equipment, arg_19_0._battleInitData.battleType)

				ipairs = var_8

				for iter_20_4, iter_20_9 in var_8(var_20_1) do
					var_20_0[iter_20_9.buffID] = {
						id = iter_20_9.buffID,
						level = iter_20_9.buffLV
					}
				end
			end

			local var_20_2 = var_0_5.GetSongList(var_20_0)

			pairs = var_8

			for iter_20_6, iter_20_9 in var_8(var_20_2.initList) do
				var_19_0[iter_20_6] = true
			end

			pairs = var_8

			for iter_20_8, iter_20_9 in var_8(var_20_2.otherList) do
				var_19_1[iter_20_8] = true
			end
		end

		return
	end)(arg_19_0._battleInitData.MainUnitList)
	var_3(arg_19_0._battleInitData.VanguardUnitList)
	var_3(arg_19_0._battleInitData.SubUnitList)

	if arg_19_0._battleInitData.RivalMainUnitList then
		var_3(arg_19_0._battleInitData.RivalMainUnitList)
	end

	if arg_19_0._battleInitData.RivalVanguardUnitList then
		var_3(arg_19_0._battleInitData.RivalVanguardUnitList)
	end

	pairs = var_4

	for iter_19_0, iter_19_1 in var_4(var_19_0) do
		table = var_1_10009

		var_1_10009.insert(arg_19_0._initBGMList, iter_19_0)
	end

	pairs = var_4

	for iter_19_2, iter_19_3 in var_4(var_19_1) do
		table = var_1_10009

		var_1_10009.insert(arg_19_0._otherBGMList, iter_19_2)
	end

	return
end

function var_0_9.initCommanderBuff(arg_21_0)
	local var_21_0 = {}

	ipairs = var_1_10002

	for iter_21_0, iter_21_1 in var_1_10002(arg_21_0) do
		local var_21_1 = iter_21_1[1]
		local var_21_2 = var_7.getSkills(var_21_1)[1]
		local var_21_3 = var_8.getLevel(var_21_2)

		ipairs = var_21_2

		for iter_21_2, iter_21_3 in var_21_2(iter_21_1[2]) do
			table = var_1_10014

			var_1_10014.insert(var_21_0, {
				id = iter_21_3,
				level = var_21_3,
				commander = var_7
			})
		end
	end

	return var_21_0
end

function var_0_9.Clear(arg_22_0)
	pairs = var_1_10001

	for iter_22_0, iter_22_1 in var_1_10001(arg_22_0._teamList) do
		arg_22_0:KillNPCTeam(iter_22_1)
	end

	arg_22_0._teamList = nil
	pairs = var_1

	for iter_22_2, iter_22_3 in var_1(arg_22_0._bulletList) do
		arg_22_0:RemoveBulletUnit(iter_22_2)
	end

	arg_22_0._bulletList = nil
	pairs = var_1

	for iter_22_4, iter_22_5 in var_1(arg_22_0._unitList) do
		arg_22_0:KillUnit(iter_22_4)
	end

	arg_22_0._unitList = nil
	ipairs = var_1

	for iter_22_6, iter_22_7 in var_1(arg_22_0._deadUnitList) do
		iter_22_7:Dispose()
	end

	arg_22_0._deadUnitList = nil
	pairs = var_1

	for iter_22_8, iter_22_9 in var_1(arg_22_0._aircraftList) do
		arg_22_0:KillAircraft(iter_22_8)
	end

	arg_22_0._aircraftList = nil
	pairs = var_1

	for iter_22_10, iter_22_11 in var_1(arg_22_0._fleetList) do
		iter_22_11:Dispose()

		arg_22_0._fleetList[iter_22_10] = nil
	end

	arg_22_0._fleetList = nil
	pairs = var_1

	for iter_22_12, iter_22_13 in var_1(arg_22_0._aidUnitList) do
		iter_22_13:Dispose()
	end

	arg_22_0._aidUnitList = nil
	pairs = var_1

	for iter_22_14, iter_22_15 in var_1(arg_22_0._environmentList) do
		arg_22_0:RemoveEnvironment(iter_22_15:GetUniqueID())
	end

	arg_22_0._environmentList = nil
	pairs = var_1

	for iter_22_16, iter_22_17 in var_1(arg_22_0._AOEList) do
		arg_22_0:RemoveAreaOfEffect(iter_22_16)
	end

	arg_22_0._AOEList = nil

	local var_22_0 = arg_22_0._cldSystem

	var_1.Dispose(var_22_0)

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
	var_0_5.ClearDungeonCfg(arg_22_0._dungeonID)

	return
end

function var_0_9.DeactiveProxy(arg_23_0)
	arg_23_0._state = nil

	arg_23_0:Clear()
	var_0.Battle.BattleDataProxy.super.DeactiveProxy(arg_23_0)

	return
end

function var_0_9.InitUserShipsData(arg_24_0, arg_24_1, arg_24_2, arg_24_3, arg_24_4)
	ipairs = var_1_10005

	for iter_24_0, iter_24_1 in var_1_10005(arg_24_2) do
		local var_24_0 = arg_24_0:SpawnVanguard(iter_24_1, arg_24_3)
	end

	ipairs = var_5

	for iter_24_2, iter_24_3 in var_5(arg_24_1) do
		local var_24_1 = arg_24_0:SpawnMain(iter_24_3, arg_24_3)
	end

	local var_24_2 = arg_24_0:GetFleetByIFF(arg_24_3)

	var_5.FleetUnitSpwanFinish(var_24_2)

	local var_24_3 = arg_24_0._battleInitData.battleType

	SYSTEM_SUBMARINE_RUN = var_24_2

	if var_24_3 ~= var_24_2 then
		SYSTEM_SUB_ROUTINE = var_24_2

		if var_24_3 == var_24_2 then
			ipairs = var_24_2

			for iter_24_4, iter_24_5 in var_24_2(arg_24_4) do
				arg_24_0:SpawnManualSub(iter_24_5, arg_24_3)
			end

			iter_24_2 = var_5

			var_5.ShiftManualSub(iter_24_2)
		else
			iter_24_2 = var_5

			var_5.SetSubUnitData(iter_24_2, arg_24_4)
		end

		local var_24_4 = arg_24_0._battleInitData.battleType

		SYSTEM_DUEL = iter_24_2

		if var_24_4 == iter_24_2 then
			ipairs = var_24_4

			for iter_24_6, iter_24_7 in var_24_4(var_5:GetCloakList()) do
				local var_24_5 = iter_24_7:GetCloak()

				var_12.SetRecoverySpeed(var_24_5, 0)
			end
		end

		arg_24_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_FLEET, {
			fleetVO = var_5
		}))

		return
	end
end

function var_0_9.InitUserSupportShipsData(arg_25_0, arg_25_1, arg_25_2)
	ipairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_2) do
		local var_25_0 = var_0_5.GetPlayerShipTmpDataFromID(iter_25_1.tmpID).type

		table = var_9

		local var_25_1 = var_9.contains

		ShipType = var_1_10010

		if var_25_1(var_1_10010.BundleList.hang, var_25_0) then
			var_1_10010 = arg_25_0

			local var_25_2 = arg_25_0.SpawnSupportUnit(var_1_10010, iter_25_1, arg_25_1)
		end
	end

	return
end

function var_0_9.InitUserAidData(arg_26_0)
	ipairs = var_1_10001

	for iter_26_0, iter_26_1 in var_1_10001(arg_26_0._battleInitData.AidUnitList) do
		local var_26_0 = arg_26_0:GenerateUnitID()
		local var_26_1 = iter_26_1.properties

		var_26_1.level = iter_26_1.level
		var_26_1.formationID = var_0_4.FORMATION_ID
		var_26_1.id = iter_26_1.id

		var_0_2.AttrFixer(arg_26_0._battleInitData.battleType, var_26_1)

		local var_26_2

		if not iter_26_1.proficiency then
			var_26_2 = {
				1,
				1,
				1
			}
		end

		local var_26_3 = var_0_5.CreateBattleUnitData(var_26_0, var_0_3.UnitType.PLAYER_UNIT, var_0_4.FRIENDLY_CODE, iter_26_1.tmpID, iter_26_1.skinId, iter_26_1.equipment, var_26_1, iter_26_1.baseProperties, var_26_2, iter_26_1.baseList, iter_26_1.preloasList)

		arg_26_0._aidUnitList[var_26_3:GetUniqueID()] = var_26_3
	end

	return
end

function var_0_9.SetSubmarinAidData(arg_27_0)
	local var_27_0 = arg_27_0:GetFleetByIFF(var_0_4.FRIENDLY_CODE)

	var_1.SetSubAidData(var_27_0, arg_27_0._battleInitData.TotalSubAmmo, arg_27_0._battleInitData.SubFlag)

	return
end

function var_0_9.AddWeather(arg_28_0, arg_28_1)
	table = var_1_10002

	var_1_10002.insert(arg_28_0._weahter, arg_28_1)
	arg_28_0:InitWeatherData()

	return
end

function var_0_9.InitWeatherData(arg_29_0)
	ipairs = var_1_10001

	for iter_29_0, iter_29_1 in var_1_10001(arg_29_0._weahter) do
		if iter_29_1 == var_0_3.WEATHER.NIGHT then
			pairs = var_6

			for iter_29_2, iter_29_3 in var_6(arg_29_0._fleetList) do
				iter_29_3:AttachNightCloak()
			end

			pairs = var_6

			for iter_29_4, iter_29_5 in var_6(arg_29_0._unitList) do
				var_0_5.AttachWeather(iter_29_5, arg_29_0._weahter)
			end
		end
	end

	return
end

function var_0_9.CelebrateVictory(arg_30_0, arg_30_1)
	local var_30_0

	if arg_30_1 == arg_30_0:GetFoeCode() then
		var_30_0 = arg_30_0._foeShipList
	else
		var_30_0 = arg_30_0._friendlyShipList
	end

	pairs = var_3

	for iter_30_0, iter_30_1 in var_3(var_30_0) do
		iter_30_1:StateChange(var_0.Battle.UnitState.STATE_VICTORY)
	end

	return
end

function var_0_9.InitStageData(arg_31_0)
	arg_31_0._currentStageData = arg_31_0._dungeonInfo.stages[arg_31_0._currentStageIndex]
	arg_31_0._countDown = arg_31_0._currentStageData.timeCount
	arg_31_0._totalLeftBound = arg_31_0._currentStageData.totalArea[1]
	arg_31_0._totalRightBound = var_1[1] + var_1[3]
	arg_31_0._totalUpperBound = var_1[2] + var_1[4]
	arg_31_0._totalLowerBound = var_1[2]
	arg_31_0._leftZoneLeftBound = arg_31_0._currentStageData.playerArea[1]
	arg_31_0._leftZoneRightBound = var_2[1] + var_2[3]
	arg_31_0._leftZoneUpperBound = var_2[2] + var_2[4]
	arg_31_0._leftZoneLowerBound = var_2[2]
	arg_31_0._rightZoneLeftBound = arg_31_0._leftZoneRightBound
	arg_31_0._rightZoneRightBound = arg_31_0._totalRightBound
	arg_31_0._rightZoneUpperBound = arg_31_0._leftZoneUpperBound
	arg_31_0._rightZoneLowerBound = arg_31_0._leftZoneLowerBound
	arg_31_0._bulletUpperBound = arg_31_0._totalUpperBound + 3
	arg_31_0._bulletLowerBound = arg_31_0._totalLowerBound - 10
	arg_31_0._bulletLeftBound = arg_31_0._totalLeftBound - 10
	arg_31_0._bulletRightBound = arg_31_0._totalRightBound + 10
	arg_31_0._bulletUpperBoundVision = arg_31_0._totalUpperBound + var_0_4.BULLET_UPPER_BOUND_VISION_OFFSET
	arg_31_0._bulletLowerBoundSplit = arg_31_0._bulletLowerBound + var_0_4.BULLET_LOWER_BOUND_SPLIT_OFFSET
	arg_31_0._bulletLeftBoundSplit = arg_31_0._bulletLeftBound + var_0_4.BULLET_LEFT_BOUND_SPLIT_OFFSET

	local var_31_0 = arg_31_0._battleInitData.battleType

	SYSTEM_DUEL = var_4

	if var_31_0 == var_4 then
		arg_31_0._leftFieldBound = arg_31_0._totalLeftBound
		arg_31_0._rightFieldBound = arg_31_0._totalRightBound
	else
		local var_31_1

		if arg_31_0._currentStageData.mainUnitPosition and arg_31_0._currentStageData.mainUnitPosition[var_0_4.FRIENDLY_CODE] then
			var_31_1 = arg_31_0._currentStageData.mainUnitPosition[var_0_4.FRIENDLY_CODE][1].x
		else
			var_31_1 = var_0_4.MAIN_UNIT_POS[var_0_4.FRIENDLY_CODE][1].x
		end

		arg_31_0._leftFieldBound = var_31_1 - 1
		arg_31_0._rightFieldBound = arg_31_0._totalRightBound + var_0_4.FIELD_RIGHT_BOUND_BIAS
	end

	return
end

function var_0_9.GetVanguardBornCoordinate(arg_32_0, arg_32_1)
	if arg_32_1 == var_0_4.FRIENDLY_CODE then
		return arg_32_0._currentStageData.fleetCorrdinate
	elseif arg_32_1 == var_0_4.FOE_CODE then
		return arg_32_0._currentStageData.rivalCorrdinate
	end

	return
end

function var_0_9.GetTotalBounds(arg_33_0)
	return arg_33_0._totalUpperBound, arg_33_0._totalLowerBound, arg_33_0._totalLeftBound, arg_33_0._totalRightBound
end

function var_0_9.GetTotalRightBound(arg_34_0)
	return arg_34_0._totalRightBound
end

function var_0_9.GetTotalLowerBound(arg_35_0)
	return arg_35_0._totalLowerBound
end

function var_0_9.GetUnitBoundByIFF(arg_36_0, arg_36_1)
	if arg_36_1 == var_0_4.FRIENDLY_CODE then
		return arg_36_0._leftZoneUpperBound, arg_36_0._leftZoneLowerBound, arg_36_0._leftZoneLeftBound, var_0_4.MaxRight, var_0_4.MaxLeft, arg_36_0._leftZoneRightBound
	elseif arg_36_1 == var_0_4.FOE_CODE then
		return arg_36_0._rightZoneUpperBound, arg_36_0._rightZoneLowerBound, arg_36_0._rightZoneLeftBound, arg_36_0._rightZoneRightBound, arg_36_0._rightZoneLeftBound, var_0_4.MaxRight
	end

	return
end

function var_0_9.GetFleetBoundByIFF(arg_37_0, arg_37_1)
	if arg_37_1 == var_0_4.FRIENDLY_CODE then
		return arg_37_0._leftZoneUpperBound, arg_37_0._leftZoneLowerBound, arg_37_0._leftZoneLeftBound, arg_37_0._leftZoneRightBound
	elseif arg_37_1 == var_0_4.FOE_CODE then
		return arg_37_0._rightZoneUpperBound, arg_37_0._rightZoneLowerBound, arg_37_0._rightZoneLeftBound, arg_37_0._rightZoneRightBound
	end

	return
end

function var_0_9.ShiftFleetBound(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = arg_38_1:GetUnitBound()

	var_3.SwtichDuelAggressive(var_38_0)
	arg_38_1:SetAutobotBound(arg_38_0:GetFleetBoundByIFF(arg_38_2))
	arg_38_1:UpdateScoutUnitBound()

	return
end

function var_0_9.GetFieldBound(arg_39_0)
	if arg_39_0._battleInitData then
		local var_39_0 = arg_39_0._battleInitData.battleType

		SYSTEM_DUEL = var_1_10002

		if var_39_0 == var_1_10002 then
			do return arg_39_0:GetTotalBounds() end

			goto label_39_0
		end
	end

	do return arg_39_0._totalUpperBound, arg_39_0._totalLowerBound, arg_39_0._leftFieldBound, arg_39_0._rightFieldBound end

	::label_39_0::

	return
end

function var_0_9.GetFleetByIFF(arg_40_0, arg_40_1)
	if arg_40_0._fleetList[arg_40_1] == nil then
		local var_40_0 = var_0.Battle.BattleFleetVO.New(arg_40_1)

		arg_40_0._fleetList[arg_40_1] = var_40_0

		var_40_0:SetAutobotBound(arg_40_0:GetFleetBoundByIFF(arg_40_1))
		var_40_0:SetTotalBound(arg_40_0:GetTotalBounds())
		var_40_0:SetUnitBound(arg_40_0._currentStageData.totalArea, arg_40_0._currentStageData.playerArea)
		var_40_0:SetExposeLine(arg_40_0._expeditionTmp.horizon_line[arg_40_1], arg_40_0._expeditionTmp.expose_line[arg_40_1])
		var_40_0:CalcSubmarineBaseLine(arg_40_0._battleInitData.battleType)

		local var_40_1 = var_40_0

		var_40_0.SetChapterPlayType(var_40_1, arg_40_0._battleInitData.ChapterType)

		local var_40_2 = arg_40_0._battleInitData.battleType

		SYSTEM_CARDPUZZLE = var_40_1

		if var_40_2 == var_40_1 then
			local var_40_3 = var_40_0:AttachCardPuzzleComponent()
			local var_40_4 = {
				cardList = arg_40_0._battleInitData.CardPuzzleCardIDList,
				commonHP = arg_40_0._battleInitData.CardPuzzleCommonHPValue,
				relicList = arg_40_0._battleInitData.CardPuzzleRelicList
			}

			var_40_3:InitCardPuzzleData(var_40_4)
			var_40_3:CustomConfigID(arg_40_0._battleInitData.CardPuzzleCombatID)
			arg_40_0:DispatchEvent(var_0.Event.New(var_0_8.CARD_PUZZLE_INIT))
		end
	end

	return arg_40_0._fleetList[arg_40_1]
end

function var_0_9.GetAidUnit(arg_41_0)
	return arg_41_0._aidUnitList
end

function var_0_9.GetFleetList(arg_42_0)
	return arg_42_0._fleetList
end

function var_0_9.GetEnemySubmarineCount(arg_43_0)
	return arg_43_0._enemySubmarineCount
end

function var_0_9.GetCommander(arg_44_0)
	return arg_44_0._commander
end

function var_0_9.GetCommanderBuff(arg_45_0)
	return arg_45_0._commanderBuff, arg_45_0._subCommanderBuff
end

function var_0_9.GetStageInfo(arg_46_0)
	return arg_46_0._currentStageData
end

function var_0_9.GetWinningStreak(arg_47_0)
	return arg_47_0._chapterWinningStreak
end

function var_0_9.GetBGMList(arg_48_0, arg_48_1)
	if not arg_48_1 then
		return arg_48_0._initBGMList
	else
		return arg_48_0._otherBGMList
	end

	return
end

function var_0_9.GetDungeonLevel(arg_49_0)
	return arg_49_0._dungeonLevel
end

function var_0_9.SetDungeonLevel(arg_50_0, arg_50_1)
	arg_50_0._dungeonLevel = arg_50_1

	return
end

function var_0_9.IsCompletelyRepress(arg_51_0)
	return arg_51_0._completelyRepress
end

function var_0_9.GetRepressReduce(arg_52_0)
	return arg_52_0._repressReduce
end

function var_0_9.GetRepressLevel(arg_53_0)
	return arg_53_0._repressLevel
end

function var_0_9.updateInit(arg_54_0, arg_54_1)
	arg_54_0:TriggerBattleInitBuffs()

	arg_54_0.checkCld = true

	arg_54_0:updateLoop(arg_54_1)

	arg_54_0.Update = arg_54_0.updateLoop

	return
end

function var_0_9.updateLoop(arg_55_0, arg_55_1)
	arg_55_0.FrameIndex = arg_55_0.FrameIndex + 1

	arg_55_0:updateDeadList()
	arg_55_0:UpdateCountDown(arg_55_1)
	arg_55_0:UpdateWeather(arg_55_1)

	pairs = var_2

	for iter_55_0, iter_55_1 in var_2(arg_55_0._fleetList) do
		iter_55_1:UpdateMotion()
	end

	arg_55_0.checkCld = not arg_55_0.checkCld

	local var_55_0 = {
		[var_0_4.FRIENDLY_CODE] = arg_55_0._totalLeftBound,
		[var_0_4.FOE_CODE] = arg_55_0._totalRightBound
	}

	pairs = var_3

	for iter_55_2, iter_55_3 in var_3(arg_55_0._unitList) do
		if iter_55_3:IsSpectre() then
			if iter_55_3:GetAttrByName(var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY) <= var_0_4.FUSION_ELEMENT_UNIT_TYPE then
				-- block empty
			else
				iter_55_3:Update(arg_55_1)
			end
		else
			if arg_55_0.checkCld then
				local var_55_1 = arg_55_0._cldSystem

				var_8.UpdateShipCldTree(var_55_1, iter_55_3)
			end

			if iter_55_3:IsAlive() then
				iter_55_3:Update(arg_55_1)
			end

			local var_55_2 = iter_55_3:GetPosition().x

			if iter_55_3:GetIFF() == var_0_4.FRIENDLY_CODE then
				math = var_10
				var_55_0[var_9] = var_10.max(var_55_0[var_9], var_55_2)
			elseif var_9 == var_0_4.FOE_CODE then
				math = var_10
				var_55_0[var_9] = var_10.min(var_55_0[var_9], var_55_2)
			end
		end
	end

	local var_55_3 = arg_55_0._fleetList[var_0_4.FRIENDLY_CODE]
	local var_55_4 = var_3.GetFleetExposeLine(var_55_3)
	local var_55_5 = var_3:GetFleetVisionLine()
	local var_55_6 = var_55_0[var_0_4.FOE_CODE]

	if var_55_4 and var_55_6 < var_55_4 then
		var_3:CloakFatalExpose()
	elseif var_55_6 < var_55_5 then
		var_3:CloakInVision(arg_55_0._exposeSpeed)
	else
		var_3:CloakOutVision()
	end

	if arg_55_0._fleetList[var_0_4.FOE_CODE] then
		local var_55_7 = arg_55_0._fleetList[var_0_4.FOE_CODE]
		local var_55_8 = var_7.GetFleetExposeLine(var_55_7)
		local var_55_9 = var_7:GetFleetVisionLine()
		local var_55_10 = var_55_0[var_0_4.FRIENDLY_CODE]

		if var_55_8 and var_55_8 < var_55_10 then
			var_7:CloakFatalExpose()
		elseif var_55_9 < var_55_10 then
			var_7:CloakInVision(arg_55_0._exposeSpeed)
		else
			var_7:CloakOutVision()
		end
	end

	pairs = var_7

	for iter_55_4, iter_55_5 in var_7(arg_55_0._bulletList) do
		local var_55_11 = iter_55_5:GetSpeed()
		local var_55_12 = iter_55_5:GetPosition()
		local var_55_13 = iter_55_5:GetType()

		if iter_55_5:GetOutBound() == var_0_3.BulletOutBound.SPLIT and var_55_13 == var_0_3.BulletType.SHRAPNEL and (var_55_12.x > arg_55_0._bulletRightBound and var_55_11.x > 0 or var_55_12.x < arg_55_0._bulletLeftBoundSplit and var_55_11.x < 0 or var_55_12.z > arg_55_0._bulletUpperBound and var_55_11.z > 0 or var_55_12.z < arg_55_0._bulletLowerBoundSplit and var_55_11.z < 0) then
			if iter_55_5:GetExist() then
				iter_55_5:OutRange()
			else
				arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
			end
		elseif (var_15 == var_0_3.BulletOutBound.COMMON or var_15 == var_0_3.BulletOutBound.SHIFT_SPLIT) and (var_55_12.x > arg_55_0._bulletRightBound and var_55_11.x > 0 or var_55_12.z < arg_55_0._bulletLowerBound and var_55_11.z < 0) then
			arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
		elseif var_55_12.x < arg_55_0._bulletLeftBound and var_55_11.x < 0 and var_55_13 ~= var_0_3.BulletType.BOMB then
			if var_15 == var_0_3.BulletOutBound.RANDOM then
				local var_55_14 = arg_55_0._fleetList[var_0_4.FRIENDLY_CODE]

				if var_16.RandomMainVictim(var_55_14) then
					arg_55_0:HandleDamage(iter_55_5, var_16)
				end
			end

			arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
		else
			iter_55_5:Update(arg_55_1)

			local var_55_15

			if not iter_55_5.GetCurrentState or not iter_55_5:GetCurrentState() then
				var_55_15 = nil
			end

			if var_55_15 == var_0.Battle.BattleShrapnelBulletUnit.STATE_FINAL_SPLIT then
				-- block empty
			elseif var_55_15 == var_0.Battle.BattleShrapnelBulletUnit.STATE_SPLIT and not iter_55_5:IsFragile() then
				-- block empty
			elseif (var_15 == var_0_3.BulletOutBound.COMMON or var_15 == var_0_3.BulletOutBound.SHIFT_SPLIT) and var_55_12.z > arg_55_0._bulletUpperBound and var_55_11.z > 0 or var_15 == var_0_3.BulletOutBound.VISION and var_55_12.z > arg_55_0._bulletUpperBoundVision and var_55_11.z > 0 or iter_55_5:IsOutRange(arg_55_1) then
				if iter_55_5:GetExist() then
					iter_55_5:OutRange()
				else
					arg_55_0:RemoveBulletUnit(iter_55_5:GetUniqueID())
				end
			elseif arg_55_0.checkCld then
				local var_55_16 = arg_55_0._cldSystem

				var_17.UpdateBulletCld(var_55_16, iter_55_5)
			end
		end
	end

	pairs = var_7

	for iter_55_6, iter_55_7 in var_7(arg_55_0._aircraftList) do
		iter_55_7:Update(arg_55_1)

		local var_55_17, var_55_18 = iter_55_7:GetIFF()

		if var_55_17 == var_0_4.FRIENDLY_CODE then
			var_55_18 = arg_55_0._totalRightBound
		elseif var_55_17 == var_0_4.FOE_CODE then
			var_55_18 = arg_55_0._totalLeftBound
		end

		local var_55_19 = iter_55_7
		local var_55_20 = iter_55_7.GetPosition(var_55_19).x * var_55_17

		math = var_55_19

		if var_55_20 > var_55_19.abs(var_55_18) and iter_55_7:GetSpeed().x * var_55_17 > 0 then
			iter_55_7:OutBound()
		else
			local var_55_21 = arg_55_0._cldSystem

			var_14.UpdateAircraftCld(var_55_21, iter_55_7)
		end

		if not iter_55_7:IsAlive() then
			arg_55_0:KillAircraft(iter_55_7:GetUniqueID())
		end
	end

	pairs = var_7

	for iter_55_8, iter_55_9 in var_7(arg_55_0._AOEList) do
		local var_55_22 = arg_55_0._cldSystem

		var_12.UpdateAOECld(var_55_22, iter_55_9)
		iter_55_9:Settle()

		if iter_55_9:GetActiveFlag() == false then
			iter_55_9:SettleFinale()
			arg_55_0:RemoveAreaOfEffect(iter_55_9:GetUniqueID())
		end
	end

	pairs = var_7

	for iter_55_10, iter_55_11 in var_7(arg_55_0._environmentList) do
		iter_55_11:Update()

		if iter_55_11:IsExpire(arg_55_1) then
			arg_55_0:RemoveEnvironment(iter_55_11:GetUniqueID())
		end
	end

	if arg_55_0.checkCld then
		pairs = var_7

		for iter_55_12, iter_55_13 in var_7(arg_55_0._shelterList) do
			if not iter_55_13:IsWallActive() then
				arg_55_0:RemoveShelter(iter_55_13:GetUniqueID())
			else
				iter_55_13:Update(arg_55_1)
			end
		end

		pairs = var_7

		for iter_55_14, iter_55_15 in var_7(arg_55_0._wallList) do
			if iter_55_15:IsActive() then
				local var_55_23 = arg_55_0._cldSystem

				var_12.UpdateWallCld(var_55_23, iter_55_15)
			end
		end
	end

	local var_55_24 = arg_55_0._battleInitData.battleType

	SYSTEM_DUEL = var_8

	if var_55_24 ~= var_8 then
		pairs = var_55_24

		for iter_55_16, iter_55_17 in var_55_24(arg_55_0._foeShipList) do
			if iter_55_17:GetPosition().x + iter_55_17:GetBoxSize().x < arg_55_0._leftZoneLeftBound then
				iter_55_17:SetDeathReason(var_0_3.UnitDeathReason.TOUCHDOWN)
				iter_55_17:DeadAction()
				arg_55_0:KillUnit(iter_55_17:GetUniqueID())
				arg_55_0:HandleShipMissDamage(iter_55_17, arg_55_0._fleetList[var_0_4.FRIENDLY_CODE])
			end
		end
	end

	return
end

function var_0_9.UpdateAutoComponent(arg_56_0, arg_56_1)
	pairs = var_1_10002

	for iter_56_0, iter_56_1 in var_1_10002(arg_56_0._fleetList) do
		iter_56_1:UpdateAutoComponent(arg_56_1)
	end

	pairs = var_2

	for iter_56_2, iter_56_3 in var_2(arg_56_0._teamList) do
		if iter_56_3:IsFatalDamage() then
			arg_56_0:KillNPCTeam(iter_56_2)
		else
			iter_56_3:UpdateMotion()
		end
	end

	pairs = var_2

	for iter_56_4, iter_56_5 in var_2(arg_56_0._freeShipList) do
		iter_56_5:UpdateOxygen(arg_56_1)
		iter_56_5:UpdateWeapon(arg_56_1)
		iter_56_5:UpdatePhaseSwitcher()
	end

	return
end

function var_0_9.UpdateWeather(arg_57_0, arg_57_1)
	ipairs = var_1_10002

	for iter_57_0, iter_57_1 in var_1_10002(arg_57_0._weahter) do
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

			pairs = var_10

			for iter_57_2, iter_57_3 in var_10(arg_57_0._unitList) do
				if not iter_57_3:GetAimBias() or var_15:GetCurrentState() ~= var_15.STATE_SUMMON_SICKNESS then
					local var_57_3 = var_57_1[iter_57_3:GetIFF()]
					local var_57_4 = var_0_6.GetCurrent(iter_57_3, "attackRating")
					local var_57_5 = var_0_6.GetCurrent(iter_57_3, "aimBiasExtraACC")

					math = var_20
					var_57_1[var_16] = var_20.max(var_57_3, var_57_4)
					var_57_2[var_16] = var_57_2[var_16] + var_57_5
					ShipType = var_20

					local var_57_6 = var_20.ContainInLimitBundle

					ShipType = var_21

					if var_57_6(var_21.BundleAntiSubmarine, iter_57_3:GetTemplate().type) then
						math = var_20
						var_57_0[var_16] = var_20.max(var_57_0[var_16], var_57_4)
					end
				end
			end

			pairs = var_10

			for iter_57_4, iter_57_5 in var_10(arg_57_0._fleetList) do
				local var_57_7 = iter_57_5:GetFleetBias()
				local var_57_8 = iter_57_4 * -1

				var_57_7:SetDecayFactor(var_57_1[var_57_8], var_57_2[var_57_8])
				var_57_7:Update(arg_57_1)

				ipairs = var_17

				for iter_57_6, iter_57_7 in var_17(iter_57_5:GetSubList()) do
					local var_57_9 = iter_57_7:GetAimBias()

					if var_22.GetDecayFactorType(var_57_9) == var_22.DIVING then
						var_22:SetDecayFactor(var_57_0[var_57_8], var_57_2[var_57_8])
					else
						var_22:SetDecayFactor(var_57_1[var_57_8], var_57_2[var_57_8])
					end

					var_22:Update(arg_57_1)
				end
			end

			pairs = var_10

			for iter_57_8, iter_57_9 in var_10(arg_57_0._freeShipList) do
				local var_57_10 = iter_57_9:GetIFF() * -1
				local var_57_11 = iter_57_9:GetAimBias()

				if var_17.GetDecayFactorType(var_57_11) == var_17.DIVING then
					var_17:SetDecayFactor(var_57_0[var_57_10], var_57_2[var_57_10])
				else
					var_17:SetDecayFactor(var_57_1[var_57_10], var_57_2[var_57_10])
				end

				var_17:Update(arg_57_1)
			end
		end
	end

	return
end

function var_0_9.UpdateEscapeOnly(arg_58_0, arg_58_1)
	pairs = var_1_10002

	for iter_58_0, iter_58_1 in var_1_10002(arg_58_0._foeShipList) do
		iter_58_1:Update(arg_58_1)
	end

	return
end

function var_0_9.UpdateCountDown(arg_59_0, arg_59_1)
	local var_59_0

	if not arg_59_0._lastUpdateTime then
		var_59_0 = arg_59_1
	end

	arg_59_0._lastUpdateTime = var_59_0

	local var_59_1

	if arg_59_0._countDown - (arg_59_1 - arg_59_0._lastUpdateTime) <= 0 then
		var_59_1 = 0
	end

	math = var_3

	if var_3.floor(arg_59_0._countDown - var_59_1) == 0 or var_59_1 == 0 then
		arg_59_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_COUNT_DOWN, {}))
	end

	arg_59_0._countDown = var_59_1
	arg_59_0._totalTime = arg_59_1 - arg_59_0._startTimeStamp
	arg_59_0._lastUpdateTime = arg_59_1

	return
end

function var_0_9.SpawnMonster(arg_60_0, arg_60_1, arg_60_2, arg_60_3, arg_60_4, arg_60_5)
	local var_60_0 = arg_60_0:GenerateUnitID()
	local var_60_1 = var_0_5.GetMonsterTmpDataFromID(arg_60_1.monsterTemplateID)
	local var_60_2 = {}

	ipairs = var_1_10009

	for iter_60_0, iter_60_1 in var_1_10009(var_60_1.equipment_list) do
		table = var_1_10014

		var_1_10014.insert(var_60_2, {
			id = iter_60_1
		})
	end

	local var_60_3 = var_60_1.random_equipment_list
	local var_60_4 = var_60_1.random_nub

	ipairs = var_11

	for iter_60_2, iter_60_3 in var_11(var_60_3) do
		local var_60_5 = var_60_4[iter_60_2]

		Clone = var_1_10017
		var_1_10017 = var_1_10017(iter_60_3)

		for iter_60_4 = 1, var_60_5 do
			math = var_1_10022
			var_1_10022 = var_1_10022.random(#var_1_10017)
			table = var_23

			var_23.insert(var_60_2, {
				id = var_1_10017[var_1_10022]
			})

			table = var_23

			var_23.remove(var_1_10017, var_1_10022)
		end
	end

	local var_60_6 = var_0_5.CreateBattleUnitData(var_60_0, arg_60_3, arg_60_4, arg_60_1.monsterTemplateID, nil, var_60_2, arg_60_1.extraInfo, nil, nil, nil, nil, arg_60_1.level)

	var_0_6.MonsterAttrFixer(arg_60_0._battleInitData.battleType, var_60_6)

	local var_60_7

	if arg_60_1.immuneHPInherit then
		var_60_7 = var_60_6:GetMaxHP()
	else
		math = var_13
		var_60_7 = var_13.ceil(var_60_6:GetMaxHP() * arg_60_0._repressEnemyHpRant)
	end

	if var_60_7 <= 0 then
		var_60_7 = 1
	end

	var_60_6:SetCurrentHP(var_60_7)

	local var_60_8 = var_0_2.RandomPos(arg_60_1.corrdinate)

	var_60_6:SetPosition(var_60_8)

	local var_60_9 = var_60_6
	local var_60_10 = var_60_6.SetAI
	local var_60_11

	if not arg_60_1.pilotAITemplateID then
		var_60_11 = var_60_1.pilot_ai_template_id
	end

	var_60_10(var_60_9, var_60_11)

	local var_60_12 = arg_60_0

	arg_60_0.setShipUnitBound(var_60_12, var_60_6)

	table = var_14

	local var_60_13 = var_14.contains

	ShipType = var_60_12

	if var_60_13(var_60_12.SubShipType, var_60_1.type) then
		var_60_6:InitOxygen()
		arg_60_0:UpdateHostileSubmarine(true)
	end

	var_0_5.AttachWeather(var_60_6, arg_60_0._weahter)

	arg_60_0._freeShipList[var_60_0] = var_60_6
	arg_60_0._unitList[var_60_0] = var_60_6

	if var_60_6:IsSpectre() then
		var_60_6:UpdateBlindInvisibleBySpectre()
	else
		local var_60_14 = arg_60_0._cldSystem

		var_14.InitShipCld(var_60_14, var_60_6)
	end

	local var_60_15

	if not arg_60_1.sickness then
		var_60_15 = var_0_3.SUMMONING_SICKNESS_DURATION
	end

	var_60_6:SummonSickness(var_60_15)
	var_60_6:SetMoveCast(arg_60_1.moveCast == true)

	if var_60_6:GetIFF() == var_0_4.FRIENDLY_CODE then
		arg_60_0._friendlyShipList[var_60_0] = var_60_6
	else
		if var_60_6:IsSpectre() then
			arg_60_0._spectreShipList[var_60_0] = var_60_6
		else
			arg_60_0._foeShipList[var_60_0] = var_60_6
		end

		var_60_6:SetWaveIndex(arg_60_2)
	end

	if arg_60_1.reinforce then
		var_60_6:Reinforce()
	end

	if arg_60_1.reinforceDelay then
		var_60_6:SetReinforceCastTime(arg_60_1.reinforceDelay)
	end

	if arg_60_1.team then
		local var_60_16 = arg_60_0:GetNPCTeam(arg_60_1.team)

		var_15.AppendUnit(var_60_16, var_60_6)
	end

	if arg_60_1.phase then
		local var_60_17 = var_0.Battle.BattleUnitPhaseSwitcher.New(var_60_6)

		var_15.SetTemplateData(var_60_17, arg_60_1.phase)
	end

	if arg_60_5 then
		arg_60_5(var_60_6)
	end

	local var_60_18 = {
		type = arg_60_3,
		unit = var_60_6,
		bossData = arg_60_1.bossData,
		extraInfo = arg_60_1.extraInfo
	}

	arg_60_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_60_18))

	local function var_60_19(arg_61_0)
		ipairs = var_2_10001

		for iter_61_0, iter_61_1 in var_2_10001(arg_61_0) do
			local var_61_0
			local var_61_1

			type = var_2_10008

			local var_61_2

			if var_2_10008(iter_61_1) == "number" then
				var_61_1 = iter_61_1
				var_61_2 = 1
			else
				var_61_1 = iter_61_1.ID
				var_61_2 = iter_61_1.LV or 1
			end

			var_2_10008 = var_0.Battle.BattleBuffUnit.New(var_61_1, var_61_2, var_60_6)

			local var_61_3 = var_60_6

			var_9.AddBuff(var_61_3, var_2_10008)
		end

		return
	end

	local var_60_20 = var_60_6:GetTemplate().buff_list
	local var_60_21

	if not arg_60_1.buffList then
		var_60_21 = {}
	end

	local var_60_22

	if not arg_60_0._battleInitData.ExtraBuffList then
		var_60_22 = {}
	end

	local var_60_23

	if not arg_60_0._battleInitData.AffixBuffList then
		var_60_23 = {}
	end

	var_60_19(var_60_20)
	var_60_19(var_60_22)
	var_60_19(var_60_21)

	if arg_60_1.affix then
		var_60_19(var_60_23)
	end

	if arg_60_1.summonWaveIndex then
		local var_60_24 = arg_60_0._waveSummonList
		local var_60_25

		if not arg_60_0._waveSummonList[var_21] then
			var_60_25 = {}
		end

		var_60_24[var_21] = var_60_25
		arg_60_0._waveSummonList[var_21][var_60_6] = true
	end

	var_60_6:CheckWeaponInitial()

	if arg_60_0._battleInitData.CMDArgs and var_60_6:GetTemplateID() == arg_60_0._battleInitData.CMDArgs then
		arg_60_0:InitSpecificEnemyStatistics(var_60_6)
	end

	var_60_6:OverrideDeadFX(arg_60_1.deadFX)

	BATTLE_ENEMY_AIMBIAS_RANGE = var_22

	if var_22 and var_60_6:GetAimBias() then
		arg_60_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AIM_BIAS, {
			aimBias = var_60_6:GetAimBias()
		}))
	end

	return var_60_6
end

function var_0_9.UpdateHostileSubmarine(arg_62_0, arg_62_1)
	if arg_62_1 then
		arg_62_0._enemySubmarineCount = arg_62_0._enemySubmarineCount + 1
	else
		arg_62_0._enemySubmarineCount = arg_62_0._enemySubmarineCount - 1
	end

	arg_62_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_HOSTILE_SUBMARINE))

	return
end

function var_0_9.SpawnNPC(arg_63_0, arg_63_1, arg_63_2)
	local var_63_0 = arg_63_0:GenerateUnitID()
	local var_63_1 = var_0_3.UnitType.MINION_UNIT
	local var_63_2 = var_0_5.GetMonsterTmpDataFromID(arg_63_1.monsterTemplateID)
	local var_63_3 = {}

	ipairs = var_1_10007

	for iter_63_0, iter_63_1 in var_1_10007(var_63_2.equipment_list) do
		table = var_1_10012

		var_1_10012.insert(var_63_3, {
			id = iter_63_1
		})
	end

	local var_63_4 = var_0_5.CreateBattleUnitData(var_63_0, var_63_1, arg_63_2:GetIFF(), arg_63_1.monsterTemplateID, nil, var_63_3, arg_63_1.extraInfo, nil, nil, nil, nil, arg_63_1.level, arg_63_2)
	local var_63_5 = var_7.GetMaxHP(var_63_4)

	var_7:SetCurrentHP(var_63_5)

	local var_63_6

	if arg_63_1.corrdinate then
		var_63_6 = var_0_2.RandomPos(arg_63_1.corrdinate)
	else
		Clone = var_10
		var_63_6 = var_10(arg_63_2:GetPosition())
	end

	var_7:SetPosition(var_63_6)

	local var_63_7 = var_7
	local var_63_8 = var_7.SetAI
	local var_63_9

	if not arg_63_1.pilotAITemplateID then
		var_63_9 = var_63_2.pilot_ai_template_id
	end

	var_63_8(var_63_7, var_63_9)

	local var_63_10 = arg_63_0

	arg_63_0.setShipUnitBound(var_63_10, var_7)

	table = var_10

	local var_63_11 = var_10.contains

	ShipType = var_63_10

	if var_63_11(var_63_10.SubShipType, var_63_2.type) then
		var_7:InitOxygen()

		if var_7:GetIFF() ~= var_0_4.FRIENDLY_CODE then
			arg_63_0:UpdateHostileSubmarine(true)
		end
	end

	var_0_5.AttachWeather(var_7, arg_63_0._weahter)

	arg_63_0._freeShipList[var_63_0] = var_7
	arg_63_0._unitList[var_63_0] = var_7

	local var_63_12 = arg_63_0._cldSystem

	var_10.InitShipCld(var_63_12, var_7)

	local var_63_13

	if not arg_63_1.sickness then
		var_63_13 = var_0_3.SUMMONING_SICKNESS_DURATION
	end

	var_7:SummonSickness(var_63_13)
	var_7:SetMoveCast(arg_63_1.moveCast == true)

	arg_63_0._minionShipList[var_63_0] = var_7

	if arg_63_1.phase then
		local var_63_14 = var_0.Battle.BattleUnitPhaseSwitcher.New(var_7)

		var_11.SetTemplateData(var_63_14, arg_63_1.phase)
	end

	local var_63_15 = {
		type = var_63_1,
		unit = var_7,
		bossData = arg_63_1.bossData,
		extraInfo = arg_63_1.extraInfo
	}

	arg_63_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_63_15))

	local function var_63_16(arg_64_0)
		ipairs = var_2_10001

		for iter_64_0, iter_64_1 in var_2_10001(arg_64_0) do
			local var_64_0
			local var_64_1

			type = var_2_10008

			local var_64_2

			if var_2_10008(iter_64_1) == "number" then
				var_64_1 = iter_64_1
				var_64_2 = 1
			else
				var_64_1 = iter_64_1.ID
				var_64_2 = iter_64_1.LV or 1
			end

			var_2_10008 = var_0.Battle.BattleBuffUnit.New(var_64_1, var_64_2, var_0)

			local var_64_3 = var_0

			var_9.AddBuff(var_64_3, var_2_10008)
		end

		return
	end

	local var_63_17 = var_7:GetTemplate().buff_list
	local var_63_18

	if not arg_63_1.buffList then
		var_63_18 = {}
	end

	var_63_16(var_63_17)
	var_63_16(var_63_18)
	var_7:CheckWeaponInitial()

	return var_7
end

function var_0_9.EnemyEscape(arg_65_0)
	pairs = var_1_10001

	for iter_65_0, iter_65_1 in var_1_10001(arg_65_0._foeShipList) do
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

function var_0_9.GetNPCTeam(arg_66_0, arg_66_1)
	if not arg_66_0._teamList[arg_66_1] then
		arg_66_0._teamList[arg_66_1] = var_0.Battle.BattleTeamVO.New(arg_66_1)
	end

	return arg_66_0._teamList[arg_66_1]
end

function var_0_9.KillNPCTeam(arg_67_0, arg_67_1)
	if arg_67_0._teamList[arg_67_1] then
		var_2:Dispose()

		arg_67_0._teamList[arg_67_1] = nil
	end

	return
end

function var_0_9.SpawnVanguard(arg_68_0, arg_68_1, arg_68_2)
	local var_68_0 = arg_68_0:GetVanguardBornCoordinate(arg_68_2)
	local var_68_1 = arg_68_0
	local var_68_2 = arg_68_0.generatePlayerUnit
	local var_68_3 = arg_68_1
	local var_68_4 = arg_68_2

	BuildVector3 = var_1_10008

	local var_68_5 = var_68_2(var_68_1, var_68_3, var_68_4, var_1_10008(var_68_0), arg_68_0._commanderBuff)
	local var_68_6 = arg_68_0:GetFleetByIFF(arg_68_2)

	var_5.AppendPlayerUnit(var_68_6, var_68_5)
	arg_68_0:setShipUnitBound(var_68_5)
	var_0_5.AttachWeather(var_68_5, arg_68_0._weahter)

	local var_68_7 = arg_68_0._cldSystem

	var_6.InitShipCld(var_68_7, var_68_5)

	local var_68_8 = {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_68_5
	}

	arg_68_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_68_8))

	return var_68_5
end

function var_0_9.SpawnMain(arg_69_0, arg_69_1, arg_69_2)
	local var_69_0
	local var_69_1 = arg_69_0:GetFleetByIFF(arg_69_2)
	local var_69_2 = #var_4.GetMainList(var_69_1) + 1

	if arg_69_0._currentStageData.mainUnitPosition and arg_69_0._currentStageData.mainUnitPosition[arg_69_2] then
		Clone = var_6
		var_69_0 = var_6(arg_69_0._currentStageData.mainUnitPosition[arg_69_2][var_69_2])
	else
		Clone = var_6
		var_69_0 = var_6(var_0_4.MAIN_UNIT_POS[arg_69_2][var_69_2])
	end

	local var_69_3 = arg_69_0:generatePlayerUnit(arg_69_1, arg_69_2, var_69_0, arg_69_0._commanderBuff)

	var_6.SetBornPosition(var_69_3, var_69_0)
	var_6:SetMainFleetUnit()

	if var_69_0.x < arg_69_0._totalLeftBound or var_7 > arg_69_0._totalRightBound then
		var_6:SetImmuneCommonBulletCLD()
	end

	var_4:AppendPlayerUnit(var_6)
	arg_69_0:setShipUnitBound(var_6)
	var_0_5.AttachWeather(var_6, arg_69_0._weahter)

	local var_69_4 = arg_69_0._cldSystem

	var_8.InitShipCld(var_69_4, var_6)

	local var_69_5 = {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_6
	}

	arg_69_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_69_5))

	return var_6
end

function var_0_9.SpawnSub(arg_70_0, arg_70_1, arg_70_2)
	local var_70_0
	local var_70_1 = arg_70_0:GetFleetByIFF(arg_70_2)
	local var_70_2 = #var_4.GetSubList(var_70_1) + 1
	local var_70_3 = var_0_4.SUB_UNIT_OFFSET_X
	local var_70_4

	if not var_0_5.GetPlayerShipTmpDataFromID(arg_70_1.tmpID).summon_offset then
		var_70_4 = 0
	end

	local var_70_5 = var_70_3 + var_70_4

	if arg_70_2 == var_0_4.FRIENDLY_CODE then
		Vector3 = var_7
		var_70_0 = var_7(var_70_5 + arg_70_0._totalLeftBound, 0, var_0_4.SUB_UNIT_POS_Z[var_70_2])
	else
		Vector3 = var_7
		var_70_0 = var_7(arg_70_0._totalRightBound - var_70_5, 0, var_0_4.SUB_UNIT_POS_Z[var_70_2])
	end

	local var_70_6 = arg_70_0:generatePlayerUnit(arg_70_1, arg_70_2, var_70_0, arg_70_0._subCommanderBuff)

	var_4:AddSubMarine(var_70_6)
	arg_70_0:setShipUnitBound(var_70_6)
	var_0_5.AttachWeather(var_70_6, arg_70_0._weahter)

	local var_70_7 = arg_70_0._cldSystem

	var_8.InitShipCld(var_70_7, var_70_6)

	local var_70_8 = {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_70_6
	}

	arg_70_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_70_8))

	return var_70_6
end

function var_0_9.SpawnManualSub(arg_71_0, arg_71_1, arg_71_2)
	local var_71_0 = arg_71_0:GetVanguardBornCoordinate(arg_71_2)
	local var_71_1 = arg_71_0
	local var_71_2 = arg_71_0.generatePlayerUnit
	local var_71_3 = arg_71_1
	local var_71_4 = arg_71_2

	BuildVector3 = var_1_10008

	local var_71_5 = var_71_2(var_71_1, var_71_3, var_71_4, var_1_10008(var_71_0), arg_71_0._commanderBuff)
	local var_71_6 = arg_71_0:GetFleetByIFF(arg_71_2)

	var_5.AddManualSubmarine(var_71_6, var_71_5)
	arg_71_0:setShipUnitBound(var_71_5)

	local var_71_7 = arg_71_0._cldSystem

	var_6.InitShipCld(var_71_7, var_71_5)

	local var_71_8 = {
		type = var_0_3.UnitType.SUB_UNIT,
		unit = var_71_5
	}

	arg_71_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_71_8))

	return var_71_5
end

function var_0_9.SpawnSupportUnit(arg_72_0, arg_72_1, arg_72_2)
	local var_72_0 = arg_72_0:generateSupportPlayerUnit(arg_72_1, arg_72_2)
	local var_72_1 = arg_72_0:GetFleetByIFF(arg_72_2)

	var_4.AppendSupportUnit(var_72_1, var_72_0)

	local var_72_2 = var_72_0
	local var_72_3 = var_72_0.GetTemplate(var_72_2).type

	table = var_72_2

	local var_72_4 = var_72_2.contains

	ShipType = var_7

	if var_72_4(var_7.BundleList.qian, var_72_3) then
		local var_72_5 = var_72_0
		local var_72_6 = var_72_0.SetPosition

		Clone = var_8

		var_72_6(var_72_5, var_8(var_0_4.SubSupportUnitPosList[#var_4:GetSupportUnitList()]))
	else
		local var_72_7 = var_72_0
		local var_72_8 = var_72_0.SetPosition

		Clone = var_8

		var_72_8(var_72_7, var_8(var_0_4.AirSupportUnitPos))
	end

	local var_72_9 = {
		type = var_0_3.UnitType.SUPPORT_UNIT,
		unit = var_72_0
	}

	arg_72_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_72_9))

	return var_72_0
end

function var_0_9.ShutdownPlayerUnit(arg_73_0, arg_73_1)
	local var_73_0 = arg_73_0._unitList[arg_73_1]
	local var_73_1 = var_2.GetIFF(var_73_0)
	local var_73_2 = arg_73_0:GetFleetByIFF(var_73_1)

	var_4.RemovePlayerUnit(var_73_2, var_2)

	local var_73_3 = {}
	local var_73_4 = var_4:GetFleetAntiAirWeapon()

	if var_6.GetRange(var_73_4) == 0 then
		var_73_3.isShow = false
	end

	arg_73_0:DispatchEvent(var_0.Event.New(var_0_1.ANTI_AIR_AREA, var_73_3))

	local var_73_5 = {
		unit = var_2
	}

	arg_73_0:DispatchEvent(var_0.Event.New(var_0_1.SHUT_DOWN_PLAYER, var_73_5))

	return
end

function var_0_9.updateDeadList(arg_74_0)
	local var_74_0 = #arg_74_0._deadUnitList

	while var_74_0 > 0 do
		local var_74_1 = arg_74_0._deadUnitList[var_74_0]

		var_2.Dispose(var_74_1)

		arg_74_0._deadUnitList[var_74_0] = nil
		var_74_0 = var_74_0 - 1
	end

	return
end

function var_0_9.KillUnit(arg_75_0, arg_75_1)
	if arg_75_0._unitList[arg_75_1] == nil then
		return
	end

	local var_75_0 = var_2:GetUnitType()
	local var_75_1 = arg_75_0._cldSystem

	var_4.DeleteShipCld(var_75_1, var_2)
	var_2:Clear()

	arg_75_0._unitList[arg_75_1] = nil

	if arg_75_0._freeShipList[arg_75_1] then
		arg_75_0._freeShipList[arg_75_1] = nil
	end

	local var_75_2 = var_2:GetIFF()
	local var_75_3 = var_2:GetDeathReason()

	if var_2:GetAimBias() then
		var_1_10008 = var_2:GetAimBias()

		var_6.RemoveCrew(var_1_10008, var_2)

		var_1_10008 = var_6

		if var_6.GetCurrentState(var_1_10008) == var_6.STATE_EXPIRE then
			var_1_10008 = arg_75_0

			arg_75_0.DispatchEvent(var_1_10008, var_0.Event.New(var_0_1.REMOVE_AIM_BIAS, {
				aimBias = var_2:GetAimBias()
			}))
		end
	end

	if var_2:IsSpectre() then
		arg_75_0._spectreShipList[arg_75_1] = nil
	elseif var_75_2 == var_0_4.FOE_CODE then
		arg_75_0._foeShipList[arg_75_1] = nil

		if var_75_0 == var_0_3.UnitType.ENEMY_UNIT or var_75_0 == var_0_3.UnitType.BOSS_UNIT then
			if var_2:GetTeam() then
				var_1_10008 = var_2:GetTeam()

				var_6.RemoveUnit(var_1_10008, var_2)
			end

			local var_75_4 = var_2
			local var_75_5 = var_2.GetTemplate(var_75_4).type

			table = var_75_4

			local var_75_6 = var_75_4.contains

			ShipType = var_1_10008

			if var_75_6(var_1_10008.SubShipType, var_75_5) then
				arg_75_0:UpdateHostileSubmarine(false)
			end

			if var_2:GetWaveIndex() and arg_75_0._waveSummonList[var_7] then
				arg_75_0._waveSummonList[var_7][var_2] = nil
			end
		end
	elseif var_75_2 == var_0_4.FRIENDLY_CODE then
		arg_75_0._friendlyShipList[arg_75_1] = nil
	end

	local var_75_7 = {
		UID = arg_75_1,
		type = var_75_0,
		deadReason = var_75_3,
		unit = var_2
	}

	arg_75_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_UNIT, var_75_7))

	table = var_7

	var_7.insert(arg_75_0._deadUnitList, var_2)

	return
end

function var_0_9.KillAllEnemy(arg_76_0)
	pairs = var_1_10001

	for iter_76_0, iter_76_1 in var_1_10001(arg_76_0._unitList) do
		if iter_76_1:GetIFF() == var_0_4.FOE_CODE and iter_76_1:IsAlive() and not iter_76_1:IsBoss() then
			iter_76_1:DeadAction()
		end
	end

	return
end

function var_0_9.KillSubmarineByIFF(arg_77_0, arg_77_1)
	pairs = var_1_10002

	for iter_77_0, iter_77_1 in var_1_10002(arg_77_0._unitList) do
		if iter_77_1:GetIFF() == arg_77_1 then
			local var_77_0 = iter_77_1

			if iter_77_1.IsAlive(var_77_0) then
				table = var_7

				local var_77_1 = var_7.contains

				ShipType = var_77_0

				if var_77_1(var_77_0.SubShipType, iter_77_1:GetTemplate().type) and not iter_77_1:IsBoss() then
					iter_77_1:DeadAction()
				end
			end
		end
	end

	return
end

function var_0_9.KillAllAircraft(arg_78_0)
	pairs = var_1_10001

	for iter_78_0, iter_78_1 in var_1_10001(arg_78_0._aircraftList) do
		iter_78_1:Clear()

		local var_78_0 = {
			UID = iter_78_0
		}

		arg_78_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, var_78_0))

		arg_78_0._aircraftList[iter_78_0] = nil
	end

	return
end

function var_0_9.KillWaveSummonMonster(arg_79_0, arg_79_1)
	if arg_79_0._waveSummonList[arg_79_1] then
		pairs = var_1_10003

		for iter_79_0, iter_79_1 in var_1_10003(var_2) do
			local var_79_0 = iter_79_0:GetUniqueID()

			arg_79_0:KillUnit(var_79_0)
		end
	end

	arg_79_0._waveSummonList[arg_79_1] = nil

	return
end

function var_0_9.IsThereBoss(arg_80_0)
	return arg_80_0:GetActiveBossCount() > 0
end

function var_0_9.GetActiveBossCount(arg_81_0)
	local var_81_0 = 0

	pairs = var_1_10002

	for iter_81_0, iter_81_1 in var_1_10002(arg_81_0:GetUnitList()) do
		if iter_81_1:IsBoss() and iter_81_1:IsAlive() then
			var_81_0 = var_81_0 + 1
		end
	end

	return var_81_0
end

function var_0_9.setShipUnitBound(arg_82_0, arg_82_1)
	local var_82_0 = arg_82_1:GetIFF()

	if arg_82_1:GetFleetVO() then
		local var_82_1 = arg_82_1
		local var_82_2 = arg_82_1.SetBound
		local var_82_3 = arg_82_1:GetFleetVO()
		local var_82_4 = var_5.GetUnitBound(var_82_3)

		var_82_2(var_82_1, var_5.GetBound(var_82_4))
	else
		arg_82_1:SetBound(arg_82_0:GetUnitBoundByIFF(var_82_0))
	end

	return
end

function var_0_9.generatePlayerUnit(arg_83_0, arg_83_1, arg_83_2, arg_83_3, arg_83_4)
	local var_83_0 = arg_83_0:GenerateUnitID()
	local var_83_1 = arg_83_1.properties

	var_83_1.level = arg_83_1.level
	var_83_1.formationID = var_0_4.FORMATION_ID
	var_83_1.id = arg_83_1.id

	var_0_6.AttrFixer(arg_83_0._battleInitData.battleType, var_83_1)

	local var_83_2

	if not arg_83_1.proficiency then
		var_83_2 = {
			1,
			1,
			1
		}
	end

	local var_83_3 = var_0_3.UnitType.PLAYER_UNIT
	local var_83_4 = arg_83_0._battleInitData.battleType

	SYSTEM_SUBMARINE_RUN = var_1_10010

	if var_83_4 ~= var_1_10010 then
		SYSTEM_SUB_ROUTINE = var_1_10010

		if var_83_4 == var_1_10010 then
			var_83_3 = var_0_3.UnitType.SUB_UNIT
		else
			SYSTEM_AIRFIGHT = var_1_10010

			if var_83_4 == var_1_10010 then
				var_83_3 = var_0_3.UnitType.CONST_UNIT
			else
				SYSTEM_CARDPUZZLE = var_1_10010

				if var_83_4 == var_1_10010 then
					var_83_3 = var_0_3.UnitType.CARDPUZZLE_PLAYER_UNIT
				end
			end
		end

		local var_83_5 = var_0_5.CreateBattleUnitData(var_83_0, var_83_3, arg_83_2, arg_83_1.tmpID, arg_83_1.skinId, arg_83_1.equipment, var_83_1, arg_83_1.baseProperties, var_83_2, arg_83_1.baseList, arg_83_1.preloasList)

		var_0_5.AttachUltimateBonus(var_83_5)

		local var_83_6 = var_83_5
		local var_83_7 = var_83_5.InitCurrentHP
		local var_83_8

		if not arg_83_1.initHPRate then
			var_83_8 = 1
		end

		var_83_7(var_83_6, var_83_8)
		var_83_5:SetRarity(arg_83_1.rarity)
		var_83_5:SetIntimacy(arg_83_1.intimacy)
		var_83_5:SetShipName(arg_83_1.name)

		if arg_83_1.spWeapon then
			var_83_5:SetSpWeapon(arg_83_1.spWeapon)

			_ = var_11

			local var_83_9 = var_11.each
			local var_83_10 = arg_83_1.spWeapon

			var_83_9(var_12.GetLabel(var_83_10), function(arg_84_0)
				local var_84_0 = var_83_5

				var_1.AddLabelTag(var_84_0, arg_84_0)

				return
			end)
		end

		arg_83_0._unitList[var_83_0] = var_83_5

		local var_83_11

		if var_83_5:GetIFF() == var_0_4.FRIENDLY_CODE then
			var_83_11 = arg_83_0._friendlyShipList
			var_83_11[var_83_0] = var_83_5
		elseif var_83_5:GetIFF() == var_0_4.FOE_CODE then
			var_83_11 = arg_83_0._foeShipList
			var_83_11[var_83_0] = var_83_5
		end

		SYSTEM_WORLD = var_83_11

		if var_83_4 == var_83_11 then
			local var_83_12 = var_0_2.WorldMapRewardHealingRate(arg_83_0._battleInitData.EnemyMapRewards, arg_83_0._battleInitData.FleetMapRewards)

			var_0_6.SetCurrent(var_83_5, "healingRate", var_83_12)
		end

		var_83_5:SetPosition(arg_83_3)
		var_0_5.InitUnitSkill(arg_83_1, var_83_5, var_83_4)
		var_0_5.InitEquipSkill(arg_83_1.equipment, var_83_5, var_83_4)
		var_0_5.InitCommanderSkill(arg_83_4, var_83_5, var_83_4)
		var_83_5:SetGearScore(arg_83_1.shipGS)

		if arg_83_1.deathMark then
			var_83_5:SetWorldDeathMark()
		end

		return var_83_5
	end
end

function var_0_9.generateSupportPlayerUnit(arg_85_0, arg_85_1, arg_85_2)
	local var_85_0 = arg_85_0:GenerateUnitID()
	local var_85_1 = arg_85_1.properties

	var_85_1.level = arg_85_1.level
	var_85_1.formationID = var_0_4.FORMATION_ID
	var_85_1.id = arg_85_1.id

	var_0_6.AttrFixer(arg_85_0._battleInitData.battleType, var_85_1)

	local var_85_2

	if not arg_85_1.proficiency then
		var_85_2 = {
			1,
			1,
			1
		}
	end

	local var_85_3 = var_0_5.CreateBattleUnitData(var_85_0, var_0_3.UnitType.SUPPORT_UNIT, arg_85_2, arg_85_1.tmpID, arg_85_1.skinId, arg_85_1.equipment, var_85_1, arg_85_1.baseProperties, var_85_2, arg_85_1.baseList, arg_85_1.preloasList)

	var_6.InitCurrentHP(var_85_3, 1)
	var_6:SetShipName(arg_85_1.name)

	arg_85_0._spectreShipList[var_85_0] = var_6

	return var_6
end

function var_0_9.SwitchSpectreUnit(arg_86_0, arg_86_1)
	local var_86_0 = arg_86_1:GetUniqueID()
	local var_86_1

	if arg_86_1:GetIFF() ~= var_0_4.FRIENDLY_CODE or not arg_86_0._friendlyShipList then
		var_86_1 = arg_86_0._foeShipList
	end

	if arg_86_1:IsSpectre() then
		var_86_1[var_86_0] = nil

		local var_86_2 = arg_86_0._spectreShipList

		var_86_2[var_86_0] = arg_86_1
		pairs = var_86_2

		for iter_86_0, iter_86_1 in var_86_2(arg_86_0._AOEList) do
			iter_86_1:ForceExit(arg_86_1:GetUniqueID())
		end

		local var_86_3 = arg_86_0._cldSystem

		var_5.DeleteShipCld(var_86_3, arg_86_1)
	else
		arg_86_0._spectreShipList[var_86_0] = nil
		var_86_1[var_86_0] = arg_86_1

		arg_86_1:ActiveCldBox()

		local var_86_4 = arg_86_0._cldSystem

		var_5.InitShipCld(var_86_4, arg_86_1)
	end

	return
end

function var_0_9.GetUnitList(arg_87_0)
	return arg_87_0._unitList
end

function var_0_9.GetFriendlyShipList(arg_88_0)
	return arg_88_0._friendlyShipList
end

function var_0_9.GetFoeShipList(arg_89_0)
	return arg_89_0._foeShipList
end

function var_0_9.GetFoeAircraftList(arg_90_0)
	return arg_90_0._foeAircraftList
end

function var_0_9.GetFreeShipList(arg_91_0)
	return arg_91_0._freeShipList
end

function var_0_9.GetSpectreShipList(arg_92_0)
	return arg_92_0._spectreShipList
end

function var_0_9.GenerateUnitID(arg_93_0)
	arg_93_0._unitCount = arg_93_0._unitCount + 1

	return arg_93_0._unitCount
end

function var_0_9.GetCountDown(arg_94_0)
	return arg_94_0._countDown
end

function var_0_9.SpawnAirFighter(arg_95_0, arg_95_1)
	local var_95_0 = #arg_95_0._airFighterList + 1
	local var_95_1 = var_0_5.GetFormationTmpDataFromID(arg_95_1.formation).pos_offset
	local var_95_2 = {
		currentNumber = 0,
		templateID = arg_95_1.templateID
	}
	local var_95_3

	if not arg_95_1.totalNumber then
		var_95_3 = 0
	end

	var_95_2.totalNumber = var_95_3
	var_95_2.onceNumber = arg_95_1.onceNumber

	local var_95_4

	if not arg_95_1.interval then
		var_95_4 = 3
	end

	var_95_2.timeDelay = var_95_4

	local var_95_5

	if not arg_95_1.maxTotalNumber then
		var_95_5 = 15
	end

	var_95_2.maxTotalNumber = var_95_5

	local function var_95_6(arg_96_0)
		if var_95_2.currentNumber < var_95_2.totalNumber then
			var_95_2.currentNumber = var_1 + 1

			local var_96_0 = arg_95_0
			local var_96_1 = var_2.CreateAirFighter(var_96_0, arg_95_1)

			var_2.SetFormationOffset(var_96_1, var_95_1[arg_96_0])
			var_2:SetFormationIndex(arg_96_0)
			var_2:SetDeadCallBack(function()
				var_95_2.totalNumber = var_95_2.totalNumber - 1
				var_95_2.currentNumber = var_95_2.currentNumber - 1

				local var_97_0 = arg_95_0

				var_0.DispatchEvent(var_97_0, var_0.Event.New(var_0_1.REMOVE_AIR_FIGHTER_ICON, {
					index = var_95_0
				}))

				local var_97_1 = arg_95_0

				var_0.DispatchEvent(var_97_1, var_0.Event.New(var_0_1.UPDATE_AIR_SUPPORT_LABEL, {}))

				return
			end)
			var_2:SetLiveCallBack(function()
				var_95_2.currentNumber = var_95_2.currentNumber - 1

				return
			end)
		end

		return
	end

	local function var_95_7()
		local var_99_0 = var_95_2.onceNumber

		if var_95_2.totalNumber > 0 then
			for iter_99_0 = 1, var_99_0 do
				var_95_6(iter_99_0)
			end
		else
			pg = var_1

			local var_99_1 = var_1.TimeMgr.GetInstance()

			var_1.RemoveBattleTimer(var_99_1, var_95_2.timer)

			var_95_2.timer = nil
		end

		return
	end

	arg_95_0._airFighterList[var_95_0] = var_95_2

	arg_95_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AIR_FIGHTER_ICON, {
		index = var_95_0
	}))
	arg_95_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_AIR_SUPPORT_LABEL, {}))

	pg = var_7

	local var_95_8 = var_7.TimeMgr.GetInstance()

	var_95_2.timer = var_7.AddBattleTimer(var_95_8, "striker", -1, arg_95_1.interval, var_95_7)

	return
end

function var_0_9.ClearAirFighterTimer(arg_100_0)
	ipairs = var_1_10001

	for iter_100_0, iter_100_1 in var_1_10001(arg_100_0._airFighterList) do
		pg = var_1_10006

		local var_100_0 = var_1_10006.TimeMgr.GetInstance()

		var_1_10006.RemoveBattleTimer(var_100_0, iter_100_1.timer)

		iter_100_1.timer = nil
	end

	arg_100_0._airFighterList = {}

	return
end

function var_0_9.KillAllAirStrike(arg_101_0)
	pairs = var_1_10001

	for iter_101_0, iter_101_1 in var_1_10001(arg_101_0._aircraftList) do
		if iter_101_1.__name == var_0.Battle.BattleAirFighterUnit.__name then
			local var_101_0 = arg_101_0._cldSystem

			var_6.DeleteAircraftCld(var_101_0, iter_101_1)

			iter_101_1._aliveState = false
			arg_101_0._aircraftList[iter_101_0] = nil
			arg_101_0._foeAircraftList[iter_101_0] = nil

			local var_101_1 = {
				UID = iter_101_0
			}

			arg_101_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, var_101_1))
		end
	end

	local var_101_2 = true

	pairs = var_2

	for iter_101_2, iter_101_3 in var_2(arg_101_0._foeAircraftList) do
		var_101_2 = false

		break
	end

	if var_101_2 then
		arg_101_0:DispatchEvent(var_0.Event.New(var_0_1.ANTI_AIR_AREA, {
			isShow = false
		}))
	end

	ipairs = var_2

	for iter_101_4, iter_101_5 in var_2(arg_101_0._airFighterList) do
		iter_101_5.totalNumber = 0

		arg_101_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIR_FIGHTER_ICON, {
			index = iter_101_4
		}))

		pg = var_7

		local var_101_3 = var_7.TimeMgr.GetInstance()

		var_7.RemoveBattleTimer(var_101_3, iter_101_5.timer)

		iter_101_5.timer = nil
	end

	arg_101_0._airFighterList = {}

	return
end

function var_0_9.GetAirFighterInfo(arg_102_0, arg_102_1)
	return arg_102_0._airFighterList[arg_102_1]
end

function var_0_9.GetAirFighterList(arg_103_0)
	return arg_103_0._airFighterList
end

function var_0_9.CreateAircraft(arg_104_0, arg_104_1, arg_104_2, arg_104_3, arg_104_4)
	local var_104_0 = arg_104_0:GenerateAircraftID()
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

	arg_104_0:doCreateAirUnit(var_104_0, var_104_1, var_0_3.UnitType.AIRCRAFT_UNIT, var_104_2)

	return var_104_1
end

function var_0_9.CreateAirFighter(arg_105_0, arg_105_1)
	local var_105_0 = arg_105_0:GenerateAircraftID()
	local var_105_1 = var_0_5.CreateAirFighterUnit(var_105_0, arg_105_1)

	arg_105_0:doCreateAirUnit(var_105_0, var_105_1, var_0_3.UnitType.AIRFIGHTER_UNIT, true)

	return var_105_1
end

function var_0_9.doCreateAirUnit(arg_106_0, arg_106_1, arg_106_2, arg_106_3, arg_106_4)
	arg_106_0._aircraftList[arg_106_1] = arg_106_2

	local var_106_0 = arg_106_0._cldSystem

	var_5.InitAircraftCld(var_106_0, arg_106_2)
	arg_106_2:SetBound(arg_106_0._leftZoneUpperBound, arg_106_0._leftZoneLowerBound)
	arg_106_2:SetViewBoundData(arg_106_0._cameraTop, arg_106_0._cameraBottom, arg_106_0._cameraLeft, arg_106_0._cameraRight)
	arg_106_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, {
		unit = arg_106_2,
		type = arg_106_3
	}))

	arg_106_4 = arg_106_4 or false

	if arg_106_4 then
		arg_106_0._foeAircraftList[arg_106_1] = arg_106_2

		arg_106_0:DispatchEvent(var_0.Event.New(var_0_1.ANTI_AIR_AREA, {
			isShow = true
		}))
	end

	return
end

function var_0_9.KillAircraft(arg_107_0, arg_107_1)
	if arg_107_0._aircraftList[arg_107_1] == nil then
		return
	end

	var_2:Clear()

	local var_107_0 = arg_107_0._cldSystem

	var_3.DeleteAircraftCld(var_107_0, var_2)

	if var_2:IsUndefeated() and var_2:GetCurrentState() ~= var_2.STRIKE_STATE_RECYCLE then
		local var_107_1 = var_2:GetIFF() * -1

		arg_107_0:HandleAircraftMissDamage(var_2, arg_107_0._fleetList[var_107_1])
	end

	var_2._aliveState = false
	arg_107_0._aircraftList[arg_107_1] = nil
	arg_107_0._foeAircraftList[arg_107_1] = nil

	local var_107_2 = true

	pairs = var_4

	for iter_107_0, iter_107_1 in var_4(arg_107_0._foeAircraftList) do
		var_107_2 = false

		break
	end

	if var_107_2 then
		arg_107_0:DispatchEvent(var_0.Event.New(var_0_1.ANTI_AIR_AREA, {
			isShow = false
		}))
	end

	local var_107_3 = {
		UID = arg_107_1
	}

	arg_107_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, var_107_3))

	return
end

function var_0_9.GetAircraftList(arg_108_0)
	return arg_108_0._aircraftList
end

function var_0_9.GenerateAircraftID(arg_109_0)
	arg_109_0._aircraftCount = arg_109_0._aircraftCount + 1

	return arg_109_0._aircraftCount
end

function var_0_9.CreateBulletUnit(arg_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)
	local var_110_0 = arg_110_0:GenerateBulletID()
	local var_110_1, var_110_2 = var_0_5.CreateBattleBulletData(var_110_0, arg_110_1, arg_110_2, arg_110_3, arg_110_4)

	if var_110_2 then
		local var_110_3 = arg_110_0._cldSystem

		var_8.InitBulletCld(var_110_3, var_110_1)
	end

	local var_110_4, var_110_5 = arg_110_3:GetFixBulletRange()

	if var_110_4 or var_110_5 then
		var_110_1:FixRange(var_110_4, var_110_5)
	end

	arg_110_0._bulletList[var_110_0] = var_110_1

	return var_110_1
end

function var_0_9.RemoveBulletUnit(arg_111_0, arg_111_1)
	if arg_111_0._bulletList[arg_111_1] == nil then
		return
	end

	var_2:DamageUnitListWriteback()

	if var_2:GetIsCld() then
		local var_111_0 = arg_111_0._cldSystem

		var_3.DeleteBulletCld(var_111_0, var_2)
	end

	arg_111_0._bulletList[arg_111_1] = nil

	local var_111_1 = {
		UID = arg_111_1
	}

	arg_111_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_BULLET, var_111_1))
	var_2:Dispose()

	return
end

function var_0_9.GetBulletList(arg_112_0)
	return arg_112_0._bulletList
end

function var_0_9.GenerateBulletID(arg_113_0)
	arg_113_0._bulletCount = arg_113_0._bulletCount + 1

	return var_1
end

function var_0_9.CLSBullet(arg_114_0, arg_114_1, arg_114_2)
	local var_114_0 = true
	local var_114_1 = arg_114_0._battleInitData.battleType

	SYSTEM_DUEL = var_1_10005

	if var_114_1 == var_1_10005 then
		var_114_0 = false
	end

	if var_114_0 then
		pairs = var_1_10005

		for iter_114_0, iter_114_1 in var_1_10005(arg_114_0._bulletList) do
			if iter_114_1:GetIFF() ~= arg_114_1 or not iter_114_1:GetExist() or iter_114_1:ImmuneCLS() or iter_114_1:ImmuneBombCLS() and arg_114_2 then
				-- block empty
			else
				arg_114_0:RemoveBulletUnit(iter_114_0)
			end
		end
	end

	return
end

function var_0_9.CLSAircraft(arg_115_0, arg_115_1)
	pairs = var_1_10002

	for iter_115_0, iter_115_1 in var_1_10002(arg_115_0._aircraftList) do
		if iter_115_1:GetIFF() == arg_115_1 then
			iter_115_1:Clear()

			local var_115_0 = {
				UID = iter_115_0
			}

			arg_115_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIR_CRAFT, var_115_0))

			arg_115_0._aircraftList[iter_115_0] = nil
		end
	end

	return
end

function var_0_9.CLSMinion(arg_116_0)
	pairs = var_1_10001

	for iter_116_0, iter_116_1 in var_1_10001(arg_116_0._unitList) do
		if iter_116_1:GetIFF() == var_0_4.FOE_CODE and iter_116_1:IsAlive() and not iter_116_1:IsBoss() then
			iter_116_1:SetDeathReason(var_0_3.UnitDeathReason.CLS)
			iter_116_1:DeadAction()
		end
	end

	return
end

function var_0_9.CLSAOE(arg_117_0)
	pairs = var_1_10001

	for iter_117_0, iter_117_1 in var_1_10001(arg_117_0._AOEList) do
		if iter_117_1:GetSource() == iter_117_1.SOURCE_BULLET_9 then
			arg_117_0:RemoveAreaOfEffect(iter_117_0)
		end
	end

	return
end

function var_0_9.SpawnColumnArea(arg_118_0, arg_118_1, arg_118_2, arg_118_3, arg_118_4, arg_118_5, arg_118_6, arg_118_7, arg_118_8)
	arg_118_7 = arg_118_7 or false

	local var_118_0 = arg_118_0:GenerateAreaID()
	local var_118_1 = var_0.Battle.BattleAOEData.New(var_118_0, arg_118_2, arg_118_6, arg_118_8)

	Clone = var_11

	local var_118_2 = var_11(arg_118_3)

	var_118_1:SetPosition(var_118_2)
	var_118_1:SetRange(arg_118_4)
	var_118_1:SetAreaType(var_0_3.AreaType.COLUMN)
	var_118_1:SetLifeTime(arg_118_5)
	var_118_1:SetFieldType(arg_118_1)
	var_118_1:SetOpponentAffected(not arg_118_7)
	arg_118_0:CreateAreaOfEffect(var_118_1)

	return var_118_1
end

function var_0_9.SpawnCubeArea(arg_119_0, arg_119_1, arg_119_2, arg_119_3, arg_119_4, arg_119_5, arg_119_6, arg_119_7, arg_119_8, arg_119_9)
	arg_119_8 = arg_119_8 or false

	local var_119_0 = arg_119_0:GenerateAreaID()
	local var_119_1 = var_0.Battle.BattleAOEData.New(var_119_0, arg_119_2, arg_119_7, arg_119_9)

	Clone = var_12

	local var_119_2 = var_12(arg_119_3)

	var_119_1:SetPosition(var_119_2)
	var_119_1:SetWidth(arg_119_4)
	var_119_1:SetHeight(arg_119_5)
	var_119_1:SetAreaType(var_0_3.AreaType.CUBE)
	var_119_1:SetLifeTime(arg_119_6)
	var_119_1:SetFieldType(arg_119_1)
	var_119_1:SetOpponentAffected(not arg_119_8)
	arg_119_0:CreateAreaOfEffect(var_119_1)

	return var_119_1
end

function var_0_9.SpawnLastingColumnArea(arg_120_0, arg_120_1, arg_120_2, arg_120_3, arg_120_4, arg_120_5, arg_120_6, arg_120_7, arg_120_8, arg_120_9, arg_120_10, arg_120_11)
	arg_120_8 = arg_120_8 or false

	local var_120_0 = arg_120_0:GenerateAreaID()
	local var_120_1 = var_0.Battle.BattleLastingAOEData.New(var_120_0, arg_120_2, arg_120_6, arg_120_7, arg_120_10, arg_120_11)

	Clone = var_14

	local var_120_2 = var_14(arg_120_3)

	var_120_1:SetPosition(var_120_2)
	var_120_1:SetRange(arg_120_4)
	var_120_1:SetAreaType(var_0_3.AreaType.COLUMN)
	var_120_1:SetLifeTime(arg_120_5)
	var_120_1:SetFieldType(arg_120_1)
	var_120_1:SetOpponentAffected(not arg_120_8)
	arg_120_0:CreateAreaOfEffect(var_120_1)

	if arg_120_9 and arg_120_9 ~= "" then
		local var_120_3 = {
			area = var_120_1,
			FXID = arg_120_9
		}

		arg_120_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AREA, var_120_3))
	end

	return var_120_1
end

function var_0_9.SpawnLastingEllipseArea(arg_121_0, arg_121_1, arg_121_2, arg_121_3, arg_121_4, arg_121_5, arg_121_6, arg_121_7, arg_121_8, arg_121_9, arg_121_10, arg_121_11, arg_121_12)
	arg_121_9 = arg_121_9 or false

	local var_121_0 = arg_121_0:GenerateAreaID()
	local var_121_1 = var_0.Battle.BattleLastingAOEData.New(var_121_0, arg_121_2, arg_121_7, arg_121_8, arg_121_11, arg_121_12)

	Clone = var_15

	local var_121_2 = var_15(arg_121_3)

	var_121_1:SetPosition(var_121_2)
	var_121_1:SetWidth(arg_121_4)
	var_121_1:SetHeight(arg_121_5)
	var_121_1:SetAreaType(var_0_3.AreaType.ELLIPSE)
	var_121_1:SetLifeTime(arg_121_6)
	var_121_1:SetFieldType(arg_121_1)
	var_121_1:SetOpponentAffected(not arg_121_9)
	arg_121_0:CreateAreaOfEffect(var_121_1)

	if arg_121_10 and arg_121_10 ~= "" then
		local var_121_3 = {
			area = var_121_1,
			FXID = arg_121_10
		}

		arg_121_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AREA, var_121_3))
	end

	return var_121_1
end

function var_0_9.SpawnLastingCubeArea(arg_122_0, arg_122_1, arg_122_2, arg_122_3, arg_122_4, arg_122_5, arg_122_6, arg_122_7, arg_122_8, arg_122_9, arg_122_10, arg_122_11, arg_122_12)
	arg_122_9 = arg_122_9 or false

	local var_122_0 = arg_122_0:GenerateAreaID()
	local var_122_1 = var_0.Battle.BattleLastingAOEData.New(var_122_0, arg_122_2, arg_122_7, arg_122_8, arg_122_11, arg_122_12)

	Clone = var_15

	local var_122_2 = var_15(arg_122_3)

	var_122_1:SetPosition(var_122_2)
	var_122_1:SetWidth(arg_122_4)
	var_122_1:SetHeight(arg_122_5)
	var_122_1:SetAreaType(var_0_3.AreaType.CUBE)
	var_122_1:SetLifeTime(arg_122_6)
	var_122_1:SetFieldType(arg_122_1)
	var_122_1:SetOpponentAffected(not arg_122_9)
	arg_122_0:CreateAreaOfEffect(var_122_1)

	if arg_122_10 and arg_122_10 ~= "" then
		local var_122_3 = {
			area = var_122_1,
			FXID = arg_122_10
		}

		arg_122_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AREA, var_122_3))
	end

	return var_122_1
end

function var_0_9.SpawnTriggerColumnArea(arg_123_0, arg_123_1, arg_123_2, arg_123_3, arg_123_4, arg_123_5, arg_123_6, arg_123_7, arg_123_8)
	arg_123_6 = arg_123_6 or false

	local var_123_0 = arg_123_0:GenerateAreaID()
	local var_123_1 = var_0.Battle.BattleTriggerAOEData.New(var_123_0, arg_123_2, arg_123_8)

	Clone = var_11

	local var_123_2 = var_11(arg_123_3)

	var_123_1:SetPosition(var_123_2)
	var_123_1:SetRange(arg_123_4)
	var_123_1:SetAreaType(var_0_3.AreaType.COLUMN)
	var_123_1:SetLifeTime(arg_123_5)
	var_123_1:SetFieldType(arg_123_1)
	var_123_1:SetOpponentAffected(not arg_123_6)
	arg_123_0:CreateAreaOfEffect(var_123_1)

	if arg_123_7 and arg_123_7 ~= "" then
		local var_123_3 = {
			area = var_123_1,
			FXID = arg_123_7
		}

		arg_123_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AREA, var_123_3))
	end

	return var_123_1
end

function var_0_9.CreateAreaOfEffect(arg_124_0, arg_124_1)
	arg_124_0._AOEList[arg_124_1:GetUniqueID()] = arg_124_1

	local var_124_0 = arg_124_0._cldSystem

	var_2.InitAOECld(var_124_0, arg_124_1)
	arg_124_1:StartTimer()

	return
end

function var_0_9.RemoveAreaOfEffect(arg_125_0, arg_125_1)
	if not arg_125_0._AOEList[arg_125_1] then
		return
	end

	var_2:Dispose()

	arg_125_0._AOEList[arg_125_1] = nil

	local var_125_0 = arg_125_0._cldSystem

	var_3.DeleteAOECld(var_125_0, var_2)
	arg_125_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AREA, {
		id = arg_125_1
	}))

	return
end

function var_0_9.GetAOEList(arg_126_0)
	return arg_126_0._AOEList
end

function var_0_9.GenerateAreaID(arg_127_0)
	arg_127_0._AOECount = arg_127_0._AOECount + 1

	return arg_127_0._AOECount
end

function var_0_9.SpawnWall(arg_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)
	local var_128_0 = arg_128_0:GenerateWallID()
	local var_128_1 = var_0.Battle.BattleWallData.New(var_128_0, arg_128_1, arg_128_2, arg_128_3, arg_128_4)

	arg_128_0._wallList[var_128_0] = var_128_1

	local var_128_2 = arg_128_0._cldSystem

	var_7.InitWallCld(var_128_2, var_128_1)

	return var_128_1
end

function var_0_9.RemoveWall(arg_129_0, arg_129_1)
	local var_129_0 = arg_129_0._wallList[arg_129_1]

	arg_129_0._wallList[arg_129_1] = nil

	local var_129_1 = arg_129_0._cldSystem

	var_3.DeleteWallCld(var_129_1, var_129_0)

	return
end

function var_0_9.SpawnShelter(arg_130_0, arg_130_1, arg_130_2)
	local var_130_0 = arg_130_0:GernerateShelterID()
	local var_130_1 = var_0.Battle.BattleShelterData.New(var_130_0)

	arg_130_0._shelterList[var_130_0] = var_130_1

	return var_130_1
end

function var_0_9.RemoveShelter(arg_131_0, arg_131_1)
	local var_131_0 = arg_131_0._shelterList[arg_131_1]
	local var_131_1 = {
		uid = arg_131_1
	}

	arg_131_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_SHELTER, var_131_1))
	var_131_0:Deactive()

	arg_131_0._shelterList[arg_131_1] = nil

	return
end

function var_0_9.GetWallList(arg_132_0)
	return arg_132_0._wallList
end

function var_0_9.GenerateWallID(arg_133_0)
	arg_133_0._wallIndex = arg_133_0._wallIndex + 1

	return arg_133_0._wallIndex
end

function var_0_9.GernerateShelterID(arg_134_0)
	arg_134_0._shelterIndex = arg_134_0._shelterIndex + 1

	return arg_134_0._shelterIndex
end

function var_0_9.SpawnEnvironment(arg_135_0, arg_135_1)
	local var_135_0 = arg_135_0:GernerateEnvironmentID()
	local var_135_1 = var_0.Battle.BattleEnvironmentUnit.New(var_135_0, var_0_4.FOE_CODE)

	var_3.SetTemplate(var_135_1, arg_135_1)

	local var_135_2 = var_3
	local var_135_3 = var_3.GetBehaviours(var_135_2)

	Vector3 = var_135_2

	local var_135_4 = var_135_2(arg_135_1.coordinate[1], arg_135_1.coordinate[2], arg_135_1.coordinate[3])

	local function var_135_5(arg_136_0)
		local var_136_0 = {}

		ipairs = var_2_10002

		for iter_136_0, iter_136_1 in var_2_10002(arg_136_0) do
			if iter_136_1.Active then
				local var_136_1 = arg_135_0._unitList[iter_136_1.UID]

				if not var_7.IsSpectre(var_136_1) then
					table = var_8

					var_8.insert(var_136_0, var_7)
				end
			end
		end

		local var_136_2 = var_0

		var_2.UpdateFrequentlyCollide(var_136_2, var_136_0)

		return
	end

	local function var_135_6()
		return
	end

	local function var_135_7()
		return
	end

	local var_135_8

	if not arg_135_1.field_type then
		var_135_8 = var_0_3.BulletField.SURFACE
	end

	local var_135_9

	if not arg_135_1.IFF then
		var_135_9 = var_0_4.FOE_CODE
	end

	local var_135_10 = 0
	local var_135_11

	if #arg_135_1.cld_data == 1 then
		local var_135_12 = arg_135_1.cld_data[1]

		var_135_11 = arg_135_0:SpawnLastingColumnArea(var_135_8, var_135_9, var_135_4, var_135_12, var_135_10, var_135_5, var_135_6, false, arg_135_1.prefab, var_135_7, true)
	else
		local var_135_13 = arg_135_1.cld_data[1]
		local var_135_14 = arg_135_1.cld_data[2]

		var_135_11 = arg_135_0:SpawnLastingCubeArea(var_135_8, var_135_9, var_135_4, var_135_13, var_135_14, var_135_10, var_135_5, var_135_6, false, arg_135_1.prefab, var_135_7, true)
	end

	var_3:SetAOEData(var_135_11)

	arg_135_0._environmentList[var_135_0] = var_3

	return var_3
end

function var_0_9.RemoveEnvironment(arg_139_0, arg_139_1)
	local var_139_0 = arg_139_0._environmentList[arg_139_1]
	local var_139_1 = var_2.GetAOEData(var_139_0)

	arg_139_0:RemoveAreaOfEffect(var_139_1:GetUniqueID())
	var_2:Dispose()

	arg_139_0._environmentList[arg_139_1] = nil

	return
end

function var_0_9.DispatchWarning(arg_140_0, arg_140_1, arg_140_2)
	arg_140_0:DispatchEvent(var_0.Event.New(var_0_1.UPDATE_ENVIRONMENT_WARNING, {
		isActive = arg_140_1
	}))

	return
end

function var_0_9.GetEnvironmentList(arg_141_0)
	return arg_141_0._environmentList
end

function var_0_9.GernerateEnvironmentID(arg_142_0)
	arg_142_0._environmentIndex = arg_142_0._environmentIndex + 1

	return arg_142_0._environmentIndex
end

function var_0_9.SpawnEffect(arg_143_0, arg_143_1, arg_143_2, arg_143_3)
	arg_143_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_EFFECT, {
		FXID = arg_143_1,
		position = arg_143_2,
		localScale = arg_143_3
	}))

	return
end

function var_0_9.SpawnUIFX(arg_144_0, arg_144_1, arg_144_2, arg_144_3, arg_144_4)
	arg_144_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UI_FX, {
		FXID = arg_144_1,
		position = arg_144_2,
		localScale = arg_144_3,
		orderDiff = arg_144_4
	}))

	return
end

function var_0_9.SpawnCameraFX(arg_145_0, arg_145_1, arg_145_2, arg_145_3, arg_145_4)
	arg_145_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_CAMERA_FX, {
		FXID = arg_145_1,
		position = arg_145_2,
		localScale = arg_145_3,
		orderDiff = arg_145_4
	}))

	return
end

function var_0_9.GetFriendlyCode(arg_146_0)
	return arg_146_0._friendlyCode
end

function var_0_9.GetFoeCode(arg_147_0)
	return arg_147_0._foeCode
end

function var_0_9.GetOppoSideCode(arg_148_0)
	if arg_148_0 == var_0_4.FRIENDLY_CODE then
		return var_0_4.FOE_CODE
	elseif arg_148_0 == var_0_4.FOE_CODE then
		return var_0_4.FRIENDLY_CODE
	end

	return
end

function var_0_9.GetStatistics(arg_149_0)
	return arg_149_0._statistics
end

function var_0_9.BlockManualCast(arg_150_0, arg_150_1)
	local var_150_0 = arg_150_1 and 1 or -1

	pairs = var_1_10003

	for iter_150_0, iter_150_1 in var_1_10003(arg_150_0._fleetList) do
		iter_150_1:SetWeaponBlock(var_150_0)
	end

	return
end

function var_0_9.JamManualCast(arg_151_0, arg_151_1)
	arg_151_0:DispatchEvent(var_0.Event.New(var_0_1.JAMMING, {
		jammingFlag = arg_151_1
	}))

	return
end

function var_0_9.SubmarineStrike(arg_152_0, arg_152_1)
	local var_152_0 = arg_152_0:GetFleetByIFF(arg_152_1)
	local var_152_1 = var_2.GetSubAidVO(var_152_0)
	local var_152_2 = arg_152_0._battleInitData.battleType

	SYSTEM_SCENARIO_SUB_STRIKE = var_1_10005

	if var_152_2 ~= var_1_10005 and (var_2:GetWeaponBlock() or var_152_1:GetCurrent() < 1) then
		return
	end

	local var_152_3 = var_2
	local var_152_4 = var_2.GetSubUnitData(var_152_3)

	ipairs = var_152_3

	for iter_152_0, iter_152_1 in var_152_3(var_152_4) do
		local var_152_5 = arg_152_0:SpawnSub(iter_152_1, arg_152_1)

		arg_152_0:InitAidUnitStatistics(var_152_5)
	end

	var_2:SubWarcry()

	local var_152_6 = var_2
	local var_152_7 = var_2.GetSubList(var_152_6)

	ipairs = var_152_6

	for iter_152_2, iter_152_3 in var_152_6(var_152_7) do
		if iter_152_2 == 1 then
			iter_152_3:TriggerBuff(var_0_3.BuffEffectType.ON_SUB_LEADER)
		elseif iter_152_2 == 2 then
			iter_152_3:TriggerBuff(var_0_3.BuffEffectType.ON_UPPER_SUB_CONSORT)
		elseif iter_152_2 == 3 then
			iter_152_3:TriggerBuff(var_0_3.BuffEffectType.ON_LOWER_SUB_CONSORT)
		end

		if iter_152_3:GetAimBias() then
			arg_152_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_AIM_BIAS, {
				aimBias = iter_152_3:GetAimBias()
			}))
		end
	end

	local var_152_8 = var_152_7[1]

	var_152_1:Cast()

	return
end

function var_0_9.GetWaveFlags(arg_153_0)
	return arg_153_0._waveFlags
end

function var_0_9.AddWaveFlag(arg_154_0, arg_154_1)
	if not arg_154_1 then
		return
	end

	local var_154_0 = arg_154_0
	local var_154_1 = arg_154_0.GetWaveFlags(var_154_0)

	table = var_154_0

	if var_154_0.contains(var_154_1, arg_154_1) then
		return
	end

	table = var_3

	var_3.insert(var_154_1, arg_154_1)

	return
end

function var_0_9.RemoveFlag(arg_155_0, arg_155_1)
	if not arg_155_1 then
		return
	end

	local var_155_0 = arg_155_0
	local var_155_1 = arg_155_0.GetWaveFlags(var_155_0)

	table = var_155_0

	if not var_155_0.contains(var_155_1, arg_155_1) then
		return
	end

	table = var_3

	var_3.removebyvalue(var_155_1, arg_155_1)

	return
end

function var_0_9.DispatchCustomWarning(arg_156_0, arg_156_1)
	arg_156_0:DispatchEvent(var_0.Event.New(var_0_1.EDIT_CUSTOM_WARNING_LABEL, {
		labelData = arg_156_1
	}))

	return
end

function var_0_9.DispatchGridmanSkill(arg_157_0, arg_157_1, arg_157_2)
	arg_157_0:DispatchEvent(var_0.Event.New(var_0_1.GRIDMAN_SKILL_FLOAT, {
		type = arg_157_1,
		IFF = arg_157_2
	}))

	return
end

function var_0_9.SpawnFusionUnit(arg_158_0, arg_158_1, arg_158_2, arg_158_3, arg_158_4)
	Clone = var_1_10005

	local var_158_0 = var_1_10005(arg_158_1:GetPosition())
	local var_158_1 = arg_158_1:GetIFF()
	local var_158_2 = arg_158_0:generatePlayerUnit(arg_158_2, var_158_1, var_158_0, arg_158_0._commanderBuff)

	var_0_6.SetFusionAttrFromElement(var_158_2, arg_158_1, arg_158_3, arg_158_4)
	var_158_2:SetCurrentHP(var_158_2:GetMaxHP())

	local var_158_3 = arg_158_1:GetFleetVO()

	var_8.AppendPlayerUnit(var_158_3, var_158_2)
	arg_158_0:setShipUnitBound(var_158_2)
	var_0_5.AttachWeather(var_158_2, arg_158_0._weahter)

	local var_158_4 = arg_158_0._cldSystem

	var_9.InitShipCld(var_158_4, var_158_2)

	local var_158_5 = {
		type = var_0_3.UnitType.PLAYER_UNIT,
		unit = var_158_2
	}

	arg_158_0:DispatchEvent(var_0.Event.New(var_0_1.ADD_UNIT, var_158_5))

	return var_158_2
end

function var_0_9.DefusionUnit(arg_159_0, arg_159_1)
	local var_159_0 = arg_159_1:GetIFF()
	local var_159_1 = arg_159_0:GetFleetByIFF(var_159_0)

	var_3.RemovePlayerUnit(var_159_1, arg_159_1)

	local var_159_2 = {}
	local var_159_3 = var_3:GetFleetAntiAirWeapon()

	if var_5.GetRange(var_159_3) == 0 then
		var_159_2.isShow = false
	end

	arg_159_0:DispatchEvent(var_0.Event.New(var_0_1.ANTI_AIR_AREA, var_159_2))
	arg_159_1:SetDeathReason(var_0_3.UnitDeathReason.DEFUSION)
	arg_159_0:KillUnit(arg_159_1:GetUniqueID())

	return
end

function var_0_9.FreezeUnit(arg_160_0, arg_160_1)
	var_0_6.SetCurrent(arg_160_1, var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY, var_0_4.FUSION_ELEMENT_UNIT_TYPE)
	arg_160_1:UpdateBlindInvisibleBySpectre()
	arg_160_0:SwitchSpectreUnit(arg_160_1)

	if arg_160_1:GetAimBias() then
		local var_160_0 = arg_160_1:GetAimBias()

		var_2.RemoveCrew(var_160_0, arg_160_1)

		if var_2:GetCurrentState() == var_2.STATE_EXPIRE then
			arg_160_0:DispatchEvent(var_0.Event.New(var_0_1.REMOVE_AIM_BIAS, {
				aimBias = arg_160_1:GetAimBias()
			}))
		end
	end

	arg_160_1:Freeze()

	if arg_160_1:GetFleetVO() then
		var_2:FreezeUnit(arg_160_1)
	end

	return
end

function var_0_9.ActiveFreezeUnit(arg_161_0, arg_161_1)
	var_0_6.SetCurrent(arg_161_1, var_0.Battle.BattleBuffSetBattleUnitType.ATTR_KEY, var_0_4.PLAYER_DEFAULT)
	arg_161_1:UpdateBlindInvisibleBySpectre()
	arg_161_0:SwitchSpectreUnit(arg_161_1)
	var_0_5.AttachWeather(arg_161_1, arg_161_0._weahter)
	arg_161_1:ActiveFreeze()

	if arg_161_1:GetFleetVO() then
		var_2:ActiveFreezeUnit(arg_161_1)
	end

	return
end

function var_0_9.GetFleetLegal(arg_162_0, arg_162_1, arg_162_2)
	SYSTEM_DUEL = var_1_10003

	if arg_162_2 ~= var_1_10003 then
		SYSTEM_PERFORM = var_1_10003

		if arg_162_2 ~= var_1_10003 then
			SYSTEM_SUB_ROUTINE = var_1_10003

			if arg_162_2 ~= var_1_10003 then
				SYSTEM_CARDPUZZLE = var_1_10003

				if arg_162_2 ~= var_1_10003 then
					SYSTEM_PROLOGUE = var_1_10003

					if arg_162_2 ~= var_1_10003 then
						SYSTEM_DODGEM = var_1_10003

						if arg_162_2 ~= var_1_10003 then
							SYSTEM_SIMULATION = var_1_10003

							if arg_162_2 ~= var_1_10003 then
								SYSTEM_SUBMARINE_RUN = var_1_10003

								if arg_162_2 ~= var_1_10003 then
									SYSTEM_SCENARIO_SUB_STRIKE = var_1_10003

									if arg_162_2 ~= var_1_10003 then
										SYSTEM_DEBUG = var_1_10003

										if arg_162_2 ~= var_1_10003 then
											SYSTEM_AIRFIGHT = var_1_10003

											if arg_162_2 == var_1_10003 then
												do return true end

												goto label_162_0
											end

											local var_162_0 = arg_162_0:GetFleetByIFF(arg_162_1)

											if #var_3.GetScoutList(var_162_0) ~= 0 then
												do
													local var_162_1 = var_3:GetFlagShip()

													if not var_4.IsAlive(var_162_1) then
														return false
													else
														return true
													end
												end

												::label_162_0::

												return
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function var_0_9.TriggerFinishBattle(arg_163_0)
	pairs = var_1_10001

	for iter_163_0, iter_163_1 in var_1_10001(arg_163_0._fleetList) do
		local var_163_0 = iter_163_1
		local var_163_1 = iter_163_1.GetUnitList(var_163_0)

		ipairs = var_163_0

		for iter_163_2, iter_163_3 in var_163_0(var_163_1) do
			iter_163_3:TriggerBuff(var_0_3.BuffEffectType.ON_FINISH_GAME)
		end
	end

	pairs = var_1

	for iter_163_4, iter_163_5 in var_1(arg_163_0._minionShipList) do
		iter_163_5:TriggerBuff(var_0_3.BuffEffectType.ON_FINISH_GAME)
	end

	return
end

function var_0_9.ChapterSupportBarrage(arg_164_0, arg_164_1, arg_164_2)
	local var_164_0

	local function var_164_1(...)
		ipairs = var_2_10000

		for iter_165_0, iter_165_1 in var_2_10000(arg_164_0._battleInitData.SupportUnitList) do
			local var_165_0 = var_0_5.GetPlayerShipTmpDataFromID(iter_165_1.tmpID).type

			table = var_6

			local var_165_1 = var_6.contains

			ShipType = var_2_10007

			if var_165_1(var_2_10007.BundleList.qian, var_165_0) then
				var_2_10007 = arg_164_0

				local var_165_2 = var_6.SpawnSupportUnit(var_2_10007, iter_165_1, arg_164_1)

				var_0_6.SetCurrent(var_165_2, "loadSpeed", 0)
			end
		end

		pg = var_0

		local var_165_3 = var_0.TimeMgr.GetInstance()

		var_0.RemoveBattleTimer(var_165_3, var_164_0)

		return
	end

	if arg_164_2 then
		pg = var_1_10005

		local var_164_2 = var_1_10005.TimeMgr.GetInstance()

		var_164_0 = var_5.AddBattleTimer(var_164_2, "supportBarrageTimer", -1, arg_164_2, var_164_1)
	else
		var_164_1()
	end

	return
end

return
