ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleScaleBullet = var_0_10002("BattleScaleBullet", var_0.Battle.BattleBullet)
var_0.Battle.BattleScaleBullet.__name = "BattleScaleBullet"

local var_0_2 = var_0.Battle.BattleScaleBullet

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.Update(arg_2_0, arg_2_1)
	var_0_2.super.Update(arg_2_0, arg_2_1)
	arg_2_0:updateModelScale()

	return
end

function var_0_2.updateModelScale(arg_3_0)
	local var_3_0 = arg_3_0._bulletData
	local var_3_1

	var_3_1.x, var_3_1 = var_1.GetBoxSize(var_3_0).x * 2, arg_3_0._tf.localScale
	arg_3_0._tf.localScale = var_3_1

	return
end

return
