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

function ys.Battle.BattleDebugConsole:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1
	self._state = arg_1_2
	self._dataProxy = self._state:GetProxyByName(var_0_0.Battle.BattleDataProxy.__name)

	self:initComponent()

	if self._dataProxy:GetInitData().battleType == SYSTEM_DEBUG or self._dataProxy:GetInitData().battleType == SYSTEM_CARDPUZZLE then
		self:initData()
		self:initDebug()
	else
		SetActive(self._debug, false)
	end

	return
end

function ys.Battle.BattleDebugConsole:initDebug()
	self._randomEngage = self._debug:Find("spawn_enemy")

	onButton(nil, self._randomEngage, function()
		self:spawnEnemy(self._monsterArray[math.random(#self._monsterArray)], 15, 25, 25, 65)

		return
	end, SFX_PANEL)

	self._summon = self._debug:Find("summon_enemy")
	self._summonID = self._debug:Find("model_id"):GetComponent("InputField")
	self._minX = self._debug:Find("x_min"):GetComponent("InputField")
	self._manX = self._debug:Find("x_max"):GetComponent("InputField")
	self._minZ = self._debug:Find("z_min"):GetComponent("InputField")
	self._manZ = self._debug:Find("z_max"):GetComponent("InputField")

	onButton(nil, self._summon, function()
		self:spawnEnemy(tonumber(self._summonID.text), tonumber(self._minX.text), tonumber(self._manX.text), tonumber(self._minZ.text), (tonumber(self._manZ.text)))

		return
	end, SFX_PANEL)

	self._killAllEnemy = self._debug:Find("clear_enemy")

	onButton(nil, self._killAllEnemy, function()
		self._dataProxy:KillAllEnemy()

		return
	end, SFX_PANEL)

	self._summonStrike = self._debug:Find("spawn_strike")
	self._summonStrikeID = self._debug:Find("air_model_id"):GetComponent("InputField")
	self._summonStrikeTotal = self._debug:Find("total"):GetComponent("InputField")
	self._summonStrikeSingular = self._debug:Find("once"):GetComponent("InputField")
	self._summonStrikeInterval = self._debug:Find("interval"):GetComponent("InputField")

	onButton(nil, self._summonStrike, function()
		self:spawnStrike(tonumber(self._summonStrikeID.text), tonumber(self._summonStrikeTotal.text), tonumber(self._summonStrikeSingular.text), (tonumber(self._summonStrikeInterval.text)))

		return
	end, SFX_PANEL)

	self._killAllStrike = self._debug:Find("clear_strike")

	onButton(nil, self._killAllStrike, function()
		self._dataProxy:KillAllAirStrike()

		return
	end, SFX_PANEL)

	self._blockCld = self._debug:Find("all_cld")
	self._blockPlayerWeapon = self._debug:Find("player_weapon")
	self._blockMonsterWeapon = self._debug:Find("monster_weapon")
	self._blockMonsterAI = self._debug:Find("monster_motion")

	onToggle(nil, self._blockCld, function(arg_8_0)
		self._dataProxy.Update = arg_8_0 and var_0_3.ProxyUpdateNormal or self._dataProxy.__debug__BlockCldUpdate__

		return
	end, SFX_PANEL)
	onToggle(nil, self._blockPlayerWeapon, function(arg_9_0)
		self._autoComponentFuncList.updatePlayerWeapon = arg_9_0 and self._updatePlayerWeapon or nil

		return
	end, SFX_PANEL)
	onToggle(nil, self._blockMonsterWeapon, function(arg_10_0)
		self._autoComponentFuncList.updateMonsterWeapon = arg_10_0 and self._updateMonsterWeapon or nil

		return
	end, SFX_PANEL)
	onToggle(nil, self._blockMonsterAI, function(arg_11_0)
		self._autoComponentFuncList.updateMonsterAI = arg_11_0 and self._updateMonsterAI or nil

		return
	end, SFX_PANEL)

	self._setDungeonLevel = self._debug:Find("dungeon_level")
	self._dungeonLevel = self._debug:Find("level_input"):GetComponent("InputField")

	onButton(nil, self._setDungeonLevel, function()
		self._dataProxy:SetDungeonLevel(tonumber(self._dungeonLevel.text))

		return
	end, SFX_PANEL)

	self._clsBullet = self._debug:Find("cls_bullet")

	onButton(nil, self._clsBullet, function()
		self._dataProxy:CLSBullet(var_0_2.FRIENDLY_CODE)
		self._dataProxy:CLSBullet(var_0_2.FOE_CODE)

		return
	end, SFX_PANEL)

	return
end

function ys.Battle.BattleDebugConsole:initData()
	self._fleetList = self._dataProxy:GetFleetList()
	self._freeShipList = self._dataProxy:GetFreeShipList()
	self._monsterArray = {}

	for iter_14_0, iter_14_1 in ipairs(pg.enemy_data_statistics.all) do
		if type(iter_14_1) == "number" and iter_14_1 <= 0 then
			table.insert(self._monsterArray, iter_14_1)
		end
	end

	function self._updatePlayerWeapon(arg_15_0)
		for iter_15_0, iter_15_1 in pairs(self._fleetList) do
			iter_15_1:UpdateAutoComponent(arg_15_0)
		end

		return
	end

	function self._updateMonsterWeapon(arg_16_0)
		for iter_16_0, iter_16_1 in pairs(self._freeShipList) do
			iter_16_1:UpdateWeapon(arg_16_0)
		end

		return
	end

	function self._updateMonsterAI(arg_17_0)
		for iter_17_0, iter_17_1 in pairs(self._dataProxy._teamList) do
			if iter_17_1:IsFatalDamage() then
				self._dataProxy:KillNPCTeam(iter_17_0)
			else
				iter_17_1:UpdateMotion()
			end
		end

		return
	end

	self._autoComponentFuncList = {}
	self._autoComponentFuncList.updatePlayerWeapon = self._updatePlayerWeapon
	self._autoComponentFuncList.updateMonsterWeapon = self._updateMonsterWeapon
	self._autoComponentFuncList.updateMonsterAI = self._updateMonsterAI

	function self._dataProxy.UpdateAutoComponent(arg_18_0, arg_18_1)
		for iter_18_0, iter_18_1 in pairs(self._autoComponentFuncList) do
			iter_18_1(arg_18_1)
		end

		return
	end

	return
end

function ys.Battle.BattleDebugConsole:initComponent()
	self._base = self._go:Find("bg")
	self._common = self._base:Find("common")
	self._debug = self._base:Find("debug")
	self._exitBtn = self._common:Find("close")

	onButton(nil, self._exitBtn, function()
		self:SetActive(false)

		return
	end, SFX_PANEL)

	self._activeReference = self._common:Find("reference_switch")

	onButton(nil, self._activeReference, function()
		self:activeReference()

		return
	end, SFX_PANEL)

	self._lockCommonDMG = self._common:Find("common_damage")
	self._lockS2MDMG = self._common:Find("ship2main_damage")
	self._lockA2MDMG = self._common:Find("aircraft2main_damage")
	self._lockCrushDMG = self._common:Find("crush_damage")

	onToggle(nil, self._lockCommonDMG, function(arg_22_0)
		self._dataProxy:SetupCalculateDamage((arg_22_0 or nil) and (var_0_0.Battle.BattleFormulas.CalcDamageLock or nil))

		return
	end, SFX_PANEL)
	onToggle(nil, self._lockS2MDMG, function(arg_23_0)
		self._dataProxy:SetupDamageKamikazeAir((arg_23_0 or nil) and (var_0_0.Battle.BattleFormulas.CalcDamageLockA2M or nil))

		return
	end, SFX_PANEL)
	onToggle(nil, self._lockA2MDMG, function(arg_24_0)
		self._dataProxy:SetupDamageKamikazeShip((arg_24_0 or nil) and (var_0_0.Battle.BattleFormulas.CalcDamageLockS2M or nil))

		return
	end, SFX_PANEL)
	onToggle(nil, self._lockCrushDMG, function(arg_25_0)
		self._dataProxy:SetupDamageCrush((arg_25_0 or nil) and (var_0_0.Battle.BattleFormulas.CalcDamageLockCrush or nil))

		return
	end, SFX_PANEL)

	self._triggerWave = self._common:Find("wave_trigger")
	self._waveIndex = self._common:Find("wave_input"):GetComponent("InputField")

	if self._dataProxy:GetInitData().battleType ~= SYSTEM_SCENARIO and self._dataProxy:GetInitData().battleType ~= SYSTEM_ROUTINE and self._dataProxy:GetInitData().battleType ~= SYSTEM_ACT_BOSS then
		SetActive(self._triggerWave, false)
		SetActive(self._waveIndex, false)
	else
		onButton(nil, self._triggerWave, function()
			self:forceTrigger(tonumber(self._waveIndex.text))

			return
		end)
	end

	self._triggerWeather = self._common:Find("weather_trigger")
	self._weatherInput = self._common:Find("weather_input"):GetComponent("InputField")

	onButton(nil, self._triggerWeather, function()
		self._dataProxy:AddWeather(tonumber(self._weatherInput.text))

		return
	end)

	self._antiSubDetailRange = self._common:Find("anti_sub_detail")

	onButton(nil, self._antiSubDetailRange, function()
		self._state:GetMediatorByName("BattleSceneMediator"):InitDetailAntiSubArea()

		return
	end)

	self._instantReload = self._common:Find("instant_reload")

	onButton(nil, self._instantReload, function()
		local function var_29_0(arg_30_0)
			for iter_30_0, iter_30_1 in ipairs((arg_30_0:GetWeaponList())) do
				iter_30_1:QuickCoolDown()
			end

			return
		end

		var_29_0(self._dataProxy._fleetList[1]:GetChargeWeaponVO())
		var_29_0(self._dataProxy._fleetList[1]:GetTorpedoWeaponVO())
		var_29_0(self._dataProxy._fleetList[1]:GetAirAssistVO())

		return
	end)

	self._white = self._base:Find("white_button")

	onButton(nil, self._white, function()
		self._dataProxy._fleetList[1]._scoutList[1]:UpdateHP(-20, {})

		return
	end, SFX_PANEL)
	SetActive(self._white, true)

	return
end

function ys.Battle.BattleDebugConsole:SetActive(arg_32_1)
	SetActive(self._go, arg_32_1)

	return
end

function ys.Battle.BattleDebugConsole:spawnEnemy(arg_33_1, arg_33_2, arg_33_3, arg_33_4, arg_33_5)
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

	self._dataProxy:SpawnMonster(var_33_0, 1, var_0_1.UnitType.ENEMY_UNIT, var_0_2.FOE_CODE)

	return
end

function ys.Battle.BattleDebugConsole:spawnStrike(arg_34_1, arg_34_2, arg_34_3, arg_34_4)
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

	self._dataProxy:SpawnAirFighter(var_34_0)

	return
end

function ys.Battle.BattleDebugConsole:activeReference()
	self._state:ActiveReference()

	local var_35_0 = self._state:GetMediatorByName(var_0_0.Battle.BattleReferenceBoxMediator.__name) or self._state:AddMediator(var_0_0.Battle.BattleReferenceBoxMediator.New())

	pg.TipsMgr.GetInstance():ShowTips("┏━━━━━━━━━━━━━━━━━━━┓")
	pg.TipsMgr.GetInstance():ShowTips("┃ヽ(•̀ω•́ )ゝ战斗调试模块初始化成功！(ง •̀_•́)ง┃")
	pg.TipsMgr.GetInstance():ShowTips("┗━━━━━━━━━━━━━━━━━━━┛")

	self._activeReference.transform:GetComponent("Button").enabled = false
	self._activeReference:Find("text"):GetComponent(typeof(Text)).text = "(ﾉ･ω･)ﾉﾞ"
	self._referenceConsole = self._common:Find("reference_btns")

	SetActive(self._referenceConsole, true)

	self._speedUp = self._referenceConsole:Find("speed_up")
	self._speedDown = self._referenceConsole:Find("speed_down")
	self._speedLevel = self._referenceConsole:Find("speed")

	onButton(nil, self._speedUp, function()
		if var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE < 1 then
			var_0_0.Battle.BattleControllerCommand.removeSpeed(2)
		elseif var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE >= 1 then
			var_0_0.Battle.BattleControllerCommand.addSpeed(2)
		end

		self._speedLevel:GetComponent(typeof(Text)).text = var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE

		self._state:ScaleTimer()

		return
	end, SFX_PANEL)
	onButton(nil, self._speedDown, function()
		if var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE > 1 then
			var_0_0.Battle.BattleControllerCommand.removeSpeed(0.5)
		elseif var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE <= 1 then
			var_0_0.Battle.BattleControllerCommand.addSpeed(0.5)
		end

		self._speedLevel:GetComponent(typeof(Text)).text = var_0_0.Battle.BattleConfig.BASIC_TIME_SCALE

		self._state:ScaleTimer()

		return
	end, SFX_PANEL)

	self._shipBox = self._referenceConsole:Find("ship_box")
	self._bulletBox = self._referenceConsole:Find("bullet_box")
	self._pp = self._referenceConsole:Find("property_panel")

	onToggle(nil, self._shipBox, function(arg_38_0)
		var_35_0:ActiveUnitBoxes(arg_38_0)

		return
	end, SFX_PANEL)
	onToggle(nil, self._bulletBox, function(arg_39_0)
		var_35_0:ActiveBulletBoxes(arg_39_0)

		return
	end, SFX_PANEL)
	onToggle(nil, self._pp, function(arg_40_0)
		var_35_0:ActiveUnitDetail(arg_40_0)

		return
	end, SFX_PANEL)

	return
end

function ys.Battle.BattleDebugConsole:forceTrigger(arg_41_1)
	local var_41_0 = self._state:GetCommandByName("BattleSingleDungeonCommand")._waveUpdater._waveInfoList[arg_41_1]

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
