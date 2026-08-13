ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleAttr
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.FloatOxyState = var_0_10004("FloatOxyState", var_0.Battle.IOxyState)
var_0.Battle.FloatOxyState.__name = "FloatOxyState"

local var_0_4 = var_0.Battle.FloatOxyState

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.GetWeaponUseableList(arg_2_0)
	return {
		var_0_1.OXY_STATE.DIVE,
		var_0_1.OXY_STATE.FLOAT
	}
end

function var_0_4.UpdateCldData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_2:GetDiveState()
	local var_3_1 = arg_3_0:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_1

	if var_3_0 ~= var_3_1 then
		var_0_2.UnitCldEnable(arg_3_1)
	end

	return
end

function var_0_4.GetDiveState(arg_4_0)
	return var_0_1.OXY_STATE.FLOAT
end

function var_0_4.GetBubbleFlag(arg_5_0)
	return false
end

function var_0_4.DoUpdateOxy(arg_6_0, arg_6_1)
	arg_6_1:OxyRecover(var_0.Battle.OxyState.STATE_FLOAT)

	return
end

function var_0_4.IsVisible(arg_7_0)
	return true
end

function var_0_4.GetBarVisible(arg_8_0)
	return false
end

function var_0_4.RunMode(arg_9_0)
	return false
end

function var_0_4.UpdateDive(arg_10_0)
	return true
end

return
