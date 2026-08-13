ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffCoverSpine = var_0_10002("BattleBuffCoverSpine", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffCoverSpine.__name = "BattleBuffCoverSpine"

local var_0_2 = var_0.Battle.BattleBuffCoverSpine

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._skin = arg_2_0._tempData.arg_list.ship_skin_id

	local var_2_0

	if not arg_2_0._tempData.arg_list.hp_bar_offset then
		var_2_0 = 0
	end

	arg_2_0._hpbarOffset = var_2_0

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
	arg_3_1:SwitchSpine(arg_3_0._skin, arg_3_0._hpbarOffset)

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_1:SwitchSpine(nil, arg_4_0._hpbarOffset * -1)

	return
end

return
