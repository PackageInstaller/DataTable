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

function ys.Battle.OxyState:Ctor(arg_1_1)
	self._target = arg_1_1
	self._idleState = var_0_0.Battle.IdleOxyState.New()
	self._diveState = var_0_0.Battle.DiveOxyState.New()
	self._floatState = var_0_0.Battle.FloatOxyState.New()
	self._raidState = var_0_0.Battle.RaidOxyState.New()
	self._retreatState = var_0_0.Battle.RetreatOxyState.New()
	self._freeDiveState = var_0_0.Battle.FreeDiveOxyState.New()
	self._freeFloatState = var_0_0.Battle.FreeFloatOxyState.New()
	self._freeBenchState = var_0_0.Battle.FreeBenchOxyState.New()
	self._deepMineState = var_0_0.Battle.DeepMineOxyState.New()

	self._target:AddBuff((var_0_0.Battle.BattleBuffUnit.New(8520)))
	self:OnIdleState()

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

function ys.Battle.OxyState:UpdateOxygen()
	self._currentState:DoUpdateOxy(self)

	return
end

function ys.Battle.OxyState:GetNextBubbleStamp()
	if self._currentState:GetBubbleFlag() then
		if self._target:GetPosition().x < self._bubbleInitial and self._bubbleTimpStamp == nil then
			self._bubbleTimpStamp = 0
		end

		return self._bubbleTimpStamp
	else
		return nil
	end

	return
end

function ys.Battle.OxyState:SetForceExpose(arg_6_1)
	self._forceExpose = arg_6_1

	self._target:SetForceVisible()

	return
end

function ys.Battle.OxyState:GetForceExpose()
	return self._forceExpose
end

function ys.Battle.OxyState:FlashBubbleStamp(arg_8_1)
	self._bubbleTimpStamp = arg_8_1 + self._bubbleInterval

	return
end

function ys.Battle.OxyState:ChangeState(arg_9_1, arg_9_2)
	if arg_9_1 == var_0_3.STATE_IDLE then
		self:OnIdleState()
	elseif arg_9_1 == var_0_3.STATE_DIVE then
		self:OnDiveState()
	elseif arg_9_1 == var_0_3.STATE_FLOAT then
		self:OnFloatState()
	elseif arg_9_1 == var_0_3.STATE_RAID then
		self:OnRaidState()
	elseif arg_9_1 == var_0_3.STATE_RETREAT then
		self:OnRetreatState()
	elseif arg_9_1 == var_0_3.STATE_FREE_DIVE then
		self:OnFreeDiveState()
	elseif arg_9_1 == var_0_3.STATE_FREE_FLOAT then
		self:OnFreeFloatState()
	elseif arg_9_1 == var_0_3.STATE_FREE_BENCH then
		self:OnFreeBenchState()
	elseif arg_9_1 == var_0_3.STATE_DEEP_MINE then
		self:OnDeepMineState()
	else
		assert(false, self._target.__name .. "'s oxygen state machine, unexcepted state: " .. arg_9_1)
	end

	self._target:GetCldData().Surface = self._currentState:GetDiveState()

	return
end

function ys.Battle.OxyState:OxyConsume()
	self._target:OxyConsume()

	return
end

function ys.Battle.OxyState:OxyRecover(arg_11_1)
	self._target:OxyRecover(arg_11_1)

	return
end

function ys.Battle.OxyState:OnIdleState()
	self._currentState = self._idleState

	return
end

function ys.Battle.OxyState:OnDiveState()
	self._currentState = self._diveState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()
	self._target:SetCrash(false)
	self._target:SetAI(var_0_1.SUB_DEFAULT_ENGAGE_AI)

	if self._currentState:UpdateDive() then
		self._target:SetDiveInvisible(true)
	end

	self._target:StateChange(var_0_0.Battle.UnitState.STATE_DIVE)
	self._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_DIVE, {})
	self._target:RemoveBuff(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnFloatState()
	self._currentState = self._floatState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()
	self._target:SetDiveInvisible(false)
	self._target:StateChange(var_0_0.Battle.UnitState.STATE_MOVE)
	self._target:RemoveSonarExpose()
	self._target:PlayFX("qianting_chushui", false)
	self._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_FLOAT, {})
	self._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnRaidState()
	self._currentState = self._raidState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()

	if self._currentState:UpdateDive() then
		self._target:SetDiveInvisible(true)
	end

	self._target:SetAI(var_0_1.SUB_DEFAULT_STAY_AI)
	self._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_RAID, {})
	self._target:RemoveBuff(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnRetreatState()
	self._currentState = self._retreatState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()
	self._target:SetDiveInvisible(false)
	self._target:SetAI(var_0_1.SUB_DEFAULT_RETREAT_AI)
	self._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_RETREAT, {})
	self._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnFreeDiveState()
	self._currentState = self._freeDiveState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()
	self._target:SetCrash(false)
	self._target:SetDiveInvisible(true)
	self._target:StateChange(var_0_0.Battle.UnitState.STATE_DIVE)
	self._target:PlayFX("qianting_rushui", false)
	self._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_DIVE, {})
	self._target:RemoveBuff(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnFreeFloatState()
	self._currentState = self._freeFloatState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()
	self._target:SetDiveInvisible(false)
	self._target:StateChange(var_0_0.Battle.UnitState.STATE_MOVE)
	self._target:PlayFX("qianting_chushui", false)
	self._target:TriggerBuff(var_0_2.BuffEffectType.ON_SUBMARINE_FLOAT, {})
	self._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnFreeBenchState()
	self._currentState = self._freeBenchState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:ChangeWeaponDiveState()
	self._target:SetDiveInvisible(false)
	self._target:StateChange(var_0_0.Battle.UnitState.STATE_MOVE)
	self._target:PlayFX("qianting_chushui", false)
	self._target:RemoveBuff(var_0_1.SUB_DIVE_IMMUNE_IGNITE_BUFF)
	self._target:AddBuff(var_0_0.Battle.BattleBuffUnit.New(var_0_1.SUB_FLOAT_DISIMMUNE_IGNITE_BUFF))

	return
end

function ys.Battle.OxyState:OnDeepMineState()
	self._currentState = self._deepMineState

	self._currentState.UpdateCldData(self._currentState, self._target, self._currentState)
	self._target:SetDiveInvisible(false)
	self._target:ChangeWeaponDiveState()
	self._target:SetAI(20005)

	return
end

function ys.Battle.OxyState.GetRecycle(arg_21_0)
	return false
end

function ys.Battle.OxyState:GetTarget()
	return self._target
end

function ys.Battle.OxyState:GetCurrentState()
	return self._currentState
end

function ys.Battle.OxyState:GetCurrentStateName()
	return self._currentState.__name
end

function ys.Battle.OxyState:GetWeaponType()
	return self._currentState:GetWeaponUseableList()
end

function ys.Battle.OxyState:GetBarVisible()
	return self._currentState:GetBarVisible()
end

function ys.Battle.OxyState:GetRundMode()
	return self._currentState:RunMode()
end

function ys.Battle.OxyState:GetCurrentDiveState()
	return self._currentState:GetDiveState()
end

return
