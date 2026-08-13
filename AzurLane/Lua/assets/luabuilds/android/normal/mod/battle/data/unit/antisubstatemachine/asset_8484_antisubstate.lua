ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst.ActionName
local var_0_2 = var_0.Battle

class = var_0_10004
var_0_2.AntiSubState = var_0_10004("AntiSubState")
var_0.Battle.AntiSubState.__name = "AntiSubState"

local var_0_3 = var_0.Battle.AntiSubState

function var_0_3.Ctor(arg_1_0, arg_1_1)
	arg_1_0._client = arg_1_1
	arg_1_0._calmState = var_0.Battle.CalmAntiSubState.New()
	arg_1_0._suspiciousState = var_0.Battle.SuspiciousAntiSubState.New()
	arg_1_0._vigilantState = var_0.Battle.VigilantAntiSubState.New()
	arg_1_0._engageState = var_0.Battle.EngageAntiSubState.New()
	arg_1_0._currentState = arg_1_0._calmState
	arg_1_0._vigilantValue = 0
	arg_1_0._vigilantDecayTimeStamp = nil
	arg_1_0._decayFlag = false
	arg_1_0._engageRage = false
	arg_1_0._lastSonarDected = false

	return
end

function var_0_3.Update(arg_2_0, arg_2_1, arg_2_2)
	if arg_2_2 > 0 and arg_2_0:checkDecayRage() then
		arg_2_0:OnEngageState()
	end

	if arg_2_1 + arg_2_2 > 0 then
		arg_2_0:resetVigilantDecay()
	end

	pg = var_3

	local var_2_0 = var_3.TimeMgr.GetInstance()
	local var_2_1 = var_3.GetCombatTime(var_2_0)

	if arg_2_0._vigilantDecayTimeStamp then
		arg_2_0:updateVigilantDecay(var_2_1)
	else
		local var_2_2 = arg_2_0._currentState

		if var_4.CanDecay(var_2_2) and arg_2_1 + arg_2_2 == 0 then
			arg_2_0._vigilantDecayTimeStamp = var_2_1
		end
	end

	local var_2_3 = arg_2_0._currentState
	local var_2_4 = var_4.GetMeterSpeed(var_2_3)

	if arg_2_0._decayFlag then
		math = var_5
		var_2_4 = var_5.min(0, var_2_4)
	end

	math = var_5
	arg_2_0._vigilantValue = var_5.clamp(arg_2_0._vigilantValue + var_2_4, 0, 100)

	if arg_2_0._vigilantValue >= 100 and arg_2_0._currentState ~= arg_2_0._engageState then
		arg_2_0:OnEngageState()
	end

	return
end

function var_0_3.updateVigilantDecay(arg_3_0, arg_3_1)
	local var_3_0 = arg_3_1 - arg_3_0._vigilantDecayTimeStamp
	local var_3_1 = arg_3_0._currentState

	if var_3_0 >= var_3.DecayDuration(var_3_1) then
		arg_3_0._vigilantValue = arg_3_0._vigilantValue - 0.01

		local var_3_2 = arg_3_0._currentState

		var_3.ToPreLevel(var_3_2, arg_3_0)

		arg_3_0._decayFlag = true
	end

	return
end

function var_0_3.resetVigilantDecay(arg_4_0)
	arg_4_0._vigilantDecayTimeStamp = nil
	arg_4_0._decayFlag = false

	return
end

function var_0_3.checkDecayRage(arg_5_0)
	local var_5_0

	if arg_5_0._vigilantDecayTimeStamp then
		var_5_0 = arg_5_0._engageRage
	end

	return var_5_0
end

function var_0_3.HateChain(arg_6_0)
	arg_6_0:resetVigilantDecay()

	local var_6_0 = arg_6_0._currentState

	var_1.OnHateChain(var_6_0, arg_6_0)

	return
end

function var_0_3.InitCheck(arg_7_0, arg_7_1)
	if arg_7_1 > 0 then
		arg_7_0:SubmarineFloat()
	end

	return
end

function var_0_3.MineExplode(arg_8_0)
	if arg_8_0:checkDecayRage() then
		arg_8_0:OnEngageState()

		return
	end

	arg_8_0:resetVigilantDecay()

	local var_8_0 = arg_8_0._currentState

	var_1.OnMineExplode(var_8_0, arg_8_0)

	return
end

function var_0_3.SubmarineFloat(arg_9_0)
	if arg_9_0:checkDecayRage() then
		arg_9_0:OnEngageState()

		return
	end

	arg_9_0:resetVigilantDecay()

	local var_9_0 = arg_9_0._currentState

	var_1.OnSubmarinFloat(var_9_0, arg_9_0)

	return
end

function var_0_3.VigilantAreaEngage(arg_10_0)
	arg_10_0:resetVigilantDecay()

	local var_10_0 = arg_10_0._currentState

	var_1.OnVigilantEngage(var_10_0, arg_10_0)

	return
end

function var_0_3.SonarDetect(arg_11_0, arg_11_1)
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

function var_0_3.OnCalmState(arg_12_0)
	arg_12_0:resetVigilantDecay()

	arg_12_0._currentState = arg_12_0._calmState
	arg_12_0._engageRage = false

	arg_12_0:DispatchStateChange()

	return
end

function var_0_3.OnSuspiciousState(arg_13_0)
	arg_13_0:resetVigilantDecay()

	arg_13_0._currentState = arg_13_0._suspiciousState

	arg_13_0:DispatchStateChange()

	return
end

function var_0_3.OnVigilantState(arg_14_0)
	arg_14_0:resetVigilantDecay()

	arg_14_0._currentState = arg_14_0._vigilantState

	arg_14_0:DispatchStateChange()

	return
end

function var_0_3.OnEngageState(arg_15_0, arg_15_1)
	arg_15_0:resetVigilantDecay()

	arg_15_0._currentState = arg_15_0._engageState
	arg_15_0._engageRage = true

	arg_15_0:DispatchStateChange()

	if not arg_15_1 then
		arg_15_0:DispatchHateChain()
	end

	return
end

function var_0_3.IsWeaponUseable(arg_16_0)
	local var_16_0 = arg_16_0._currentState

	return #var_1.GetWeaponUseable(var_16_0) > 0
end

function var_0_3.GetVigilantRate(arg_17_0)
	return arg_17_0._vigilantValue * 0.01
end

function var_0_3.DispatchStateChange(arg_18_0)
	local var_18_0 = var_0.Event.New(var_0.Battle.BattleUnitEvent.CHANGE_ANTI_SUB_VIGILANCE)
	local var_18_1 = arg_18_0._client

	var_2.DispatchEvent(var_18_1, var_18_0)

	return
end

function var_0_3.DispatchSonarCheck(arg_19_0)
	local var_19_0 = var_0.Event.New(var_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_SONAR_CHECK)
	local var_19_1 = arg_19_0._client

	var_2.DispatchEvent(var_19_1, var_19_0)

	return
end

function var_0_3.DispatchHateChain(arg_20_0)
	local var_20_0 = var_0.Event.New(var_0.Battle.BattleUnitEvent.ANTI_SUB_VIGILANCE_HATE_CHAIN)
	local var_20_1 = arg_20_0._client

	var_2.DispatchEvent(var_20_1, var_20_0)

	return
end

function var_0_3.GetVigilantMark(arg_21_0)
	local var_21_0 = arg_21_0._currentState

	return var_1.GetWarnMark(var_21_0)
end

return
