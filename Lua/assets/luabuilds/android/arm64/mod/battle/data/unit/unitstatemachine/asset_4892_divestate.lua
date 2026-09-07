ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.DiveState = class("DiveState", ys.Battle.IUnitState)
ys.Battle.DiveState.__name = "DiveState"

local var_0_1 = ys.Battle.DiveState

function ys.Battle.DiveState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.DiveState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:OnIdleState()

	return
end

function ys.Battle.DiveState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:OnMoveState()

	return
end

function ys.Battle.DiveState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:OnMoveLeftState()

	return
end

function ys.Battle.DiveState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:OnRaidState(arg_5_2)

	return
end

function ys.Battle.DiveState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.DiveState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.DiveState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1:OnSpellState()

	return
end

function ys.Battle.DiveState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.DiveState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.DiveState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.DiveState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.DiveState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1:OnDiveLeftState()

	return
end

function ys.Battle.DiveState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.DiveState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.DiveState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.DiveState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.DiveState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.DiveState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.DiveState.OnEnd(arg_20_0, arg_20_1)
	return
end

function ys.Battle.DiveState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.DiveState.FreshActionKeyOffset(arg_22_0)
	return false
end

function ys.Battle.DiveState.GetActionName(arg_23_0, arg_23_1)
	return var_0_0.DIVE
end

return
