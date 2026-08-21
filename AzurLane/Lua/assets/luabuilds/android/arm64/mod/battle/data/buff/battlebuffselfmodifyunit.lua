ys = ys or {}

local var_0_2 = class("BattleBuffSelfModifyUnit", ys.Battle.BattleBuffUnit)

ys.Battle.BattleBuffSelfModifyUnit = var_0_2
var_0_2.__name = "BattleBuffSelfModifyUnit"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)
	arg_1_0._selfModifyTempData = arg_1_4

	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3, arg_1_4)

	return
end

function var_0_2.SetTemplate(arg_2_0)
	arg_2_0._tempData = arg_2_0._selfModifyTempData

	return
end

return
