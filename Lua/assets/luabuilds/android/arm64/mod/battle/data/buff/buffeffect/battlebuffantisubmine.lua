ys = ys or {}

local var_0_0 = class("BattleBuffAntiSubMine", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAntiSubMine = var_0_0
var_0_0.__name = "BattleBuffAntiSubMine"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.onAttach(arg_2_0, arg_2_1)
	arg_2_1:InitOxygen()
	arg_2_1:ChangeOxygenState(var_0.Battle.OxyState.STATE_DEEP_MINE)

	return
end

return
