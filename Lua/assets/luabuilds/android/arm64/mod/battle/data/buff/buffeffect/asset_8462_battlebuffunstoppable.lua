ys = ys or {}

local BattleBuffUnstoppable = class("BattleBuffUnstoppable", ys.Battle.BattleBuffEffect)

ys.Battle.BattleBuffUnstoppable = BattleBuffUnstoppable
BattleBuffUnstoppable.__name = "BattleBuffUnstoppable"

function BattleBuffUnstoppable:Ctor(arg_1_1)
	BattleBuffUnstoppable.super.Ctor(self, arg_1_1)

	return
end

function BattleBuffUnstoppable:onAttach(arg_2_1, arg_2_2)
	arg_2_1:ActiveUnstoppable(true)

	return
end

function BattleBuffUnstoppable:onRemove(arg_3_1, arg_3_2)
	arg_3_1:ActiveUnstoppable(false)

	return
end

return
