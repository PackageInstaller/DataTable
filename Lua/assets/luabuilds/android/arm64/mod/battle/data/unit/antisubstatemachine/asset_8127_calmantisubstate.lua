ys = ys or {}
ys.Battle.CalmAntiSubState = class("CalmAntiSubState", ys.Battle.IAntiSubState)
ys.Battle.CalmAntiSubState.__name = "CalmAntiSubState"

local var_0_0 = ys.Battle.CalmAntiSubState

function ys.Battle.CalmAntiSubState.Ctor(arg_1_0)
	var_0_0.super.Ctor(arg_1_0)

	return
end

function ys.Battle.CalmAntiSubState.OnVigilantEngage(arg_2_0, arg_2_1)
	arg_2_1:OnVigilantState()

	return
end

function ys.Battle.CalmAntiSubState.OnMineExplode(arg_3_0, arg_3_1)
	arg_3_1:OnSuspiciousState()

	return
end

function ys.Battle.CalmAntiSubState.OnSubmarinFloat(arg_4_0, arg_4_1)
	arg_4_1:OnSuspiciousState()

	return
end

function ys.Battle.CalmAntiSubState.OnHateChain(arg_5_0, arg_5_1)
	arg_5_1:OnSuspiciousState()

	return
end

function ys.Battle.CalmAntiSubState.ToPreLevel(arg_6_0, arg_6_1)
	return
end

function ys.Battle.CalmAntiSubState.GetWeaponUseable(arg_7_0)
	return {}
end

function ys.Battle.CalmAntiSubState.CanDecay(arg_8_0)
	return false
end

function ys.Battle.CalmAntiSubState.GetWarnMark(arg_9_0)
	return 0
end

function ys.Battle.CalmAntiSubState.GetMeterSpeed(arg_10_0)
	return -1
end

function ys.Battle.CalmAntiSubState.DecayDuration(arg_11_0)
	return 0
end

return
