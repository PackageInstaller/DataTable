ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleAttr

class = var_0_10004

local var_0_4 = var_0_10004("BattlePointAirStrikeUnit", var_0.Battle.BattlePointHitWeaponUnit)

var_0.Battle.BattlePointAirStrikeUnit = var_0_4
var_0_4.__name = "BattlePointAirStrikeUnit"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	var_0_4._strikePoint = nil
	var_0_4._strikeMode = false

	return
end

function var_0_4.RemoveAllLock(arg_2_0)
	arg_2_0._lockList = {}

	return
end

function var_0_4.Charge(arg_3_0)
	arg_3_0._currentState = arg_3_0.STATE_PRECAST
	arg_3_0._lockList = {}

	local var_3_0 = {}
	local var_3_1 = var_0.Event.New(var_0_2.POINT_HIT_CHARGE, var_3_0)

	arg_3_0:DispatchEvent(var_3_1)

	arg_3_0._strikeMode = true

	return
end

function var_0_4.CancelCharge(arg_4_0)
	if arg_4_0._currentState ~= arg_4_0.STATE_PRECAST then
		return
	end

	arg_4_0:RemoveAllLock()

	arg_4_0._currentState = arg_4_0.STATE_READY

	local var_4_0 = {}
	local var_4_1 = var_0.Event.New(var_0_2.POINT_HIT_CANCEL, var_4_0)

	arg_4_0:DispatchEvent(var_4_1)

	arg_4_0._strikeMode = nil

	return
end

function var_0_4.SetAirUnit(arg_5_0, arg_5_1)
	arg_5_0._hiveList = {}
	ipairs = var_2

	for iter_5_0, iter_5_1 in var_2(arg_5_1) do
		local var_5_0 = var_0.Battle.BattleDataFunction.CreateWeaponUnit(iter_5_1, arg_5_0._host, nil, -1)
		local var_5_1 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CREATE_TEMPORARY_WEAPON, {
			weapon = var_5_0
		})
		local var_5_2 = arg_5_0._host

		var_9.DispatchEvent(var_5_2, var_5_1)

		table = var_9

		var_9.insert(arg_5_0._hiveList, var_5_0)
	end

	return
end

function var_0_4.DoAttack(arg_6_0, arg_6_1)
	var_0.Battle.PlayBattleSFX(arg_6_0._tmpData.fire_sfx)

	local var_6_0 = var_0.Event.New(var_0_2.CHARGE_WEAPON_FIRE, {
		weapon = arg_6_0
	})

	arg_6_0:DispatchEvent(var_6_0)

	local var_6_1 = arg_6_0._host

	var_3.TriggerBuff(var_6_1, var_0_1.BuffEffectType.ON_POINT_STRIKE_STEADY, {})

	ipairs = var_3

	for iter_6_0, iter_6_1 in var_3(arg_6_0._hiveList) do
		local var_6_3

		if not arg_6_0._strikePoint then
			local var_6_2 = arg_6_0._lockList[1]

			var_6_3 = var_8.GetPosition(var_6_2)
		end

		iter_6_1:SetStrikePoint(var_6_3)
		iter_6_1:updateMovementInfo()
		iter_6_1:SingleFire()
	end

	arg_6_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_WEAPON_FIRE, {}))
	arg_6_0:TriggerBuffOnFire()

	arg_6_0._strikePoint = nil

	arg_6_0:RemoveAllLock()

	return
end

function var_0_4.SetReloadTime(arg_7_0, arg_7_1)
	arg_7_0._reloadMax = arg_7_1

	return
end

function var_0_4.AddCDTimer(arg_8_0, arg_8_1)
	arg_8_0._currentState = arg_8_0.STATE_OVER_HEAT
	pg = var_2

	local var_8_0 = var_2.TimeMgr.GetInstance()

	arg_8_0._CDstartTime = var_2.GetCombatTime(var_8_0)
	arg_8_0._reloadRequire = arg_8_1

	return
end

function var_0_4.TriggerBuffOnReady(arg_9_0)
	local var_9_0 = arg_9_0._host

	var_1.TriggerBuff(var_9_0, var_0_1.BuffEffectType.ON_POINT_STRIKE_READY, {})

	return
end

function var_0_4.TriggerBuffOnFire(arg_10_0)
	local var_10_0 = arg_10_0._host

	var_1.TriggerBuff(var_10_0, var_0_1.BuffEffectType.ON_POINT_STRIKE, {})

	return
end

function var_0_4.GetReloadFinishTimeStamp(arg_11_0)
	local var_11_0 = 0

	ipairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0._reloadBoostList) do
		var_11_0 = var_11_0 + iter_11_1
	end

	return arg_11_0._reloadRequire + arg_11_0._CDstartTime + arg_11_0._jammingTime + var_11_0
end

function var_0_4.GetLockList(arg_12_0)
	return arg_12_0._lockList
end

function var_0_4.GetFilteredList(arg_13_0)
	local var_13_0 = var_0_4.super.GetFilteredList(arg_13_0)

	return (arg_13_0:filterEnemyUnitType(var_13_0))
end

function var_0_4.filterEnemyUnitType(arg_14_0, arg_14_1)
	local var_14_0 = {}
	local var_14_1 = {}
	local var_14_2 = -9999

	ipairs = var_1_10005

	for iter_14_0, iter_14_1 in var_1_10005(arg_14_1) do
		if iter_14_1:GetTargetedPriority() == nil then
			var_14_1[#var_14_1 + 1] = iter_14_1
		elseif var_14_2 < var_10 then
			var_14_2 = var_10
			var_14_0[#{} + 1] = iter_14_1
		elseif var_14_2 == var_10 then
			var_14_0[#var_14_0 + 1] = iter_14_1
		end
	end

	ipairs = var_5

	for iter_14_2, iter_14_3 in var_5(var_14_1) do
		var_14_0[#var_14_0 + 1] = iter_14_3
	end

	return var_14_0
end

function var_0_4.handleCoolDown(arg_15_0)
	arg_15_0._currentState = arg_15_0.STATE_READY

	local var_15_0 = arg_15_0._playerChargeWeaponVo

	var_1.Plus(var_15_0, arg_15_0)
	arg_15_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_WEAPON_READY, {}))
	arg_15_0:TriggerBuffOnReady()

	arg_15_0._CDstartTime = nil
	arg_15_0._reloadBoostList = {}

	return
end

function var_0_4.FlushReloadMax(arg_16_0, arg_16_1)
	if var_0_4.super.FlushReloadMax(arg_16_0, arg_16_1) then
		return true
	end

	local var_16_0 = arg_16_0._playerChargeWeaponVo

	var_3.RefreshReloadingBar(var_16_0)

	return
end

function var_0_4.FlushReloadRequire(arg_17_0)
	if var_0_4.super.FlushReloadRequire(arg_17_0) then
		return true
	end

	local var_17_0 = arg_17_0._playerChargeWeaponVo

	var_2.RefreshReloadingBar(var_17_0)

	return
end

function var_0_4.QuickCoolDown(arg_18_0)
	if arg_18_0._currentState == arg_18_0.STATE_OVER_HEAT then
		arg_18_0._currentState = arg_18_0.STATE_READY

		local var_18_0 = arg_18_0._playerChargeWeaponVo

		var_1.InstantCoolDown(var_18_0, arg_18_0)
		arg_18_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_WEAPON_INSTANT_READY, {}))

		arg_18_0._CDstartTime = nil
		arg_18_0._reloadBoostList = {}
	end

	return
end

function var_0_4.IsStrikeMode(arg_19_0)
	return arg_19_0._strikeMode
end

return
