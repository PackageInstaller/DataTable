ys = ys or {}

local var_0_0 = ys

ys.Battle.BattleBuffStun = class("BattleBuffStun", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffStun.__name = "BattleBuffStun"

local var_0_1 = ys.Battle.BattleBuffStun

function ys.Battle.BattleBuffStun.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffStun.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.BattleBuffStun.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0:onTrigger(arg_3_1, arg_3_2)

	return
end

function ys.Battle.BattleBuffStun.onUpdate(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:onTrigger(arg_4_1, arg_4_2)

	return
end

function ys.Battle.BattleBuffStun.onTrigger(arg_5_0, arg_5_1, arg_5_2)
	var_0_1.super.onTrigger(arg_5_0, arg_5_1, arg_5_2)
	var_0_0.Battle.BattleAttr.Stun(arg_5_1)
	arg_5_1:UpdateMoveLimit()

	return
end

function ys.Battle.BattleBuffStun.onRemove(arg_6_0, arg_6_1, arg_6_2)
	var_0_0.Battle.BattleAttr.CancelStun(arg_6_1)
	arg_6_1:UpdateMoveLimit()

	return
end

return
