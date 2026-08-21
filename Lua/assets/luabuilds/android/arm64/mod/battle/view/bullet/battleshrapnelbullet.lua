ys = ys or {}

local var_0_0 = ys.Battle.BattleBulletEvent
local var_0_1 = class("BattleShrapnelBullet", ys.Battle.BattleBullet)

ys.Battle.BattleShrapnelBullet = var_0_1
var_0_1.__name = "BattleShrapnelBullet"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.AddBulletEvent(arg_2_0)
	var_0_1.super.AddBulletEvent(arg_2_0)
	arg_2_0._bulletData:RegisterEventListener(arg_2_0, var_0_0.SPLIT, arg_2_0.onBulletSplit)

	return
end

function var_0_1.RemoveBulletEvent(arg_3_0)
	var_0_1.super.RemoveBulletEvent(arg_3_0)
	arg_3_0._bulletData:UnregisterEventListener(arg_3_0, var_0_0.SPLIT)

	return
end

function var_0_1.onBulletSplit(arg_4_0, arg_4_1)
	arg_4_0:_bulletHitFunc()

	return
end

return
