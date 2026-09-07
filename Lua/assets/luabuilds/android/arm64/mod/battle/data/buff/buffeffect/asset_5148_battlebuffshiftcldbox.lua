ys = ys or {}
ys.Battle.BattleBuffShiftCLDBox = class("BattleBuffShiftCLDBox", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffShiftCLDBox.__name = "BattleBuffShiftCLDBox"

local var_0_0 = ys.Battle.BattleBuffShiftCLDBox

function ys.Battle.BattleBuffShiftCLDBox.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffShiftCLDBox:SetArgs(arg_2_1, arg_2_2)
	self._cldBox = self._tempData.arg_list.cld_box
	self._cldOffset = self._tempData.arg_list.cld_offset or {
		0,
		0,
		0
	}

	return
end

function ys.Battle.BattleBuffShiftCLDBox.GetEffectType(arg_3_0)
	return var_0_0.FX_TYPE
end

function ys.Battle.BattleBuffShiftCLDBox:onAttach(arg_4_1, arg_4_2)
	arg_4_1:ShiftCldComponent(self._cldBox, self._cldOffset)

	return
end

function ys.Battle.BattleBuffShiftCLDBox.onRemove(arg_5_0, arg_5_1, arg_5_2)
	arg_5_1:ResetCldComponent()

	return
end

return
