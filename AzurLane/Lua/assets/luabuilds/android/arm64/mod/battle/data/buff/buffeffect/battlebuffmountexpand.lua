ys = ys or {}

local var_0_0 = class("BattleBuffMountExpand", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffMountExpand = var_0_0
var_0_0.__name = "BattleBuffMountExpand"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._weaponIndex = arg_2_0._tempData.arg_list.index

	return
end

function var_0_0.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:ExpandWeaponMount(arg_3_0._weaponIndex)

	return
end

return
