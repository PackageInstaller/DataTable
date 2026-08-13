ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffActionKeyOffset = var_0_10002("BattleBuffActionKeyOffset", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffActionKeyOffset.__name = "BattleBuffActionKeyOffset"

local var_0_2 = var_0.Battle.BattleBuffActionKeyOffset

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._actionKey = arg_2_0._tempData.arg_list.key

	return
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1:ActionKeyOffsetUseable() then
		arg_3_1:SetActionKeyOffset(arg_3_0._actionKey)
	end

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1:ActionKeyOffsetUseable() then
		arg_4_1:SetActionKeyOffset(nil)
	end

	return
end

return
