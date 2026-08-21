ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst.ActionName

ys.Battle.DeadState = class("DeadState", ys.Battle.IUnitState)
ys.Battle.DeadState.__name = "DeadState"

local var_0_2 = ys.Battle.DeadState

function ys.Battle.DeadState.Ctor(arg_1_0)
	var_0_2.super.Ctor()

	return
end

function ys.Battle.DeadState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.DeadState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.DeadState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.DeadState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.DeadState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	return
end

function ys.Battle.DeadState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.DeadState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.DeadState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	return
end

function ys.Battle.DeadState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	return
end

function ys.Battle.DeadState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.DeadState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.DeadState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.DeadState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	return
end

function ys.Battle.DeadState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.DeadState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	return
end

function ys.Battle.DeadState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.DeadState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.DeadState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.DeadState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:GetTarget():SendDeadEvent()

	return
end

function ys.Battle.DeadState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.DeadState.FreshActionKeyOffset(arg_22_0)
	return true
end

function ys.Battle.DeadState.GetActionName(arg_23_0, arg_23_1, arg_23_2)
	local var_23_1 = arg_23_1:GetTarget():GetOxyState()
	local var_23_2 = arg_23_1:ActionKeyOffset()

	return var_23_1 and var_23_1:GetCurrentDiveState() == var_0_0.Battle.BattleConst.OXY_STATE.DIVE and var_0_1.DEAD_SWIM or var_23_2 ~= nil and var_0_1.DEAD .. var_23_2 or var_0_1.DEAD
end

return
