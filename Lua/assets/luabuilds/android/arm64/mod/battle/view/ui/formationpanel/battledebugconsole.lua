ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleConfig

ys.Battle.BattleDebugConsole = class("BattleDebugConsole")
ys.Battle.BattleDebugConsole.__name = "BattleDebugConsole"

local var_0_3 = ys.Battle.BattleDebugConsole

ys.Battle.BattleDebugConsole.ProxyUpdateNormal = ys.Battle.BattleDataProxy.Update
ys.Battle.BattleDebugConsole.ProxyUpdateAutoComponentNormal = ys.Battle.BattleDataProxy.UpdateAutoComponent
ys.Battle.BattleDebugConsole.UPDATE_PLAYER_WEAPON = "updatePlayerWeapon"
ys.Battle.BattleDebugConsole.UPDATE_MONSTER_WEAPON = "updateMonsterWeapon"
ys.Battle.BattleDebugConsole.UPDATE_MONSTER_AI = "updateMonsterAI"

function ys.Battle.BattleDebugConsole.Ctor(arg_1_0, arg_1_1, arg_1_2)
	arg_1_0._go = arg_1_1
	arg_1_0._state = arg_1_2
	arg_1_0._dataProxy = arg_1_0._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	arg_1_0:initComponent()

	if arg_1_0._dataProxy:GetInitData().battleType == SYSTEM_DEBUG or arg_1_0._dataProxy:GetInitData().battleType == SYSTEM_CARDPUZZLE then
		arg_1_0:initData()
		arg_1_0:initDebug()
	else
		SetActive(arg_1_0._debug, false)
	end

	return
end

function ys.Battle.BattleDebugConsole.initDebug(arg_2_0)
	arg_2_0._randomEngage = arg_2_0._debug:Find("spawn_enemy")

	onButton(nil, arg_2_0._randomEngage, function()
		arg_2_0:spawnEnemy(arg_2_0._monsterArray[math.random(#arg_2_0._monsterArray)], 15, 25, 25, 65)

		return
	end, SFX_PANEL)

	arg_2_0._summon = arg_2_0._debug:Find("summon_enemy")
	arg_2_0._summonID = arg_2_0._debug:Find("model_id"):GetComponent("InputField")
	arg_2_0._minX = arg_2_0._debug:Find("x_min"):GetComponent("InputField")
	arg_2_0._manX = arg_2_0._debug:Find("x_max"):GetComponent("InputField")
	arg_2_0._minZ = arg_2_0._debug:Find("z_min"):GetComponent("InputField")
	arg_2_0._manZ = arg_2_0._debug:Find("z_max"):GetComponent("InputField")

	onButton(nil, arg_2_0._summon, function()
		arg_2_0:spawnEnemy(tonumber(arg_2_0._summonID.text), tonumber(arg_2_0._minX.text), tonumber(arg_2_0._manX.text), tonumber(arg_2_0._minZ.text), (tonumber(arg_2_0._manZ.text)))

		return
	end, SFX_PANEL)

	arg_2_0._killAllEnemy = arg_2_0._debug:Find("clear_enemy")

	onButton(nil, arg_2_0._killAllEnemy, function()
		arg_2_0._dataProxy:KillAllEnemy()

		return
	end, SFX_PANEL)

	arg_2_0._summonStrike = arg_2_0._debug:Find("spawn_strike")
	arg_2_0._summonStrikeID = arg_2_0._debug:Find("air_model_id"):GetComponent("InputField")
	arg_2_0._summonStrikeTotal = arg_2_0._debug:Find("total"):GetComponent("InputField")
	arg_2_0._summonStrikeSingular = arg_2_0._debug:Find("once"):GetComponent("InputField")
	arg_2_0._summonStrikeInterval = arg_2_0._debug:Find("interval"):GetComponent("InputField")

	onButton(nil, arg_2_0._summonStrike, function()
		arg_2_0:spawnStrike(tonumber(arg_2_0._summonStrikeID.text), tonumber(arg_2_0._summonStrikeTotal.text), tonumber(arg_2_0._summonStrikeSingular.text), (tonumber(arg_2_0._summonStrikeInterval.text)))

		return
	end, SFX_PANEL)

	arg_2_0._killAllStrike = arg_2_0._debug:Find("clear_strike")

	onButton(nil, arg_2_0._killAllStrike, function()
		arg_2_0._dataProxy:KillAllAirStrike()

		return
	end, SFX_PANEL)

	arg_2_0._blockCld = arg_2_0._debug:Find("all_cld")
	arg_2_0._blockPlayerWeapon = arg_2_0._debug:Find("player_weapon")
	arg_2_0._blockMonsterWeapon = arg_2_0._debug:Find("monster_weapon")
	arg_2_0._blockMonsterAI = arg_2_0._debug:Find("monster_motion")

	onToggle(nil, arg_2_0._blockCld, function(arg_8_0)
		arg_2_0._dataProxy.Update = arg_8_0 and var_0_3.ProxyUpdateNormal or arg_2_0._dataProxy.__debug__BlockCldUpdate__

		return
	end, SFX_PANEL)
	onToggle(nil, arg_2_0._blockPlayerWeapon, function(arg_9_0)
		arg_2_0._autoComponentFuncList.updatePlayerWeapon = arg_9_0 and arg_2_0._updatePlayerWeapon or nil

		return
	end, SFX_PANEL)
	onToggle(nil, arg_2_0._blockMonsterWeapon, function(arg_10_0)
		arg_2_0._autoComponentFuncList.updateMonsterWeapon = arg_10_0 and arg_2_0._updateMonsterWeapon or nil

		return
	end, SFX_PANEL)
	onToggle(nil, arg_2_0._blockMonsterAI, function(arg_11_0)
		arg_2_0._autoComponentFuncList.updateMonsterAI = arg_11_0 and arg_2_0._updateMonsterAI or nil

		return
	end, SFX_PANEL)

	arg_2_0._setDungeonLevel = arg_2_0._debug:Find("dungeon_level")
	arg_2_0._dungeonLevel = arg_2_0._debug:Find("level_input"):GetComponent("InputField")

	onButton(nil, arg_2_0._setDungeonLevel, function()
		arg_2_0._dataProxy:SetDungeonLevel(tonumber(arg_2_0._dungeonLevel.text))

		return
	end, SFX_PANEL)

	arg_2_0._clsBullet = arg_2_0._debug:Find("cls_bullet")

	onButton(nil, arg_2_0._clsBullet, function()
		arg_2_0._dataProxy:CLSBullet(var_0_2.FRIENDLY_CODE)
		arg_2_0._dataProxy:CLSBullet(var_0_2.FOE_CODE)

		return
	end, SFX_PANEL)

	return
end

function ys.Battle.BattleDebugConsole.initData(arg_14_0)
	arg_14_0._fleetList = arg_14_0._dataProxy:GetFleetList()
	arg_14_0._freeShipList = arg_14_0._dataProxy:GetFreeShipList()
	arg_14_0._monsterArray = {}

	for iter_14_0, iter_14_1 in ipairs(pg.enemy_data_statistics.all) do
		if type(iter_14_1) == "number" and iter_14_1 <= 0 then
			table.insert(arg_14_0._monsterArray, iter_14_1)
		end
	end

	function arg_14_0._updatePlayerWeapon(arg_15_0)
		for iter_15_0, iter_15_1 in pairs(arg_14_0._fleetList) do
			iter_15_1:UpdateAutoComponent(arg_15_0)
		end

		return
	end

	function arg_14_0._updateMonsterWeapon(arg_16_0)
		for iter_16_0, iter_16_1 in pairs(arg_14_0._freeShipList) do
			iter_16_1:UpdateWeapon(arg_16_0)
		end

		return
	end

	function arg_14_0._updateMonsterAI(arg_17_0)
		for iter_17_0, iter_17_1 in pairs(arg_14_0._dataProxy._teamList) do
			if iter_17_1:IsFatalDamage() then
				arg_14_0._dataProxy:KillNPCTeam(iter_17_0)
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

	function arg_14_0._dataProxy.UpdateAutoComponent(arg_18_0, arg_18_1)
		for iter_18_0, iter_18_1 in pairs(arg_14_0._autoComponentFuncList) do
			iter_18_1(arg_18_1)
		end

		return
	end

	return
end

function ys.Battle.BattleDebugConsole.initComponent(arg_19_0)
	arg_19_0._base = arg_19_0._go:Find("bg")
	arg_19_0._common = arg_19_0._base:Find("common")
	arg_19_0._debug = arg_19_0._base:Find("debug")
	arg_19_0._exitBtn = arg_19_0._common:Find("close")

	onButton(nil, arg_19_0._exitBtn, function()
		arg_19_0:SetActive(false)

		return
	end, SFX_PANEL)

	arg_19_0._activeReference = arg_19_0._common:Find("reference_switch")

	onButton(nil, arg_19_0._activeReference, function()
		arg_19_0:activeReference()

		return
	end, SFX_PANEL)

	arg_19_0._lockCommonDMG = arg_19_0._common:Find("common_damage")
	arg_19_0._lockS2MDMG = arg_19_0._common:Find("ship2main_damage")
	arg_19_0._lockA2MDMG = arg_19_0._common:Find("aircraft2main_damage")
	arg_19_0._lockCrushDMG = arg_19_0._common:Find("crush_damage")

	onToggle(nil, arg_19_0._lockCommonDMG, function(arg_22_0)
		local var_22_0 = arg_19_0._dataProxy

		if arg_22_0 then
			local var_22_2 = var_0_0.Battle.BattleFormulas.CalcDamageLock or nil

			var_22_1(var_22_0, var_22_2)

			return
		end
	end, SFX_PANEL)
	onToggle(nil, arg_19_0._lockS2MDMG, function(arg_23_0)
		local var_23_0 = arg_19_0._dataProxy

		if arg_23_0 then
			local var_23_2 = var_0_0.Battle.BattleFormulas.CalcDamageLockA2M or nil

			var_23_1(var_23_0, var_23_2)

			return
		end
	end, SFX_PANEL)
	onToggle(nil, arg_19_0._lockA2MDMG, function(arg_24_0)
		local var_24_0 = arg_19_0._dataProxy

		if arg_24_0 then
			local var_24_2 = var_0_0.Battle.BattleFormulas.CalcDamageLockS2M or nil

			var_24_1(var_24_0, var_24_2)

			return
		end
	end, SFX_PANEL)
	onToggle(nil, arg_19_0._lockCrushDMG, function(arg_25_0)
		local var_25_0 = arg_19_0._dataProxy

		if arg_25_0 then
			local var_25_2 = var_0_0.Battle.BattleFormulas.CalcDamageLockCrush or nil

			var_25_1(var_25_0, var_25_2)

			return
		end
	end, SFX_PANEL)

	arg_19_0._triggerWave = arg_19_0._common:Find("wave_trigger")
	arg_19_0._waveIndex = arg_19_0._common:Find("wave_input"):GetComponent("InputField")

	if arg_19_0._dataProxy:GetInitData().battleType ~= SYSTEM_SCENARIO and arg_19_0._dataProxy:GetInitData().battleType ~= SYSTEM_ROUTINE and arg_19_0._dataProxy:GetInitData().battleType ~= SYSTEM_ACT_BOSS then
		SetActive(arg_19_0._triggerWave, false)
		SetActive(arg_19_0._waveIndex, false)
	else
		onButton(nil, arg_19_0._triggerWave, function()
			arg_19_0:forceTrigger(tonumber(arg_19_0._waveIndex.text))

			return
		end)
	end

	arg_19_0._triggerWeather = arg_19_0._common:Find("weather_trigger")
	arg_19_0._weatherInput = arg_19_0._common:Find("weather_input"):GetComponent("InputField")

	onButton(nil, arg_19_0._triggerWeather, function()
		arg_19_0._dataProxy:AddWeather(tonumber(arg_19_0._weatherInput.text))

		return
	end)

	arg_19_0._antiSubDetailRange = arg_19_0._common:Find("anti_sub_detail")

	onButton(nil, arg_19_0._antiSubDetailRange, function()
		arg_19_0._state:GetMediatorByName("BattleSceneMediator"):InitDetailAntiSubArea()

		return
	end)

	arg_19_0._instantReload = arg_19_0._common:Find("instant_reload")

	onButton(nil, arg_19_0._instantReload, function()
		(function(arg_30_0)
			for iter_30_0, iter_30_1 in ipairs((arg_30_0:GetWeaponList())) do
				iter_30_1:QuickCoolDown()
			end

			return
		end)(arg_19_0._dataProxy._fleetList[1]:GetChargeWeaponVO())
		;(function(arg_30_0)
			for iter_30_0, iter_30_1 in ipairs((arg_30_0:GetWeaponList())) do
				iter_30_1:QuickCoolDown()
			end

			return
		end)(arg_19_0._dataProxy._fleetList[1]:GetTorpedoWeaponVO())
		;(function(arg_30_0)
			for iter_30_0, iter_30_1 in ipairs((arg_30_0:GetWeaponList())) do
				iter_30_1:QuickCoolDown()
			end

			return
		end)(arg_19_0._dataProxy._fleetList[1]:GetAirAssistVO())

		return
	end)

	arg_19_0._white = arg_19_0._base:Find("white_button")

	onButton(nil, arg_19_0._white, function()
		arg_19_0._dataProxy._fleetList[1]._scoutList[1]:UpdateHP(-20, {})

		return
	end, SFX_PANEL)
	SetActive(arg_19_0._white, true)

	return
end

function ys.Battle.BattleDebugConsole.SetActive(arg_32_0, arg_32_1)
	SetActive(arg_32_0._go, arg_32_1)

	return
end

function ys.Battle.BattleDebugConsole.spawnEnemy(arg_33_0, arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
	local var_33_0 = {
		monsterTemplateID = arg_33_1,
		corrdinate = {
			math.random(arg_33_2, arg_33_3),
			0,
			math.random(arg_33_4, arg_33_5)
		}
	}

	var_33_0.delay = 0
	var_33_0.moveCast = true
	var_33_0.score = 0
	var_33_0.buffList = {
		8001
	}

	arg_33_0._dataProxy:SpawnMonster(var_33_0, 1, var_0_1.UnitType.ENEMY_UNIT, var_0_2.FOE_CODE)

	return
end

function ys.Battle.BattleDebugConsole.spawnStrike(arg_34_0, arg_34_1, arg_34_2, arg_34_3, arg_34_4)
	({
		templateID = arg_34_1,
		weaponID = {},
		attr = {},
		totalNumber = arg_34_2,
		onceNumber = arg_34_3
	}).formation = 10006
	;({
		templateID = arg_34_1,
		weaponID = {},
		attr = {},
		totalNumber = arg_34_2,
		onceNumber = arg_34_3
	}).delay = 0
	;({
		templateID = arg_34_1,
		weaponID = {},
		attr = {},
		totalNumber = arg_34_2,
		onceNumber = arg_34_3
	}).interval = 0.1
	;({
		templateID = arg_34_1,
		weaponID = {},
		attr = {},
		totalNumber = arg_34_2,
		onceNumber = arg_34_3
	}).score = 0

	arg_34_0._dataProxy:SpawnAirFighter({
		templateID = arg_34_1,
		weaponID = {},
		attr = {},
		totalNumber = arg_34_2,
		onceNumber = arg_34_3
	})

	return
end

function ys.Battle.BattleDebugConsole.activeReference(arg_35_0)
	arg_35_0._state:ActiveReference()

	local var_35_0

	if not arg_35_0._state:GetMediatorByName(var_0_0.Battle.BattleReferenceBoxMediator.__name) then
		var_35_0 = arg_35_0._state:AddMediator(var_0_0.Battle.BattleReferenceBoxMediator.New())
	end

	pg.TipsMgr.GetInstance():ShowTips("┏━━━━━━━━━━━━━━━━━━━┓")
	pg.TipsMgr.GetInstance():ShowTips("┃ヽ(•̀ω•́ )ゝ战斗调试模块初始化成功！(ง •̀_•́)ง┃")
	pg.TipsMgr.GetInstance():ShowTips("┗━━━━━━━━━━━━━━━━━━━┛")

	arg_35_0._activeReference.transform:GetComponent("Button").enabled = false
	arg_35_0._activeReference:Find("text"):GetComponent(typeof(Text)).text = "(ﾉ･ω･)ﾉﾞ"
	arg_35_0._referenceConsole = arg_35_0._common:Find("reference_btns")

	SetActive(arg_35_0._referenceConsole, true)

	arg_35_0._speedUp = arg_35_0._referenceConsole:Find("speed_up")
	arg_35_0._speedDown = arg_35_0._referenceConsole:Find("speed_down")
	arg_35_0._speedLevel = arg_35_0._referenceConsole:Find("speed")

	onButton(nil, arg_35_0._speedUp, function()
		if var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE < 1 then
			var_0_0.Battle.BattleControllerCommand.removeSpeed(2)
		elseif var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE >= 1 then
			var_0_0.Battle.BattleControllerCommand.addSpeed(2)
		end

		arg_35_0._speedLevel:GetComponent(typeof(Text)).text = var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE

		arg_35_0._state:ScaleTimer()

		return
	end, SFX_PANEL)
	onButton(nil, arg_35_0._speedDown, function()
		if var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE > 1 then
			var_0_0.Battle.BattleControllerCommand.removeSpeed(0.5)
		elseif var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE <= 1 then
			var_0_0.Battle.BattleControllerCommand.addSpeed(0.5)
		end

		arg_35_0._speedLevel:GetComponent(typeof(Text)).text = var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE

		arg_35_0._state:ScaleTimer()

		return
	end, SFX_PANEL)

	arg_35_0._shipBox = arg_35_0._referenceConsole:Find("ship_box")
	arg_35_0._bulletBox = arg_35_0._referenceConsole:Find("bullet_box")
	arg_35_0._pp = arg_35_0._referenceConsole:Find("property_panel")

	onToggle(nil, arg_35_0._shipBox, function(arg_38_0)
		var_35_0:ActiveUnitBoxes(arg_38_0)

		return
	end, SFX_PANEL)
	onToggle(nil, arg_35_0._bulletBox, function(arg_39_0)
		var_35_0:ActiveBulletBoxes(arg_39_0)

		return
	end, SFX_PANEL)
	onToggle(nil, arg_35_0._pp, function(arg_40_0)
		var_35_0:ActiveUnitDetail(arg_40_0)

		return
	end, SFX_PANEL)

	return
end

function ys.Battle.BattleDebugConsole.forceTrigger(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0._state:GetCommandByName("BattleSingleDungeonCommand")._waveUpdater._waveInfoList[arg_41_1]

	if var_41_0 == nil then
		pg.TipsMgr.GetInstance():ShowTips("查无次波")
	elseif var_41_0:GetState() ~= var_41_0.STATE_DEACTIVE then
		pg.TipsMgr.GetInstance():ShowTips("该触发器已经触发")
	else
		var_41_0:DoWave()
	end

	return
end

return
