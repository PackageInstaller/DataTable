ys = ys or {}

local var_0_0 = class("BattleCubeCldComponent", ys.Battle.BattleCldComponent)

ys.Battle.BattleCubeCldComponent = var_0_0
var_0_0.__name = "BattleCubeCldComponent"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4, arg_1_5)
	var_0.Battle.BattleCubeCldComponent.super.Ctor(arg_1_0)

	arg_1_0._offsetX = arg_1_4
	arg_1_0._offsetZ = arg_1_5
	arg_1_0._offset = Vector3(arg_1_4, 0, arg_1_5)
	arg_1_0._boxSize = Vector3.zero
	arg_1_0._min = Vector3.zero
	arg_1_0._max = Vector3.zero

	arg_1_0:ResetSize(arg_1_1, arg_1_2, arg_1_3)

	arg_1_0._box = pg.CldNode.New()

	return
end

function var_0_0.ResetOffset(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._offsetX = arg_2_1
	arg_2_0._offsetZ = arg_2_2
	arg_2_0._offset.x = arg_2_1
	arg_2_0._offset.z = arg_2_2

	return
end

function var_0_0.ResetSize(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_0._boxSize.x = arg_3_1 * 0.5
	arg_3_0._boxSize.y = arg_3_2 * 0.5
	arg_3_0._boxSize.z = arg_3_3 * 0.5
	arg_3_0._min.x = arg_3_0._offsetX - arg_3_1 * 0.5
	arg_3_0._min.y = -(arg_3_2 * 0.5)
	arg_3_0._min.z = arg_3_0._offsetZ - arg_3_3 * 0.5
	arg_3_0._max.x = arg_3_0._offsetX + arg_3_1 * 0.5
	arg_3_0._max.y = arg_3_2 * 0.5
	arg_3_0._max.z = arg_3_0._offsetZ + arg_3_3 * 0.5

	return
end

function var_0_0.GetCldBox(arg_4_0, arg_4_1)
	if arg_4_1 then
		arg_4_0._cldData.LeftBound = arg_4_1.x - math.abs(arg_4_0._min.x)
		arg_4_0._cldData.RightBound = arg_4_1.x + math.abs(arg_4_0._max.x)
		arg_4_0._cldData.LowerBound = arg_4_1.z - math.abs(arg_4_0._min.z)
		arg_4_0._cldData.UpperBound = arg_4_1.z + math.abs(arg_4_0._max.z)
	end

	return arg_4_0._box:UpdateBox(arg_4_0._min, arg_4_0._max, arg_4_1)
end

function var_0_0.GetCldBoxSize(arg_5_0)
	return arg_5_0._boxSize
end

return
