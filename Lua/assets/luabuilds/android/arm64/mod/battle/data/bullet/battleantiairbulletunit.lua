ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleAntiAirBulletUnit = class("BattleAntiAirBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleAntiAirBulletUnit.__name = "BattleAntiAirBulletUnit"

local var_0_1 = ys.Battle.BattleAntiAirBulletUnit

function ys.Battle.BattleAntiAirBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.Battle.BattleAntiAirBulletUnit.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleAntiAirBulletUnit.Update(arg_2_0, arg_2_1)
	return
end

function ys.Battle.BattleAntiAirBulletUnit.IsOutRange(arg_3_0)
	return false
end

function ys.Battle.BattleAntiAirBulletUnit.SetDirectHitUnit(arg_4_0, arg_4_1)
	arg_4_0._directHitUnit = arg_4_1

	return
end

function ys.Battle.BattleAntiAirBulletUnit.GetDirectHitUnit(arg_5_0)
	return arg_5_0._directHitUnit
end

function ys.Battle.BattleAntiAirBulletUnit.Dispose(arg_6_0)
	arg_6_0._directHitUnit = nil

	var_0_1.super.Dispose(arg_6_0)

	return
end

return
