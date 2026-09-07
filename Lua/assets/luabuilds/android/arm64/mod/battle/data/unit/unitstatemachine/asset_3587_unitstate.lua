ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst

ys.Battle.UnitState = class("UnitState")
ys.Battle.UnitState.__name = "UnitState"
ys.Battle.UnitState.STATE_IDLE = "STATE_IDLE"
ys.Battle.UnitState.STATE_MOVE = "STATE_MOVE"
ys.Battle.UnitState.STATE_ATTACK = "STATE_ATTACK"
ys.Battle.UnitState.STATE_ATTACKLEFT = "STATE_ATTACKLEFT"
ys.Battle.UnitState.STATE_DEAD = "STATE_DEAD"
ys.Battle.UnitState.STATE_MOVELEFT = "STATE_MOVELEFT"
ys.Battle.UnitState.STATE_SKILL = "STATE_SKILL"
ys.Battle.UnitState.STATE_VICTORY = "STATE_VICTORY"
ys.Battle.UnitState.STATE_STAND = "STATE_STAND"
ys.Battle.UnitState.STATE_INTERRUPT = "STATE_INTERRUPT"
ys.Battle.UnitState.STATE_SKILL_START = "STATE_SKILL_START"
ys.Battle.UnitState.STATE_SKILL_END = "STATE_SKILL_END"
ys.Battle.UnitState.STATE_DIVING = "STATE_DIVING"
ys.Battle.UnitState.STATE_DIVE = "STATE_DIVE"
ys.Battle.UnitState.STATE_DIVELEFT = "STATE_DIVELEFT"
ys.Battle.UnitState.STATE_RAID = "STATE_RAID"
ys.Battle.UnitState.STATE_RAIDLEFT = "STATE_RAIDLEFT"

function ys.Battle.UnitState:Ctor(arg_1_1)
	self._target = arg_1_1
	self._idleState = var_0_0.Battle.IdleState.New()
	self._moveState = var_0_0.Battle.MoveState.New()
	self._attackState = var_0_0.Battle.AttackState.New()
	self._attackLeftState = var_0_0.Battle.AttackLeftState.New()
	self._deadState = var_0_0.Battle.DeadState.New()
	self._moveLeftState = var_0_0.Battle.MoveLeftState.New()
	self._victoryState = var_0_0.Battle.VictoryState.New()
	self._victorySwimState = var_0_0.Battle.VictorySwimState.New()
	self._standState = var_0_0.Battle.StandState.New()
	self._spellState = var_0_0.Battle.SpellState.New()
	self._interruptState = var_0_0.Battle.InterruptState.New()
	self._skillStartState = var_0_0.Battle.SkillStartState.New()
	self._skillEndState = var_0_0.Battle.SkillEndState.New()
	self._diveState = var_0_0.Battle.DiveState.New()
	self._diveLeftState = var_0_0.Battle.DiveLeftState.New()
	self._raidState = var_0_0.Battle.RaidState.New()
	self._raidLeftState = var_0_0.Battle.RaidLeftState.New()

	self:OnIdleState()

	return
end

function ys.Battle.UnitState:FreshActionKeyOffset()
	local var_2_0 = self:ActionKeyOffset()

	if var_2_0 then
		if string.find(self._currentAction, var_2_0) == nil then
			self:SendAction(self._currentAction .. var_2_0)
		end
	elseif self._offset ~= nil then
		self:SendAction(string.sub(self._currentAction, 1, string.find(self._currentAction, self._offset) - 1))
	end

	self._offset = var_2_0

	return
end

function ys.Battle.UnitState:ChangeState(arg_3_1, arg_3_2)
	if arg_3_1 == self.STATE_IDLE then
		self._currentState:AddIdleState(self)
	elseif arg_3_1 == self.STATE_MOVE then
		self._currentState:AddMoveState(self)
	elseif arg_3_1 == self.STATE_MOVE then
		self._currentState:AddMoveState(self)
	elseif arg_3_1 == self.STATE_ATTACK then
		self._currentState:AddAttackState(self, arg_3_2)
	elseif arg_3_1 == self.STATE_DEAD then
		self._currentState:AddDeadState(self)
	elseif arg_3_1 == self.STATE_MOVELEFT then
		self._currentState:AddMoveLeftState(self)
	elseif arg_3_1 == self.STATE_VICTORY then
		local var_3_0 = self:GetTarget():GetOxyState()

		if var_3_0 and var_3_0:GetCurrentDiveState() == var_0_1.OXY_STATE.DIVE then
			self._currentState:AddVictorySwimState(self)
		else
			self._currentState:AddVictoryState(self)
		end
	elseif arg_3_1 == self.STATE_INTERRUPT then
		self._currentState:AddInterruptState(self)
	elseif arg_3_1 == self.STATE_STAND then
		self._currentState:AddStandState(self)
	elseif arg_3_1 == self.STATE_DIVE then
		self._currentState:AddDiveState(self)
	elseif arg_3_1 == self.STATE_DIVELEFT then
		self._currentState:AddDiveLeftState(self)
	elseif arg_3_1 == self.STATE_SKILL_START then
		self._currentState:AddSkillStartState(self)
	elseif arg_3_1 == self.STATE_SKILL_END then
		self._currentState:AddSkillEndState(self)
	else
		assert(false, self._target.__name .. "'s state machine, unexcepted state: " .. arg_3_1)
	end

	return
end

function ys.Battle.UnitState:OnMoveState()
	self._currentState = self._moveState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnMoveLeftState()
	self._currentState = self._moveLeftState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnIdleState()
	self._currentState = self._idleState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnAttackState(arg_7_1)
	self._currentState = self._attackState

	self:SendAction((self._currentState:GetActionName(self, arg_7_1)))

	return
end

function ys.Battle.UnitState:OnAttackLeftState(arg_8_1)
	self._currentState = self._attackLeftState

	self:SendAction((self._currentState:GetActionName(self, arg_8_1)))

	return
end

function ys.Battle.UnitState:OnDiveState()
	self._currentState = self._diveState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnDiveLeftState()
	self._currentState = self._diveLeftState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnRaidState(arg_11_1)
	self._currentState = self._raidState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnRaidLeftState(arg_12_1)
	self._currentState = self._raidLeftState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnDeadState()
	self._currentState = self._deadState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnVictoryState()
	self._currentState = self._victoryState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnVictorySwimState()
	self._currentState = self._victorySwimState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnStandState()
	self._currentState = self._standState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnInterruptState()
	self._currentState = self._interruptState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnSkillStartState()
	self._currentState = self._skillStartState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:OnSkillEndState()
	self._currentState = self._skillEndState

	self:SendAction((self._currentState:GetActionName(self)))

	return
end

function ys.Battle.UnitState:ChangeToMoveState()
	local var_20_0 = self:GetTarget():GetSpeed().x
	local var_20_1 = self:GetTarget():GetOxyState()

	if var_20_1 and var_20_1:GetCurrentDiveState() == var_0_1.OXY_STATE.DIVE then
		if var_20_0 >= 0 then
			self:OnDiveState()
		else
			self:OnDiveLeftState()
		end
	elseif var_20_0 >= 0 then
		self:OnMoveState()
	else
		self:OnMoveLeftState()
	end

	return
end

function ys.Battle.UnitState:SendAction(arg_21_1)
	self._currentAction = arg_21_1

	self._target:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CHANGE_ACTION, {
		actionType = arg_21_1
	})))

	return
end

function ys.Battle.UnitState:ChangeOxyState(arg_22_1)
	self._target:ChangeOxygenState(arg_22_1)

	return
end

function ys.Battle.UnitState:GetTarget()
	return self._target
end

function ys.Battle.UnitState:ActionKeyOffset()
	return self._target:GetActionKeyOffset()
end

function ys.Battle.UnitState:GetCurrentStateName()
	return self._currentState.__name
end

function ys.Battle.UnitState:NeedWeaponCache()
	return self._currentState:CacheWeapon()
end

function ys.Battle.UnitState:OnActionStart()
	self._currentState:OnStart(self)

	return
end

function ys.Battle.UnitState:OnActionTrigger()
	self._currentState:OnTrigger(self)

	return
end

function ys.Battle.UnitState:OnActionEnd()
	self._currentState:OnEnd(self)

	return
end

return
