ys = ys or {}

local var_0_0 = ys.Battle.BattleConst

ys.Battle.DeepMineOxyState = class("DeepMineOxyState", ys.Battle.IOxyState)
ys.Battle.DeepMineOxyState.__name = "DeepMineOxyState"

local var_0_2 = ys.Battle.DeepMineOxyState

function ys.Battle.DeepMineOxyState.Ctor(arg_1_0)
	var_0_2.super.Ctor(arg_1_0)

	return
end

function ys.Battle.DeepMineOxyState.UpdateCldData(arg_2_0, arg_2_1, arg_2_2)
	arg_2_1:GetCldData().Surface = arg_2_0:GetDiveState()

	return
end

function ys.Battle.DeepMineOxyState.GetWeaponUseableList(arg_3_0)
	return {
		var_0_0.OXY_STATE.DIVE
	}
end

function ys.Battle.DeepMineOxyState.UpdateCldData(arg_4_0, arg_4_1)
	return
end

function ys.Battle.DeepMineOxyState.GetDiveState(arg_5_0)
	return var_0_0.OXY_STATE.DIVE
end

function ys.Battle.DeepMineOxyState.GetBubbleFlag(arg_6_0)
	return false
end

function ys.Battle.DeepMineOxyState.IsVisible(arg_7_0)
	return false
end

function ys.Battle.DeepMineOxyState.GetBarVisible(arg_8_0)
	return true
end

function ys.Battle.DeepMineOxyState.RunMode(arg_9_0)
	return false
end

return
