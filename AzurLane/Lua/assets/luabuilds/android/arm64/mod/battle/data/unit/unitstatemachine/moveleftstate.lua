ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.ActionName
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.MoveLeftState = var_0_10003("MoveLeftState", var_0.Battle.IUnitState)
var_0.Battle.MoveLeftState.__name = "MoveLeftState"

local var_0_3 = var_0.Battle.MoveLeftState

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor()

	return
end

function var_0_3.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:OnIdleState()

	return
end

function var_0_3.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:OnMoveState()

	return
end

function var_0_3.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function var_0_3.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:OnAttackLeftState(arg_5_2)

	return
end

function var_0_3.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function var_0_3.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function var_0_3.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1:OnSpellState()

	return
end

function var_0_3.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function var_0_3.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function var_0_3.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function var_0_3.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:OnDiveState()

	return
end

function var_0_3.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1:OnDiveLeftState()

	return
end

function var_0_3.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function var_0_3.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:OnDivingState()

	return
end

function var_0_3.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function var_0_3.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function var_0_3.OnTrigger(arg_18_0, arg_18_1)
	return
end

function var_0_3.OnStart(arg_19_0, arg_19_1)
	return
end

function var_0_3.OnEnd(arg_20_0, arg_20_1)
	return
end

function var_0_3.CacheWeapon(arg_21_0)
	return true
end

function var_0_3.FreshActionKeyOffset(arg_22_0)
	return true
end

function var_0_3.GetActionName(arg_23_0, arg_23_1)
	local var_23_0 = var_0_1.MOVELEFT

	if arg_23_1:ActionKeyOffset() then
		var_23_0 = var_23_0 .. var_3
	end

	return var_23_0
end

return
