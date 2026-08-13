ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleStrayBulletUnit = var_0_10002("BattleStrayBulletUnit", var_0.Battle.BattleBulletUnit)
var_0.Battle.BattleStrayBulletUnit.__name = "BattleStrayBulletUnit"

local var_0_2 = var_0.Battle.BattleStrayBulletUnit

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.SetExplodePosition(arg_2_0, arg_2_1)
	arg_2_0._explodePos = arg_2_1

	return
end

function var_0_2.GetExplodePostion(arg_3_0)
	return arg_3_0._explodePos
end

return
