ys = ys or {}
ys.Battle.BattleBuffCoverSpine = class("BattleBuffCoverSpine", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffCoverSpine.__name = "BattleBuffCoverSpine"

local var_0_0 = ys.Battle.BattleBuffCoverSpine

function ys.Battle.BattleBuffCoverSpine.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffCoverSpine:SetArgs(arg_2_1, arg_2_2)
	self._skin = self._tempData.arg_list.ship_skin_id
	self._hpbarOffset = self._tempData.arg_list.hp_bar_offset or 0

	return
end

function ys.Battle.BattleBuffCoverSpine:onAttach(arg_3_1, arg_3_2, arg_3_3)
	arg_3_1:SwitchSpine(self._skin, self._hpbarOffset)

	return
end

function ys.Battle.BattleBuffCoverSpine:onRemove(arg_4_1, arg_4_2, arg_4_3)
	arg_4_1:SwitchSpine(nil, self._hpbarOffset * -1)

	return
end

return
