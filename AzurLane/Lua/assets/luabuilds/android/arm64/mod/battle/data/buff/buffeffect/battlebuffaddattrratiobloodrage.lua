ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddAttrRatioBloodrage", var_0.Battle.BattleBuffAddAttr)

var_0.Battle.BattleBuffAddAttrRatioBloodrage = var_0_1
var_0_1.__name = "BattleBuffAddAttrRatioBloodrage"

function var_0_1.Ctor(arg_1_0, arg_1_1)
	var_0_1.super.Ctor(arg_1_0, arg_1_1)

	return
end

function var_0_1.GetEffectType(arg_2_0)
	return var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR
end

function var_0_1.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	local var_3_0

	if not arg_3_0._tempData.arg_list.group then
		var_3_0 = arg_3_2:GetID()
	end

	arg_3_0._group = var_3_0
	arg_3_0._attr = arg_3_0._tempData.arg_list.attr
	arg_3_0._threshold = arg_3_0._tempData.arg_list.threshold
	arg_3_0._value = arg_3_0._tempData.arg_list.value
	arg_3_0._attrBound = arg_3_0._tempData.arg_list.attrBound
	arg_3_0._number = 0

	return
end

function var_0_1.doOnHPRatioUpdate(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:UpdateAttr(arg_4_1)

	return
end

function var_0_1.calcBloodRageNumber(arg_5_0, arg_5_1)
	if arg_5_1:GetHPRate() > arg_5_0._threshold then
		arg_5_0._number = 0
	else
		local var_5_0 = var_0.Battle.BattleAttr.GetBase(arg_5_1, arg_5_0._attr)

		arg_5_0._number = (arg_5_0._threshold - var_2) / arg_5_0._value * var_5_0 * 0.0001

		if arg_5_0._attrBound then
			math = var_5
			arg_5_0._number = var_5.min(arg_5_0._number, arg_5_0._attrBound)
		end
	end

	return
end

function var_0_1.doOnHPRatioUpdate(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:calcBloodRageNumber(arg_6_1)
	arg_6_0:UpdateAttr(arg_6_1)

	return
end

function var_0_1.onRemove(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._number = 0

	arg_7_0:UpdateAttr(arg_7_1)

	return
end

return
