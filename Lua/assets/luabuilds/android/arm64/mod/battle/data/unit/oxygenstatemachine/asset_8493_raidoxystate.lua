ys = ys or {}

local var_0_0 = ys.Battle.BattleConst
local var_0_1 = ys.Battle.BattleAttr

ys.Battle.RaidOxyState = class("RaidOxyState", ys.Battle.IOxyState)
ys.Battle.RaidOxyState.__name = "RaidOxyState"

local var_0_2 = ys.Battle.RaidOxyState

function ys.Battle.RaidOxyState.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.RaidOxyState.GetWeaponUseableList(arg_2_0)
	return {
		var_0_0.OXY_STATE.DIVE
	}
end

function ys.Battle.RaidOxyState:UpdateCldData(arg_3_1, arg_3_2)
	local var_3_0 = self:GetDiveState()

	arg_3_1:GetCldData().Surface = var_3_0

	if arg_3_2:GetDiveState() ~= var_3_0 then
		var_0_1.UnitCldImmune(arg_3_1)
	end

	return
end

function ys.Battle.RaidOxyState.GetDiveState(arg_4_0)
	return var_0_0.OXY_STATE.DIVE
end

function ys.Battle.RaidOxyState.GetBubbleFlag(arg_5_0)
	return true
end

function ys.Battle.RaidOxyState.IsVisible(arg_6_0)
	return false
end

function ys.Battle.RaidOxyState.GetBarVisible(arg_7_0)
	return true
end

function ys.Battle.RaidOxyState.RunMode(arg_8_0)
	return false
end

function ys.Battle.RaidOxyState.DoUpdateOxy(arg_9_0, arg_9_1)
	arg_9_1:OxyConsume()

	return
end

return
