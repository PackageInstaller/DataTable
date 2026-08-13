ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleDepthChargeUnit = var_0_10003("BattleDepthChargeUnit", var_0.Battle.BattleWeaponUnit)
var_0.Battle.BattleDepthChargeUnit.__name = "BattleDepthChargeUnit"

local var_0_3 = var_0.Battle.BattleDepthChargeUnit
local var_0_4 = var_0.Battle.BattleTargetChoise

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.TriggerBuffOnFire(arg_2_0)
	local var_2_0 = arg_2_0._host

	var_1.TriggerBuff(var_2_0, var_0_1.BuffEffectType.ON_DEPTH_CHARGE_DROP, {
		equipIndex = arg_2_0._equipmentIndex
	})

	return
end

return
