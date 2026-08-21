ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.InterruptState = class("InterruptState", ys.Battle.IUnitState)
ys.Battle.InterruptState.__name = "InterruptState"

local var_0_1 = ys.Battle.InterruptState

function ys.Battle.InterruptState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.InterruptState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.InterruptState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.InterruptState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.InterruptState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.InterruptState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.InterruptState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.InterruptState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.InterruptState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.InterruptState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.InterruptState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.InterruptState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.InterruptState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.InterruptState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	return
end

function ys.Battle.InterruptState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:OnDivingState()

	return
end

function ys.Battle.InterruptState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.InterruptState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.InterruptState.OnTrigger(arg_18_0, arg_18_1)
	arg_18_1:GetTarget():SetInterruptSickness(true)

	return
end

function ys.Battle.InterruptState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.InterruptState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:GetTarget():SetInterruptSickness(false)
	arg_20_1:ChangeToMoveState()

	return
end

function ys.Battle.InterruptState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.InterruptState.FreshActionKeyOffset(arg_22_0)
	return false
end

function ys.Battle.InterruptState.GetActionName(arg_23_0, arg_23_1)
	return var_0_0.INTERRUPT
end

return
