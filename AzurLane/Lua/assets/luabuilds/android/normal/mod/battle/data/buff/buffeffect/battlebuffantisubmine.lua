ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAntiSubMine", var_0.Battle.BattleBuffEffect)

var_0.Battle.BattleBuffAntiSubMine = var_0_1
var_0_1.__name = "BattleBuffAntiSubMine"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.onAttach(arg_2_0, arg_2_1)
	arg_2_1:InitOxygen()
	arg_2_1:ChangeOxygenState(var_0.Battle.OxyState.STATE_DEEP_MINE)

	return
end

return
