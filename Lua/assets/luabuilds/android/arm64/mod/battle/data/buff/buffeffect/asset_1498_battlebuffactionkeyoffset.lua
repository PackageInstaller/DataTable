ys = ys or {}
ys.Battle.BattleBuffActionKeyOffset = class("BattleBuffActionKeyOffset", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffActionKeyOffset.__name = "BattleBuffActionKeyOffset"

local var_0_0 = ys.Battle.BattleBuffActionKeyOffset

function ys.Battle.BattleBuffActionKeyOffset.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffActionKeyOffset:SetArgs(arg_2_1, arg_2_2)
	self._actionKey = self._tempData.arg_list.key

	return
end

function ys.Battle.BattleBuffActionKeyOffset:onAttach(arg_3_1, arg_3_2)
	if arg_3_1:ActionKeyOffsetUseable() then
		arg_3_1:SetActionKeyOffset(self._actionKey)
	end

	return
end

function ys.Battle.BattleBuffActionKeyOffset.onRemove(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_1:ActionKeyOffsetUseable() then
		arg_4_1:SetActionKeyOffset(nil)
	end

	return
end

return
