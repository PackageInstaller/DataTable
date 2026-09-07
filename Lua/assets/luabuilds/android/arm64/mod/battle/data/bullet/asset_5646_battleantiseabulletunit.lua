ys = ys or {}
ys.Battle.BattleAntiSeaBulletUnit = class("BattleAntiSeaBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleAntiSeaBulletUnit.__name = "BattleAntiSeaBulletUnit"

local var_0_0 = ys.Battle.BattleAntiSeaBulletUnit

function ys.Battle.BattleAntiSeaBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleAntiSeaBulletUnit.Update(arg_2_0, arg_2_1)
	return
end

function ys.Battle.BattleAntiSeaBulletUnit.IsOutRange(arg_3_0)
	return false
end

function ys.Battle.BattleAntiSeaBulletUnit.SetDirectHitUnit(arg_4_0, arg_4_1)
	arg_4_0._directHitUnit = arg_4_1

	return
end

function ys.Battle.BattleAntiSeaBulletUnit:GetDirectHitUnit()
	return self._directHitUnit
end

function ys.Battle.BattleAntiSeaBulletUnit.Dispose(arg_6_0)
	arg_6_0._directHitUnit = nil

	var_0_0.super.Dispose(arg_6_0)

	return
end

return
