ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.SkillEndState = class("SkillEndState", ys.Battle.IUnitState)
ys.Battle.SkillEndState.__name = "SkillEndState"

local var_0_1 = ys.Battle.SkillEndState

function ys.Battle.SkillEndState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.SkillEndState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.SkillEndState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.SkillEndState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.SkillEndState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.SkillEndState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.SkillEndState.AddSpellState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.SkillEndState.AddSkillState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.SkillEndState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.SkillEndState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.SkillEndState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.SkillEndState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.SkillEndState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.SkillEndState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.SkillEndState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.SkillEndState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	return
end

function ys.Battle.SkillEndState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.SkillEndState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.SkillEndState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.SkillEndState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:ChangeToMoveState()

	return
end

function ys.Battle.SkillEndState.CacheWeapon(arg_21_0)
	return false
end

function ys.Battle.SkillEndState.FreshActionKeyOffset(arg_22_0)
	return false
end

function ys.Battle.SkillEndState.GetActionName(arg_23_0, arg_23_1)
	return var_0_0.SKILL_END
end

return
