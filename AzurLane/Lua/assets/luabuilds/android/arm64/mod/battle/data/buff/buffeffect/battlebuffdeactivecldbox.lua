ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffDeactiveCLDBox = var_0_10002("BattleBuffDeactiveCLDBox", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffDeactiveCLDBox.__name = "BattleBuffDeactiveCLDBox"

local var_0_2 = var_0.Battle.BattleBuffDeactiveCLDBox

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.GetEffectType(arg_2_0)
	return var_0_2.FX_TYPE
end

function var_0_2.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:SetCldBoxImmune(true)

	return
end

function var_0_2.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:SetCldBoxImmune(false)

	return
end

return
