ys = ys or {}

local var_0_0 = ys.Battle.BattleConst

ys.Battle.EngageAntiSubState = class("EngageAntiSubState", ys.Battle.IAntiSubState)
ys.Battle.EngageAntiSubState.__name = "EngageAntiSubState"

local var_0_1 = ys.Battle.EngageAntiSubState

function ys.Battle.EngageAntiSubState.Ctor(arg_1_0)
	var_0_1.super.Ctor(arg_1_0)

	return
end

function ys.Battle.EngageAntiSubState.OnVigilantEngage(arg_2_0, arg_2_1)
	return
end

function ys.Battle.EngageAntiSubState.OnMineExplode(arg_3_0, arg_3_1)
	return
end

function ys.Battle.EngageAntiSubState.OnSubmarinFloat(arg_4_0, arg_4_1)
	return
end

function ys.Battle.EngageAntiSubState.ToPreLevel(arg_5_0, arg_5_1)
	arg_5_1:OnVigilantState()

	return
end

function ys.Battle.EngageAntiSubState.OnHateChain(arg_6_0)
	return
end

function ys.Battle.EngageAntiSubState.GetWeaponUseable(arg_7_0)
	return {
		var_0_0.OXY_STATE.FLOAT
	}
end

function ys.Battle.EngageAntiSubState.CanDecay(arg_8_0)
	return true
end

function ys.Battle.EngageAntiSubState.GetWarnMark(arg_9_0)
	return 3
end

function ys.Battle.EngageAntiSubState.GetMeterSpeed(arg_10_0)
	return 5
end

function ys.Battle.EngageAntiSubState.DecayDuration(arg_11_0)
	return 3
end

return
