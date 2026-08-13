ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConst
local var_0_2 = var_0.Battle.BattleAttr
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.DeepMineOxyState = var_0_10004("DeepMineOxyState", var_0.Battle.IOxyState)
var_0.Battle.DeepMineOxyState.__name = "DeepMineOxyState"

local var_0_4 = var_0.Battle.DeepMineOxyState

function var_0_4.Ctor(arg_1_0)
	var_0_4.super.Ctor(arg_1_0)

	return
end

function var_0_4.UpdateCldData(arg_2_0, arg_2_1, arg_2_2)
	local var_2_0 = arg_2_0:GetDiveState()

	arg_2_1:GetCldData().Surface = var_2_0

	return
end

function var_0_4.GetWeaponUseableList(arg_3_0)
	return {
		var_0_1.OXY_STATE.DIVE
	}
end

function var_0_4.UpdateCldData(arg_4_0, arg_4_1)
	return
end

function var_0_4.GetDiveState(arg_5_0)
	return var_0_1.OXY_STATE.DIVE
end

function var_0_4.GetBubbleFlag(arg_6_0)
	return false
end

function var_0_4.IsVisible(arg_7_0)
	return false
end

function var_0_4.GetBarVisible(arg_8_0)
	return true
end

function var_0_4.RunMode(arg_9_0)
	return false
end

return
