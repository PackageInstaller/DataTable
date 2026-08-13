ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleColumnCldComponent", var_0.Battle.BattleCldComponent)

var_0.Battle.BattleColumnCldComponent = var_0_1
var_0_1.__name = "BattleColumnCldComponent"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0.Battle.BattleColumnCldComponent.super.Ctor(arg_1_0)

	arg_1_0._range = arg_1_1 * 0.5
	arg_1_0._tickness = arg_1_2 * 0.5
	pg = var_3
	arg_1_0._box = var_3.CldNode.New()

	return
end

function var_0_1.GetCldBox(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._box

	return var_2.UpdateCylinder(var_2_0, arg_2_1, arg_2_0._tickness, arg_2_0._range)
end

function var_0_1.GetCldBoxSize(arg_3_0)
	return {
		range = arg_3_0._range,
		tickness = arg_3_0._tickness
	}
end

return
