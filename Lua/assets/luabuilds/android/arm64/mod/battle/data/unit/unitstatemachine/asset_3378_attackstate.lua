ys = ys or {}
ys.Battle.AttackState = class("AttackState", ys.Battle.IUnitState)
ys.Battle.AttackState.__name = "AttackState"

local var_0_1 = ys.Battle.AttackState

function ys.Battle.AttackState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.AttackState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.AttackState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.AttackState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.AttackState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.AttackState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.AttackState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.AttackState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1:OnSpellState()

	return
end

function ys.Battle.AttackState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.AttackState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.AttackState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.AttackState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.AttackState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.AttackState:AddInterruptState(arg_14_1, arg_14_2)
	self:OnTrigger(arg_14_1)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.AttackState:AddDivingState(arg_15_1, arg_15_2)
	self:OnTrigger(arg_15_1)
	arg_15_1:OnDivingState()

	return
end

function ys.Battle.AttackState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.AttackState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.AttackState.OnTrigger(arg_18_0, arg_18_1)
	arg_18_1:GetTarget():SendAttackTrigger()

	return
end

function ys.Battle.AttackState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.AttackState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:ChangeToMoveState()

	return
end

function ys.Battle.AttackState.CacheWeapon(arg_21_0)
	return false
end

function ys.Battle.AttackState.FreshActionKeyOffset(arg_22_0)
	return true
end

function ys.Battle.AttackState.GetActionName(arg_23_0, arg_23_1, arg_23_2)
	local var_23_0 = arg_23_2
	local var_23_1 = arg_23_1:ActionKeyOffset()

	if var_23_1 then
		var_23_0 = var_23_0 .. var_23_1
	end

	return var_23_0
end

return
