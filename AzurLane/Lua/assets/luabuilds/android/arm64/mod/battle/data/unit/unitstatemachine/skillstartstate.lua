ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.SkillStartState = class("SkillStartState", ys.Battle.IUnitState)
ys.Battle.SkillStartState.__name = "SkillStartState"

local var_0_1 = ys.Battle.SkillStartState

function ys.Battle.SkillStartState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.SkillStartState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.SkillStartState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.SkillStartState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.SkillStartState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.SkillStartState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.SkillStartState.AddSpellState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.SkillStartState.AddSkillState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.SkillStartState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.SkillStartState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.SkillStartState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.SkillStartState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.SkillStartState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.SkillStartState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.SkillStartState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.SkillStartState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	return
end

function ys.Battle.SkillStartState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	arg_17_1:OnSkillEndState()

	return
end

function ys.Battle.SkillStartState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.SkillStartState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.SkillStartState.OnEnd(arg_20_0, arg_20_1)
	return
end

function ys.Battle.SkillStartState.CacheWeapon(arg_21_0)
	return false
end

function ys.Battle.SkillStartState.FreshActionKeyOffset(arg_22_0)
	return false
end

function ys.Battle.SkillStartState.GetActionName(arg_23_0, arg_23_1)
	return var_0_0.SKILL_START
end

return
