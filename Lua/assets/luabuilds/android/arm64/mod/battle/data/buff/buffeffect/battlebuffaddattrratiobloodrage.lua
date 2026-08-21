ys = ys or {}

local var_0_0 = class("BattleBuffAddAttrRatioBloodrage", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrRatioBloodrage = var_0_0
var_0_0.__name = "BattleBuffAddAttrRatioBloodrage"

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
	arg_3_0._threshold = arg_3_0._tempData.arg_list.threshold
	arg_3_0._value = arg_3_0._tempData.arg_list.value
	arg_3_0._attrBound = arg_3_0._tempData.arg_list.attrBound
	arg_3_0._number = 0

	return
end

function var_0_0.doOnHPRatioUpdate(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0:UpdateAttr(arg_4_1)

	return
end

function var_0_0.calcBloodRageNumber(arg_5_0, arg_5_1)
	local var_5_0 = arg_5_1:GetHPRate()

	if var_5_0 > arg_5_0._threshold then
		arg_5_0._number = 0
	else
		arg_5_0._number = (arg_5_0._threshold - var_5_0) / arg_5_0._value * var_0.Battle.BattleAttr.GetBase(arg_5_1, arg_5_0._attr) * 0.0001

		if arg_5_0._attrBound then
			arg_5_0._number = math.min(arg_5_0._number, arg_5_0._attrBound)
		end
	end

	return
end

function var_0_0.doOnHPRatioUpdate(arg_6_0, arg_6_1, arg_6_2)
	arg_6_0:calcBloodRageNumber(arg_6_1)
	arg_6_0:UpdateAttr(arg_6_1)

	return
end

function var_0_0.onRemove(arg_7_0, arg_7_1, arg_7_2)
	arg_7_0._number = 0

	arg_7_0:UpdateAttr(arg_7_1)

	return
end

return
