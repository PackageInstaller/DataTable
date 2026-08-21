ys = ys or {}
ys.Battle.SuspiciousAntiSubState = class("SuspiciousAntiSubState", ys.Battle.IAntiSubState)
ys.Battle.SuspiciousAntiSubState.__name = "SuspiciousAntiSubState"

local var_0_0 = ys.Battle.SuspiciousAntiSubState

function ys.Battle.SuspiciousAntiSubState.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.SuspiciousAntiSubState.OnVigilantEngage(arg_2_0, arg_2_1)
	arg_2_1:OnVigilantState()

	return
end

function ys.Battle.SuspiciousAntiSubState.OnMineExplode(arg_3_0, arg_3_1)
	arg_3_1:OnVigilantState()

	return
end

function ys.Battle.SuspiciousAntiSubState.OnSubmarinFloat(arg_4_0, arg_4_1)
	arg_4_1:OnVigilantState()

	return
end

function ys.Battle.SuspiciousAntiSubState.ToPreLevel(arg_5_0, arg_5_1)
	arg_5_1:OnCalmState()

	return
end

function ys.Battle.SuspiciousAntiSubState.OnHateChain(arg_6_0, arg_6_1)
	arg_6_1:OnVigilantState()

	return
end

function ys.Battle.SuspiciousAntiSubState.GetWeaponUseable(arg_7_0)
	return {}
end

function ys.Battle.SuspiciousAntiSubState.CanDecay(arg_8_0)
	return true
end

function ys.Battle.SuspiciousAntiSubState.GetWarnMark(arg_9_0)
	return 1
end

function ys.Battle.SuspiciousAntiSubState.GetMeterSpeed(arg_10_0)
	return 1
end

function ys.Battle.SuspiciousAntiSubState.DecayDuration(arg_11_0)
	return 1
end

return
