ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent

class = var_0_10002

local var_0_2 = var_0_10002("BattleShrapnelBullet", var_0.Battle.BattleBullet)

var_0.Battle.BattleShrapnelBullet = var_0_2
var_0_2.__name = "BattleShrapnelBullet"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.AddBulletEvent(arg_2_0)
	var_0_2.super.AddBulletEvent(arg_2_0)

	local var_2_0 = arg_2_0._bulletData

	var_1.RegisterEventListener(var_2_0, arg_2_0, var_0_1.SPLIT, arg_2_0.onBulletSplit)

	return
end

function var_0_2.RemoveBulletEvent(arg_3_0)
	var_0_2.super.RemoveBulletEvent(arg_3_0)

	local var_3_0 = arg_3_0._bulletData

	var_1.UnregisterEventListener(var_3_0, arg_3_0, var_0_1.SPLIT)

	return
end

function var_0_2.onBulletSplit(arg_4_0, arg_4_1)
	arg_4_0._bulletHitFunc(arg_4_0)

	return
end

return
