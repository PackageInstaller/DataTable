ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleConfig
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.BattleDebugConsole = var_0_10004("BattleDebugConsole")
var_0.Battle.BattleDebugConsole.__name = "BattleDebugConsole"

local var_0_4 = var_0.Battle.BattleDebugConsole

var_0_4.ProxyUpdateNormal = var_0.Battle.BattleDataProxy.Update
var_0_4.ProxyUpdateAutoComponentNormal = var_0.Battle.BattleDataProxy.UpdateAutoComponent
var_0_4.UPDATE_PLAYER_WEAPON = "updatePlayerWeapon"
var_0_4.UPDATE_MONSTER_WEAPON = "updateMonsterWeapon"
var_0_4.UPDATE_MONSTER_AI = "updateMonsterAI"

function var_0_4.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._state = arg_1_2

	local var_1_0 = arg_1_0._state

	arg_1_0._dataProxy = var_3.GetProxyByName(var_1_0, var_0.Battle.BattleDataProxy.__name)

	arg_1_0:initComponent()

	local var_1_1 = arg_1_0._dataProxy
	local var_1_2 = var_3.GetInitData(var_1_1).battleType

	SYSTEM_DEBUG = var_1_10004

	if var_1_2 ~= var_1_10004 then
		local var_1_3 = arg_1_0._dataProxy

		var_1_2 = var_1_2.GetInitData(var_1_3).battleType
		SYSTEM_CARDPUZZLE = var_1_10004

		if var_1_2 == var_1_10004 then
			arg_1_0:initData()
			arg_1_0:initDebug()
		else
			SetActive = var_1_2

			var_1_2(arg_1_0._debug, false)
		end

		return
	end
end

function var_0_4.initDebug(arg_2_0)
	local var_2_0 = arg_2_0._debug

	arg_2_0._randomEngage = var_1.Find(var_2_0, "spawn_enemy")
	onButton = var_1

	local var_2_1
	local var_2_2 = arg_2_0._randomEngage

	local function var_2_3()
		math = var_2_10000

		local var_3_0 = var_2_10000.random(#arg_2_0._monsterArray)
		local var_3_1 = arg_2_0

		var_1.spawnEnemy(var_3_1, arg_2_0._monsterArray[var_3_0], 15, 25, 25, 65)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_1, var_2_2, var_2_3, var_1_10006)

	local var_2_4 = arg_2_0._debug

	arg_2_0._summon = var_1.Find(var_2_4, "summon_enemy")

	local var_2_5 = arg_2_0._debug
	local var_2_6 = var_1.Find(var_2_5, "model_id")

	arg_2_0._summonID = var_1.GetComponent(var_2_6, "InputField")

	local var_2_7 = arg_2_0._debug
	local var_2_8 = var_1.Find(var_2_7, "x_min")

	arg_2_0._minX = var_1.GetComponent(var_2_8, "InputField")

	local var_2_9 = arg_2_0._debug
	local var_2_10 = var_1.Find(var_2_9, "x_max")

	arg_2_0._manX = var_1.GetComponent(var_2_10, "InputField")

	local var_2_11 = arg_2_0._debug
	local var_2_12 = var_1.Find(var_2_11, "z_min")

	arg_2_0._minZ = var_1.GetComponent(var_2_12, "InputField")

	local var_2_13 = arg_2_0._debug
	local var_2_14 = var_1.Find(var_2_13, "z_max")

	arg_2_0._manZ = var_1.GetComponent(var_2_14, "InputField")
	onButton = var_1

	local var_2_15
	local var_2_16 = arg_2_0._summon

	local function var_2_17()
		tonumber = var_2_10000

		local var_4_0 = var_2_10000(arg_2_0._summonID.text)

		tonumber = var_2_10001

		local var_4_1 = var_2_10001(arg_2_0._minX.text)

		tonumber = var_2

		local var_4_2 = var_2(arg_2_0._manX.text)

		tonumber = var_3

		local var_4_3 = var_3(arg_2_0._minZ.text)

		tonumber = var_4

		local var_4_4 = var_4(arg_2_0._manZ.text)
		local var_4_5 = arg_2_0

		var_5.spawnEnemy(var_4_5, var_4_0, var_4_1, var_4_2, var_4_3, var_4_4)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_15, var_2_16, var_2_17, var_1_10006)

	local var_2_18 = arg_2_0._debug

	arg_2_0._killAllEnemy = var_1.Find(var_2_18, "clear_enemy")
	onButton = var_1

	local var_2_19
	local var_2_20 = arg_2_0._killAllEnemy

	local function var_2_21()
		local var_5_0 = arg_2_0._dataProxy

		var_0.KillAllEnemy(var_5_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_19, var_2_20, var_2_21, var_1_10006)

	local var_2_22 = arg_2_0._debug

	arg_2_0._summonStrike = var_1.Find(var_2_22, "spawn_strike")

	local var_2_23 = arg_2_0._debug
	local var_2_24 = var_1.Find(var_2_23, "air_model_id")

	arg_2_0._summonStrikeID = var_1.GetComponent(var_2_24, "InputField")

	local var_2_25 = arg_2_0._debug
	local var_2_26 = var_1.Find(var_2_25, "total")

	arg_2_0._summonStrikeTotal = var_1.GetComponent(var_2_26, "InputField")

	local var_2_27 = arg_2_0._debug
	local var_2_28 = var_1.Find(var_2_27, "once")

	arg_2_0._summonStrikeSingular = var_1.GetComponent(var_2_28, "InputField")

	local var_2_29 = arg_2_0._debug
	local var_2_30 = var_1.Find(var_2_29, "interval")

	arg_2_0._summonStrikeInterval = var_1.GetComponent(var_2_30, "InputField")
	onButton = var_1

	local var_2_31
	local var_2_32 = arg_2_0._summonStrike

	local function var_2_33()
		tonumber = var_2_10000

		local var_6_0 = var_2_10000(arg_2_0._summonStrikeID.text)

		tonumber = var_2_10001

		local var_6_1 = var_2_10001(arg_2_0._summonStrikeTotal.text)

		tonumber = var_2

		local var_6_2 = var_2(arg_2_0._summonStrikeSingular.text)

		tonumber = var_3

		local var_6_3 = var_3(arg_2_0._summonStrikeInterval.text)
		local var_6_4 = arg_2_0

		var_4.spawnStrike(var_6_4, var_6_0, var_6_1, var_6_2, var_6_3)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_31, var_2_32, var_2_33, var_1_10006)

	local var_2_34 = arg_2_0._debug

	arg_2_0._killAllStrike = var_1.Find(var_2_34, "clear_strike")
	onButton = var_1

	local var_2_35
	local var_2_36 = arg_2_0._killAllStrike

	local function var_2_37()
		local var_7_0 = arg_2_0._dataProxy

		var_0.KillAllAirStrike(var_7_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_35, var_2_36, var_2_37, var_1_10006)

	local var_2_38 = arg_2_0._debug

	arg_2_0._blockCld = var_1.Find(var_2_38, "all_cld")

	local var_2_39 = arg_2_0._debug

	arg_2_0._blockPlayerWeapon = var_1.Find(var_2_39, "player_weapon")

	local var_2_40 = arg_2_0._debug

	arg_2_0._blockMonsterWeapon = var_1.Find(var_2_40, "monster_weapon")

	local var_2_41 = arg_2_0._debug

	arg_2_0._blockMonsterAI = var_1.Find(var_2_41, "monster_motion")
	onToggle = var_1

	local var_2_42
	local var_2_43 = arg_2_0._blockCld

	local function var_2_44(arg_8_0)
		if arg_8_0 then
			arg_2_0._dataProxy.Update = var_0_4.ProxyUpdateNormal
		else
			arg_2_0._dataProxy.Update = arg_2_0._dataProxy.__debug__BlockCldUpdate__
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_42, var_2_43, var_2_44, var_1_10006)

	onToggle = var_1

	local var_2_45
	local var_2_46 = arg_2_0._blockPlayerWeapon

	local function var_2_47(arg_9_0)
		if arg_9_0 then
			arg_2_0._autoComponentFuncList.updatePlayerWeapon = arg_2_0._updatePlayerWeapon
		else
			arg_2_0._autoComponentFuncList.updatePlayerWeapon = nil
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_45, var_2_46, var_2_47, var_1_10006)

	onToggle = var_1

	local var_2_48
	local var_2_49 = arg_2_0._blockMonsterWeapon

	local function var_2_50(arg_10_0)
		if arg_10_0 then
			arg_2_0._autoComponentFuncList.updateMonsterWeapon = arg_2_0._updateMonsterWeapon
		else
			arg_2_0._autoComponentFuncList.updateMonsterWeapon = nil
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_48, var_2_49, var_2_50, var_1_10006)

	onToggle = var_1

	local var_2_51
	local var_2_52 = arg_2_0._blockMonsterAI

	local function var_2_53(arg_11_0)
		if arg_11_0 then
			arg_2_0._autoComponentFuncList.updateMonsterAI = arg_2_0._updateMonsterAI
		else
			arg_2_0._autoComponentFuncList.updateMonsterAI = nil
		end

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_51, var_2_52, var_2_53, var_1_10006)

	local var_2_54 = arg_2_0._debug

	arg_2_0._setDungeonLevel = var_1.Find(var_2_54, "dungeon_level")

	local var_2_55 = arg_2_0._debug
	local var_2_56 = var_1.Find(var_2_55, "level_input")

	arg_2_0._dungeonLevel = var_1.GetComponent(var_2_56, "InputField")
	onButton = var_1

	local var_2_57
	local var_2_58 = arg_2_0._setDungeonLevel

	local function var_2_59()
		local var_12_0 = arg_2_0._dataProxy
		local var_12_1 = var_0.SetDungeonLevel

		tonumber = var_2_10003

		var_12_1(var_12_0, var_2_10003(arg_2_0._dungeonLevel.text))

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_57, var_2_58, var_2_59, var_1_10006)

	local var_2_60 = arg_2_0._debug

	arg_2_0._clsBullet = var_1.Find(var_2_60, "cls_bullet")
	onButton = var_1

	local var_2_61
	local var_2_62 = arg_2_0._clsBullet

	local function var_2_63()
		local var_13_0 = arg_2_0._dataProxy

		var_0.CLSBullet(var_13_0, var_0_2.FRIENDLY_CODE)

		local var_13_1 = arg_2_0._dataProxy

		var_0.CLSBullet(var_13_1, var_0_2.FOE_CODE)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_2_61, var_2_62, var_2_63, var_1_10006)

	return
end

function var_0_4.initData(arg_14_0)
	local var_14_0 = arg_14_0._dataProxy

	arg_14_0._fleetList = var_1.GetFleetList(var_14_0)

	local var_14_1 = arg_14_0._dataProxy

	arg_14_0._freeShipList = var_1.GetFreeShipList(var_14_1)
	arg_14_0._monsterArray = {}
	ipairs = var_1
	pg = var_14_1

	for iter_14_0, iter_14_1 in var_1(var_14_1.enemy_data_statistics.all) do
		type = var_1_10006

		if var_1_10006(iter_14_1) == "number" and iter_14_1 <= 0 then
			table = var_1_10006

			var_1_10006.insert(arg_14_0._monsterArray, iter_14_1)
		end
	end

	function arg_14_0._updatePlayerWeapon(arg_15_0)
		pairs = var_2_10001

		for iter_15_0, iter_15_1 in var_2_10001(arg_14_0._fleetList) do
			iter_15_1:UpdateAutoComponent(arg_15_0)
		end

		return
	end

	function arg_14_0._updateMonsterWeapon(arg_16_0)
		pairs = var_2_10001

		for iter_16_0, iter_16_1 in var_2_10001(arg_14_0._freeShipList) do
			iter_16_1:UpdateWeapon(arg_16_0)
		end

		return
	end

	function arg_14_0._updateMonsterAI(arg_17_0)
		pairs = var_2_10001

		for iter_17_0, iter_17_1 in var_2_10001(arg_14_0._dataProxy._teamList) do
			if iter_17_1:IsFatalDamage() then
				local var_17_0 = arg_14_0._dataProxy

				var_6.KillNPCTeam(var_17_0, iter_17_0)
			else
				iter_17_1:UpdateMotion()
			end
		end

		return
	end

	arg_14_0._autoComponentFuncList = {}
	arg_14_0._autoComponentFuncList.updatePlayerWeapon = arg_14_0._updatePlayerWeapon
	arg_14_0._autoComponentFuncList.updateMonsterWeapon = arg_14_0._updateMonsterWeapon
	arg_14_0._autoComponentFuncList.updateMonsterAI = arg_14_0._updateMonsterAI

	local function var_14_2(arg_18_0, arg_18_1)
		pairs = var_2_10002

		for iter_18_0, iter_18_1 in var_2_10002(arg_14_0._autoComponentFuncList) do
			iter_18_1(arg_18_1)
		end

		return
	end

	arg_14_0._dataProxy.UpdateAutoComponent = var_14_2

	return
end

function var_0_4.initComponent(arg_19_0)
	local var_19_0 = arg_19_0._go

	arg_19_0._base = var_1.Find(var_19_0, "bg")

	local var_19_1 = arg_19_0._base

	arg_19_0._common = var_1.Find(var_19_1, "common")

	local var_19_2 = arg_19_0._base

	arg_19_0._debug = var_1.Find(var_19_2, "debug")

	local var_19_3 = arg_19_0._common

	arg_19_0._exitBtn = var_1.Find(var_19_3, "close")
	onButton = var_1

	local var_19_4
	local var_19_5 = arg_19_0._exitBtn

	local function var_19_6()
		local var_20_0 = arg_19_0

		var_0.SetActive(var_20_0, false)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_4, var_19_5, var_19_6, var_1_10006)

	local var_19_7 = arg_19_0._common

	arg_19_0._activeReference = var_1.Find(var_19_7, "reference_switch")
	onButton = var_1

	local var_19_8
	local var_19_9 = arg_19_0._activeReference

	local function var_19_10()
		local var_21_0 = arg_19_0

		var_0.activeReference(var_21_0)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_8, var_19_9, var_19_10, var_1_10006)

	local var_19_11 = arg_19_0._common

	arg_19_0._lockCommonDMG = var_1.Find(var_19_11, "common_damage")

	local var_19_12 = arg_19_0._common

	arg_19_0._lockS2MDMG = var_1.Find(var_19_12, "ship2main_damage")

	local var_19_13 = arg_19_0._common

	arg_19_0._lockA2MDMG = var_1.Find(var_19_13, "aircraft2main_damage")

	local var_19_14 = arg_19_0._common

	arg_19_0._lockCrushDMG = var_1.Find(var_19_14, "crush_damage")
	onToggle = var_1

	local var_19_15
	local var_19_16 = arg_19_0._lockCommonDMG

	local function var_19_17(arg_22_0)
		local var_22_0 = arg_19_0._dataProxy
		local var_22_1 = var_1.SetupCalculateDamage
		local var_22_2

		if not arg_22_0 or not var_0.Battle.BattleFormulas.CalcDamageLock then
			var_22_2 = nil
		end

		var_22_1(var_22_0, var_22_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_15, var_19_16, var_19_17, var_1_10006)

	onToggle = var_1

	local var_19_18
	local var_19_19 = arg_19_0._lockS2MDMG

	local function var_19_20(arg_23_0)
		local var_23_0 = arg_19_0._dataProxy
		local var_23_1 = var_1.SetupDamageKamikazeAir
		local var_23_2

		if not arg_23_0 or not var_0.Battle.BattleFormulas.CalcDamageLockA2M then
			var_23_2 = nil
		end

		var_23_1(var_23_0, var_23_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_18, var_19_19, var_19_20, var_1_10006)

	onToggle = var_1

	local var_19_21
	local var_19_22 = arg_19_0._lockA2MDMG

	local function var_19_23(arg_24_0)
		local var_24_0 = arg_19_0._dataProxy
		local var_24_1 = var_1.SetupDamageKamikazeShip
		local var_24_2

		if not arg_24_0 or not var_0.Battle.BattleFormulas.CalcDamageLockS2M then
			var_24_2 = nil
		end

		var_24_1(var_24_0, var_24_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_21, var_19_22, var_19_23, var_1_10006)

	onToggle = var_1

	local var_19_24
	local var_19_25 = arg_19_0._lockCrushDMG

	local function var_19_26(arg_25_0)
		local var_25_0 = arg_19_0._dataProxy
		local var_25_1 = var_1.SetupDamageCrush
		local var_25_2

		if not arg_25_0 or not var_0.Battle.BattleFormulas.CalcDamageLockCrush then
			var_25_2 = nil
		end

		var_25_1(var_25_0, var_25_2)

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_24, var_19_25, var_19_26, var_1_10006)

	local var_19_27 = arg_19_0._common

	arg_19_0._triggerWave = var_1.Find(var_19_27, "wave_trigger")

	local var_19_28 = arg_19_0._common
	local var_19_29 = var_1.Find(var_19_28, "wave_input")

	arg_19_0._waveIndex = var_1.GetComponent(var_19_29, "InputField")

	local var_19_30 = arg_19_0._dataProxy
	local var_19_31 = var_1.GetInitData(var_19_30).battleType

	SYSTEM_SCENARIO = var_1_10002

	if var_19_31 ~= var_1_10002 then
		local var_19_32 = arg_19_0._dataProxy

		var_19_31 = var_19_31.GetInitData(var_19_32).battleType
		SYSTEM_ROUTINE = var_1_10002

		if var_19_31 ~= var_1_10002 then
			local var_19_33 = arg_19_0._dataProxy

			var_19_31 = var_19_31.GetInitData(var_19_33).battleType
			SYSTEM_ACT_BOSS = var_1_10002

			if var_19_31 ~= var_1_10002 then
				SetActive = var_19_31

				var_19_31(arg_19_0._triggerWave, false)

				SetActive = var_19_31

				var_19_31(arg_19_0._waveIndex, false)

				goto label_19_0
			end
		end
	end

	onButton = var_19_31

	var_19_31(nil, arg_19_0._triggerWave, function()
		local var_26_0 = arg_19_0
		local var_26_1 = var_0.forceTrigger

		tonumber = var_2_10003

		var_26_1(var_26_0, var_2_10003(arg_19_0._waveIndex.text))

		return
	end)

	::label_19_0::

	local var_19_34 = arg_19_0._common

	arg_19_0._triggerWeather = var_1.Find(var_19_34, "weather_trigger")

	local var_19_35 = arg_19_0._common
	local var_19_36 = var_1.Find(var_19_35, "weather_input")

	arg_19_0._weatherInput = var_1.GetComponent(var_19_36, "InputField")
	onButton = var_1

	var_1(nil, arg_19_0._triggerWeather, function()
		local var_27_0 = arg_19_0._dataProxy
		local var_27_1 = var_0.AddWeather

		tonumber = var_2_10003

		var_27_1(var_27_0, var_2_10003(arg_19_0._weatherInput.text))

		return
	end)

	local var_19_37 = arg_19_0._common

	arg_19_0._antiSubDetailRange = var_1.Find(var_19_37, "anti_sub_detail")
	onButton = var_1

	var_1(nil, arg_19_0._antiSubDetailRange, function()
		local var_28_0 = arg_19_0._state
		local var_28_1 = var_0.GetMediatorByName(var_28_0, "BattleSceneMediator")

		var_0.InitDetailAntiSubArea(var_28_1)

		return
	end)

	local var_19_38 = arg_19_0._common

	arg_19_0._instantReload = var_1.Find(var_19_38, "instant_reload")
	onButton = var_1

	var_1(nil, arg_19_0._instantReload, function()
		local var_29_0 = arg_19_0._dataProxy._fleetList[1]

		;(function(arg_30_0)
			local var_30_0 = arg_30_0:GetWeaponList()

			ipairs = var_3_10002

			for iter_30_0, iter_30_1 in var_3_10002(var_30_0) do
				iter_30_1:QuickCoolDown()
			end

			return
		end)(var_29_0:GetChargeWeaponVO())
		var_1(var_29_0:GetTorpedoWeaponVO())
		var_1(var_29_0:GetAirAssistVO())

		return
	end)

	local var_19_39 = arg_19_0._base

	arg_19_0._white = var_1.Find(var_19_39, "white_button")
	onButton = var_1

	local var_19_40
	local var_19_41 = arg_19_0._white

	local function var_19_42()
		local var_31_0 = arg_19_0._dataProxy._fleetList[1]._scoutList[1]

		var_0.UpdateHP(var_31_0, -20, {})

		return
	end

	SFX_PANEL = var_1_10006

	var_1(var_19_40, var_19_41, var_19_42, var_1_10006)

	SetActive = var_1

	var_1(arg_19_0._white, true)

	return
end

function var_0_4.SetActive(arg_32_0, arg_32_1)
	SetActive = var_1_10002

	var_1_10002(arg_32_0._go, arg_32_1)

	return
end

function var_0_4.spawnEnemy(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	local var_33_0 = {
		monsterTemplateID = arg_33_1
	}
	local var_33_1 = {
		nil,
		0
	}

	math = var_1_10008
	var_33_1[1] = var_1_10008.random(arg_33_2, arg_33_3)
	math = var_8
	var_33_1[3] = var_8.random(arg_33_4, arg_33_5)
	var_33_0.corrdinate = var_33_1
	var_33_0.delay = 0
	var_33_0.moveCast = true
	var_33_0.score = 0
	var_33_0.buffList = {
		8001
	}

	local var_33_2 = arg_33_0._dataProxy

	var_7.SpawnMonster(var_33_2, var_33_0, 1, var_0_1.UnitType.ENEMY_UNIT, var_0_2.FOE_CODE)

	return
end

function var_0_4.spawnStrike(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	local var_34_0 = {
		templateID = arg_34_1,
		weaponID = {},
		attr = {},
		totalNumber = arg_34_2,
		onceNumber = arg_34_3
	}

	var_34_0.formation = 10006
	var_34_0.delay = 0
	var_34_0.interval = 0.1
	var_34_0.score = 0

	local var_34_1 = arg_34_0._dataProxy

	var_6.SpawnAirFighter(var_34_1, var_34_0)

	return
end

function var_0_4.activeReference(arg_35_0)
	local var_35_0 = arg_35_0._state

	var_1.ActiveReference(var_35_0)

	local var_35_1 = arg_35_0._state
	local var_35_3

	if not var_1.GetMediatorByName(var_35_1, var_0.Battle.BattleReferenceBoxMediator.__name) then
		local var_35_2 = arg_35_0._state

		var_35_3 = var_1.AddMediator(var_35_2, var_0.Battle.BattleReferenceBoxMediator.New())
	end

	pg = var_1_10002

	local var_35_4 = var_1_10002.TipsMgr.GetInstance()

	var_2.ShowTips(var_35_4, "┏━━━━━━━━━━━━━━━━━━━┓")

	pg = var_2

	local var_35_5 = var_2.TipsMgr.GetInstance()

	var_2.ShowTips(var_35_5, "┃ヽ(•̀ω•́ )ゝ战斗调试模块初始化成功！(ง •̀_•́)ง┃")

	pg = var_2

	local var_35_6 = var_2.TipsMgr.GetInstance()

	var_2.ShowTips(var_35_6, "┗━━━━━━━━━━━━━━━━━━━┛")

	local var_35_7 = arg_35_0._activeReference.transform

	var_2.GetComponent(var_35_7, "Button").enabled = false

	local var_35_8 = arg_35_0._activeReference
	local var_35_9 = var_2.Find(var_35_8, "text")
	local var_35_10 = var_2.GetComponent

	typeof = var_5
	Text = var_1_10007
	var_35_10(var_35_9, var_5(var_1_10007)).text = "(ﾉ･ω･)ﾉﾞ"

	local var_35_11 = arg_35_0._common

	arg_35_0._referenceConsole = var_2.Find(var_35_11, "reference_btns")
	SetActive = var_2

	var_2(arg_35_0._referenceConsole, true)

	local var_35_12 = arg_35_0._referenceConsole

	arg_35_0._speedUp = var_2.Find(var_35_12, "speed_up")

	local var_35_13 = arg_35_0._referenceConsole

	arg_35_0._speedDown = var_2.Find(var_35_13, "speed_down")

	local var_35_14 = arg_35_0._referenceConsole

	arg_35_0._speedLevel = var_2.Find(var_35_14, "speed")
	onButton = var_2

	local var_35_15
	local var_35_16 = arg_35_0._speedUp

	local function var_35_17()
		if var_0.Battle.BattleConfig.BASIC_TIME_SCALE < 1 then
			var_0.Battle.BattleControllerCommand.removeSpeed(2)
		elseif var_0 >= 1 then
			var_0.Battle.BattleControllerCommand.addSpeed(2)
		end

		local var_36_0 = arg_35_0._speedLevel
		local var_36_1 = var_1.GetComponent

		typeof = var_2_10004
		Text = var_2_10006
		var_36_1(var_36_0, var_2_10004(var_2_10006)).text = var_0.Battle.BattleConfig.BASIC_TIME_SCALE

		local var_36_2 = arg_35_0._state

		var_1.ScaleTimer(var_36_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_15, var_35_16, var_35_17, var_1_10007)

	onButton = var_2

	local var_35_18
	local var_35_19 = arg_35_0._speedDown

	local function var_35_20()
		if var_0.Battle.BattleConfig.BASIC_TIME_SCALE > 1 then
			var_0.Battle.BattleControllerCommand.removeSpeed(0.5)
		elseif var_0 <= 1 then
			var_0.Battle.BattleControllerCommand.addSpeed(0.5)
		end

		local var_37_0 = arg_35_0._speedLevel
		local var_37_1 = var_1.GetComponent

		typeof = var_2_10004
		Text = var_2_10006
		var_37_1(var_37_0, var_2_10004(var_2_10006)).text = var_0.Battle.BattleConfig.BASIC_TIME_SCALE

		local var_37_2 = arg_35_0._state

		var_1.ScaleTimer(var_37_2)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_18, var_35_19, var_35_20, var_1_10007)

	local var_35_21 = arg_35_0._referenceConsole

	arg_35_0._shipBox = var_2.Find(var_35_21, "ship_box")

	local var_35_22 = arg_35_0._referenceConsole

	arg_35_0._bulletBox = var_2.Find(var_35_22, "bullet_box")

	local var_35_23 = arg_35_0._referenceConsole

	arg_35_0._pp = var_2.Find(var_35_23, "property_panel")
	onToggle = var_2

	local var_35_24
	local var_35_25 = arg_35_0._shipBox

	local function var_35_26(arg_38_0)
		local var_38_0 = var_35_3

		var_1.ActiveUnitBoxes(var_38_0, arg_38_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_24, var_35_25, var_35_26, var_1_10007)

	onToggle = var_2

	local var_35_27
	local var_35_28 = arg_35_0._bulletBox

	local function var_35_29(arg_39_0)
		local var_39_0 = var_35_3

		var_1.ActiveBulletBoxes(var_39_0, arg_39_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_27, var_35_28, var_35_29, var_1_10007)

	onToggle = var_2

	local var_35_30
	local var_35_31 = arg_35_0._pp

	local function var_35_32(arg_40_0)
		local var_40_0 = var_35_3

		var_1.ActiveUnitDetail(var_40_0, arg_40_0)

		return
	end

	SFX_PANEL = var_1_10007

	var_2(var_35_30, var_35_31, var_35_32, var_1_10007)

	return
end

function var_0_4.forceTrigger(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._state

	if var_2.GetCommandByName(var_41_0, "BattleSingleDungeonCommand")._waveUpdater._waveInfoList[arg_41_1] == nil then
		pg = var_41_0

		local var_41_1 = var_41_0.TipsMgr.GetInstance()

		var_4.ShowTips(var_41_1, "查无次波")
	elseif var_3:GetState() ~= var_3.STATE_DEACTIVE then
		pg = var_4

		local var_41_2 = var_4.TipsMgr.GetInstance()

		var_4.ShowTips(var_41_2, "该触发器已经触发")
	else
		var_3:DoWave()
	end

	return
end

return
