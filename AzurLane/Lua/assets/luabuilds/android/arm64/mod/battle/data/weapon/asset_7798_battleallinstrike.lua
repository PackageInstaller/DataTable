ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleFormulas
local var_0_3 = var_0.Battle.BattleUnitEvent
local var_0_4 = var_0.Battle.BattleDataFunction
local var_0_5 = var_0.Battle.BattleAttr
local var_0_6 = var_0.Battle

class = var_0_10007
var_0_6.BattleAllInStrike = var_0_10007("BattleAllInStrike")

local var_0_7 = var_0.Battle.BattleAllInStrike

var_0_7.__name = "BattleAllInStrike"
var_0_7.EMITTER_NORMAL = "BattleBulletEmitter"
var_0_7.EMITTER_SHOTGUN = "BattleShotgunEmitter"
var_0_7.STATE_DISABLE = "DISABLE"
var_0_7.STATE_READY = "READY"
var_0_7.STATE_PRECAST = "PRECAST"
var_0_7.STATE_PRECAST_FINISH = "STATE_PRECAST_FINISH"
var_0_7.STATE_ATTACK = "ATTACK"
var_0_7.STATE_OVER_HEAT = "OVER_HEAT"

function var_0_7.Ctor(arg_1_0, arg_1_1)
	var_0.EventDispatcher.AttachEventDispatcher(arg_1_0)

	arg_1_0._skill = var_0.Battle.BattleSkillUnit.New(arg_1_1)
	arg_1_0._skillID = arg_1_1
	arg_1_0._reloadFacotrList = {}
	arg_1_0._reloadBoostList = {}
	arg_1_0._jammingTime = 0

	return
end

function var_0_7.Update(arg_2_0)
	arg_2_0:UpdateReload()

	return
end

function var_0_7.UpdateReload(arg_3_0)
	if arg_3_0._CDstartTime and not arg_3_0._jammingStartTime then
		local var_3_0 = arg_3_0:GetReloadFinishTimeStamp()

		pg = var_1_10002

		local var_3_1 = var_1_10002.TimeMgr.GetInstance()

		if var_3_0 <= var_2.GetCombatTime(var_3_1) then
			arg_3_0:handleCoolDown()
		else
			return
		end
	end

	return
end

function var_0_7.Clear(arg_4_0)
	local var_4_0 = arg_4_0._skill

	var_1.Clear(var_4_0)

	return
end

function var_0_7.Dispose(arg_5_0)
	var_0.EventDispatcher.DetachEventDispatcher(arg_5_0)

	return
end

function var_0_7.SetHost(arg_6_0, arg_6_1)
	arg_6_0._host = arg_6_1

	local var_6_0

	arg_6_0._hiveList = arg_6_1:GetHiveList()
	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(arg_6_0._hiveList) do
		if iter_6_1:GetSkinID() then
			local var_6_1, var_6_2, var_6_3, var_6_4 = var_0_4.GetEquipSkin(var_8)

			if var_6_4 then
				var_6_0 = var_6_4

				break
			end
		end
	end

	if var_6_0 and var_6_0 ~= "" then
		local var_6_5 = arg_6_0._skill
		local var_6_6 = var_3.GetSkillEffectList(var_6_5)

		ipairs = var_4

		for iter_6_2, iter_6_3 in var_4(var_6_6) do
			if iter_6_3.__name == var_0.Battle.BattleSkillFire.__name then
				iter_6_3:SetWeaponSkin(var_6_0)
			end
		end
	end

	arg_6_0:FlushTotalReload()
	arg_6_0:FlushReloadMax(1)

	return
end

function var_0_7.FlushTotalReload(arg_7_0)
	arg_7_0._totalReload = var_0_2.CaclulateAirAssistReloadMax(arg_7_0._hiveList)

	return
end

function var_0_7.FlushReloadMax(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_0._totalReload

	arg_8_1 = arg_8_1 or 1
	arg_8_0._reloadMax = var_8_0 * arg_8_1

	if not arg_8_0._CDstartTime or arg_8_0._reloadRequire == 0 then
		return true
	end

	local var_8_1 = var_0_5.GetCurrent(arg_8_0._host, "loadSpeed")

	arg_8_0._reloadRequire = var_0.Battle.BattleWeaponUnit.FlushRequireByInverse(arg_8_0, var_8_1)

	local var_8_2 = arg_8_0._allInWeaponVo

	var_4.RefreshReloadingBar(var_8_2)

	return
end

function var_0_7.AppendReloadFactor(arg_9_0, arg_9_1, arg_9_2)
	arg_9_0._reloadFacotrList[arg_9_1] = arg_9_2

	return
end

function var_0_7.RemoveReloadFactor(arg_10_0, arg_10_1)
	if arg_10_0._reloadFacotrList[arg_10_1] then
		arg_10_0._reloadFacotrList[arg_10_1] = nil
	end

	return
end

function var_0_7.GetReloadFactorList(arg_11_0)
	return arg_11_0._reloadFacotrList
end

function var_0_7.SetAllInWeaponVO(arg_12_0, arg_12_1)
	arg_12_0._allInWeaponVo = arg_12_1
	arg_12_0._currentState = var_0_7.STATE_READY

	return
end

function var_0_7.GetCurrentState(arg_13_0)
	return arg_13_0._currentState
end

function var_0_7.GetHost(arg_14_0)
	return arg_14_0._host
end

function var_0_7.GetType(arg_15_0)
	return var_0_1.EquipmentType.AIR_ASSIST
end

function var_0_7.Fire(arg_16_0)
	local var_16_0 = arg_16_0._host

	if var_1.IsCease(var_16_0) then
		return false
	else
		local var_16_1 = arg_16_0._host

		var_1.TriggerBuff(var_16_1, var_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE_STEADY, {})

		ipairs = var_1

		for iter_16_0, iter_16_1 in var_1(arg_16_0._hiveList) do
			iter_16_1:SingleFire()
		end

		local var_16_2 = arg_16_0._skill

		var_1.Cast(var_16_2, arg_16_0._host)

		local var_16_3 = arg_16_0._host

		var_1.StrikeExpose(var_16_3)

		local var_16_4 = arg_16_0._host

		var_1.StateChange(var_16_4, var_0.Battle.UnitState.STATE_ATTACK, "attack")
		arg_16_0:DispatchEvent(var_0.Event.New(var_0_3.MANUAL_WEAPON_FIRE, {}))

		local var_16_5 = arg_16_0._host

		var_1.TriggerBuff(var_16_5, var_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE, {})
	end

	return true
end

function var_0_7.TriggerBuffOnReady(arg_17_0)
	local var_17_0 = arg_17_0._host

	var_1.TriggerBuff(var_17_0, var_0.Battle.BattleConst.BuffEffectType.ON_AIR_ASSIST_READY, {})

	return
end

function var_0_7.SingleFire(arg_18_0)
	ipairs = var_1_10001

	for iter_18_0, iter_18_1 in var_1_10001(arg_18_0._hiveList) do
		iter_18_1:SingleFire()
	end

	local var_18_0 = arg_18_0._skill

	var_1.Cast(var_18_0, arg_18_0._host)

	local var_18_1 = arg_18_0._host

	var_1.StrikeExpose(var_18_1)

	local var_18_2 = arg_18_0._host

	var_1.TriggerBuff(var_18_2, var_0.Battle.BattleConst.BuffEffectType.ON_ALL_IN_STRIKE, {})

	return
end

function var_0_7.GetReloadTime(arg_19_0)
	local var_19_0 = var_0_5.GetCurrent(arg_19_0._host, "loadSpeed")

	if arg_19_0._reloadMax ~= arg_19_0._cacheReloadMax or var_19_0 ~= arg_19_0._cacheHostReload then
		arg_19_0._cacheReloadMax = arg_19_0._reloadMax
		arg_19_0._cacheHostReload = var_19_0
		arg_19_0._cacheReloadTime = var_0_2.CalculateReloadTime(arg_19_0._reloadMax, var_0_5.GetCurrent(arg_19_0._host, "loadSpeed"))
	end

	return arg_19_0._cacheReloadTime
end

function var_0_7.GetReloadTimeByRate(arg_20_0, arg_20_1)
	local var_20_0 = var_0_5.GetCurrent(arg_20_0._host, "loadSpeed")
	local var_20_1 = arg_20_0._cacheReloadMax * arg_20_1

	return (var_0_2.CalculateReloadTime(var_20_1, var_20_0))
end

function var_0_7.SetModifyInitialCD(arg_21_0)
	arg_21_0._modInitCD = true

	return
end

function var_0_7.GetModifyInitialCD(arg_22_0)
	return arg_22_0._modInitCD
end

function var_0_7.InitialCD(arg_23_0)
	arg_23_0:AddCDTimer(arg_23_0:GetReloadTime())

	local var_23_0 = arg_23_0._allInWeaponVo

	var_1.InitialDeduct(var_23_0, arg_23_0)

	local var_23_1 = arg_23_0._allInWeaponVo

	var_1.Charge(var_23_1, arg_23_0)

	return
end

function var_0_7.EnterCoolDown(arg_24_0)
	arg_24_0:AddCDTimer(arg_24_0:GetReloadTime())

	local var_24_0 = arg_24_0._allInWeaponVo

	var_1.Charge(var_24_0, arg_24_0)

	return
end

function var_0_7.OverHeat(arg_25_0)
	arg_25_0._currentState = arg_25_0.STATE_OVER_HEAT

	local var_25_0 = arg_25_0._allInWeaponVo

	var_1.Deduct(var_25_0, arg_25_0)

	return
end

function var_0_7.AddCDTimer(arg_26_0, arg_26_1)
	arg_26_0._currentState = var_0_7.STATE_OVER_HEAT
	pg = var_2

	local var_26_0 = var_2.TimeMgr.GetInstance()

	arg_26_0._CDstartTime = var_2.GetCombatTime(var_26_0)
	arg_26_0._reloadRequire = arg_26_1

	return
end

function var_0_7.GetCDStartTimeStamp(arg_27_0)
	return arg_27_0._CDstartTime
end

function var_0_7.handleCoolDown(arg_28_0)
	arg_28_0._currentState = var_0_7.STATE_READY

	local var_28_0 = arg_28_0._allInWeaponVo

	var_1.Plus(var_28_0, arg_28_0)
	arg_28_0:DispatchEvent(var_0.Event.New(var_0_3.MANUAL_WEAPON_READY, {}))
	arg_28_0:TriggerBuffOnReady()

	arg_28_0._CDstartTime = nil
	arg_28_0._jammingTime = 0
	arg_28_0._reloadBoostList = {}

	return
end

function var_0_7.FlushReloadRequire(arg_29_0)
	if not arg_29_0._CDstartTime or arg_29_0._reloadRequire == 0 then
		return true
	end

	local var_29_0 = var_0_2.CaclulateReloadAttr(arg_29_0._reloadMax, arg_29_0._reloadRequire)

	arg_29_0._reloadRequire = var_0.Battle.BattleWeaponUnit.FlushRequireByInverse(arg_29_0, var_29_0)

	local var_29_1 = arg_29_0._allInWeaponVo

	var_2.RefreshReloadingBar(var_29_1)

	return
end

function var_0_7.QuickCoolDown(arg_30_0)
	if arg_30_0._currentState == arg_30_0.STATE_OVER_HEAT then
		arg_30_0._currentState = var_0_7.STATE_READY

		local var_30_0 = arg_30_0._allInWeaponVo

		var_1.InstantCoolDown(var_30_0, arg_30_0)
		arg_30_0:DispatchEvent(var_0.Event.New(var_0_3.MANUAL_WEAPON_INSTANT_READY, {}))

		arg_30_0._CDstartTime = nil
		arg_30_0._reloadBoostList = {}
	end

	return
end

function var_0_7.ReloadBoost(arg_31_0, arg_31_1)
	local var_31_0 = 0

	ipairs = var_1_10003

	for iter_31_0, iter_31_1 in var_1_10003(arg_31_0._reloadBoostList) do
		var_31_0 = var_31_0 + iter_31_1
	end

	local var_31_1 = var_31_0 + arg_31_1

	pg = var_3

	local var_31_2 = var_3.TimeMgr.GetInstance()
	local var_31_3 = var_3.GetCombatTime(var_31_2) - arg_31_0._jammingTime - arg_31_0._CDstartTime
	local var_31_4

	if var_31_1 < 0 then
		math = var_6
		var_31_4 = var_6.max(var_31_1, (arg_31_0._reloadRequire - var_31_3) * -1)
	else
		math = var_6
		var_31_4 = var_6.min(var_31_1, var_31_3)
	end

	local var_31_5 = var_31_4 - var_31_1 + arg_31_1

	table = fixValue

	local var_31_6 = var_6.insert
	local var_31_7 = arg_31_0._reloadBoostList

	fixValue = var_1_10009

	var_31_6(var_31_7, var_1_10009)

	return
end

function var_0_7.AppendReloadBoost(arg_32_0, arg_32_1)
	if arg_32_0._currentState == arg_32_0.STATE_OVER_HEAT then
		local var_32_0 = arg_32_0._allInWeaponVo

		var_2.ReloadBoost(var_32_0, arg_32_0, arg_32_1)
	end

	return
end

function var_0_7.GetReloadFinishTimeStamp(arg_33_0)
	local var_33_0 = 0

	ipairs = var_1_10002

	for iter_33_0, iter_33_1 in var_1_10002(arg_33_0._reloadBoostList) do
		var_33_0 = var_33_0 + iter_33_1
	end

	return arg_33_0._reloadRequire + arg_33_0._CDstartTime + arg_33_0._jammingTime + var_33_0
end

function var_0_7.StartJamming(arg_34_0)
	pg = var_1_10001

	local var_34_0 = var_1_10001.TimeMgr.GetInstance()

	arg_34_0._jammingStartTime = var_1.GetCombatTime(var_34_0)

	return
end

function var_0_7.JammingEliminate(arg_35_0)
	if not arg_35_0._jammingStartTime then
		return
	end

	pg = var_1

	local var_35_0 = var_1.TimeMgr.GetInstance()

	arg_35_0._jammingTime = var_1.GetCombatTime(var_35_0) - arg_35_0._jammingStartTime
	arg_35_0._jammingStartTime = nil

	return
end

function var_0_7.CLSBullet(arg_36_0)
	local var_36_0 = arg_36_0._host
	local var_36_1 = var_1.GetIFF(var_36_0) * -1
	local var_36_2 = var_0.Battle.BattleDataProxy.GetInstance()

	var_2.CLSBullet(var_36_2, var_36_1, true)

	return
end

function var_0_7.DispatchBlink(arg_37_0, arg_37_1)
	local var_37_0 = {
		callbackFunc = arg_37_1,
		timeScale = var_0.Battle.BattleConfig.FOCUS_MAP_RATE
	}
	local var_37_1 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CHARGE_WEAPON_FINISH, var_37_0)

	arg_37_0:DispatchEvent(var_37_1)

	return
end

function var_0_7.GetReloadRate(arg_38_0)
	if arg_38_0._currentState == arg_38_0.STATE_READY then
		return 0
	elseif arg_38_0._CDstartTime then
		local var_38_0 = arg_38_0:GetReloadFinishTimeStamp()

		pg = var_2

		local var_38_1 = var_2.TimeMgr.GetInstance()

		return (var_38_0 - var_2.GetCombatTime(var_38_1)) / arg_38_0._reloadRequire
	else
		return 1
	end

	return
end

function var_0_7.GetDamageSUM(arg_39_0)
	local var_39_0 = 0
	local var_39_1 = 0

	ipairs = var_1_10003

	for iter_39_0, iter_39_1 in var_1_10003(arg_39_0._hiveList) do
		ipairs = var_1_10008

		for iter_39_2, iter_39_3 in var_1_10008(iter_39_1:GetATKAircraftList()) do
			local var_39_2 = iter_39_3:GetWeapon()

			ipairs = var_1_10014

			for iter_39_4, iter_39_5 in var_1_10014(var_39_2) do
				var_39_0 = var_39_0 + iter_39_5:GetDamageSUM()
			end
		end
	end

	local var_39_3 = arg_39_0._skill
	local var_39_4 = var_3.GetSkillEffectList(var_39_3)

	ipairs = var_4

	for iter_39_6, iter_39_7 in var_4(var_39_4) do
		if iter_39_7:GetDamageSum() then
			var_39_1 = var_39_1 + var_9
		end
	end

	return var_39_0, var_39_1
end

function var_0_7.GetStrikeSkillID(arg_40_0)
	return arg_40_0._skillID
end

return
