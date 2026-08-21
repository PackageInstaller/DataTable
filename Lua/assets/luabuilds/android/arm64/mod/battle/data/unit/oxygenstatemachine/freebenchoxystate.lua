ys = ys or {}

local var_0_0 = ys
local var_0_1 = ys.Battle.BattleConst
local var_0_2 = ys.Battle.BattleAttr

ys.Battle.FreeBenchOxyState = class("FreeBenchOxyState", ys.Battle.IOxyState)
ys.Battle.FreeBenchOxyState.__name = "FreeBenchOxyState"

local var_0_3 = ys.Battle.FreeBenchOxyState

function ys.Battle.FreeBenchOxyState.Ctor(arg_1_0)
	var_0_3.super.Ctor(arg_1_0)

	return
end

function ys.Battle.FreeBenchOxyState.GetWeaponUseableList(arg_2_0)
	return {}
end

function ys.Battle.FreeBenchOxyState.UpdateCldData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_0

	if arg_3_2:GetDiveState() ~= var_3_0 then
		var_0_2.UnitCldImmune(arg_3_1)
	end

	return
end

function ys.Battle.FreeBenchOxyState.GetDiveState(arg_4_0)
	return var_0_1.OXY_STATE.FLOAT
end

function ys.Battle.FreeBenchOxyState.GetBubbleFlag(arg_5_0)
	return true
end

function ys.Battle.FreeBenchOxyState.DoUpdateOxy(arg_6_0, arg_6_1)
	arg_6_1:OxyRecover(var_0_0.Battle.OxyState.STATE_FREE_BENCH)

	return
end

function ys.Battle.FreeBenchOxyState.IsVisible(arg_7_0)
	return false
end

function ys.Battle.FreeBenchOxyState.GetBarVisible(arg_8_0)
	return true
end

function ys.Battle.FreeBenchOxyState.RunMode(arg_9_0)
	return true
end

return
