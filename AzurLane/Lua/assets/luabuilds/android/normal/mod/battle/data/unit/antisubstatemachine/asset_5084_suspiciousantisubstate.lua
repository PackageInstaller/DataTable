ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.SuspiciousAntiSubState = var_0_10002("SuspiciousAntiSubState", var_0.Battle.IAntiSubState)
var_0.Battle.SuspiciousAntiSubState.__name = "SuspiciousAntiSubState"

local var_0_2 = var_0.Battle.SuspiciousAntiSubState

function var_0_2.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function var_0_2.OnVigilantEngage(arg_2_0, arg_2_1)
	arg_2_1:OnVigilantState()

	return
end

function var_0_2.OnMineExplode(arg_3_0, arg_3_1)
	arg_3_1:OnVigilantState()

	return
end

function var_0_2.OnSubmarinFloat(arg_4_0, arg_4_1)
	arg_4_1:OnVigilantState()

	return
end

function var_0_2.ToPreLevel(arg_5_0, arg_5_1)
	arg_5_1:OnCalmState()

	return
end

function var_0_2.OnHateChain(arg_6_0, arg_6_1)
	arg_6_1:OnVigilantState()

	return
end

function var_0_2.GetWeaponUseable(arg_7_0)
	return {}
end

function var_0_2.CanDecay(arg_8_0)
	return true
end

function var_0_2.GetWarnMark(arg_9_0)
	return 1
end

function var_0_2.GetMeterSpeed(arg_10_0)
	return 1
end

function var_0_2.DecayDuration(arg_11_0)
	return 1
end

return
