ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotHiveRelativeStay", var_0.Battle.IPilot)

var_0.Battle.AutoPilotHiveRelativeStay = var_0_1
var_0_1.__name = "AutoPilotHiveRelativeStay"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._distX = arg_2_1.x
	arg_2_0._distZ = arg_2_1.z

	return
end

function var_0_1.GetDirection(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._pilot
	local var_3_1 = var_2.GetHiveUnit(var_3_0)

	if not var_2.IsAlive(var_3_1) then
		local var_3_2 = arg_3_0._pilot

		var_3.OnHiveUnitDead(var_3_2)

		Vector3 = var_3

		return var_3.zero
	end

	local var_3_3 = var_2:GetPosition()

	Vector3 = var_3_0

	local var_3_4 = var_3_0(var_3_3.x + arg_3_0._distX, arg_3_1.y, var_3_3.z + arg_3_0._distZ) - arg_3_1

	if arg_3_0:IsExpired() then
		arg_3_0:Finish()
	end

	if var_3_4.magnitude < 0.4 then
		Vector3 = var_6

		return var_6.zero
	else
		var_3_4.y = 0

		return var_3_4:SetNormalize()
	end

	return
end

return
