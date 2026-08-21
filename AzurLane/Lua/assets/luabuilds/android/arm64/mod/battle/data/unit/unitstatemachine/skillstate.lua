ys = ys or {}
ys.Battle.SkillState = class("SkillState", ys.Battle.IUnitState)
ys.Battle.SkillState.__name = "SkillState"

local var_0_1 = ys.Battle.SkillState

function ys.Battle.SkillState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.SkillState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.SkillState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.SkillState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.SkillState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:OnAttackState(arg_5_2)

	return
end

function ys.Battle.SkillState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.SkillState.AddSpellState(arg_7_0, arg_7_1, arg_7_2)
	arg_7_1:OnSpellState()

	return
end

function ys.Battle.SkillState.AddSkillState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.SkillState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.SkillState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.SkillState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.SkillState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.SkillState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.SkillState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.SkillState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.SkillState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.SkillState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.SkillState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.SkillState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.SkillState.OnEnd(arg_20_0, arg_20_1)
	if arg_20_1:GetTarget():IsMoving() then
		arg_20_1:OnMoveState()
	else
		arg_20_1:OnIdleState()
	end

	return
end

function ys.Battle.SkillState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.SkillState.FreshActionKeyOffset(arg_22_0)
	return false
end

return
