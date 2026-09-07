ys = ys or {}

local var_0_0 = ys.Battle.BattleConst

ys.Battle.BattleDepthChargeUnit = class("BattleDepthChargeUnit", ys.Battle.BattleWeaponUnit)
ys.Battle.BattleDepthChargeUnit.__name = "BattleDepthChargeUnit"

local var_0_1 = ys.Battle.BattleDepthChargeUnit

function ys.Battle.BattleDepthChargeUnit.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.BattleDepthChargeUnit:TriggerBuffOnFire()
	self._host:TriggerBuff(var_0_0.BuffEffectType.ON_DEPTH_CHARGE_DROP, {
		equipIndex = self._equipmentIndex
	})

	return
end

return
