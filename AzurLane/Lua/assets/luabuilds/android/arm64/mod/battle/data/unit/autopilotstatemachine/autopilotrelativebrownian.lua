ys = ys or {}

local var_0_0 = class("AutoPilotRelativeBrownian", ys.Battle.IPilot)

ys.Battle.AutoPilotRelativeBrownian = var_0_0
var_0_0.__name = "AutoPilotRelativeBrownian"

function var_0_0.Ctor(arg_1_0, ...)
	var_0_0.super.Ctor(arg_1_0, ...)

	return
end

function var_0_0.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_0.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._randomPoint = {
		X1 = arg_2_1.X1,
		X2 = arg_2_1.X2,
		Z1 = arg_2_1.Z1,
		Z2 = arg_2_1.Z2
	}
	arg_2_0._stop = arg_2_1.stopCount
	arg_2_0._move = arg_2_1.moveCount
	arg_2_0._random = arg_2_1.randomCount or 30

	return
end

function var_0_0.Active(arg_3_0, arg_3_1)
	arg_3_0._stopCount = arg_3_0._stop
	arg_3_0._moveCount = 0
	arg_3_0._randomCount = 0

	local var_3_0 = Clone(arg_3_1:GetPosition())

	arg_3_0._relativePoint = {
		X1 = arg_3_0._randomPoint.X1 + var_3_0.x,
		X2 = arg_3_0._randomPoint.X2 + var_3_0.x,
		Z1 = arg_3_0._randomPoint.Z1 + var_3_0.z,
		Z2 = arg_3_0._randomPoint.Z2 + var_3_0.z
	}
	arg_3_0._referencePoint = var_0.Battle.BattleFormulas.RandomPos(arg_3_0._relativePoint)

	var_0_0.super.Active(arg_3_0, arg_3_1)

	return
end

function var_0_0.GetDirection(arg_4_0, arg_4_1)
	if arg_4_0:IsExpired() then
		arg_4_0:Finish()

		return Vector3.zero
	end

	arg_4_0._moveCount = arg_4_0._moveCount or 0

	if arg_4_0._stop > arg_4_0._stopCount then
		arg_4_0._stopCount = arg_4_0._stopCount + 1

		return Vector3.zero
	end

	local var_4_0 = arg_4_0._referencePoint - arg_4_1

	if (arg_4_0._referencePoint - arg_4_1).magnitude < 0.4 or arg_4_0._randomCount > arg_4_0._random then
		if arg_4_0._move < arg_4_0._moveCount then
			arg_4_0._stopCount = 0
			arg_4_0._moveCount = 0
		else
			arg_4_0._randomCount = 0

			local var_4_1 = var_0.Battle.BattleFormulas.RandomPos(arg_4_0._relativePoint)

			while Vector3.SqrDistance(var_4_1, arg_4_1) < 5 do
				var_4_1 = var_0.Battle.BattleFormulas.RandomPos(arg_4_0._relativePoint)
			end

			arg_4_0._referencePoint = var_4_1
		end

		return Vector3.zero
	else
		arg_4_0._randomCount = arg_4_0._randomCount + 1
		arg_4_0._moveCount = arg_4_0._moveCount + 1

		return var_4_0.normalized
	end

	return
end

return
