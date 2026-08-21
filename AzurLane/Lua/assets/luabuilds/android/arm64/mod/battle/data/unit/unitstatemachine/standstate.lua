ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.StandState = class("StandState", ys.Battle.IUnitState)
ys.Battle.StandState.__name = "StandState"

local var_0_1 = ys.Battle.StandState

function ys.Battle.StandState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.StandState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.StandState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.StandState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.StandState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.StandState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	return
end

function ys.Battle.StandState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.StandState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.StandState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	return
end

function ys.Battle.StandState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	return
end

function ys.Battle.StandState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.StandState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.StandState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.StandState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.StandState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:OnDivingState()

	return
end

function ys.Battle.StandState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.StandState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.StandState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.StandState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.StandState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:OnVictoryState()

	return
end

function ys.Battle.StandState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.StandState.FreshActionKeyOffset(arg_22_0)
	return false
end

function ys.Battle.StandState.GetActionName(arg_23_0, arg_23_1)
	return var_0_0.STAND
end

return
