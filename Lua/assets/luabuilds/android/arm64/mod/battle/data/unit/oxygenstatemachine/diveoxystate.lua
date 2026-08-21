ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleAttr

ys.Battle.DiveOxyState = class("DiveOxyState", ys.Battle.IOxyState)
ys.Battle.DiveOxyState.__name = "DiveOxyState"

local var_0_2 = ys.Battle.DiveOxyState

function ys.Battle.DiveOxyState.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.DiveOxyState.GetWeaponUseableList(arg_2_0)
	return {}
end

function ys.Battle.DiveOxyState.UpdateCldData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_0

	if arg_3_2:GetDiveState() ~= var_3_0 then
		var_0_1.UnitCldImmune(arg_3_1)
	end

	return
end

function ys.Battle.DiveOxyState.GetDiveState(arg_4_0)
	return var_0_0.OXY_STATE.DIVE
end

function ys.Battle.DiveOxyState.GetBubbleFlag(arg_5_0)
	return true
end

function ys.Battle.DiveOxyState.IsVisible(arg_6_0)
	return false
end

function ys.Battle.DiveOxyState.GetBarVisible(arg_7_0)
	return true
end

function ys.Battle.DiveOxyState.RunMode(arg_8_0)
	return false
end

return
