ys = ys or {}

local var_0_0 = class("AutoPilotMoveRelative", ys.Battle.IPilot)

ys.Battle.AutoPilotMoveRelative = var_0_0
var_0_0.__name = "AutoPilotMoveRelative"

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	return
end

function var_0_0.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._distX = arg_2_1.x
	arg_2_0._distZ = arg_2_1.z

	return
end

function var_0_0.Active(arg_3_0, arg_3_1)
	arg_3_0._targetPos = Vector3(arg_3_0._distX * arg_3_1:GetDirection(), 0, arg_3_0._distZ):Add(arg_3_1:GetPosition())

	var_0_0.super.Active(arg_3_0, arg_3_1)

	return
end

function var_0_0.GetDirection(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0._targetPos - arg_4_1

	var_4_0.y = 0

	if var_4_0.magnitude < arg_4_0._valve then
		var_4_0 = Vector3.zero

		if arg_4_0._duration == -1 or arg_4_0:IsExpired() then
			arg_4_0:Finish()
		end
	end

	return var_4_0:SetNormalize()
end

return
