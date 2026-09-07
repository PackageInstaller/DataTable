ys = ys or {}

local var_0_0 = ys

ys.Battle.DivingState = class("DivingState", ys.Battle.IUnitState)
ys.Battle.DivingState.__name = "DivingState"

local var_0_2 = ys.Battle.DivingState

function ys.Battle.DivingState.Ctor(arg_1_0)
	var_0_2.super.Ctor()

	return
end

function ys.Battle.DivingState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.DivingState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.DivingState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.DivingState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.DivingState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.DivingState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.DivingState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.DivingState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.DivingState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.DivingState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.DivingState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.DivingState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.DivingState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	return
end

function ys.Battle.DivingState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.DivingState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.DivingState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.DivingState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.DivingState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.DivingState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:ChangeOxyState(var_0_0.Battle.OxyState.STATE_DIVE)
	arg_20_1:ChangeToMoveState()

	return
end

function ys.Battle.DivingState.CacheWeapon(arg_21_0)
	return false
end

function ys.Battle.DivingState.FreshActionKeyOffset(arg_22_0)
	return false
end

return
