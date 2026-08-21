ys = ys or {}

local var_0_0 = class("BattleBuffAddAttrRatioCommander", ys.Battle.BattleBuffAddAttrRatio)

ys.Battle.BattleBuffAddAttrRatioCommander = var_0_0
var_0_0.__name = "BattleBuffAddAttrRatioCommander"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function var_0_0.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._group = arg_3_0._tempData.arg_list.group or arg_3_2:GetID()
	arg_3_0._attr = arg_3_0._tempData.arg_list.convertAttr
	arg_3_0._number = arg_3_0._commander:getAbilitys()[arg_3_0._tempData.arg_list.ability].value * arg_3_0._tempData.arg_list.convertRate * var_0.Battle.BattleAttr.GetBase(arg_3_1, arg_3_0._attr) * 0.0001
	arg_3_0._numberBase = arg_3_0._number

	return
end

return
