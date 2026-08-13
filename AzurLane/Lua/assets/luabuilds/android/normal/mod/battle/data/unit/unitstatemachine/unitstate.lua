ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.ActionName
local var_0_2 = var_0.Battle

class = var_0_10004
var_0_2.UnitState = var_0_10004("UnitState")
var_0.Battle.UnitState.__name = "UnitState"
var_0.Battle.UnitState.STATE_IDLE = "STATE_IDLE"
var_0.Battle.UnitState.STATE_MOVE = "STATE_MOVE"
var_0.Battle.UnitState.STATE_ATTACK = "STATE_ATTACK"
var_0.Battle.UnitState.STATE_ATTACKLEFT = "STATE_ATTACKLEFT"
var_0.Battle.UnitState.STATE_DEAD = "STATE_DEAD"
var_0.Battle.UnitState.STATE_MOVELEFT = "STATE_MOVELEFT"
var_0.Battle.UnitState.STATE_SKILL = "STATE_SKILL"
var_0.Battle.UnitState.STATE_VICTORY = "STATE_VICTORY"
var_0.Battle.UnitState.STATE_STAND = "STATE_STAND"
var_0.Battle.UnitState.STATE_INTERRUPT = "STATE_INTERRUPT"
var_0.Battle.UnitState.STATE_SKILL_START = "STATE_SKILL_START"
var_0.Battle.UnitState.STATE_SKILL_END = "STATE_SKILL_END"
var_0.Battle.UnitState.STATE_DIVING = "STATE_DIVING"
var_0.Battle.UnitState.STATE_DIVE = "STATE_DIVE"
var_0.Battle.UnitState.STATE_DIVELEFT = "STATE_DIVELEFT"
var_0.Battle.UnitState.STATE_RAID = "STATE_RAID"
var_0.Battle.UnitState.STATE_RAIDLEFT = "STATE_RAIDLEFT"

function var_0.Battle.UnitState.Ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._idleState = var_0.Battle.IdleState.New()
	arg_1_0._moveState = var_0.Battle.MoveState.New()
	arg_1_0._attackState = var_0.Battle.AttackState.New()
	arg_1_0._attackLeftState = var_0.Battle.AttackLeftState.New()
	arg_1_0._deadState = var_0.Battle.DeadState.New()
	arg_1_0._moveLeftState = var_0.Battle.MoveLeftState.New()
	arg_1_0._victoryState = var_0.Battle.VictoryState.New()
	arg_1_0._victorySwimState = var_0.Battle.VictorySwimState.New()
	arg_1_0._standState = var_0.Battle.StandState.New()
	arg_1_0._spellState = var_0.Battle.SpellState.New()
	arg_1_0._interruptState = var_0.Battle.InterruptState.New()
	arg_1_0._skillStartState = var_0.Battle.SkillStartState.New()
	arg_1_0._skillEndState = var_0.Battle.SkillEndState.New()
	arg_1_0._diveState = var_0.Battle.DiveState.New()
	arg_1_0._diveLeftState = var_0.Battle.DiveLeftState.New()
	arg_1_0._raidState = var_0.Battle.RaidState.New()
	arg_1_0._raidLeftState = var_0.Battle.RaidLeftState.New()

	arg_1_0:OnIdleState()

	return
end

function var_0.Battle.UnitState.FreshActionKeyOffset(arg_2_0)
	local var_2_0 = arg_2_0

	if arg_2_0.ActionKeyOffset(var_2_0) then
		string = var_2_0

		if var_2_0.find(arg_2_0._currentAction, var_1) == nil then
			arg_2_0:SendAction(arg_2_0._currentAction .. var_1)
		end
	elseif arg_2_0._offset ~= nil then
		string = var_2

		local var_2_1 = var_2.find(arg_2_0._currentAction, arg_2_0._offset)
		local var_2_2 = arg_2_0
		local var_2_3 = arg_2_0.SendAction

		string = var_1_10005

		var_2_3(var_2_2, var_1_10005.sub(arg_2_0._currentAction, 1, var_2_1 - 1))
	end

	arg_2_0._offset = var_1

	return
end

function var_0.Battle.UnitState.ChangeState(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_1 == arg_3_0.STATE_IDLE then
		local var_3_0 = arg_3_0._currentState

		var_3.AddIdleState(var_3_0, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_MOVE then
		local var_3_1 = arg_3_0._currentState

		var_3.AddMoveState(var_3_1, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_MOVE then
		local var_3_2 = arg_3_0._currentState

		var_3.AddMoveState(var_3_2, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_ATTACK then
		local var_3_3 = arg_3_0._currentState

		var_3.AddAttackState(var_3_3, arg_3_0, arg_3_2)
	elseif arg_3_1 == arg_3_0.STATE_DEAD then
		local var_3_4 = arg_3_0._currentState

		var_3.AddDeadState(var_3_4, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_MOVELEFT then
		local var_3_5 = arg_3_0._currentState

		var_3.AddMoveLeftState(var_3_5, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_VICTORY then
		local var_3_6 = arg_3_0:GetTarget()

		if var_3.GetOxyState(var_3_6) and var_3:GetCurrentDiveState() == var_0.OXY_STATE.DIVE then
			local var_3_7 = arg_3_0._currentState

			var_4.AddVictorySwimState(var_3_7, arg_3_0)
		else
			local var_3_8 = arg_3_0._currentState

			var_4.AddVictoryState(var_3_8, arg_3_0)
		end
	elseif arg_3_1 == arg_3_0.STATE_INTERRUPT then
		local var_3_9 = arg_3_0._currentState

		var_3.AddInterruptState(var_3_9, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_STAND then
		local var_3_10 = arg_3_0._currentState

		var_3.AddStandState(var_3_10, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_DIVE then
		local var_3_11 = arg_3_0._currentState

		var_3.AddDiveState(var_3_11, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_DIVELEFT then
		local var_3_12 = arg_3_0._currentState

		var_3.AddDiveLeftState(var_3_12, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_SKILL_START then
		local var_3_13 = arg_3_0._currentState

		var_3.AddSkillStartState(var_3_13, arg_3_0)
	elseif arg_3_1 == arg_3_0.STATE_SKILL_END then
		local var_3_14 = arg_3_0._currentState

		var_3.AddSkillEndState(var_3_14, arg_3_0)
	else
		assert = var_3

		var_3(false, arg_3_0._target.__name .. "'s state machine, unexcepted state: " .. arg_3_1)
	end

	return
end

function var_0.Battle.UnitState.OnMoveState(arg_4_0)
	arg_4_0._currentState = arg_4_0._moveState

	local var_4_0 = arg_4_0._currentState
	local var_4_1 = var_1.GetActionName(var_4_0, arg_4_0)

	arg_4_0:SendAction(var_4_1)

	return
end

function var_0.Battle.UnitState.OnMoveLeftState(arg_5_0)
	arg_5_0._currentState = arg_5_0._moveLeftState

	local var_5_0 = arg_5_0._currentState
	local var_5_1 = var_1.GetActionName(var_5_0, arg_5_0)

	arg_5_0:SendAction(var_5_1)

	return
end

function var_0.Battle.UnitState.OnIdleState(arg_6_0)
	arg_6_0._currentState = arg_6_0._idleState

	local var_6_0 = arg_6_0._currentState
	local var_6_1 = var_1.GetActionName(var_6_0, arg_6_0)

	arg_6_0:SendAction(var_6_1)

	return
end

function var_0.Battle.UnitState.OnAttackState(arg_7_0, arg_7_1)
	arg_7_0._currentState = arg_7_0._attackState

	local var_7_0 = arg_7_0._currentState
	local var_7_1 = var_2.GetActionName(var_7_0, arg_7_0, arg_7_1)

	arg_7_0:SendAction(var_7_1)

	return
end

function var_0.Battle.UnitState.OnAttackLeftState(arg_8_0, arg_8_1)
	arg_8_0._currentState = arg_8_0._attackLeftState

	local var_8_0 = arg_8_0._currentState
	local var_8_1 = var_2.GetActionName(var_8_0, arg_8_0, arg_8_1)

	arg_8_0:SendAction(var_8_1)

	return
end

function var_0.Battle.UnitState.OnDiveState(arg_9_0)
	arg_9_0._currentState = arg_9_0._diveState

	local var_9_0 = arg_9_0._currentState
	local var_9_1 = var_1.GetActionName(var_9_0, arg_9_0)

	arg_9_0:SendAction(var_9_1)

	return
end

function var_0.Battle.UnitState.OnDiveLeftState(arg_10_0)
	arg_10_0._currentState = arg_10_0._diveLeftState

	local var_10_0 = arg_10_0._currentState
	local var_10_1 = var_1.GetActionName(var_10_0, arg_10_0)

	arg_10_0:SendAction(var_10_1)

	return
end

function var_0.Battle.UnitState.OnRaidState(arg_11_0, arg_11_1)
	arg_11_0._currentState = arg_11_0._raidState

	local var_11_0 = arg_11_0._currentState
	local var_11_1 = var_2.GetActionName(var_11_0, arg_11_0)

	arg_11_0:SendAction(var_11_1)

	return
end

function var_0.Battle.UnitState.OnRaidLeftState(arg_12_0, arg_12_1)
	arg_12_0._currentState = arg_12_0._raidLeftState

	local var_12_0 = arg_12_0._currentState
	local var_12_1 = var_2.GetActionName(var_12_0, arg_12_0)

	arg_12_0:SendAction(var_12_1)

	return
end

function var_0.Battle.UnitState.OnDeadState(arg_13_0)
	arg_13_0._currentState = arg_13_0._deadState

	local var_13_0 = arg_13_0._currentState
	local var_13_1 = var_1.GetActionName(var_13_0, arg_13_0)

	arg_13_0:SendAction(var_13_1)

	return
end

function var_0.Battle.UnitState.OnVictoryState(arg_14_0)
	arg_14_0._currentState = arg_14_0._victoryState

	local var_14_0 = arg_14_0._currentState
	local var_14_1 = var_1.GetActionName(var_14_0, arg_14_0)

	arg_14_0:SendAction(var_14_1)

	return
end

function var_0.Battle.UnitState.OnVictorySwimState(arg_15_0)
	arg_15_0._currentState = arg_15_0._victorySwimState

	local var_15_0 = arg_15_0._currentState
	local var_15_1 = var_1.GetActionName(var_15_0, arg_15_0)

	arg_15_0:SendAction(var_15_1)

	return
end

function var_0.Battle.UnitState.OnStandState(arg_16_0)
	arg_16_0._currentState = arg_16_0._standState

	local var_16_0 = arg_16_0._currentState
	local var_16_1 = var_1.GetActionName(var_16_0, arg_16_0)

	arg_16_0:SendAction(var_16_1)

	return
end

function var_0.Battle.UnitState.OnInterruptState(arg_17_0)
	arg_17_0._currentState = arg_17_0._interruptState

	local var_17_0 = arg_17_0._currentState
	local var_17_1 = var_1.GetActionName(var_17_0, arg_17_0)

	arg_17_0:SendAction(var_17_1)

	return
end

function var_0.Battle.UnitState.OnSkillStartState(arg_18_0)
	arg_18_0._currentState = arg_18_0._skillStartState

	local var_18_0 = arg_18_0._currentState
	local var_18_1 = var_1.GetActionName(var_18_0, arg_18_0)

	arg_18_0:SendAction(var_18_1)

	return
end

function var_0.Battle.UnitState.OnSkillEndState(arg_19_0)
	arg_19_0._currentState = arg_19_0._skillEndState

	local var_19_0 = arg_19_0._currentState
	local var_19_1 = var_1.GetActionName(var_19_0, arg_19_0)

	arg_19_0:SendAction(var_19_1)

	return
end

function var_0.Battle.UnitState.ChangeToMoveState(arg_20_0)
	local var_20_0 = arg_20_0:GetTarget()
	local var_20_1 = var_1.GetSpeed(var_20_0).x
	local var_20_2 = arg_20_0:GetTarget()

	if var_2.GetOxyState(var_20_2) and var_2:GetCurrentDiveState() == var_0.OXY_STATE.DIVE then
		if var_20_1 >= 0 then
			arg_20_0:OnDiveState()
		else
			arg_20_0:OnDiveLeftState()
		end
	elseif var_20_1 >= 0 then
		arg_20_0:OnMoveState()
	else
		arg_20_0:OnMoveLeftState()
	end

	return
end

function var_0.Battle.UnitState.SendAction(arg_21_0, arg_21_1)
	arg_21_0._currentAction = arg_21_1

	local var_21_0 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CHANGE_ACTION, {
		actionType = arg_21_1
	})
	local var_21_1 = arg_21_0._target

	var_3.DispatchEvent(var_21_1, var_21_0)

	return
end

function var_0.Battle.UnitState.ChangeOxyState(arg_22_0, arg_22_1)
	local var_22_0 = arg_22_0._target

	var_2.ChangeOxygenState(var_22_0, arg_22_1)

	return
end

function var_0.Battle.UnitState.GetTarget(arg_23_0)
	return arg_23_0._target
end

function var_0.Battle.UnitState.ActionKeyOffset(arg_24_0)
	local var_24_0 = arg_24_0._target

	return var_1.GetActionKeyOffset(var_24_0)
end

function var_0.Battle.UnitState.GetCurrentStateName(arg_25_0)
	return arg_25_0._currentState.__name
end

function var_0.Battle.UnitState.NeedWeaponCache(arg_26_0)
	local var_26_0 = arg_26_0._currentState

	return var_1.CacheWeapon(var_26_0)
end

function var_0.Battle.UnitState.OnActionStart(arg_27_0)
	local var_27_0 = arg_27_0._currentState

	var_1.OnStart(var_27_0, arg_27_0)

	return
end

function var_0.Battle.UnitState.OnActionTrigger(arg_28_0)
	local var_28_0 = arg_28_0._currentState

	var_1.OnTrigger(var_28_0, arg_28_0)

	return
end

function var_0.Battle.UnitState.OnActionEnd(arg_29_0)
	local var_29_0 = arg_29_0._currentState

	var_1.OnEnd(var_29_0, arg_29_0)

	return
end

return
