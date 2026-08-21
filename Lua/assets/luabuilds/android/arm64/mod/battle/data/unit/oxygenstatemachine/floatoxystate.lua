ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleAttr

ys.Battle.FloatOxyState = class("FloatOxyState", ys.Battle.IOxyState)
ys.Battle.FloatOxyState.__name = "FloatOxyState"

local var_0_3 = ys.Battle.FloatOxyState

function ys.Battle.FloatOxyState.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.FloatOxyState.GetWeaponUseableList(arg_2_0)
	return {
		var_0_1.OXY_STATE.DIVE,
		var_0_1.OXY_STATE.FLOAT
	}
end

function ys.Battle.FloatOxyState.UpdateCldData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_0

	if arg_3_2:GetDiveState() ~= var_3_0 then
		var_0_2.UnitCldEnable(arg_3_1)
	end

	return
end

function ys.Battle.FloatOxyState.GetDiveState(arg_4_0)
	return var_0_1.OXY_STATE.FLOAT
end

function ys.Battle.FloatOxyState.GetBubbleFlag(arg_5_0)
	return false
end

function ys.Battle.FloatOxyState.DoUpdateOxy(arg_6_0, arg_6_1)
	arg_6_1:OxyRecover(var_0_0.Battle.OxyState.STATE_FLOAT)

	return
end

function ys.Battle.FloatOxyState.IsVisible(arg_7_0)
	return true
end

function ys.Battle.FloatOxyState.GetBarVisible(arg_8_0)
	return false
end

function ys.Battle.FloatOxyState.RunMode(arg_9_0)
	return false
end

function ys.Battle.FloatOxyState.UpdateDive(arg_10_0)
	return true
end

return
