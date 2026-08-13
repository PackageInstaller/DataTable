ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleAntiAirBulletUnit = var_0_10002("BattleAntiAirBulletUnit", var_0.Battle.BattleBulletUnit)
var_0.Battle.BattleAntiAirBulletUnit.__name = "BattleAntiAirBulletUnit"

local var_0_2 = var_0.Battle.BattleAntiAirBulletUnit

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0.Battle.BattleAntiAirBulletUnit.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.Update(arg_2_0, arg_2_1)
	return
end

function var_0_2.IsOutRange(arg_3_0)
	return false
end

function var_0_2.SetDirectHitUnit(arg_4_0, arg_4_1)
	arg_4_0._directHitUnit = arg_4_1

	return
end

function var_0_2.GetDirectHitUnit(arg_5_0)
	return arg_5_0._directHitUnit
end

function var_0_2.Dispose(arg_6_0)
	arg_6_0._directHitUnit = nil

	var_0_2.super.Dispose(arg_6_0)

	return
end

return
