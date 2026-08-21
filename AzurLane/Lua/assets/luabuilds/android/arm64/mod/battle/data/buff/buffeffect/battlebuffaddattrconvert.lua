ys = ys or {}

local var_0_0 = class("BattleBuffAddAttrConvert", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrConvert = var_0_0
var_0_0.__name = "BattleBuffAddAttrConvert"

function var_0_0.Ctor(arg_1_0, arg_1_1)
	var_0_0.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_0.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function var_0_0.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	arg_3_0._group = arg_3_0._tempData.arg_list.group or arg_3_2:GetID()
	arg_3_0._attr = arg_3_0._tempData.arg_list.attr
	arg_3_0._convertAttr = arg_3_0._tempData.arg_list.convertAttr
	arg_3_0._convertAttrValue = var_0.Battle.BattleAttr.GetBase(arg_3_1, arg_3_0._convertAttr)
	arg_3_0._convertRate = arg_3_0._tempData.arg_list.convertRate

	local var_3_0 = arg_3_0._tempData.arg_list.number or 0

	arg_3_0._number = var_3_0 + arg_3_0._convertAttrValue * arg_3_0._convertRate
	arg_3_0._numberBase = arg_3_0._number

	return
end

return
