ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleAttr

ys.Battle.FreeFloatOxyState = class("FreeFloatOxyState", ys.Battle.IOxyState)
ys.Battle.FreeFloatOxyState.__name = "FreeFloatOxyState"

local var_0_3 = ys.Battle.FreeFloatOxyState

function ys.Battle.FreeFloatOxyState.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.FreeFloatOxyState.GetWeaponUseableList(arg_2_0)
	return {
		var_0_1.OXY_STATE.DIVE,
		var_0_1.OXY_STATE.FLOAT
	}
end

function ys.Battle.FreeFloatOxyState:UpdateCldData(arg_3_1, arg_3_2)
	local var_3_0 = self:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_0

	if arg_3_2:GetDiveState() ~= var_3_0 then
		var_0_2.UnitCldEnable(arg_3_1)
	end

	return
end

function ys.Battle.FreeFloatOxyState.GetDiveState(arg_4_0)
	return var_0_1.OXY_STATE.FLOAT
end

function ys.Battle.FreeFloatOxyState.GetBubbleFlag(arg_5_0)
	return false
end

function ys.Battle.FreeFloatOxyState.DoUpdateOxy(arg_6_0, arg_6_1)
	arg_6_1:OxyRecover(var_0_0.Battle.OxyState.STATE_FREE_FLOAT)

	return
end

function ys.Battle.FreeFloatOxyState.IsVisible(arg_7_0)
	return true
end

function ys.Battle.FreeFloatOxyState.GetBarVisible(arg_8_0)
	return true
end

function ys.Battle.FreeFloatOxyState.RunMode(arg_9_0)
	return true
end

return
