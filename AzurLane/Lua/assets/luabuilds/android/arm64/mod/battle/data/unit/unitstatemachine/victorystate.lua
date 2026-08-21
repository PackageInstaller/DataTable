ys = ys or {}

local var_0_0 = ys.Battle.BattleConst.ActionName

ys.Battle.VictoryState = class("VictoryState", ys.Battle.IUnitState)
ys.Battle.VictoryState.__name = "VictoryState"

local var_0_1 = ys.Battle.VictoryState

function ys.Battle.VictoryState.Ctor(arg_1_0)
	var_0_1.super.Ctor()

	return
end

function ys.Battle.VictoryState.AddIdleState(arg_2_0, arg_2_1, arg_2_2)
	return
end

function ys.Battle.VictoryState.AddMoveState(arg_3_0, arg_3_1, arg_3_2)
	return
end

function ys.Battle.VictoryState.AddMoveLeftState(arg_4_0, arg_4_1, arg_4_2)
	return
end

function ys.Battle.VictoryState.AddAttackState(arg_5_0, arg_5_1, arg_5_2)
	return
end

function ys.Battle.VictoryState.AddDeadState(arg_6_0, arg_6_1, arg_6_2)
	return
end

function ys.Battle.VictoryState.AddSkillState(arg_7_0, arg_7_1, arg_7_2)
	return
end

function ys.Battle.VictoryState.AddSpellState(arg_8_0, arg_8_1, arg_8_2)
	return
end

function ys.Battle.VictoryState.AddVictoryState(arg_9_0, arg_9_1, arg_9_2)
	return
end

function ys.Battle.VictoryState.AddVictorySwimState(arg_10_0, arg_10_1, arg_10_2)
	return
end

function ys.Battle.VictoryState.AddStandState(arg_11_0, arg_11_1, arg_11_2)
	return
end

function ys.Battle.VictoryState.AddDiveState(arg_12_0, arg_12_1, arg_12_2)
	return
end

function ys.Battle.VictoryState.AddDiveLeftState(arg_13_0, arg_13_1, arg_13_2)
	return
end

function ys.Battle.VictoryState.AddInterruptState(arg_14_0, arg_14_1, arg_14_2)
	return
end

function ys.Battle.VictoryState.AddDivingState(arg_15_0, arg_15_1, arg_15_2)
	return
end

function ys.Battle.VictoryState.AddSkillStartState(arg_16_0, arg_16_1, arg_16_2)
	return
end

function ys.Battle.VictoryState.AddSkillEndState(arg_17_0, arg_17_1, arg_17_2)
	return
end

function ys.Battle.VictoryState.OnTrigger(arg_18_0, arg_18_1)
	return
end

function ys.Battle.VictoryState.OnStart(arg_19_0, arg_19_1)
	return
end

function ys.Battle.VictoryState.OnEnd(arg_20_0, arg_20_1)
	arg_20_1:OnStandState()

	return
end

function ys.Battle.VictoryState.CacheWeapon(arg_21_0)
	return true
end

function ys.Battle.VictoryState.FreshActionKeyOffset(arg_22_0)
	return false
end

function ys.Battle.VictoryState.GetActionName(arg_23_0, arg_23_1)
	return var_0_0.VICTORY
end

return
