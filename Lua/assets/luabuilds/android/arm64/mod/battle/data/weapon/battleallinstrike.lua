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

function ys.Battle.BattleAllInStrike.Update(arg_2_0)
	arg_2_0:UpdateReload()

	return
end

function ys.Battle.BattleAllInStrike.UpdateReload(arg_3_0)
	if arg_3_0._CDstartTime and not arg_3_0._jammingStartTime then
		if arg_3_0:GetReloadFinishTimeStamp() <= pg.TimeMgr.GetInstance():GetCombatTime() then
			arg_3_0:handleCoolDown()
		else
			return
		end
	end

	return
end

function ys.Battle.BattleAllInStrike.Clear(arg_4_0)
	arg_4_0._skill:Clear()

	return
end

function ys.Battle.BattleAllInStrike.Dispose(arg_5_0)
	var_0_0.EventDispatcher.DetachEventDispatcher(arg_5_0)

	return
end

function ys.Battle.BattleAllInStrike.SetHost(arg_6_0, arg_6_1)
	arg_6_0._host = arg_6_1

	local var_6_0

	arg_6_0._hiveList = arg_6_1:GetHiveList()

	for iter_6_0, iter_6_1 in ipairs(arg_6_0._hiveList) do
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
		for iter_6_2, iter_6_3 in ipairs((arg_6_0._skill:GetSkillEffectList())) do
			if iter_6_3.__name == var_0_0.Battle.BattleSkillFire.__name then
				iter_6_3:SetWeaponSkin(var_6_0)
			end
		end
	end

	arg_6_0:FlushTotalReload()
	arg_6_0:FlushReloadMax(1)

	return
end

function ys.Battle.BattleAllInStrike.FlushTotalReload(arg_7_0)
	arg_7_0._totalReload = var_0_2.CaclulateAirAssistReloadMax(arg_7_0._hiveList)

	return
end

function ys.Battle.BattleAllInStrike.FlushReloadMax(arg_8_0, arg_8_1)
	arg_8_1 = arg_8_1 or 1
	arg_8_0._reloadMax = arg_8_0._totalReload * arg_8_1

	if not arg_8_0._CDstartTime or arg_8_0._reloadRequire == 0 then
		return true
	end

	arg_8_0._reloadRequire = var_0_0.Battle.BattleWeaponUnit.FlushRequireByInverse(arg_8_0, (var_0_5.GetCurrent(arg_8_0._host, "loadSpeed")))

	arg_8_0._allInWeaponVo:RefreshReloadingBar()

	return
end

function ys.Battle.BattleAllInStrike.AppendReloadFactor(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._reloadFacotrList[arg_9_1] = arg_9_2

	return
end

function ys.Battle.BattleAllInStrike.RemoveReloadFactor(arg_10_0, arg_10_1)
	if arg_10_0._reloadFacotrList[arg_10_1] then
		arg_10_0._reloadFacotrList[arg_10_1] = nil
	end

	return
end

function ys.Battle.BattleAllInStrike.GetReloadFactorList(arg_11_0)
	return arg_11_0._reloadFacotrList
end

function ys.Battle.BattleAllInStrike.SetAllInWeaponVO(arg_12_0, arg_12_1)
	arg_12_0._allInWeaponVo = arg_12_1
	arg_12_0._currentState = var_0_6.STATE_READY

	return
end

function ys.Battle.BattleAllInStrike.GetCurrentState(arg_13_0)
	return arg_13_0._currentState
end

function ys.Battle.BattleAllInStrike.GetHost(arg_14_0)
	return arg_14_0._host
end

function ys.Battle.BattleAllInStrike.GetType(arg_15_0)
	return var_0_1.EquipmentType.AIR_ASSIST
end

function ys.Battle.BattleAllInStrike.Fire(arg_16_0)
	if arg_16_0._host:IsCease() then
		return false
	else
		arg_16_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE_STEADY, {})

		for iter_16_0, iter_16_1 in ipairs(arg_16_0._hiveList) do
			iter_16_1:SingleFire()
		end

		arg_16_0._skill:Cast(arg_16_0._host)
		arg_16_0._host:StrikeExpose()
		arg_16_0._host:StateChange(var_0_0.Battle.UnitState.STATE_ATTACK, "attack")
		arg_16_0:DispatchEvent(var_0_0.Event.New(var_0_3.MANUAL_WEAPON_FIRE, {}))
		arg_16_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE, {})
	end

	return true
end

function ys.Battle.BattleAllInStrike.TriggerBuffOnReady(arg_17_0)
	arg_17_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_AIR_ASSIST_READY, {})

	return
end

function ys.Battle.BattleAllInStrike.SingleFire(arg_18_0)
	for iter_18_0, iter_18_1 in ipairs(arg_18_0._hiveList) do
		iter_18_1:SingleFire()
	end

	arg_18_0._skill:Cast(arg_18_0._host)
	arg_18_0._host:StrikeExpose()
	arg_18_0._host:TriggerBuff(var_0_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE, {})

	return
end

function ys.Battle.BattleAllInStrike.GetReloadTime(arg_19_0)
	local var_19_0 = var_0_5.GetCurrent(arg_19_0._host, "loadSpeed")

	if arg_19_0._reloadMax ~= arg_19_0._cacheReloadMax or var_19_0 ~= arg_19_0._cacheHostReload then
		arg_19_0._cacheReloadMax = arg_19_0._reloadMax
		arg_19_0._cacheHostReload = var_19_0
		arg_19_0._cacheReloadTime = var_0_2.CalculateReloadTime(arg_19_0._reloadMax, var_0_5.GetCurrent(arg_19_0._host, "loadSpeed"))
	end

	return arg_19_0._cacheReloadTime
end

function ys.Battle.BattleAllInStrike.GetReloadTimeByRate(arg_20_0, arg_20_1)
	return (var_0_2.CalculateReloadTime(arg_20_0._cacheReloadMax * arg_20_1, (var_0_5.GetCurrent(arg_20_0._host, "loadSpeed"))))
end

function ys.Battle.BattleAllInStrike.SetModifyInitialCD(arg_21_0)
	arg_21_0._modInitCD = true

	return
end

function ys.Battle.BattleAllInStrike.GetModifyInitialCD(arg_22_0)
	return arg_22_0._modInitCD
end

function ys.Battle.BattleAllInStrike.InitialCD(arg_23_0)
	arg_23_0:AddCDTimer(arg_23_0:GetReloadTime())
	arg_23_0._allInWeaponVo:InitialDeduct(arg_23_0)
	arg_23_0._allInWeaponVo:Charge(arg_23_0)

	return
end

function ys.Battle.BattleAllInStrike.EnterCoolDown(arg_24_0)
	arg_24_0:AddCDTimer(arg_24_0:GetReloadTime())
	arg_24_0._allInWeaponVo:Charge(arg_24_0)

	return
end

function ys.Battle.BattleAllInStrike.OverHeat(arg_25_0)
	arg_25_0._currentState = arg_25_0.STATE_OVER_HEAT

	arg_25_0._allInWeaponVo:Deduct(arg_25_0)

	return
end

function ys.Battle.BattleAllInStrike.AddCDTimer(arg_26_0, arg_26_1)
	arg_26_0._currentState = var_0_6.STATE_OVER_HEAT
	arg_26_0._CDstartTime = pg.TimeMgr.GetInstance():GetCombatTime()
	arg_26_0._reloadRequire = arg_26_1

	return
end

function ys.Battle.BattleAllInStrike.GetCDStartTimeStamp(arg_27_0)
	return arg_27_0._CDstartTime
end

function ys.Battle.BattleAllInStrike.handleCoolDown(arg_28_0)
	arg_28_0._currentState = var_0_6.STATE_READY

	arg_28_0._allInWeaponVo:Plus(arg_28_0)
	arg_28_0:DispatchEvent(var_0_0.Event.New(var_0_3.MANUAL_WEAPON_READY, {}))
	arg_28_0:TriggerBuffOnReady()

	arg_28_0._CDstartTime = nil
	arg_28_0._jammingTime = 0
	arg_28_0._reloadBoostList = {}

	return
end

function ys.Battle.BattleAllInStrike.FlushReloadRequire(arg_29_0)
	if not arg_29_0._CDstartTime or arg_29_0._reloadRequire == 0 then
		return true
	end

	arg_29_0._reloadRequire = var_0_0.Battle.BattleWeaponUnit.FlushRequireByInverse(arg_29_0, (var_0_2.CaclulateReloadAttr(arg_29_0._reloadMax, arg_29_0._reloadRequire)))

	arg_29_0._allInWeaponVo:RefreshReloadingBar()

	return
end

function ys.Battle.BattleAllInStrike.QuickCoolDown(arg_30_0)
	if arg_30_0._currentState == arg_30_0.STATE_OVER_HEAT then
		arg_30_0._currentState = var_0_6.STATE_READY

		arg_30_0._allInWeaponVo:InstantCoolDown(arg_30_0)
		arg_30_0:DispatchEvent(var_0_0.Event.New(var_0_3.MANUAL_WEAPON_INSTANT_READY, {}))

		arg_30_0._CDstartTime = nil
		arg_30_0._reloadBoostList = {}
	end

	return
end

function ys.Battle.BattleAllInStrike.ReloadBoost(arg_31_0, arg_31_1)
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in ipairs(arg_31_0._reloadBoostList) do
		var_31_0 = var_31_0 + iter_31_1
	end

	local var_31_1 = var_31_0 + arg_31_1
	local var_31_2 = var_31_0 + arg_31_1 < 0 and math.max(var_31_1, (arg_31_0._reloadRequire - (pg.TimeMgr.GetInstance():GetCombatTime() - arg_31_0._jammingTime - arg_31_0._CDstartTime)) * -1) or math.min(var_31_1, pg.TimeMgr.GetInstance():GetCombatTime() - arg_31_0._jammingTime - arg_31_0._CDstartTime)

	fixValue = var_31_2 - var_31_1 + arg_31_1

	table.insert(arg_31_0._reloadBoostList, fixValue)

	return
end

function ys.Battle.BattleAllInStrike.AppendReloadBoost(arg_32_0, arg_32_1)
	if arg_32_0._currentState == arg_32_0.STATE_OVER_HEAT then
		arg_32_0._allInWeaponVo:ReloadBoost(arg_32_0, arg_32_1)
	end

	return
end

function ys.Battle.BattleAllInStrike.GetReloadFinishTimeStamp(arg_33_0)
	local var_33_0 = 0

	for iter_33_0, iter_33_1 in ipairs(arg_33_0._reloadBoostList) do
		var_33_0 = var_33_0 + iter_33_1
	end

	return arg_33_0._reloadRequire + arg_33_0._CDstartTime + arg_33_0._jammingTime + var_33_0
end

function ys.Battle.BattleAllInStrike.StartJamming(arg_34_0)
	arg_34_0._jammingStartTime = pg.TimeMgr.GetInstance():GetCombatTime()

	return
end

function ys.Battle.BattleAllInStrike.JammingEliminate(arg_35_0)
	if not arg_35_0._jammingStartTime then
		return
	end

	local var_35_0 = pg.TimeMgr.GetInstance()

	arg_35_0._jammingTime = var_35_0:GetCombatTime() - arg_35_0._jammingStartTime
	arg_35_0._jammingStartTime = nil

	return
end

function ys.Battle.BattleAllInStrike.CLSBullet(arg_36_0)
	var_0_0.Battle.BattleDataProxy.GetInstance():CLSBullet(arg_36_0._host:GetIFF() * -1, true)

	return
end

function ys.Battle.BattleAllInStrike.DispatchBlink(arg_37_0, arg_37_1)
	arg_37_0:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CHARGE_WEAPON_FINISH, {
		callbackFunc = arg_37_1,
		timeScale = var_0_0.Battle.BattleConfig.FOCUS_MAP_RATE
	})))

	return
end

function ys.Battle.BattleAllInStrike.GetReloadRate(arg_38_0)
	if arg_38_0._currentState == arg_38_0.STATE_READY then
		return 0
	elseif arg_38_0._CDstartTime then
		return (arg_38_0:GetReloadFinishTimeStamp() - pg.TimeMgr.GetInstance():GetCombatTime()) / arg_38_0._reloadRequire
	else
		return 1
	end

	return
end

function ys.Battle.BattleAllInStrike.GetDamageSUM(arg_39_0)
	local var_39_0 = 0
	local var_39_1 = 0

	for iter_39_0, iter_39_1 in ipairs(arg_39_0._hiveList) do
		for iter_39_2, iter_39_3 in ipairs(iter_39_1:GetATKAircraftList()) do
			for iter_39_4, iter_39_5 in ipairs((iter_39_3:GetWeapon())) do
				var_39_0 = var_39_0 + iter_39_5:GetDamageSUM()
			end
		end
	end

	for iter_39_6, iter_39_7 in ipairs((arg_39_0._skill:GetSkillEffectList())) do
		local var_39_2 = iter_39_7:GetDamageSum()

		if var_39_2 then
			var_39_1 = var_39_1 + var_39_2
		end
	end

	return var_39_0, var_39_1
end

function ys.Battle.BattleAllInStrike.GetStrikeSkillID(arg_40_0)
	return arg_40_0._skillID
end

return
