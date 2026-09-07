ys = ys or {}

local var_0_0 = ys

ys.Battle.AntiSubState = class("AntiSubState")
ys.Battle.AntiSubState.__name = "AntiSubState"

function ys.Battle.AntiSubState:Ctor(arg_1_1)
	self._client = arg_1_1
	self._calmState = var_0_0.Battle.CalmAntiSubState.New()
	self._suspiciousState = var_0_0.Battle.SuspiciousAntiSubState.New()
	self._vigilantState = var_0_0.Battle.VigilantAntiSubState.New()
	self._engageState = var_0_0.Battle.EngageAntiSubState.New()
	self._currentState = self._calmState
	self._vigilantValue = 0
	self._vigilantDecayTimeStamp = nil
	self._decayFlag = false
	self._engageRage = false
	self._lastSonarDected = false

	return
end

function ys.Battle.AntiSubState:Update(arg_2_1, arg_2_2)
	if arg_2_2 > 0 and self:checkDecayRage() then
		self:OnEngageState()
	end

	if arg_2_1 + arg_2_2 > 0 then
		self:resetVigilantDecay()
	end

	local var_2_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if self._vigilantDecayTimeStamp then
		self:updateVigilantDecay(var_2_0)
	elseif self._currentState:CanDecay() and arg_2_1 + arg_2_2 == 0 then
		self._vigilantDecayTimeStamp = var_2_0
	end

	local var_2_1 = self._currentState:GetMeterSpeed()

	if self._decayFlag then
		var_2_1 = math.min(0, var_2_1)
	end

	self._vigilantValue = math.clamp(self._vigilantValue + var_2_1, 0, 100)

	if self._vigilantValue >= 100 and self._currentState ~= self._engageState then
		self:OnEngageState()
	end

	return
end

function ys.Battle.AntiSubState:updateVigilantDecay(arg_3_1)
	if arg_3_1 - self._vigilantDecayTimeStamp >= self._currentState:DecayDuration() then
		self._vigilantValue = self._vigilantValue - 0.01

		self._currentState:ToPreLevel(self)

		self._decayFlag = true
	end

	return
end

function ys.Battle.AntiSubState.resetVigilantDecay(arg_4_0)
	arg_4_0._vigilantDecayTimeStamp = nil
	arg_4_0._decayFlag = false

	return
end

function ys.Battle.AntiSubState:checkDecayRage()
	return self._vigilantDecayTimeStamp and self._engageRage
end

function ys.Battle.AntiSubState:HateChain()
	self:resetVigilantDecay()
	self._currentState:OnHateChain(self)

	return
end

function ys.Battle.AntiSubState:InitCheck(arg_7_1)
	if arg_7_1 > 0 then
		self:SubmarineFloat()
	end

	return
end

function ys.Battle.AntiSubState:MineExplode()
	if self:checkDecayRage() then
		self:OnEngageState()

		return
	end

	self:resetVigilantDecay()
	self._currentState:OnMineExplode(self)

	return
end

function ys.Battle.AntiSubState:SubmarineFloat()
	if self:checkDecayRage() then
		self:OnEngageState()

		return
	end

	self:resetVigilantDecay()
	self._currentState:OnSubmarinFloat(self)

	return
end

function ys.Battle.AntiSubState:VigilantAreaEngage()
	self:resetVigilantDecay()
	self._currentState:OnVigilantEngage(self)

	return
end

function ys.Battle.AntiSubState:SonarDetect(arg_11_1)
	self:DispatchSonarCheck()

	local var_11_0 = arg_11_1 > 0

	if self._lastSonarDected and var_11_0 then
		self:OnEngageState()
	elseif var_11_0 then
		self:OnVigilantState()
	end

	self._lastSonarDected = var_11_0

	return
end

function ys.Battle.AntiSubState:OnCalmState()
	self:resetVigilantDecay()

	self._currentState = self._calmState
	self._engageRage = false

	self:DispatchStateChange()

	return
end

function ys.Battle.AntiSubState:OnSuspiciousState()
	self:resetVigilantDecay()

	self._currentState = self._suspiciousState

	self:DispatchStateChange()

	return
end

function ys.Battle.AntiSubState:OnVigilantState()
	self:resetVigilantDecay()

	self._currentState = self._vigilantState

	self:DispatchStateChange()

	return
end

function ys.Battle.AntiSubState:OnEngageState(arg_15_1)
	self:resetVigilantDecay()

	self._currentState = self._engageState
	self._engageRage = true

	self:DispatchStateChange()

	if not arg_15_1 then
		self:DispatchHateChain()
	end

	return
end

function ys.Battle.AntiSubState:IsWeaponUseable()
	return #self._currentState:GetWeaponUseable() > 0
end

function ys.Battle.AntiSubState:GetVigilantRate()
	return self._vigilantValue * 0.01
end

function ys.Battle.AntiSubState:DispatchStateChange()
	self._client:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CHANGE_ANTI_SUB_VIGILANCE)))

	return
end

function ys.Battle.AntiSubState:DispatchSonarCheck()
	self._client:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_SONAR_CHECK)))

	return
end

function ys.Battle.AntiSubState:DispatchHateChain()
	self._client:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_HATE_CHAIN)))

	return
end

function ys.Battle.AntiSubState:GetVigilantMark()
	return self._currentState:GetWarnMark()
end

return
