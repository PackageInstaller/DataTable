ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.MoveLeftState = class("MoveLeftState", ys.Battle.IUnitState)
ys.Battle.MoveLeftState.__name = "MoveLeftState"

local var_0_1 = ys.Battle.MoveLeftState

function ys.Battle.MoveLeftState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.MoveLeftState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:OnIdleState()

	return
end

function ys.Battle.MoveLeftState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:OnMoveState()

	return
end

function ys.Battle.MoveLeftState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.MoveLeftState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:OnAttackLeftState(arg_5_2)

	return
end

function ys.Battle.MoveLeftState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	arg_6_1:OnDeadState()

	return
end

function ys.Battle.MoveLeftState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.MoveLeftState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	arg_8_1:OnSpellState()

	return
end

function ys.Battle.MoveLeftState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	arg_9_1:OnVictoryState()

	return
end

function ys.Battle.MoveLeftState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	arg_10_1:OnVictorySwimState()

	return
end

function ys.Battle.MoveLeftState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.MoveLeftState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	arg_12_1:OnDiveState()

	return
end

function ys.Battle.MoveLeftState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	arg_13_1:OnDiveLeftState()

	return
end

function ys.Battle.MoveLeftState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	arg_14_1:OnInterruptState()

	return
end

function ys.Battle.MoveLeftState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	arg_15_1:OnDivingState()

	return
end

function ys.Battle.MoveLeftState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	arg_16_1:OnSkillStartState()

	return
end

function ys.Battle.MoveLeftState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.MoveLeftState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.MoveLeftState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.MoveLeftState.OnEnd(arg_20_0, arg_20_1)
	return
end

function ys.Battle.MoveLeftState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.MoveLeftState.FreshActionKeyOffset(arg_22_0)
	return true
end

function ys.Battle.MoveLeftState.GetActionName(arg_23_0, arg_23_1)
	local var_23_0 = var_0_0.MOVELEFT
	local var_23_1 = arg_23_1:ActionKeyOffset()

	if var_23_1 then
		var_23_0 = var_23_0 .. var_23_1
	end

	return var_23_0
end

return
