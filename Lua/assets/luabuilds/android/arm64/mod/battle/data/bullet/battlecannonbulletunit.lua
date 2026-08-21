ys = ys or {}
ys.Battle.BattleCannonBulletUnit = class("BattleCannonBulletUnit", ys.Battle.BattleBulletUnit)
ys.Battle.BattleCannonBulletUnit.__name = "BattleCannonBulletUnit"

local var_0_0 = ys.Battle.BattleCannonBulletUnit

function ys.Battle.BattleCannonBulletUnit.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_0.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleCannonBulletUnit.Hit(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.Hit(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._pierceCount = arg_2_0._pierceCount - 1

	return
end

return
