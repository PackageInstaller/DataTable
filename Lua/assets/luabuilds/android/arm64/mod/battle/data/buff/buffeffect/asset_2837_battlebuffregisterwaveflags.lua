ys = ys or {}

local var_0_0 = ys
local BattleBuffRegisterWaveFlags = class("BattleBuffRegisterWaveFlags", ys.Battle.BattleBuffEffect)

BattleBuffRegisterWaveFlags.__name = "BattleBuffRegisterWaveFlags"
ys.Battle.BattleBuffRegisterWaveFlags = BattleBuffRegisterWaveFlags

function BattleBuffRegisterWaveFlags:SetArgs(arg_1_1, arg_1_2)
	self._flags = self._tempData.arg_list.flags

	return
end

function BattleBuffRegisterWaveFlags:onTrigger(arg_2_1, arg_2_2, arg_2_3)
	BattleBuffRegisterWaveFlags.super.onTrigger(self, arg_2_1, arg_2_2, arg_2_3)

	local var_2_0 = var_0_0.Battle.BattleDataProxy.GetInstance()

	for iter_2_0, iter_2_1 in ipairs(self._flags) do
		var_2_0:AddWaveFlag(iter_2_1)
	end

	return
end

return
