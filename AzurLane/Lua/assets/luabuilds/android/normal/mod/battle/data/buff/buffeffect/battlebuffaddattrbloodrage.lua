ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddAttrBloodrage", var_0.Battle.BattleBuffAddAttr)

var_0.Battle.BattleBuffAddAttrBloodrage = var_0_1
var_0_1.__name = "BattleBuffAddAttrBloodrage"

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

function var_0_1.calcBloodRageNumber(arg_4_0, arg_4_1)
	if arg_4_1:GetHPRate() > arg_4_0._threshold then
		arg_4_0._number = 0
	else
		arg_4_0._number = (arg_4_0._threshold - var_2) / arg_4_0._value

		if arg_4_0._attrBound then
			math = var_3
			arg_4_0._number = var_3.min(arg_4_0._number, arg_4_0._attrBound)
		end
	end

	return
end

function var_0_1.doOnHPRatioUpdate(arg_5_0, arg_5_1, arg_5_2)
	arg_5_0:calcBloodRageNumber(arg_5_1)
	arg_5_0:UpdateAttr(arg_5_1)

	return
end

function var_0_1.onRemove(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0._number = 0

	arg_6_0:UpdateAttr(arg_6_1)

	return
end

return
