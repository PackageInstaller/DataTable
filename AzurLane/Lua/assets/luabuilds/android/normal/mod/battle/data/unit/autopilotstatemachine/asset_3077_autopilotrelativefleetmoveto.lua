ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotRelativeFleetMoveTo", var_0.Battle.IPilot)

var_0.Battle.AutoPilotRelativeFleetMoveTo = var_0_1
var_0_1.__name = "AutoPilotRelativeFleetMoveTo"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._offsetX = arg_2_1.offsetX
	arg_2_0._offsetZ = arg_2_1.offsetZ
	arg_2_0._fixX = arg_2_1.X
	arg_2_0._fixZ = arg_2_1.Z

	local var_2_0 = var_0.Battle.BattleDataProxy.GetInstance()

	arg_2_0._targetFleetVO = var_3.GetFleetByIFF(var_2_0, var_0.Battle.BattleConfig.FRIENDLY_CODE)

	return
end

function var_0_1.GetDirection(arg_3_0, arg_3_1)
	if arg_3_0:IsExpired() then
		arg_3_0:Finish()

		Vector3 = var_2

		return var_2.zero
	end

	local var_3_0
	local var_3_1
	local var_3_2 = arg_3_0._targetFleetVO
	local var_3_3 = var_4.GetMotion(var_3_2)
	local var_3_4 = var_4.GetPos(var_3_3)

	if arg_3_0._offsetX then
		var_3_0 = var_3_4.x + arg_3_0._offsetX
	elseif arg_3_0._fixX then
		var_3_0 = arg_3_0._fixX
	else
		var_3_0 = arg_3_1.x
	end

	if arg_3_0._offsetZ then
		var_3_1 = var_3_4.z + arg_3_0._offsetZ
	elseif arg_3_0._fixZ then
		var_3_1 = arg_3_0._fixZ
	else
		var_3_1 = arg_3_1.z
	end

	Vector3 = var_5

	local var_3_5 = var_5.New(var_3_0, 0, var_3_1) - arg_3_1

	var_3_5.y = 0

	if var_3_5.magnitude < arg_3_0._valve then
		Vector3 = var_7
		var_3_5 = var_7.zero
	end

	return var_3_5.normalized
end

return
