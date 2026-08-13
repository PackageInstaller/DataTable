ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleConst
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.OxyState = var_0_10004("OxyState")
var_0.Battle.OxyState.__name = "OxyState"

local var_0_4 = var_0.Battle.OxyState

var_0_4.STATE_IDLE = "STATE_IDLE"
var_0_4.STATE_DIVE = "STATE_DIVE"
var_0_4.STATE_FLOAT = "STATE_FLOAT"
var_0_4.STATE_RAID = "STATE_RAID"
var_0_4.STATE_RETREAT = "STATE_RETREAT"
var_0_4.STATE_FREE_DIVE = "STATE_FREE_DIVE"
var_0_4.STATE_FREE_FLOAT = "STATE_FREE_FLOAT"
var_0_4.STATE_FREE_BENCH = "STATE_FREE_BENCH"
var_0_4.STATE_DEEP_MINE = "STATE_DEEP_MINE"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._idleState = var_0.Battle.IdleOxyState.New()
	arg_1_0._diveState = var_0.Battle.DiveOxyState.New()
	arg_1_0._floatState = var_0.Battle.FloatOxyState.New()
	arg_1_0._raidState = var_0.Battle.RaidOxyState.New()
	arg_1_0._retreatState = var_0.Battle.RetreatOxyState.New()
	arg_1_0._freeDiveState = var_0.Battle.FreeDiveOxyState.New()
	arg_1_0._freeFloatState = var_0.Battle.FreeFloatOxyState.New()
	arg_1_0._freeBenchState = var_0.Battle.FreeBenchOxyState.New()
	arg_1_0._deepMineState = var_0.Battle.DeepMineOxyState.New()

	local var_1_0 = var_0.Battle.BattleBuffUnit.New(8520)
	local var_1_1 = arg_1_0._target

	var_3.AddBuff(var_1_1, var_1_0)
	arg_1_0:OnIdleState()

	return
end

function var_0_4.SetRecycle(arg_2_0, arg_2_1)
	arg_2_0._recycle = arg_2_1

	return
end

function var_0_4.SetBubbleTemplate(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._bubbleInitial = arg_3_1 or 0
	arg_3_0._bubbleInterval = arg_3_2 or 0
	arg_3_0._bubbleTimpStamp = nil

	return
end

function var_0_4.UpdateOxygen(arg_4_0)
	local var_4_0 = arg_4_0._currentState

	var_1.DoUpdateOxy(var_4_0, arg_4_0)

	return
end

function var_0_4.GetNextBubbleStamp(arg_5_0)
	local var_5_0 = arg_5_0._currentState

	if var_1.GetBubbleFlag(var_5_0) then
		local var_5_1 = arg_5_0._target

		if var_1.GetPosition(var_5_1).x < arg_5_0._bubbleInitial and arg_5_0._bubbleTimpStamp == nil then
			arg_5_0._bubbleTimpStamp = 0
		end

		return arg_5_0._bubbleTimpStamp
	else
		return nil
	end

	return
end

function var_0_4.SetForceExpose(arg_6_0, arg_6_1)
	arg_6_0._forceExpose = arg_6_1

	local var_6_0 = arg_6_0._target

	var_2.SetForceVisible(var_6_0)

	return
end

function var_0_4.GetForceExpose(arg_7_0)
	return arg_7_0._forceExpose
end

function var_0_4.FlashBubbleStamp(arg_8_0, arg_8_1)
	arg_8_0._bubbleTimpStamp = arg_8_1 + arg_8_0._bubbleInterval

	return
end

function var_0_4.ChangeState(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == var_0_4.STATE_IDLE then
		arg_9_0:OnIdleState()
	elseif arg_9_1 == var_0_4.STATE_DIVE then
		arg_9_0:OnDiveState()
	elseif arg_9_1 == var_0_4.STATE_FLOAT then
		arg_9_0:OnFloatState()
	elseif arg_9_1 == var_0_4.STATE_RAID then
		arg_9_0:OnRaidState()
	elseif arg_9_1 == var_0_4.STATE_RETREAT then
		arg_9_0:OnRetreatState()
	elseif arg_9_1 == var_0_4.STATE_FREE_DIVE then
		arg_9_0:OnFreeDiveState()
	elseif arg_9_1 == var_0_4.STATE_FREE_FLOAT then
		arg_9_0:OnFreeFloatState()
	elseif arg_9_1 == var_0_4.STATE_FREE_BENCH then
		arg_9_0:OnFreeBenchState()
	elseif arg_9_1 == var_0_4.STATE_DEEP_MINE then
		arg_9_0:OnDeepMineState()
	else
		assert = var_3

		var_3(false, arg_9_0._target.__name .. "'s oxygen state machine, unexcepted state: " .. arg_9_1)
	end

	local var_9_0 = arg_9_0._target
	local var_9_1 = var_3.GetCldData(var_9_0)
	local var_9_2 = arg_9_0._currentState

	var_9_1.Surface = var_4.GetDiveState(var_9_2)

	return
end

function var_0_4.OxyConsume(arg_10_0)
	local var_10_0 = arg_10_0._target

	var_1.OxyConsume(var_10_0)

	return
end

function var_0_4.OxyRecover(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_0._target

	var_2.OxyRecover(var_11_0, arg_11_1)

	return
end

function var_0_4.OnIdleState(arg_12_0)
	arg_12_0._currentState = arg_12_0._idleState

	return
end

function var_0_4.OnDiveState(arg_13_0)
	local var_13_0 = arg_13_0._currentState
	local var_13_1 = var_1.UpdateDive(var_13_0)
	local var_13_2 = arg_13_0._currentState

	arg_13_0._currentState = arg_13_0._diveState

	local var_13_3 = arg_13_0._currentState

	var_3.UpdateCldData(var_13_3, arg_13_0._target, var_13_2)

	local var_13_4 = arg_13_0._target

	var_3.ChangeWeaponDiveState(var_13_4)

	local var_13_5 = arg_13_0._target

	var_3.SetCrash(var_13_5, false)

	local var_13_6 = arg_13_0._target

	var_3.SetAI(var_13_6, var_0_1.SUB_DEFAULT_ENGAGE_AI)

	if var_13_1 then
		local var_13_7 = arg_13_0._target

		var_3.SetDiveInvisible(var_13_7, true)
	end

	local var_13_8 = arg_13_0._target

	var_3.StateChange(var_13_8, var_0.Battle.UnitState.STATE_DIVE)

	local var_13_9 = arg_13_0._target

	var_3.TriggerBuff(var_13_9, var_0_2.BuffEffectType.ON_SUBMARINE_DIVE, {})

	local var_13_10 = arg_13_0._target

	var_3.RemoveBuff(var_13_10, var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)

	local var_13_11 = arg_13_0._target

	var_3.AddBuff(var_13_11, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnFloatState(arg_14_0)
	local var_14_0 = arg_14_0._currentState

	arg_14_0._currentState = arg_14_0._floatState

	local var_14_1 = arg_14_0._currentState

	var_2.UpdateCldData(var_14_1, arg_14_0._target, var_14_0)

	local var_14_2 = arg_14_0._target

	var_2.ChangeWeaponDiveState(var_14_2)

	local var_14_3 = arg_14_0._target

	var_2.SetDiveInvisible(var_14_3, false)

	local var_14_4 = arg_14_0._target

	var_2.StateChange(var_14_4, var_0.Battle.UnitState.STATE_MOVE)

	local var_14_5 = arg_14_0._target

	var_2.RemoveSonarExpose(var_14_5)

	local var_14_6 = arg_14_0._target

	var_2.PlayFX(var_14_6, "qianting_chushui", false)

	local var_14_7 = arg_14_0._target

	var_2.TriggerBuff(var_14_7, var_0_2.BuffEffectType.ON_SUBMARINE_FLOAT, {})

	local var_14_8 = arg_14_0._target

	var_2.RemoveBuff(var_14_8, var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)

	local var_14_9 = arg_14_0._target

	var_2.AddBuff(var_14_9, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnRaidState(arg_15_0)
	local var_15_0 = arg_15_0._currentState
	local var_15_1 = var_1.UpdateDive(var_15_0)
	local var_15_2 = arg_15_0._currentState

	arg_15_0._currentState = arg_15_0._raidState

	local var_15_3 = arg_15_0._currentState

	var_3.UpdateCldData(var_15_3, arg_15_0._target, var_15_2)

	local var_15_4 = arg_15_0._target

	var_3.ChangeWeaponDiveState(var_15_4)

	if var_15_1 then
		local var_15_5 = arg_15_0._target

		var_3.SetDiveInvisible(var_15_5, true)
	end

	local var_15_6 = arg_15_0._target

	var_3.SetAI(var_15_6, var_0_1.SUB_DEFAULT_STAY_AI)

	local var_15_7 = arg_15_0._target

	var_3.TriggerBuff(var_15_7, var_0_2.BuffEffectType.ON_SUBMARINE_RAID, {})

	local var_15_8 = arg_15_0._target

	var_3.RemoveBuff(var_15_8, var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)

	local var_15_9 = arg_15_0._target

	var_3.AddBuff(var_15_9, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnRetreatState(arg_16_0)
	local var_16_0 = arg_16_0._currentState

	arg_16_0._currentState = arg_16_0._retreatState

	local var_16_1 = arg_16_0._currentState

	var_2.UpdateCldData(var_16_1, arg_16_0._target, var_16_0)

	local var_16_2 = arg_16_0._target

	var_2.ChangeWeaponDiveState(var_16_2)

	local var_16_3 = arg_16_0._target

	var_2.SetDiveInvisible(var_16_3, false)

	local var_16_4 = arg_16_0._target

	var_2.SetAI(var_16_4, var_0_1.SUB_DEFAULT_RETREAT_AI)

	local var_16_5 = arg_16_0._target

	var_2.TriggerBuff(var_16_5, var_0_2.BuffEffectType.ON_SUBMARINE_RETREAT, {})

	local var_16_6 = arg_16_0._target

	var_2.RemoveBuff(var_16_6, var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)

	local var_16_7 = arg_16_0._target

	var_2.AddBuff(var_16_7, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnFreeDiveState(arg_17_0)
	local var_17_0 = arg_17_0._currentState

	arg_17_0._currentState = arg_17_0._freeDiveState

	local var_17_1 = arg_17_0._currentState

	var_2.UpdateCldData(var_17_1, arg_17_0._target, var_17_0)

	local var_17_2 = arg_17_0._target

	var_2.ChangeWeaponDiveState(var_17_2)

	local var_17_3 = arg_17_0._target

	var_2.SetCrash(var_17_3, false)

	local var_17_4 = arg_17_0._target

	var_2.SetDiveInvisible(var_17_4, true)

	local var_17_5 = arg_17_0._target

	var_2.StateChange(var_17_5, var_0.Battle.UnitState.STATE_DIVE)

	local var_17_6 = arg_17_0._target

	var_2.PlayFX(var_17_6, "qianting_rushui", false)

	local var_17_7 = arg_17_0._target

	var_2.TriggerBuff(var_17_7, var_0_2.BuffEffectType.ON_SUBMARINE_DIVE, {})

	local var_17_8 = arg_17_0._target

	var_2.RemoveBuff(var_17_8, var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)

	local var_17_9 = arg_17_0._target

	var_2.AddBuff(var_17_9, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnFreeFloatState(arg_18_0)
	local var_18_0 = arg_18_0._currentState

	arg_18_0._currentState = arg_18_0._freeFloatState

	local var_18_1 = arg_18_0._currentState

	var_2.UpdateCldData(var_18_1, arg_18_0._target, var_18_0)

	local var_18_2 = arg_18_0._target

	var_2.ChangeWeaponDiveState(var_18_2)

	local var_18_3 = arg_18_0._target

	var_2.SetDiveInvisible(var_18_3, false)

	local var_18_4 = arg_18_0._target

	var_2.StateChange(var_18_4, var_0.Battle.UnitState.STATE_MOVE)

	local var_18_5 = arg_18_0._target

	var_2.PlayFX(var_18_5, "qianting_chushui", false)

	local var_18_6 = arg_18_0._target

	var_2.TriggerBuff(var_18_6, var_0_2.BuffEffectType.ON_SUBMARINE_FLOAT, {})

	local var_18_7 = arg_18_0._target

	var_2.RemoveBuff(var_18_7, var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)

	local var_18_8 = arg_18_0._target

	var_2.AddBuff(var_18_8, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnFreeBenchState(arg_19_0)
	local var_19_0 = arg_19_0._currentState

	arg_19_0._currentState = arg_19_0._freeBenchState

	local var_19_1 = arg_19_0._currentState

	var_2.UpdateCldData(var_19_1, arg_19_0._target, var_19_0)

	local var_19_2 = arg_19_0._target

	var_2.ChangeWeaponDiveState(var_19_2)

	local var_19_3 = arg_19_0._target

	var_2.SetDiveInvisible(var_19_3, false)

	local var_19_4 = arg_19_0._target

	var_2.StateChange(var_19_4, var_0.Battle.UnitState.STATE_MOVE)

	local var_19_5 = arg_19_0._target

	var_2.PlayFX(var_19_5, "qianting_chushui", false)

	local var_19_6 = arg_19_0._target

	var_2.RemoveBuff(var_19_6, var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)

	local var_19_7 = arg_19_0._target

	var_2.AddBuff(var_19_7, var_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function var_0_4.OnDeepMineState(arg_20_0)
	local var_20_0 = arg_20_0._currentState

	arg_20_0._currentState = arg_20_0._deepMineState

	local var_20_1 = arg_20_0._currentState

	var_2.UpdateCldData(var_20_1, arg_20_0._target, var_20_0)

	local var_20_2 = arg_20_0._target

	var_2.SetDiveInvisible(var_20_2, false)

	local var_20_3 = arg_20_0._target

	var_2.ChangeWeaponDiveState(var_20_3)

	local var_20_4 = arg_20_0._target

	var_2.SetAI(var_20_4, 20005)

	return
end

function var_0_4.GetRecycle(arg_21_0)
	return false
end

function var_0_4.GetTarget(arg_22_0)
	return arg_22_0._target
end

function var_0_4.GetCurrentState(arg_23_0)
	return arg_23_0._currentState
end

function var_0_4.GetCurrentStateName(arg_24_0)
	return arg_24_0._currentState.__name
end

function var_0_4.GetWeaponType(arg_25_0)
	local var_25_0 = arg_25_0._currentState

	return var_1.GetWeaponUseableList(var_25_0)
end

function var_0_4.GetBarVisible(arg_26_0)
	local var_26_0 = arg_26_0._currentState

	return var_1.GetBarVisible(var_26_0)
end

function var_0_4.GetRundMode(arg_27_0)
	local var_27_0 = arg_27_0._currentState

	return var_1.RunMode(var_27_0)
end

function var_0_4.GetCurrentDiveState(arg_28_0)
	local var_28_0 = arg_28_0._currentState

	return var_1.GetDiveState(var_28_0)
end

return
