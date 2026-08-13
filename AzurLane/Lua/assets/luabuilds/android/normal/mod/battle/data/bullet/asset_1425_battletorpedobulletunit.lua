ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleFormulas

class = var_0_10002

local var_0_2 = var_0_10002("BattleTorpedoBulletUnit", var_0.Battle.BattleBulletUnit)

var_0.Battle.BattleTorpedoBulletUnit = var_0_2
var_0_2.__name = "BattleTorpedoBulletUnit"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.calcSpeed(arg_2_0)
	local var_2_0 = 1 + var_0.Battle.BattleAttr.GetCurrent(arg_2_0, "bulletSpeedRatio")

	math = var_2

	local var_2_1 = var_2.max(0, arg_2_0._velocity + var_0.Battle.BattleAttr.GetCurrent(arg_2_0, "torpedoSpeedExtra")) * var_2_0
	local var_2_2 = var_0_1.ConvertBulletSpeed(var_2_1)

	math = var_4

	local var_2_3 = var_4.deg2Rad * arg_2_0._yAngle

	Vector3 = var_5
	math = var_6

	local var_2_4 = var_2_2 * var_6.cos(var_2_3)
	local var_2_5 = 0

	math = var_1_10008
	arg_2_0._speed = var_5(var_2_4, var_2_5, var_2_2 * var_1_10008.sin(var_2_3))

	return
end

function var_0_2.GetExplodePostion(arg_3_0)
	return arg_3_0._explodePos
end

function var_0_2.SetExplodePosition(arg_4_0, arg_4_1)
	arg_4_0._explodePos = arg_4_1

	return
end

function var_0_2.InitCldComponent(arg_5_0)
	var_0_2.super.InitCldComponent(arg_5_0)
	arg_5_0:ResetCldSurface()

	return
end

function var_0_2.Hit(arg_6_0, arg_6_1, arg_6_2)
	var_0_2.super.Hit(arg_6_0, arg_6_1, arg_6_2)

	arg_6_0._pierceCount = arg_6_0._pierceCount - 1

	return
end

return
