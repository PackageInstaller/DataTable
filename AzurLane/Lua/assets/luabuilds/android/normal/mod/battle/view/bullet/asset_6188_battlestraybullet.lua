ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleResourceManager
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.BattleStrayBullet = var_0_10003("BattleStrayBullet", var_0.Battle.BattleBullet)
var_0.Battle.BattleStrayBullet.__name = "BattleStrayBullet"

local var_0_3 = var_0.Battle.BattleStrayBullet

function var_0_3.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_3.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_3.SetSpawn(arg_2_0, arg_2_1)
	var_0_3.super.SetSpawn(arg_2_0, arg_2_1)

	Clone = var_2

	local var_2_0 = arg_2_0._bulletData

	arg_2_0._targetPos = var_2(var_3.GetExplodePostion(var_2_0))
	arg_2_0._spawnDir = arg_2_0._speed.normalized

	local var_2_1 = 1 + var_0.Battle.BattleAttr.GetCurrent(arg_2_0._bulletData, "bulletSpeedRatio")
	local var_2_2 = arg_2_0._bulletData

	arg_2_0._velocity = var_3.GetVelocity(var_2_2) * var_2_1
	arg_2_0._velocity = var_0.Battle.BattleFormulas.ConvertBulletSpeed(arg_2_0._velocity)
	Vector3 = var_3
	arg_2_0._step = var_3.Distance(arg_2_0._targetPos, arg_2_0._spawnPos) / arg_2_0._velocity
	math = var_3
	arg_2_0._count = var_3.random(600) - 300
	arg_2_0.updateSpeed = var_0_3._doStray

	return
end

function var_0_3._doStray(arg_3_0)
	local var_3_0 = arg_3_0._targetPos

	if arg_3_0._step > 0 and var_3_0 and not var_3_0:EqualZero() then
		arg_3_0._count = arg_3_0._count / 1.06
		arg_3_0._step = arg_3_0._step - 1

		local var_3_1 = arg_3_0._bulletData
		local var_3_2 = var_2.GetPosition(var_3_1)
		local var_3_3 = arg_3_0._velocity

		Vector3 = var_1_10004
		arg_3_0._speed = var_1_10004(var_3_0.x - var_3_2.x, 0, var_3_0.z - var_3_2.z).normalized

		local var_3_4 = arg_3_0._speed

		Vector3 = var_5
		arg_3_0._speed = var_3_4 + var_5(arg_3_0._speed.z * arg_3_0._count / 100, 0, -arg_3_0._speed.x * arg_3_0._count / 100)
		arg_3_0._speed = arg_3_0._speed.normalized
		Vector3 = var_4
		arg_3_0._speed = var_4(arg_3_0._speed.x * var_3_3, 0, arg_3_0._speed.z * var_3_3)
	else
		arg_3_0.updateSpeed = var_0_3._updateSpeed
	end

	return
end

return
