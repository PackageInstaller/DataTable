ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConfig
local var_0_2 = ys.Battle.BattleConst

ys.Battle.OxyState = class("OxyState")
ys.Battle.OxyState.__name = "OxyState"

local var_0_3 = ys.Battle.OxyState

ys.Battle.OxyState.STATE_IDLE = "STATE_IDLE"
ys.Battle.OxyState.STATE_DIVE = "STATE_DIVE"
ys.Battle.OxyState.STATE_FLOAT = "STATE_FLOAT"
ys.Battle.OxyState.STATE_RAID = "STATE_RAID"
ys.Battle.OxyState.STATE_RETREAT = "STATE_RETREAT"
ys.Battle.OxyState.STATE_FREE_DIVE = "STATE_FREE_DIVE"
ys.Battle.OxyState.STATE_FREE_FLOAT = "STATE_FREE_FLOAT"
ys.Battle.OxyState.STATE_FREE_BENCH = "STATE_FREE_BENCH"
ys.Battle.OxyState.STATE_DEEP_MINE = "STATE_DEEP_MINE"

function ys.Battle.OxyState.Ctor(arg_1_0, arg_1_1)
	arg_1_0._target = arg_1_1
	arg_1_0._idleState = var_0_0.Battle.IdleOxyState.New()
	arg_1_0._diveState = var_0_0.Battle.DiveOxyState.New()
	arg_1_0._floatState = var_0_0.Battle.FloatOxyState.New()
	arg_1_0._raidState = var_0_0.Battle.RaidOxyState.New()
	arg_1_0._retreatState = var_0_0.Battle.RetreatOxyState.New()
	arg_1_0._freeDiveState = var_0_0.Battle.FreeDiveOxyState.New()
	arg_1_0._freeFloatState = var_0_0.Battle.FreeFloatOxyState.New()
	arg_1_0._freeBenchState = var_0_0.Battle.FreeBenchOxyState.New()
	arg_1_0._deepMineState = var_0_0.Battle.DeepMineOxyState.New()

	arg_1_0._target:AddBuff((var_0_0.Battle.BattleBuffUnit.New(8520)))
	arg_1_0:OnIdleState()

	return
end

function ys.Battle.OxyState.SetRecycle(arg_2_0, arg_2_1)
	arg_2_0._recycle = arg_2_1

	return
end

function ys.Battle.OxyState.SetBubbleTemplate(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._bubbleInitial = arg_3_1 or 0
	arg_3_0._bubbleInterval = arg_3_2 or 0
	arg_3_0._bubbleTimpStamp = nil

	return
end

function ys.Battle.OxyState.UpdateOxygen(arg_4_0)
	arg_4_0._currentState:DoUpdateOxy(arg_4_0)

	return
end

function ys.Battle.OxyState.GetNextBubbleStamp(arg_5_0)
	if arg_5_0._currentState:GetBubbleFlag() then
		if arg_5_0._target:GetPosition().x < arg_5_0._bubbleInitial and arg_5_0._bubbleTimpStamp == nil then
			arg_5_0._bubbleTimpStamp = 0
		end

		return arg_5_0._bubbleTimpStamp
	else
		return nil
	end

	return
end

function ys.Battle.OxyState.SetForceExpose(arg_6_0, arg_6_1)
	arg_6_0._forceExpose = arg_6_1

	arg_6_0._target:SetForceVisible()

	return
end

function ys.Battle.OxyState.GetForceExpose(arg_7_0)
	return arg_7_0._forceExpose
end

function ys.Battle.OxyState.FlashBubbleStamp(arg_8_0, arg_8_1)
	arg_8_0._bubbleTimpStamp = arg_8_1 + arg_8_0._bubbleInterval

	return
end

function ys.Battle.OxyState.ChangeState(arg_9_0, arg_9_1, arg_9_2)
	if arg_9_1 == var_0_3.STATE_IDLE then
		arg_9_0:OnIdleState()
	elseif arg_9_1 == var_0_3.STATE_DIVE then
		arg_9_0:OnDiveState()
	elseif arg_9_1 == var_0_3.STATE_FLOAT then
		arg_9_0:OnFloatState()
	elseif arg_9_1 == var_0_3.STATE_RAID then
		arg_9_0:OnRaidState()
	elseif arg_9_1 == var_0_3.STATE_RETREAT then
		arg_9_0:OnRetreatState()
	elseif arg_9_1 == var_0_3.STATE_FREE_DIVE then
		arg_9_0:OnFreeDiveState()
	elseif arg_9_1 == var_0_3.STATE_FREE_FLOAT then
		arg_9_0:OnFreeFloatState()
	elseif arg_9_1 == var_0_3.STATE_FREE_BENCH then
		arg_9_0:OnFreeBenchState()
	elseif arg_9_1 == var_0_3.STATE_DEEP_MINE then
		arg_9_0:OnDeepMineState()
	else
		assert(false, arg_9_0._target.__name .. "'s oxygen state machine, unexcepted state: " .. arg_9_1)
	end

	arg_9_0._target:GetCldData().Surface = arg_9_0._currentState:GetDiveState()

	return
end

function ys.Battle.OxyState.OxyConsume(arg_10_0)
	arg_10_0._target:OxyConsume()

	return
end

function ys.Battle.OxyState.OxyRecover(arg_11_0, arg_11_1)
	arg_11_0._target:OxyRecover(arg_11_1)

	return
end

function ys.Battle.OxyState.OnIdleState(arg_12_0)
	arg_12_0._currentState = arg_12_0._idleState

	return
end

function ys.Battle.OxyState.OnDiveState(arg_13_0)
	arg_13_0._currentState = arg_13_0._diveState

	arg_13_0._currentState.UpdateCldData(arg_13_0._currentState, arg_13_0._target, arg_13_0._currentState)
	arg_13_0._target:ChangeWeaponDiveState()
	arg_13_0._target:SetCrash(false)
	arg_13_0._target:SetAI(var_0_1.SUB_DEFAULT_ENGAGE_AI)

	if arg_13_0._currentState:UpdateDive() then
		arg_13_0._target:SetDiveInvisible(true)
	end

	arg_13_0._target:StateChange(var_0_0.Battle.UnitState.STATE_DIVE)
	arg_13_0._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_DIVE, {})
	arg_13_0._target:RemoveBuff(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)
	arg_13_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnFloatState(arg_14_0)
	arg_14_0._currentState = arg_14_0._floatState

	arg_14_0._currentState.UpdateCldData(arg_14_0._currentState, arg_14_0._target, arg_14_0._currentState)
	arg_14_0._target:ChangeWeaponDiveState()
	arg_14_0._target:SetDiveInvisible(false)
	arg_14_0._target:StateChange(var_0_0.Battle.UnitState.STATE_MOVE)
	arg_14_0._target:RemoveSonarExpose()
	arg_14_0._target:PlayFX("qianting_chushui", false)
	arg_14_0._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_FLOAT, {})
	arg_14_0._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	arg_14_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnRaidState(arg_15_0)
	arg_15_0._currentState = arg_15_0._raidState

	arg_15_0._currentState.UpdateCldData(arg_15_0._currentState, arg_15_0._target, arg_15_0._currentState)
	arg_15_0._target:ChangeWeaponDiveState()

	if arg_15_0._currentState:UpdateDive() then
		arg_15_0._target:SetDiveInvisible(true)
	end

	arg_15_0._target:SetAI(var_0_1.SUB_DEFAULT_STAY_AI)
	arg_15_0._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_RAID, {})
	arg_15_0._target:RemoveBuff(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)
	arg_15_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnRetreatState(arg_16_0)
	arg_16_0._currentState = arg_16_0._retreatState

	arg_16_0._currentState.UpdateCldData(arg_16_0._currentState, arg_16_0._target, arg_16_0._currentState)
	arg_16_0._target:ChangeWeaponDiveState()
	arg_16_0._target:SetDiveInvisible(false)
	arg_16_0._target:SetAI(var_0_1.SUB_DEFAULT_RETREAT_AI)
	arg_16_0._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_RETREAT, {})
	arg_16_0._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	arg_16_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnFreeDiveState(arg_17_0)
	arg_17_0._currentState = arg_17_0._freeDiveState

	arg_17_0._currentState.UpdateCldData(arg_17_0._currentState, arg_17_0._target, arg_17_0._currentState)
	arg_17_0._target:ChangeWeaponDiveState()
	arg_17_0._target:SetCrash(false)
	arg_17_0._target:SetDiveInvisible(true)
	arg_17_0._target:StateChange(var_0_0.Battle.UnitState.STATE_DIVE)
	arg_17_0._target:PlayFX("qianting_rushui", false)
	arg_17_0._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_DIVE, {})
	arg_17_0._target:RemoveBuff(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)
	arg_17_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnFreeFloatState(arg_18_0)
	arg_18_0._currentState = arg_18_0._freeFloatState

	arg_18_0._currentState.UpdateCldData(arg_18_0._currentState, arg_18_0._target, arg_18_0._currentState)
	arg_18_0._target:ChangeWeaponDiveState()
	arg_18_0._target:SetDiveInvisible(false)
	arg_18_0._target:StateChange(var_0_0.Battle.UnitState.STATE_MOVE)
	arg_18_0._target:PlayFX("qianting_chushui", false)
	arg_18_0._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_FLOAT, {})
	arg_18_0._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	arg_18_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnFreeBenchState(arg_19_0)
	arg_19_0._currentState = arg_19_0._freeBenchState

	arg_19_0._currentState.UpdateCldData(arg_19_0._currentState, arg_19_0._target, arg_19_0._currentState)
	arg_19_0._target:ChangeWeaponDiveState()
	arg_19_0._target:SetDiveInvisible(false)
	arg_19_0._target:StateChange(var_0_0.Battle.UnitState.STATE_MOVE)
	arg_19_0._target:PlayFX("qianting_chushui", false)
	arg_19_0._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	arg_19_0._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState.OnDeepMineState(arg_20_0)
	arg_20_0._currentState = arg_20_0._deepMineState

	arg_20_0._currentState.UpdateCldData(arg_20_0._currentState, arg_20_0._target, arg_20_0._currentState)
	arg_20_0._target:SetDiveInvisible(false)
	arg_20_0._target:ChangeWeaponDiveState()
	arg_20_0._target:SetAI(20005)

	return
end

function ys.Battle.OxyState.GetRecycle(arg_21_0)
	return false
end

function ys.Battle.OxyState.GetTarget(arg_22_0)
	return arg_22_0._target
end

function ys.Battle.OxyState.GetCurrentState(arg_23_0)
	return arg_23_0._currentState
end

function ys.Battle.OxyState.GetCurrentStateName(arg_24_0)
	return arg_24_0._currentState.__name
end

function ys.Battle.OxyState.GetWeaponType(arg_25_0)
	return arg_25_0._currentState:GetWeaponUseableList()
end

function ys.Battle.OxyState.GetBarVisible(arg_26_0)
	return arg_26_0._currentState:GetBarVisible()
end

function ys.Battle.OxyState.GetRundMode(arg_27_0)
	return arg_27_0._currentState:RunMode()
end

function ys.Battle.OxyState.GetCurrentDiveState(arg_28_0)
	return arg_28_0._currentState:GetDiveState()
end

return
