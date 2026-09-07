ys = ys or {}

local var_0_0 = ys
local BattleBuffAntiSubMine = class("BattleBuffAntiSubMine", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffAntiSubMine = BattleBuffAntiSubMine
BattleBuffAntiSubMine.__name = "BattleBuffAntiSubMine"

function BattleBuffAntiSubMine:Ctor(arg_1_1)
	BattleBuffAntiSubMine.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffAntiSubMine:onAttach(arg_2_1)
	arg_2_1:InitOxygen()
	arg_2_1:ChangeOxygenState(var_0_0.Battle.OxyState.STATE_DEEP_MINE)

	return
end

return
