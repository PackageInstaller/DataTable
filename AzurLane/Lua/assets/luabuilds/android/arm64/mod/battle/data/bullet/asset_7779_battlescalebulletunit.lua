ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleBulletEvent
local var_0_2 = var_0.Battle.BattleFormulas

Vector3 = var_0_10003

local var_0_3 = var_0_10003.up
local var_0_4 = var_0.Battle.BattleVariable
local var_0_5 = var_0.Battle.BattleConfig
local var_0_6 = var_0.Battle

class = var_0_10007
var_0_6.BattleScaleBulletUnit = var_0_10007("BattleScaleBulletUnit", var_0.Battle.BattleBulletUnit)
var_0.Battle.BattleScaleBulletUnit.__name = "BattleScaleBulletUnit"

local var_0_7 = var_0.Battle.BattleScaleBulletUnit

function var_0_7.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_7.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._scaleX = 0

	return
end

function var_0_7.Update(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._tempData.cld_box

	if arg_2_0._scaleX + var_2_0[1] > arg_2_0._scaleLimit then
		arg_2_0:calcSpeed()
	else
		arg_2_0:UpdateCLDBox()
	end

	var_0_7.super.Update(arg_2_0, arg_2_1)

	return
end

function var_0_7.SetTemplateData(arg_3_0, arg_3_1)
	var_0_7.super.SetTemplateData(arg_3_0, arg_3_1)

	arg_3_0._scaleSpeed = arg_3_0._tempData.extra_param.scaleSpeed
	arg_3_0._scaleLimit = arg_3_0._tempData.extra_param.cldMax

	return
end

function var_0_7.InitSpeed(arg_4_0, arg_4_1)
	var_0_7.super.InitSpeed(arg_4_0, arg_4_1)
	arg_4_0:calcScaleSpeed()

	return
end

function var_0_7.calcScaleSpeed(arg_5_0)
	local var_5_0 = arg_5_0._scaleSpeed * 0.5

	math = var_1_10002

	local var_5_1 = var_1_10002.deg2Rad * arg_5_0._yAngle

	Vector3 = var_3
	math = var_1_10005

	local var_5_2 = var_5_0 * var_1_10005.cos(var_5_1)
	local var_5_3 = 0

	math = var_7
	arg_5_0._speed = var_3(var_5_2, var_5_3, var_5_0 * var_7.sin(var_5_1))

	return
end

function var_0_7.UpdateCLDBox(arg_6_0)
	local var_6_0 = arg_6_0._tempData.cld_box

	arg_6_0._scaleX = arg_6_0._scaleX + arg_6_0._scaleSpeed

	local var_6_1 = arg_6_0._cldComponent

	var_2.ResetSize(var_6_1, var_6_0[1] + arg_6_0._scaleX, var_6_0[2], var_6_0[3])

	return
end

function var_0_7.GetRadian(arg_7_0)
	local var_7_0

	if not arg_7_0._radCache then
		var_7_0 = arg_7_0:GetYAngle()
		math = var_1_10002
		var_7_0 = var_7_0 * var_1_10002.deg2Rad
	end

	local var_7_1

	if not arg_7_0._cosCache then
		math = var_7_1
		var_7_1 = var_7_1.cos(var_7_0)
	end

	local var_7_2

	if not arg_7_0._sinCache then
		math = var_7_2
		var_7_2 = var_7_2.sin(var_7_0)
	end

	return var_7_0, var_7_1, var_7_2
end

return
