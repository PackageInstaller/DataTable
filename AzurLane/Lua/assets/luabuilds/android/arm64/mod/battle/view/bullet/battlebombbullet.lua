ys = ys or {}

local var_0_0 = ys.Battle.BattleBulletEvent
local var_0_2 = ys.Battle.BattleConfig
local var_0_3 = class("BattleBombBullet", ys.Battle.BattleBullet)

ys.Battle.BattleBombBullet = var_0_3
var_0_3.__name = "BattleBombBullet"

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.Dispose(arg_2_0)
	if arg_2_0._alert then
		arg_2_0._alert:Dispose()
	end

	var_0_3.super.Dispose(arg_2_0)

	return
end

function var_0_3.AddBulletEvent(arg_3_0)
	arg_3_0._bulletData:RegisterEventListener(arg_3_0, var_0_0.EXPLODE, arg_3_0.onBulletExplode)

	return
end

function var_0_3.RemoveBulletEvent(arg_4_0)
	arg_4_0._bulletData:UnregisterEventListener(arg_4_0, var_0_0.EXPLODE)

	return
end

function var_0_3.onBulletExplode(arg_5_0, arg_5_1)
	arg_5_0:_bulletHitFunc()

	return
end

function var_0_3.UpdatePosition(arg_6_0)
	local var_6_0 = Vector3.Lerp(arg_6_0._tf.localPosition, arg_6_0:GetPosition(), var_0_2.BulletMotionRate)

	arg_6_0._tf.localPosition = var_6_0

	arg_6_0._cacheTFPos:Set(var_6_0.x, var_6_0.y, var_6_0.z)

	return
end

return
