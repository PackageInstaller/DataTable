ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent
local var_0_2 = var_0.Battle.BattleResourceManager
local var_0_3 = var_0.Battle.BattleConfig

class = var_0_10004

local var_0_4 = var_0_10004("BattleBombBullet", var_0.Battle.BattleBullet)

var_0.Battle.BattleBombBullet = var_0_4
var_0_4.__name = "BattleBombBullet"

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.Dispose(arg_2_0)
	if arg_2_0._alert then
		local var_2_0 = arg_2_0._alert

		var_1.Dispose(var_2_0)
	end

	var_0_4.super.Dispose(arg_2_0)

	return
end

function var_0_4.AddBulletEvent(arg_3_0)
	local var_3_0 = arg_3_0._bulletData

	var_1.RegisterEventListener(var_3_0, arg_3_0, var_0_1.EXPLODE, arg_3_0.onBulletExplode)

	return
end

function var_0_4.RemoveBulletEvent(arg_4_0)
	local var_4_0 = arg_4_0._bulletData

	var_1.UnregisterEventListener(var_4_0, arg_4_0, var_0_1.EXPLODE)

	return
end

function var_0_4.onBulletExplode(arg_5_0, arg_5_1)
	arg_5_0._bulletHitFunc(arg_5_0)

	return
end

function var_0_4.UpdatePosition(arg_6_0)
	Vector3 = var_1_10001

	local var_6_0 = var_1_10001.Lerp(arg_6_0._tf.localPosition, arg_6_0:GetPosition(), var_0_3.BulletMotionRate)

	arg_6_0._tf.localPosition = var_6_0

	local var_6_1 = arg_6_0._cacheTFPos

	var_2.Set(var_6_1, var_6_0.x, var_6_0.y, var_6_0.z)

	return
end

return
