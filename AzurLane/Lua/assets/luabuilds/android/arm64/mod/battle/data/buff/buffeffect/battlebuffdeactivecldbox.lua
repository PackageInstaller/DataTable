ys = ys or {}
ys.Battle.BattleBuffDeactiveCLDBox = class("BattleBuffDeactiveCLDBox", ys.Battle.BattleBuffEffect)
ys.Battle.BattleBuffDeactiveCLDBox.__name = "BattleBuffDeactiveCLDBox"

local var_0_0 = ys.Battle.BattleBuffDeactiveCLDBox

function ys.Battle.BattleBuffDeactiveCLDBox.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function ys.Battle.BattleBuffDeactiveCLDBox.GetEffectType(arg_2_0)
	return var_0_0.FX_TYPE
end

function ys.Battle.BattleBuffDeactiveCLDBox.onAttach(arg_3_0, arg_3_1, arg_3_2)
	arg_3_1:SetCldBoxImmune(true)

	return
end

function ys.Battle.BattleBuffDeactiveCLDBox.onRemove(arg_4_0, arg_4_1, arg_4_2)
	arg_4_1:SetCldBoxImmune(false)

	return
end

return
