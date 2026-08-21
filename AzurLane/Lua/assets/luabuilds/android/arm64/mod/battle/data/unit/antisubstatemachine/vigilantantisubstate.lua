ys = ys or {}
ys.Battle.VigilantAntiSubState = class("VigilantAntiSubState", ys.Battle.IAntiSubState)
ys.Battle.VigilantAntiSubState.__name = "VigilantAntiSubState"

local var_0_0 = ys.Battle.VigilantAntiSubState

function ys.Battle.VigilantAntiSubState.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.VigilantAntiSubState.OnVigilantEngage(arg_2_0, arg_2_1)
	return
end

function ys.Battle.VigilantAntiSubState.OnMineExplode(arg_3_0, arg_3_1)
	return
end

function ys.Battle.VigilantAntiSubState.OnSubmarinFloat(arg_4_0, arg_4_1)
	return
end

function ys.Battle.VigilantAntiSubState.OnHateChain(arg_5_0, arg_5_1)
	arg_5_1:OnEngageState(true)

	return
end

function ys.Battle.VigilantAntiSubState.ToPreLevel(arg_6_0, arg_6_1)
	arg_6_1:OnSuspiciousState()

	return
end

function ys.Battle.VigilantAntiSubState.GetWeaponUseable(arg_7_0)
	return {}
end

function ys.Battle.VigilantAntiSubState.CanDecay(arg_8_0)
	return true
end

function ys.Battle.VigilantAntiSubState.GetWarnMark(arg_9_0)
	return 2
end

function ys.Battle.VigilantAntiSubState.GetMeterSpeed(arg_10_0)
	return 1.3
end

function ys.Battle.VigilantAntiSubState.DecayDuration(arg_11_0)
	return 2
end

return
