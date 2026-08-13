ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("AutoPilotRelativeBrownian", var_0.Battle.IPilot)

var_0.Battle.AutoPilotRelativeBrownian = var_0_1
var_0_1.__name = "AutoPilotRelativeBrownian"

function var_0_1.Ctor(arg_1_0, ...)
	var_0_1.super.Ctor(arg_1_0, ...)

	return
end

function var_0_1.SetParameter(arg_2_0, arg_2_1, arg_2_2)
	var_0_1.super.SetParameter(arg_2_0, arg_2_1, arg_2_2)

	arg_2_0._randomPoint = {
		X1 = arg_2_1.X1,
		X2 = arg_2_1.X2,
		Z1 = arg_2_1.Z1,
		Z2 = arg_2_1.Z2
	}
	arg_2_0._stop = arg_2_1.stopCount
	arg_2_0._move = arg_2_1.moveCount

	local var_2_0

	if not arg_2_1.randomCount then
		var_2_0 = 30
	end

	arg_2_0._random = var_2_0

	return
end

function var_0_1.Active(arg_3_0, arg_3_1)
	arg_3_0._stopCount = arg_3_0._stop
	arg_3_0._moveCount = 0
	arg_3_0._randomCount = 0
	Clone = var_2

	local var_3_0 = var_2(arg_3_1:GetPosition())

	arg_3_0._relativePoint = {
		X1 = arg_3_0._randomPoint.X1 + var_3_0.x,
		X2 = arg_3_0._randomPoint.X2 + var_3_0.x,
		Z1 = arg_3_0._randomPoint.Z1 + var_3_0.z,
		Z2 = arg_3_0._randomPoint.Z2 + var_3_0.z
	}
	arg_3_0._referencePoint = var_0.Battle.BattleFormulas.RandomPos(arg_3_0._relativePoint)

	var_0_1.super.Active(arg_3_0, arg_3_1)

	return
end

function var_0_1.GetDirection(arg_4_0, arg_4_1)
	if arg_4_0:IsExpired() then
		arg_4_0:Finish()

		Vector3 = var_2

		return var_2.zero
	end

	local var_4_0

	if not arg_4_0._moveCount then
		var_4_0 = 0
	end

	arg_4_0._moveCount = var_4_0

	if arg_4_0._stop > arg_4_0._stopCount then
		arg_4_0._stopCount = arg_4_0._stopCount + 1
		Vector3 = var_2

		return var_2.zero
	end

	if (arg_4_0._referencePoint - arg_4_1).magnitude < 0.4 or arg_4_0._randomCount > arg_4_0._random then
		local var_4_1

		if arg_4_0._move < arg_4_0._moveCount then
			arg_4_0._stopCount = 0
			arg_4_0._moveCount = 0
		else
			arg_4_0._randomCount = 0
			var_4_1 = var_0.Battle.BattleFormulas.RandomPos(arg_4_0._relativePoint)

			local var_4_2 = 0

			::label_4_0::

			Vector3 = var_5

			if var_5.SqrDistance(var_4_1, arg_4_1) < 5 then
				repeat
					var_4_1 = var_0.Battle.BattleFormulas.RandomPos(arg_4_0._relativePoint)
					var_4_2 = var_4_2 + 1

					goto label_4_0
				until true
			end

			arg_4_0._referencePoint = var_4_1
		end

		Vector3 = var_4_1

		return var_4_1.zero
	else
		arg_4_0._randomCount = arg_4_0._randomCount + 1
		arg_4_0._moveCount = arg_4_0._moveCount + 1

		return var_2.normalized
	end

	return
end

return
