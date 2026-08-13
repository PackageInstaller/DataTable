ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst

class = var_0_10002

local var_0_2 = var_0_10002("BattleLaserEffect", var_0.Battle.BattleEffectArea)

var_0.Battle.BattleLaserEffect = var_0_2
var_0_2.__name = "BattleLaserEffect"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	return
end

function var_0_2.SetStatic(arg_2_0)
	return
end

function var_0_2.Init(arg_3_0)
	arg_3_0._tf = arg_3_0._go.transform
	GetComponent = var_1
	arg_3_0._laserScript = var_1(arg_3_0._go, "LaserScript")
	arg_3_0._waveCount = 0

	arg_3_0:Update()

	return
end

function var_0_2.Update(arg_4_0)
	arg_4_0:updateLineRenderer()
	arg_4_0:UpdatePosition()

	return
end

function var_0_2.updateLineRenderer(arg_5_0)
	local var_5_0 = arg_5_0._aoeData
	local var_5_1 = var_1.GetHeight(var_5_0)
	local var_5_2 = arg_5_0._laserScript

	math = var_1_10003

	local var_5_3 = var_1_10003.cos
	local var_5_4 = arg_5_0._waveCount

	math = var_1_10005
	var_5_2.width = var_5_1 + var_5_3(var_5_4 * var_1_10005.deg2Rad * 3)
	arg_5_0._waveCount = arg_5_0._waveCount + 1

	local var_5_5 = arg_5_0._laserScript
	local var_5_6 = arg_5_0._aoeData

	var_5_5.length = var_3.GetWidth(var_5_6)

	local var_5_7 = arg_5_0._aoeData
	local var_5_8 = var_2.GetAngle(var_5_7)

	math = var_5_7

	local var_5_9 = var_5_8 * var_5_7.deg2Rad
	local var_5_10 = arg_5_0._aoeData

	if var_3.GetIFF(var_5_10) == -1 then
		math = var_3
		var_5_9 = var_5_9 + var_3.pi
	end

	arg_5_0._laserScript.angle = var_5_9

	return
end

return
