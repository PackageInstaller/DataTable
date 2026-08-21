ys = ys or {}

local var_0_0 = class("BattleColumnCldComponent", ys.Battle.BattleCldComponent)

ys.Battle.BattleColumnCldComponent = var_0_0
var_0_0.__name = "BattleColumnCldComponent"

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0.Battle.BattleColumnCldComponent.super.Ctor(arg_1_0)

	arg_1_0._range = arg_1_1 * 0.5
	arg_1_0._tickness = arg_1_2 * 0.5
	arg_1_0._box = pg.CldNode.New()

	return
end

function var_0_0.GetCldBox(arg_2_0, arg_2_1)
	return arg_2_0._box:UpdateCylinder(arg_2_1, arg_2_0._tickness, arg_2_0._range)
end

function var_0_0.GetCldBoxSize(arg_3_0)
	return {
		range = arg_3_0._range,
		tickness = arg_3_0._tickness
	}
end

return
