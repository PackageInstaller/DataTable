ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle

class = var_0_10002
var_0_1.BattleBuffShiftCLDBox = var_0_10002("BattleBuffShiftCLDBox", var_0.Battle.BattleBuffEffect)
var_0.Battle.BattleBuffShiftCLDBox.__name = "BattleBuffShiftCLDBox"

local var_0_2 = var_0.Battle.BattleBuffShiftCLDBox

function var_0_2.Ctor(arg_1_0, arg_1_1)
	var_0_2.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_2.SetArgs(arg_2_0, arg_2_1, arg_2_2)
	arg_2_0._cldBox = arg_2_0._tempData.arg_list.cld_box

	local var_2_0

	if not arg_2_0._tempData.arg_list.cld_offset then
		var_2_0 = {
			0,
			0,
			0
		}
	end

	arg_2_0._cldOffset = var_2_0

	return
end

function var_0_2.GetEffectType(arg_3_0)
	return var_0_2.FX_TYPE
end

function var_0_2.onAttach(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:ShiftCldComponent(arg_4_0._cldBox, arg_4_0._cldOffset)

	return
end

function var_0_2.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:ResetCldComponent()

	return
end

return
