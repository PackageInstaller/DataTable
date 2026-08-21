ys = ys or {}

local var_0_0 = class("AutoPilotRelativeFleetMoveTo", ys.Battle.IPilot)

ys.Battle.AutoPilotRelativeFleetMoveTo = var_0_0
var_0_0.__name = "AutoPilotRelativeFleetMoveTo"

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	return
end

function var_0_0.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._offsetX = arg_2_1.offsetX
	arg_2_0._offsetZ = arg_2_1.offsetZ
	arg_2_0._fixX = arg_2_1.X
	arg_2_0._fixZ = arg_2_1.Z
	arg_2_0._targetFleetVO = var_0.Battle.BattleDataProxy.GetInstance():GetFleetByIFF(var_0.Battle.BattleConfig.FRIENDLY_CODE)

	return
end

function var_0_0.GetDirection(arg_3_0, arg_3_1)
	if arg_3_0:IsExpired() then
		arg_3_0:Finish()

		return Vector3.zero
	end

	local var_3_0
	local var_3_1
	local var_3_2 = arg_3_0._targetFleetVO:GetMotion():GetPos()

	var_3_0 = arg_3_0._offsetX and var_3_2.x + arg_3_0._offsetX or arg_3_0._fixX and arg_3_0._fixX or arg_3_1.x
	var_3_1 = arg_3_0._offsetZ and var_3_2.z + arg_3_0._offsetZ or arg_3_0._fixZ and arg_3_0._fixZ or arg_3_1.z

	local var_3_3 = Vector3.New(var_3_0, 0, var_3_1) - arg_3_1

	var_3_3.y = 0

	if var_3_3.magnitude < arg_3_0._valve then
		var_3_3 = Vector3.zero
	end

	return var_3_3.normalized
end

return
