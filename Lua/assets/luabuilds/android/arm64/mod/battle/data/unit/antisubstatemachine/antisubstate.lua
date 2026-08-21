ys = ys or {}

local var_0_0 = ys

ys.Battle.AntiSubState = class("AntiSubState")
ys.Battle.AntiSubState.__name = "AntiSubState"

function ys.Battle.AntiSubState.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1
	arg_1_0._calmState = var_0_0.Battle.CalmAntiSubState.New()
	arg_1_0._suspiciousState = var_0_0.Battle.SuspiciousAntiSubState.New()
	arg_1_0._vigilantState = var_0_0.Battle.VigilantAntiSubState.New()
	arg_1_0._engageState = var_0_0.Battle.EngageAntiSubState.New()
	arg_1_0._currentState = arg_1_0._calmState
	arg_1_0._vigilantValue = 0
	arg_1_0._vigilantDecayTimeStamp = nil
	arg_1_0._decayFlag = false
	arg_1_0._engageRage = false
	arg_1_0._lastSonarDected = false

	return
end

function ys.Battle.AntiSubState.Update(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 > 0 and arg_2_0:checkDecayRage() then
		arg_2_0:OnEngageState()
	end

	if arg_2_1 + arg_2_2 > 0 then
		arg_2_0:resetVigilantDecay()
	end

	local var_2_0 = pg.TimeMgr.GetInstance():GetCombatTime()

	if arg_2_0._vigilantDecayTimeStamp then
		arg_2_0:updateVigilantDecay(var_2_0)
	elseif arg_2_0._currentState:CanDecay() and arg_2_1 + arg_2_2 == 0 then
		arg_2_0._vigilantDecayTimeStamp = var_2_0
	end

	local var_2_1 = arg_2_0._currentState:GetMeterSpeed()

	if arg_2_0._decayFlag then
		var_2_1 = math.min(0, var_2_1)
	end

	arg_2_0._vigilantValue = math.clamp(arg_2_0._vigilantValue + var_2_1, 0, 100)

	if arg_2_0._vigilantValue >= 100 and arg_2_0._currentState ~= arg_2_0._engageState then
		arg_2_0:OnEngageState()
	end

	return
end

function ys.Battle.AntiSubState.updateVigilantDecay(arg_3_0, arg_3_1)
	if arg_3_1 - arg_3_0._vigilantDecayTimeStamp >= arg_3_0._currentState:DecayDuration() then
		arg_3_0._vigilantValue = arg_3_0._vigilantValue - 0.01

		arg_3_0._currentState:ToPreLevel(arg_3_0)

		arg_3_0._decayFlag = true
	end

	return
end

function ys.Battle.AntiSubState.resetVigilantDecay(arg_4_0)
	arg_4_0._vigilantDecayTimeStamp = nil
	arg_4_0._decayFlag = false

	return
end

function ys.Battle.AntiSubState.checkDecayRage(arg_5_0)
	return arg_5_0._vigilantDecayTimeStamp and arg_5_0._engageRage
end

function ys.Battle.AntiSubState.HateChain(arg_6_0)
	arg_6_0:resetVigilantDecay()
	arg_6_0._currentState:OnHateChain(arg_6_0)

	return
end

function ys.Battle.AntiSubState.InitCheck(arg_7_0, arg_7_1)
	if arg_7_1 > 0 then
		arg_7_0:SubmarineFloat()
	end

	return
end

function ys.Battle.AntiSubState.MineExplode(arg_8_0)
	if arg_8_0:checkDecayRage() then
		arg_8_0:OnEngageState()

		return
	end

	arg_8_0:resetVigilantDecay()
	arg_8_0._currentState:OnMineExplode(arg_8_0)

	return
end

function ys.Battle.AntiSubState.SubmarineFloat(arg_9_0)
	if arg_9_0:checkDecayRage() then
		arg_9_0:OnEngageState()

		return
	end

	arg_9_0:resetVigilantDecay()
	arg_9_0._currentState:OnSubmarinFloat(arg_9_0)

	return
end

function ys.Battle.AntiSubState.VigilantAreaEngage(arg_10_0)
	arg_10_0:resetVigilantDecay()
	arg_10_0._currentState:OnVigilantEngage(arg_10_0)

	return
end

function ys.Battle.AntiSubState.SonarDetect(arg_11_0, arg_11_1)
	arg_11_0:DispatchSonarCheck()

	local var_11_0 = arg_11_1 > 0

	if arg_11_0._lastSonarDected and var_11_0 then
		arg_11_0:OnEngageState()
	elseif var_11_0 then
		arg_11_0:OnVigilantState()
	end

	arg_11_0._lastSonarDected = var_11_0

	return
end

function ys.Battle.AntiSubState.OnCalmState(arg_12_0)
	arg_12_0:resetVigilantDecay()

	arg_12_0._currentState = arg_12_0._calmState
	arg_12_0._engageRage = false

	arg_12_0:DispatchStateChange()

	return
end

function ys.Battle.AntiSubState.OnSuspiciousState(arg_13_0)
	arg_13_0:resetVigilantDecay()

	arg_13_0._currentState = arg_13_0._suspiciousState

	arg_13_0:DispatchStateChange()

	return
end

function ys.Battle.AntiSubState.OnVigilantState(arg_14_0)
	arg_14_0:resetVigilantDecay()

	arg_14_0._currentState = arg_14_0._vigilantState

	arg_14_0:DispatchStateChange()

	return
end

function ys.Battle.AntiSubState.OnEngageState(arg_15_0, arg_15_1)
	arg_15_0:resetVigilantDecay()

	arg_15_0._currentState = arg_15_0._engageState
	arg_15_0._engageRage = true

	arg_15_0:DispatchStateChange()

	if not arg_15_1 then
		arg_15_0:DispatchHateChain()
	end

	return
end

function ys.Battle.AntiSubState.IsWeaponUseable(arg_16_0)
	return #arg_16_0._currentState:GetWeaponUseable() > 0
end

function ys.Battle.AntiSubState.GetVigilantRate(arg_17_0)
	return arg_17_0._vigilantValue * 0.01
end

function ys.Battle.AntiSubState.DispatchStateChange(arg_18_0)
	arg_18_0._client:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.CHANGE_ANTI_SUB_VIGILANCE)))

	return
end

function ys.Battle.AntiSubState.DispatchSonarCheck(arg_19_0)
	arg_19_0._client:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_SONAR_CHECK)))

	return
end

function ys.Battle.AntiSubState.DispatchHateChain(arg_20_0)
	arg_20_0._client:DispatchEvent((var_0_0.Event.New(var_0_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_HATE_CHAIN)))

	return
end

function ys.Battle.AntiSubState.GetVigilantMark(arg_21_0)
	return arg_21_0._currentState:GetWarnMark()
end

return
