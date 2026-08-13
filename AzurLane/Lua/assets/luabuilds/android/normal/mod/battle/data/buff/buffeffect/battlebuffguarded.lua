ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffGuarded", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffGuarded = var_0_1
var_0_1.__name = "BattleBuffGuarded"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_2:GetCaster()

	arg_2_0._casterUID = var_3.GetUniqueID(var_2_0)

	return
end

function var_0_1.onAttach(arg_3_0, arg_3_1, arg_3_2)
	var_0.Battle.BattleAttr.AddGuardianID(arg_3_1, arg_3_0._casterUID)

	return
end

function var_0_1.onRemove(arg_4_0, arg_4_1, arg_4_2)
	var_0.Battle.BattleAttr.RemoveGuardianID(arg_4_1, arg_4_0._casterUID)

	return
end

return
