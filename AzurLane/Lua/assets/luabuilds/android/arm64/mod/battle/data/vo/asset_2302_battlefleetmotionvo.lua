ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
pg = ys

local var_0_1

var_0_1 = var_0 or {}
ys = pg
pg = var_0_10001

local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle.BattleFormulas
local var_0_4 = var_0.Battle.BattleConfig

class = var_0_10005

local var_0_5 = var_0_10005("BattleFleetMotionVO")

var_0.Battle.BattleFleetMotionVO = var_0_5
var_0_5.__name = "BattleFleetMotionVO"

function var_0_5.Ctor(arg_1_0)
	Vector3 = var_1_10001
	arg_1_0._pos = var_1_10001.zero
	Vector3 = var_1
	arg_1_0._speed = var_1.zero
	arg_1_0._lastDir = var_0_2.NORMALIZE_FLEET_SPEED
	Quaternion = var_1
	arg_1_0._rotateAngle = var_1.identity
	arg_1_0._isCalibrateAcc = false

	return
end

function var_0_5.GetPos(arg_2_0)
	return arg_2_0._pos
end

function var_0_5.GetSpeed(arg_3_0)
	local var_3_0 = arg_3_0._speed

	return var_1.Clone(var_3_0)
end

function var_0_5.GetDirAngle(arg_4_0)
	return arg_4_0._rotateAngle
end

function var_0_5.UpdatePos(arg_5_0, arg_5_1)
	arg_5_0._pos = arg_5_1:GetPosition()

	return
end

function var_0_5.UpdateVelocityAndDirection(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_2
	local var_6_2 = arg_6_3

	Vector3 = var_1_10007

	local var_6_3 = var_1_10007(var_6_1, 0, var_6_2)
	local var_6_4 = var_7.Mul(var_6_3, var_6_0)

	arg_6_0:UpdateSpeed(var_6_4)

	return
end

function var_0_5.UpdateSpeed(arg_7_0, arg_7_1)
	if arg_7_0._speed ~= arg_7_1 then
		arg_7_0._speed = arg_7_1

		if not arg_7_1:EqualZero() then
			arg_7_0._lastDir = arg_7_1
		end

		local var_7_0 = arg_7_0._rotateAngle

		var_2.SetFromToRotation1(var_7_0, var_0_2.NORMALIZE_FLEET_SPEED, arg_7_0._lastDir)
	end

	return
end

function var_0_5.CalibrateAcc(arg_8_0, arg_8_1)
	arg_8_0._isCalibrateAcc = arg_8_1

	return
end

function var_0_5.SetPos(arg_9_0, arg_9_1)
	arg_9_0._pos = arg_9_1

	return
end

return
