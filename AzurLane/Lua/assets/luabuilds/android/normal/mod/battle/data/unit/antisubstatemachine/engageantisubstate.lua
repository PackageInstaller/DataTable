ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle

class = var_0_10003
var_0_2.EngageAntiSubState = var_0_10003("EngageAntiSubState", var_0.Battle.IAntiSubState)
var_0.Battle.EngageAntiSubState.__name = "EngageAntiSubState"

local var_0_3 = var_0.Battle.EngageAntiSubState

function var_0_3.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function var_0_3.OnVigilantEngage(arg_2_0, arg_2_1)
	return
end

function var_0_3.OnMineExplode(arg_3_0, arg_3_1)
	return
end

function var_0_3.OnSubmarinFloat(arg_4_0, arg_4_1)
	return
end

function var_0_3.ToPreLevel(arg_5_0, arg_5_1)
	arg_5_1:OnVigilantState()

	return
end

function var_0_3.OnHateChain(arg_6_0)
	return
end

function var_0_3.GetWeaponUseable(arg_7_0)
	return {
		var_0_1.OXY_STATE.FLOAT
	}
end

function var_0_3.CanDecay(arg_8_0)
	return true
end

function var_0_3.GetWarnMark(arg_9_0)
	return 3
end

function var_0_3.GetMeterSpeed(arg_10_0)
	return 5
end

function var_0_3.DecayDuration(arg_11_0)
	return 3
end

return
