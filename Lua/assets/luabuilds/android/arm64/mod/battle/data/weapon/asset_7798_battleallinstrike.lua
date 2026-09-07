ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleFormulas
local var_0_3 = ys.Battle.BattleUnitEvent
local var_0_4 = ys.Battle.BattleDataFunction
local var_0_5 = ys.Battle.BattleAttr

ys.Battle.BattleAllInStrike = class("BattleAllInStrike")

local var_0_6 = ys.Battle.BattleAllInStrike

ys.Battle.BattleAllInStrike.__name = "BattleAllInStrike"
ys.Battle.BattleAllInStrike.EMITTER_NORMAL = "BattleBulletEmitter"
ys.Battle.BattleAllInStrike.EMITTER_SHOTGUN = "BattleShotgunEmitter"
ys.Battle.BattleAllInStrike.STATE_DISABLE = "DISABLE"
ys.Battle.BattleAllInStrike.STATE_READY = "READY"
ys.Battle.BattleAllInStrike.STATE_PRECAST = "PRECAST"
ys.Battle.BattleAllInStrike.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
ys.Battle.BattleAllInStrike.STATE_ATTACK = "ATTACK"
ys.Battle.BattleAllInStrike.STATE_OVER_HEAT = "OVER_HEAT"

function ys.Battle.BattleAllInStrike.Ctor(arg_1_0, arg_1_1)
	var_0_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._skill = var_0_0.Battle.BattleSkillUnit.New(arg_1_1)
	arg_1_0._skillID = arg_1_1
	arg_1_0._reloadFacotrList = {}
	arg_1_0._reloadBoostList = {}
	arg_1_0._jammingTime = 0

	return
end

function ys.Battle.BattleAllInStrike:Update()
	self:UpdateReload()

	return
end

function ys.Battle.BattleAllInStrike:UpdateReload()
	if self._CDstartTime and not self._jammingStartTime then
		if self:GetReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime() then
			self:handleCoolDown()
		else
			return
		end
	end

	return
end

function ys.Battle.BattleAllInStrike:Clear()
	self._skill:Clear()

	return
end

function ys.Battle.BattleAllInStrike.Dispose(arg_5_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_5_0)

	return
end

function ys.Battle.BattleAllInStrike:SetHost(arg_6_1)
	self._host = arg_6_1

	local var_6_0

	self._hiveList = arg_6_1:GetHiveList()

	for iter_6_0, iter_6_1 in ipairs(self._hiveList) do
		local var_6_1 = iter_6_1:GetSkinID()

		if var_6_1 then
			local var_6_2, var_6_3, var_6_4, var_6_5 = var_0_4.GetEquipSkin(var_6_1)

			if var_6_5 then
				var_6_0 = var_6_5

				break
			end
		end
	end

	if var_6_0 and var_6_0 ~= "" then
		for iter_6_2, iter_6_3 in ipairs((self._skill:GetSkillEffectList())) do
			if iter_6_3.__name == var_0_0.Battle.BattleSkillFire.__name then
				iter_6_3:SetWeaponSkin(var_6_0)
			end
		end
	end

	self:FlushTotalReload()
	self:FlushReloadMax(1)

	return
end

function ys.Battle.BattleAllInStrike:FlushTotalReload()
	self._totalReload = var_0_2.CaclulateAirAssistReloadMax(self._hiveList)

	return
end

function ys.Battle.BattleAllInStrike:FlushReloadMax(arg_8_1)
	arg_8_1 = arg_8_1 or 1
	self._reloadMax = self._totalReload * arg_8_1

	if not self._CDstartTime or self._reloadRequire == 0 then
		return true
	end

	self._reloadRequire = var_0_0.Battle.BattleWeaponUnit:FlushRequireByInverse((var_0_5.GetCurrent(self._host, "loadSpeed")))

	self._allInWeaponVo:RefreshReloadingBar()

	return
end

function ys.Battle.BattleAllInStrike:AppendReloadFactor(arg_9_1, arg_9_2)
	self._reloadFacotrList[arg_9_1] = arg_9_2

	return
end

function ys.Battle.BattleAllInStrike:RemoveReloadFactor(arg_10_1)
	if self._reloadFacotrList[arg_10_1] then
		self._reloadFacotrList[arg_10_1] = nil
	end

	return
end

function ys.Battle.BattleAllInStrike:GetReloadFactorList()
	return self._reloadFacotrList
end

function ys.Battle.BattleAllInStrike.SetAllInWeaponVO(arg_12_0, arg_12_1)
	arg_12_0._allInWeaponVo = arg_12_1
	arg_12_0._currentState = var_0_6.STATE_READY

	return
end

function ys.Battle.BattleAllInStrike:GetCurrentState()
	return self._currentState
end

function ys.Battle.BattleAllInStrike:GetHost()
	return self._host
end

function ys.Battle.BattleAllInStrike.GetType(arg_15_0)
	return var_0_1.EquipmentType.AIR_ASSIST
end

function ys.Battle.BattleAllInStrike:Fire()
	if self._host:IsCease() then
		return false
	else
		self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE_STEADY, {})

		for iter_16_0, iter_16_1 in ipairs(self._hiveList) do
			iter_16_1:SingleFire()
		end

		self._skill:Cast(self._host)
		self._host:StrikeExpose()
		self._host:StateChange(var_0_0.Battle.UnitState.STATE_ATTACK, "attack")
		self:DispatchEvent(var_0_0.Event.New(var_0_3.MANUAL_WEAPON_FIRE, {}))
		self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE, {})
	end

	return true
end

function ys.Battle.BattleAllInStrike:TriggerBuffOnReady()
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_AIR_ASSIST_READY, {})

	return
end

function ys.Battle.BattleAllInStrike:SingleFire()
	for iter_18_0, iter_18_1 in ipairs(self._hiveList) do
		iter_18_1:SingleFire()
	end

	self._skill:Cast(self._host)
	self._host:StrikeExpose()
	self._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE, {})

	return
end

function ys.Battle.BattleAllInStrike:GetReloadTime()
	local var_19_0 = var_0_5.GetCurrent(self._host, "loadSpeed")

	if self._reloadMax ~= self._cacheReloadMax or var_19_0 ~= self._cacheHostReload then
		self._cacheReloadMax = self._reloadMax
		self._cacheHostReload = var_19_0
		self._cacheReloadTime = var_0_2.CalculateReloadTime(self._reloadMax, var_0_5.GetCurrent(self._host, "loadSpeed"))
	end

	return self._cacheReloadTime
end

function ys.Battle.BattleAllInStrike:GetReloadTimeByRate(arg_20_1)
	return (var_0_2.CalculateReloadTime(self._cacheReloadMax * arg_20_1, (var_0_5.GetCurrent(self._host, "loadSpeed"))))
end

function ys.Battle.BattleAllInStrike.SetModifyInitialCD(arg_21_0)
	arg_21_0._modInitCD = true

	return
end

function ys.Battle.BattleAllInStrike:GetModifyInitialCD()
	return self._modInitCD
end

function ys.Battle.BattleAllInStrike:InitialCD()
	self:AddCDTimer(self:GetReloadTime())
	self._allInWeaponVo:InitialDeduct(self)
	self._allInWeaponVo:Charge(self)

	return
end

function ys.Battle.BattleAllInStrike:EnterCoolDown()
	self:AddCDTimer(self:GetReloadTime())
	self._allInWeaponVo:Charge(self)

	return
end

function ys.Battle.BattleAllInStrike:OverHeat()
	self._currentState = self.STATE_OVER_HEAT

	self._allInWeaponVo:Deduct(self)

	return
end

function ys.Battle.BattleAllInStrike.AddCDTimer(arg_26_0, arg_26_1)
	arg_26_0._currentState = var_0_6.STATE_OVER_HEAT
	arg_26_0._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_26_0._reloadRequire = arg_26_1

	return
end

function ys.Battle.BattleAllInStrike:GetCDStartTimeStamp()
	return self._CDstartTime
end

function ys.Battle.BattleAllInStrike:handleCoolDown()
	self._currentState = var_0_6.STATE_READY

	self._allInWeaponVo:Plus(self)
	self:DispatchEvent(var_0_0.Event.New(var_0_3.MANUAL_WEAPON_READY, {}))
	self:TriggerBuffOnReady()

	self._CDstartTime = nil
	self._jammingTime = 0
	self._reloadBoostList = {}

	return
end

function ys.Battle.BattleAllInStrike:FlushReloadRequire()
	if not self._CDstartTime or self._reloadRequire == 0 then
		return true
	end

	self._reloadRequire = var_0_0.Battle.BattleWeaponUnit:FlushRequireByInverse((var_0_2.CaclulateReloadAttr(self._reloadMax, self._reloadRequire)))

	self._allInWeaponVo:RefreshReloadingBar()

	return
end

function ys.Battle.BattleAllInStrike:QuickCoolDown()
	if self._currentState == self.STATE_OVER_HEAT then
		self._currentState = var_0_6.STATE_READY

		self._allInWeaponVo:InstantCoolDown(self)
		self:DispatchEvent(var_0_0.Event.New(var_0_3.MANUAL_WEAPON_INSTANT_READY, {}))

		self._CDstartTime = nil
		self._reloadBoostList = {}
	end

	return
end

function ys.Battle.BattleAllInStrike:ReloadBoost(arg_31_1)
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(self._reloadBoostList) do
		var_31_0 = var_31_0 + iter_31_1
	end

	local var_31_1 = var_31_0 + arg_31_1

	fixValue = (var_31_0 + arg_31_1 < 0 and math.max(var_31_1, (self._reloadRequire - (pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingTime - self._CDstartTime)) * -1) or math.min(var_31_1, pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingTime - self._CDstartTime)) - var_31_1 + arg_31_1

	table.insert(self._reloadBoostList, fixValue)

	return
end

function ys.Battle.BattleAllInStrike:AppendReloadBoost(arg_32_1)
	if self._currentState == self.STATE_OVER_HEAT then
		self._allInWeaponVo:ReloadBoost(self, arg_32_1)
	end

	return
end

function ys.Battle.BattleAllInStrike:GetReloadFinishTimeStamp()
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(self._reloadBoostList) do
		var_33_0 = var_33_0 + iter_33_1
	end

	return self._reloadRequire + self._CDstartTime + self._jammingTime + var_33_0
end

function ys.Battle.BattleAllInStrike.StartJamming(arg_34_0)
	arg_34_0._jammingStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function ys.Battle.BattleAllInStrike:JammingEliminate()
	if not self._jammingStartTime then
		return
	end

	self._jammingTime = pg.TimeMgr.GetInstance():GetCombatTime() - self._jammingStartTime
	self._jammingStartTime = nil

	return
end

function ys.Battle.BattleAllInStrike:CLSBullet()
	var_0_0.Battle.BattleDataProxy.GetInstance():CLSBullet(self._host:GetIFF() * -1, true)

	return
end

function ys.Battle.BattleAllInStrike:DispatchBlink(arg_37_1)
	self:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CHARGE_WEAPON_FINISH, {
		callbackFunc = arg_37_1,
		timeScale = var_0_0.Battle.BattleConfig.FOCUS_MAP_RATE
	})))

	return
end

function ys.Battle.BattleAllInStrike:GetReloadRate()
	if self._currentState == self.STATE_READY then
		return 0
	elseif self._CDstartTime then
		return (self:GetReloadFinishTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime()) / self._reloadRequire
	else
		return 1
	end

	return
end

function ys.Battle.BattleAllInStrike:GetDamageSUM()
	local var_39_0 = 0
	local var_39_1 = 0

	for iter_39_0, iter_39_1 in ipairs(self._hiveList) do
		for iter_39_2, iter_39_3 in ipairs(iter_39_1:GetATKAircraftList()) do
			for iter_39_4, iter_39_5 in ipairs((iter_39_3:GetWeapon())) do
				var_39_0 = var_39_0 + iter_39_5:GetDamageSUM()
			end
		end
	end

	for iter_39_6, iter_39_7 in ipairs((self._skill:GetSkillEffectList())) do
		local var_39_2 = iter_39_7:GetDamageSum()

		if var_39_2 then
			var_39_1 = var_39_1 + var_39_2
		end
	end

	return var_39_0, var_39_1
end

function ys.Battle.BattleAllInStrike:GetStrikeSkillID()
	return self._skillID
end

return
