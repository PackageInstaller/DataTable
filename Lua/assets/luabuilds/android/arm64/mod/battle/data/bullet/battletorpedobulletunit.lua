ys = ys or {}

local var_0_0 = ys.Battle.BattleFormulas
local var_0_1 = class("BattleTorpedoBulletUnit", ys.Battle.BattleBulletUnit)

ys.Battle.BattleTorpedoBulletUnit = var_0_1
var_0_1.__name = "BattleTorpedoBulletUnit"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_1.calcSpeed(arg_2_0)
	local var_2_0 = var_0_0.ConvertBulletSpeed(math.max(0, arg_2_0._velocity + var_0.Battle.BattleAttr.GetCurrent(arg_2_0, "torpedoSpeedExtra")) * (1 + var_0.Battle.BattleAttr.GetCurrent(arg_2_0, "bulletSpeedRatio")))

	arg_2_0._speed = Vector3(var_2_0 * math.cos(math.deg2Rad * arg_2_0._yAngle), 0, var_2_0 * math.sin(math.deg2Rad * arg_2_0._yAngle))

	return
end

function var_0_1.GetExplodePostion(arg_3_0)
	return arg_3_0._explodePos
end

function var_0_1.SetExplodePosition(arg_4_0, arg_4_1)
	arg_4_0._explodePos = arg_4_1

	return
end

function var_0_1.InitCldComponent(arg_5_0)
	var_0_1.super.InitCldComponent(arg_5_0)
	arg_5_0:ResetCldSurface()

	return
end

function var_0_1.Hit(arg_6_0, arg_6_1, arg_6_2)
	var_0_1.super.Hit(arg_6_0, arg_6_1, arg_6_2)

	arg_6_0._pierceCount = arg_6_0._pierceCount - 1

	return
end

return
