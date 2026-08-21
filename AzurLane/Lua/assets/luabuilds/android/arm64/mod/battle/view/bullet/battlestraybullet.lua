ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleStrayBullet = class("BattleStrayBullet", ys.Battle.BattleBullet)
ys.Battle.BattleStrayBullet.__name = "BattleStrayBullet"

local var_0_2 = ys.Battle.BattleStrayBullet

function ys.Battle.BattleStrayBullet.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function ys.Battle.BattleStrayBullet.SetSpawn(arg_2_0, arg_2_1)
	var_0_2.super.SetSpawn(arg_2_0, arg_2_1)

	arg_2_0._targetPos = Clone(arg_2_0._bulletData:GetExplodePostion())
	arg_2_0._spawnDir = arg_2_0._speed.normalized
	arg_2_0._velocity = arg_2_0._bulletData:GetVelocity() * (1 + var_0_0.Battle.BattleAttr.GetCurrent(arg_2_0._bulletData, "bulletSpeedRatio"))
	arg_2_0._velocity = var_0_0.Battle.BattleFormulas.ConvertBulletSpeed(arg_2_0._velocity)
	arg_2_0._step = Vector3.Distance(arg_2_0._targetPos, arg_2_0._spawnPos) / arg_2_0._velocity
	arg_2_0._count = math.random(600) - 300
	arg_2_0.updateSpeed = var_0_2._doStray

	return
end

function ys.Battle.BattleStrayBullet._doStray(arg_3_0)
	if arg_3_0._step > 0 and arg_3_0._targetPos and not arg_3_0._targetPos:EqualZero() then
		arg_3_0._count = arg_3_0._count / 1.06
		arg_3_0._step = arg_3_0._step - 1

		local var_3_0 = arg_3_0._bulletData:GetPosition()

		arg_3_0._speed = Vector3(arg_3_0._targetPos.x - var_3_0.x, 0, arg_3_0._targetPos.z - var_3_0.z).normalized
		arg_3_0._speed = arg_3_0._speed + Vector3(arg_3_0._speed.z * arg_3_0._count / 100, 0, -arg_3_0._speed.x * arg_3_0._count / 100)
		arg_3_0._speed = arg_3_0._speed.normalized
		arg_3_0._speed = Vector3(arg_3_0._speed.x * arg_3_0._velocity, 0, arg_3_0._speed.z * arg_3_0._velocity)
	else
		arg_3_0.updateSpeed = var_0_2._updateSpeed
	end

	return
end

return
