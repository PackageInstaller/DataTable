ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleAttr

ys.Battle.IdleOxyState = class("IdleOxyState", ys.Battle.IOxyState)
ys.Battle.IdleOxyState.__name = "IdleOxyState"

local var_0_2 = ys.Battle.IdleOxyState

function ys.Battle.IdleOxyState.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.IdleOxyState.GetWeaponUseableList(arg_2_0)
	return {}
end

function ys.Battle.IdleOxyState.UpdateCldData(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0 = arg_3_0:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_0

	if arg_3_2:GetDiveState() ~= var_3_0 then
		var_0_1.UnitCldEnable(arg_3_1)
	end

	return
end

function ys.Battle.IdleOxyState.GetDiveState(arg_4_0)
	return var_0_0.OXY_STATE.FLOAT
end

function ys.Battle.IdleOxyState.GetBubbleFlag(arg_5_0)
	return false
end

function ys.Battle.IdleOxyState.IsVisible(arg_6_0)
	return false
end

function ys.Battle.IdleOxyState.GetBarVisible(arg_7_0)
	return true
end

function ys.Battle.IdleOxyState.RunMode(arg_8_0)
	return false
end

function ys.Battle.IdleOxyState.UpdateDive(arg_9_0)
	return true
end

return
