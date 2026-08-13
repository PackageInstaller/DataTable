ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleCubeCldComponent", var_0.Battle.BattleCldComponent)

var_0.Battle.BattleCubeCldComponent = var_0_1
var_0_1.__name = "BattleCubeCldComponent"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0.Battle.BattleCubeCldComponent.super.Ctor(arg_1_0)

	arg_1_0._offsetX = arg_1_4
	arg_1_0._offsetZ = arg_1_5
	Vector3 = var_6
	arg_1_0._offset = var_6(arg_1_4, 0, arg_1_5)
	Vector3 = var_6
	arg_1_0._boxSize = var_6.zero
	Vector3 = var_6
	arg_1_0._min = var_6.zero
	Vector3 = var_6
	arg_1_0._max = var_6.zero

	arg_1_0:ResetSize(arg_1_1, arg_1_2, arg_1_3)

	pg = var_6
	arg_1_0._box = var_6.CldNode.New()

	return
end

function var_0_1.ResetOffset(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._offsetX = arg_2_1
	arg_2_0._offsetZ = arg_2_2
	arg_2_0._offset.x = arg_2_1
	arg_2_0._offset.z = arg_2_2

	return
end

function var_0_1.ResetSize(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	local var_3_0 = arg_3_1 * 0.5
	local var_3_1 = arg_3_2 * 0.5
	local var_3_2 = arg_3_3 * 0.5

	arg_3_0._boxSize.x = var_3_0
	arg_3_0._boxSize.y = var_3_1
	arg_3_0._boxSize.z = var_3_2
	arg_3_0._min.x = arg_3_0._offsetX - var_3_0
	arg_3_0._min.y = -var_3_1
	arg_3_0._min.z = arg_3_0._offsetZ - var_3_2
	arg_3_0._max.x = arg_3_0._offsetX + var_3_0
	arg_3_0._max.y = var_3_1
	arg_3_0._max.z = arg_3_0._offsetZ + var_3_2

	return
end

function var_0_1.GetCldBox(arg_4_0, arg_4_1)
	if arg_4_1 then
		local var_4_0 = arg_4_0._cldData
		local var_4_1 = arg_4_1.x

		math = var_1_10004
		var_4_0.LeftBound = var_4_1 - var_1_10004.abs(arg_4_0._min.x)

		local var_4_2 = arg_4_0._cldData
		local var_4_3 = arg_4_1.x

		math = var_4
		var_4_2.RightBound = var_4_3 + var_4.abs(arg_4_0._max.x)

		local var_4_4 = arg_4_0._cldData
		local var_4_5 = arg_4_1.z

		math = var_4
		var_4_4.LowerBound = var_4_5 - var_4.abs(arg_4_0._min.z)

		local var_4_6 = arg_4_0._cldData
		local var_4_7 = arg_4_1.z

		math = var_4
		var_4_6.UpperBound = var_4_7 + var_4.abs(arg_4_0._max.z)
	end

	local var_4_8 = arg_4_0._box

	return var_2.UpdateBox(var_4_8, arg_4_0._min, arg_4_0._max, arg_4_1)
end

function var_0_1.GetCldBoxSize(arg_5_0)
	return arg_5_0._boxSize
end

return
