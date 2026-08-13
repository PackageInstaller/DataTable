ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleUnitEvent
local var_0_3 = var_0.Battle.BattleAttr

class = var_0_10004

local var_0_4 = var_0_10004("BattlePointHitWeaponUnit", var_0.Battle.BattleWeaponUnit)

var_0.Battle.BattlePointHitWeaponUnit = var_0_4
var_0_4.__name = "BattlePointHitWeaponUnit"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	var_0_4._strikePoint = nil
	var_0_4._strikeRequire = 1
	var_0_4._strikeMode = false

	return
end

function var_0_4.DispatchBlink(arg_2_0, arg_2_1)
	local var_2_0 = {
		callbackFunc = arg_2_1,
		timeScale = var_0.Battle.BattleConfig.FOCUS_MAP_RATE
	}
	local var_2_1 = var_0.Event.New(var_0_2.CHARGE_WEAPON_FINISH, var_2_0)

	arg_2_0:DispatchEvent(var_2_1)

	return
end

function var_0_4.RemoveAllLock(arg_3_0)
	arg_3_0._lockList = {}

	return
end

function var_0_4.createMajorEmitter(arg_4_0, arg_4_1, arg_4_2)
	local function var_4_0(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
		local var_5_0
		local var_5_1
		local var_5_2 = arg_4_0._emitBulletIDList[arg_4_2]

		if arg_4_0._strikePoint then
			var_5_1 = arg_4_0._strikePoint

			local var_5_3 = arg_4_0

			var_5_0 = var_7.SpawnPointBullet(var_5_3, var_5_2, arg_4_0._strikePoint)
		else
			local var_5_4 = arg_4_0._lockList[1]
			local var_5_5 = arg_4_0

			var_5_0 = var_8.Spawn(var_5_5, var_5_2, var_5_4, arg_4_0.INTERNAL)
			var_5_1 = var_5_4:GetBeenAimedPosition() or var_5_4:GetPosition()
		end

		var_5_0:SetOffsetPriority(arg_5_3)
		var_5_0:SetShiftInfo(arg_5_0, arg_5_1)
		var_5_0:SetRotateInfo(var_5_1, 0, 0)
		var_0.Battle.BattleVariable.AddExempt(var_5_0:GetSpeedExemptKey(), var_5_0:GetIFF(), var_0.Battle.BattleConfig.SPEED_FACTOR_FOCUS_CHARACTER)

		local var_5_6 = arg_4_0

		var_7.DispatchBulletEvent(var_5_6, var_5_0)

		return
	end

	local function var_4_1()
		arg_4_0._strikePoint = nil

		local var_6_0 = arg_4_0

		var_0.RemoveAllLock(var_6_0)

		return
	end

	var_0_4.super.createMajorEmitter(arg_4_0, arg_4_1, arg_4_2, var_0_4.EMITTER_NORMAL, var_4_0, var_4_1)

	return
end

function var_0_4.SetPlayerChargeWeaponVO(arg_7_0, arg_7_1)
	arg_7_0._playerChargeWeaponVo = arg_7_1

	return
end

function var_0_4.Charge(arg_8_0)
	arg_8_0._currentState = arg_8_0.STATE_PRECAST
	arg_8_0._lockList = {}

	local var_8_0 = {}
	local var_8_1 = var_0.Event.New(var_0_2.POINT_HIT_CHARGE, var_8_0)

	arg_8_0:DispatchEvent(var_8_1)

	arg_8_0._strikeMode = true

	return
end

function var_0_4.CancelCharge(arg_9_0)
	if arg_9_0._currentState ~= arg_9_0.STATE_PRECAST then
		return
	end

	arg_9_0:RemoveAllLock()

	arg_9_0._currentState = arg_9_0.STATE_READY

	local var_9_0 = {}
	local var_9_1 = var_0.Event.New(var_0_2.POINT_HIT_CANCEL, var_9_0)

	arg_9_0:DispatchEvent(var_9_1)

	arg_9_0._strikeMode = nil

	return
end

function var_0_4.QuickTag(arg_10_0)
	arg_10_0._currentState = arg_10_0.STATE_PRECAST
	arg_10_0._lockList = {}

	arg_10_0:updateMovementInfo()

	local var_10_0 = arg_10_0:Tracking()

	arg_10_0._lockList[#arg_10_0._lockList + 1] = var_10_0

	return
end

function var_0_4.CancelQuickTag(arg_11_0)
	arg_11_0._currentState = arg_11_0.STATE_READY
	arg_11_0._lockList = {}

	return
end

function var_0_4.Update(arg_12_0, arg_12_1)
	arg_12_0:UpdateReload()

	return
end

function var_0_4.Fire(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_0._host

	if var_2.IsCease(var_13_0) then
		arg_13_0:CancelQuickTag()

		return false
	end

	if arg_13_0._currentState ~= arg_13_0.STATE_PRECAST then
		return
	end

	arg_13_0._strikePoint = arg_13_1

	local var_13_1 = arg_13_0._host

	var_2.CloakExpose(var_13_1, var_0.Battle.BattleConfig.CLOAK_BOMBARD_BASE_EXPOSE)

	local var_13_2 = arg_13_0._host

	var_2.BombardExpose(var_13_2)

	arg_13_0._strikeMode = false

	return var_0_4.super.Fire(arg_13_0)
end

function var_0_4.DoAttack(arg_14_0, arg_14_1)
	var_0.Battle.PlayBattleSFX(arg_14_0._tmpData.fire_sfx)

	local var_14_0 = var_0.Event.New(var_0_2.CHARGE_WEAPON_FIRE, {
		weapon = arg_14_0
	})

	arg_14_0:DispatchEvent(var_14_0)
	arg_14_0:cacheBulletID()
	arg_14_0:TriggerBuffOnSteday()

	ipairs = var_3

	for iter_14_0, iter_14_1 in var_3(arg_14_0._majorEmitterList) do
		iter_14_1:Ready()
	end

	ipairs = var_3

	for iter_14_2, iter_14_3 in var_3(arg_14_0._majorEmitterList) do
		iter_14_3:Fire(arg_14_1, arg_14_0:GetDirection(), arg_14_0:GetAttackAngle())
		iter_14_3:SetTimeScale(false)
	end

	arg_14_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_WEAPON_FIRE, {}))
	arg_14_0:TriggerBuffOnFire()

	local var_14_1 = var_0.Battle.BattleCameraUtil.GetInstance()
	local var_14_2 = var_3.StartShake

	pg = var_6

	var_14_2(var_14_1, var_6.shake_template[var_0_1.ShakeType.FIRE])

	return
end

function var_0_4.TriggerBuffOnReady(arg_15_0)
	if arg_15_0._tmpData.type == var_0_1.EquipmentType.MANUAL_MISSILE then
		local var_15_0 = arg_15_0._host

		var_1.TriggerBuff(var_15_0, var_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_MISSILE_READY, {})
	else
		local var_15_1 = arg_15_0._host

		var_1.TriggerBuff(var_15_1, var_0.Battle.BattleConst.BuffEffectType.ON_CHARGE_READY, {})
	end

	return
end

function var_0_4.Spawn(arg_16_0, arg_16_1, arg_16_2, arg_16_3)
	local var_16_0

	if arg_16_2 == nil then
		arg_16_0:updateMovementInfo()

		if arg_16_0:TrackingRandom(arg_16_0:GetFilteredList()) == nil then
			Vector3 = var_5
			var_16_0 = var_5.zero
		else
			var_16_0 = arg_16_2:GetBeenAimedPosition() or arg_16_2:GetPosition()
		end
	else
		var_16_0 = arg_16_2:GetBeenAimedPosition() or arg_16_2:GetPosition()
	end

	local var_16_1 = arg_16_0._dataProxy
	local var_16_2 = var_5.CreateBulletUnit(var_16_1, arg_16_1, arg_16_0._host, arg_16_0, var_16_0)

	arg_16_0:setBulletSkin(var_16_2, arg_16_1)
	arg_16_0:TriggerBuffWhenSpawn(var_16_2)

	if arg_16_3 == arg_16_0.INTERNAL then
		local var_16_3 = arg_16_0._host
		local var_16_4 = var_6.GetAttrByName(var_16_3, "initialEnhancement")

		var_16_2:SetDamageEnhance(1 + var_16_4)
		arg_16_0:TriggerBuffWhenSpawn(var_16_2, var_0_1.BuffEffectType.ON_INTERNAL_BULLET_CREATE)
	end

	return var_16_2
end

function var_0_4.SpawnPointBullet(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = arg_17_0._dataProxy
	local var_17_1 = var_3.CreateBulletUnit(var_17_0, arg_17_1, arg_17_0._host, arg_17_0, arg_17_2)

	arg_17_0:TriggerBuffWhenSpawn(var_17_1, var_0_1.BuffEffectType.ON_MANUAL_BULLET_CREATE)
	arg_17_0:setBulletSkin(var_17_1, arg_17_1)

	local var_17_2 = arg_17_0._host
	local var_17_3 = var_4.GetAttrByName(var_17_2, "initialEnhancement")
	local var_17_4 = arg_17_0._host
	local var_17_5 = var_17_3 + var_5.GetAttrByName(var_17_4, "manualEnhancement")

	var_17_1:SetDamageEnhance(var_0.Battle.BattleConfig.ChargeWeaponConfig.Enhance + var_17_5)
	arg_17_0:TriggerBuffWhenSpawn(var_17_1)
	arg_17_0:TriggerBuffWhenSpawn(var_17_1, var_0_1.BuffEffectType.ON_INTERNAL_BULLET_CREATE)

	return var_17_1
end

function var_0_4.TriggerBuffOnFire(arg_18_0)
	if arg_18_0._tmpData.type == var_0_1.EquipmentType.MANUAL_MISSILE then
		local var_18_0 = arg_18_0._host

		var_1.TriggerBuff(var_18_0, var_0.Battle.BattleConst.BuffEffectType.ON_MANUAL_MISSILE_FIRE, {})
	else
		local var_18_1 = arg_18_0._host

		var_1.TriggerBuff(var_18_1, var_0.Battle.BattleConst.BuffEffectType.ON_CHARGE_FIRE, {})
	end

	return
end

function var_0_4.InitialCD(arg_19_0)
	var_0_4.super.InitialCD(arg_19_0)

	local var_19_0 = arg_19_0._playerChargeWeaponVo

	var_1.InitialDeduct(var_19_0, arg_19_0)

	local var_19_1 = arg_19_0._playerChargeWeaponVo

	var_1.Charge(var_19_1, arg_19_0)

	return
end

function var_0_4.EnterCoolDown(arg_20_0)
	var_0_4.super.EnterCoolDown(arg_20_0)

	local var_20_0 = arg_20_0._playerChargeWeaponVo

	var_1.Charge(var_20_0, arg_20_0)

	return
end

function var_0_4.OverHeat(arg_21_0)
	var_0_4.super.OverHeat(arg_21_0)

	local var_21_0 = arg_21_0._playerChargeWeaponVo

	var_1.Deduct(var_21_0, arg_21_0)

	return
end

function var_0_4.GetMinAngle(arg_22_0)
	return arg_22_0:GetAttackAngle()
end

function var_0_4.GetLockList(arg_23_0)
	return arg_23_0._lockList
end

function var_0_4.GetFilteredList(arg_24_0)
	local var_24_0 = var_0_4.super.GetFilteredList(arg_24_0)

	return (arg_24_0:filterEnemyUnitType(var_24_0))
end

function var_0_4.filterEnemyUnitType(arg_25_0, arg_25_1)
	local var_25_0 = {}
	local var_25_1 = {}
	local var_25_2 = -9999

	ipairs = var_1_10005

	for iter_25_0, iter_25_1 in var_1_10005(arg_25_1) do
		if iter_25_1:GetTargetedPriority() == nil then
			var_25_1[#var_25_1 + 1] = iter_25_1
		elseif var_25_2 < var_10 then
			var_25_2 = var_10
			var_25_0[#{} + 1] = iter_25_1
		elseif var_25_2 == var_10 then
			var_25_0[#var_25_0 + 1] = iter_25_1
		end
	end

	ipairs = var_5

	for iter_25_2, iter_25_3 in var_5(var_25_1) do
		var_25_0[#var_25_0 + 1] = iter_25_3
	end

	return var_25_0
end

function var_0_4.handleCoolDown(arg_26_0)
	arg_26_0._currentState = arg_26_0.STATE_READY

	local var_26_0 = arg_26_0._playerChargeWeaponVo

	var_1.Plus(var_26_0, arg_26_0)
	arg_26_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_WEAPON_READY, {}))
	arg_26_0:TriggerBuffOnReady()

	arg_26_0._CDstartTime = nil
	arg_26_0._reloadBoostList = {}

	return
end

function var_0_4.FlushReloadMax(arg_27_0, arg_27_1)
	if var_0_4.super.FlushReloadMax(arg_27_0, arg_27_1) then
		return true
	end

	local var_27_0 = arg_27_0._playerChargeWeaponVo

	var_3.RefreshReloadingBar(var_27_0)

	return
end

function var_0_4.FlushReloadRequire(arg_28_0)
	if var_0_4.super.FlushReloadRequire(arg_28_0) then
		return true
	end

	local var_28_0 = arg_28_0._playerChargeWeaponVo

	var_2.RefreshReloadingBar(var_28_0)

	return
end

function var_0_4.QuickCoolDown(arg_29_0)
	if arg_29_0._currentState == arg_29_0.STATE_OVER_HEAT then
		arg_29_0._currentState = arg_29_0.STATE_READY

		local var_29_0 = arg_29_0._playerChargeWeaponVo

		var_1.InstantCoolDown(var_29_0, arg_29_0)
		arg_29_0:DispatchEvent(var_0.Event.New(var_0_2.MANUAL_WEAPON_INSTANT_READY, {}))

		arg_29_0._CDstartTime = nil
		arg_29_0._reloadBoostList = {}
	end

	return
end

function var_0_4.ReloadBoost(arg_30_0, arg_30_1)
	local var_30_0 = 0

	ipairs = var_1_10003

	for iter_30_0, iter_30_1 in var_1_10003(arg_30_0._reloadBoostList) do
		var_30_0 = var_30_0 + iter_30_1
	end

	local var_30_1 = var_30_0 + arg_30_1

	pg = var_3

	local var_30_2 = var_3.TimeMgr.GetInstance()
	local var_30_3 = var_3.GetCombatTime(var_30_2) - arg_30_0._jammingTime - arg_30_0._CDstartTime
	local var_30_4

	if var_30_1 < 0 then
		math = var_6
		var_30_4 = var_6.max(var_30_1, (arg_30_0._reloadRequire - var_30_3) * -1)
	else
		math = var_6
		var_30_4 = var_6.min(var_30_1, var_30_3)
	end

	local var_30_5 = var_30_4 - var_30_1 + arg_30_1

	table = fixValue

	local var_30_6 = var_6.insert
	local var_30_7 = arg_30_0._reloadBoostList

	fixValue = var_1_10009

	var_30_6(var_30_7, var_1_10009)

	return
end

function var_0_4.AppendReloadBoost(arg_31_0, arg_31_1)
	if arg_31_0._currentState == arg_31_0.STATE_OVER_HEAT then
		local var_31_0 = arg_31_0._playerChargeWeaponVo

		var_2.ReloadBoost(var_31_0, arg_31_0, arg_31_1)
	end

	return
end

function var_0_4.IsStrikeMode(arg_32_0)
	return arg_32_0._strikeMode
end

return
