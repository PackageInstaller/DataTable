ys = ys or {}

local var_0_0 = class("AutoPilotHiveRelativeStay", ys.Battle.IPilot)

ys.Battle.AutoPilotHiveRelativeStay = var_0_0
var_0_0.__name = "AutoPilotHiveRelativeStay"

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

function var_0_0.GetDirection(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._pilot:GetHiveUnit()

	if not var_3_0:IsAlive() then
		arg_3_0._pilot:OnHiveUnitDead()

		return Vector3.zero
	end

	local var_3_1 = var_3_0:GetPosition()
	local var_3_2 = Vector3(var_3_1.x + arg_3_0._distX, arg_3_1.y, var_3_1.z + arg_3_0._distZ) - arg_3_1

	if arg_3_0:IsExpired() then
		arg_3_0:Finish()
	end

	if var_3_2.magnitude < 0.4 then
		return Vector3.zero
	else
		var_3_2.y = 0

		return var_3_2:SetNormalize()
	end

	return
end

return
