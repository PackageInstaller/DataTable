ys = ys or {}

local var_0_0 = class("BattleBuffCease", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffCease = var_0_0
var_0_0.__name = "BattleBuffCease"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.onAttach(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:CeaseAllWeapon(true)

	return
end

function var_0_0.onRemove(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:CeaseAllWeapon(false)

	return
end

return
