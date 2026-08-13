ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleCannonBulletUnit = var_0_10002("BattleCannonBulletUnit", var_0.Battle.BattleBulletUnit)
var_0.Battle.BattleCannonBulletUnit.__name = "BattleCannonBulletUnit"

local var_0_2 = var_0.Battle.BattleCannonBulletUnit

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.Hit(arg_2_0, arg_2_1, arg_2_2)
	var_0_2.super.Hit(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._pierceCount = arg_2_0._pierceCount - 1

	return
end

return
