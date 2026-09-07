ys = ys or {}
ys.Battle.BattleBuffSwitchShader = class("BattleBuffSwitchShader", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffSwitchShader.__name = "BattleBuffSwitchShader"

local var_0_0 = ys.Battle.BattleBuffSwitchShader

function ys.Battle.BattleBuffSwitchShader.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffSwitchShader:SetArgs(arg_2_1, arg_2_2)
	self._shader = self._tempData.arg_list.shader
	self._invisible = self._tempData.arg_list.invisible or 0.7

	return
end

function ys.Battle.BattleBuffSwitchShader:onAttach(arg_3_1, arg_3_2, arg_3_3)
	arg_3_1:SwitchShader(self._shader, nil, {
		invisible = self._invisible
	})

	return
end

function ys.Battle.BattleBuffSwitchShader.onRemove(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
	arg_4_1:SwitchShader("COLORED_ALPHA")

	return
end

return
