ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotMinionRelativeStay", var_0.Battle.IPilot)

var_0.Battle.AutoPilotMinionRelativeStay = var_0_1
var_0_1.__name = "AutoPilotMinionRelativeStay"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._distX = arg_2_1.x
	arg_2_0._distZ = arg_2_1.z
	arg_2_0._nextBuffID = arg_2_1.buffID

	return
end

function var_0_1.GetDirection(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_0._pilot
	local var_3_1 = var_2.GetTarget(var_3_0)
	local var_3_2 = var_2.GetMaster(var_3_1)

	if not var_2.IsAlive(var_3_2) then
		local var_3_3

		if arg_3_0._nextBuffID then
			var_3_3 = var_0.Battle.BattleBuffUnit.New(arg_3_0._nextBuffID)

			local var_3_4 = arg_3_0._pilot
			local var_3_5 = var_3_1.GetTarget(var_3_4)

			var_3_1.AddBuff(var_3_5, var_3_3)
		end

		Vector3 = var_3_3

		return var_3_3.zero
	end

	local var_3_6 = var_2:GetPosition()

	Vector3 = var_3_1

	local var_3_7 = var_3_1(var_3_6.x + arg_3_0._distX, arg_3_1.y, var_3_6.z + arg_3_0._distZ) - arg_3_1

	if arg_3_0:IsExpired() then
		arg_3_0:Finish()
	end

	if var_3_7.magnitude < 0.4 then
		Vector3 = var_6

		return var_6.zero
	else
		var_3_7.y = 0

		return var_3_7:SetNormalize()
	end

	return
end

return
