ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddAttrRatio", var_0.Battle.BattleBuffAddAttr)

var_0.Battle.BattleBuffAddAttrRatio = var_0_1
var_0_1.__name = "BattleBuffAddAttrRatio"

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
	arg_3_0._attrBound = arg_3_0._tempData.arg_list.attrBound

	local var_3_1

	if not arg_3_0._tempData.arg_list.convertAttr then
		var_3_1 = arg_3_0._attr
	end

	local var_3_2 = var_0.Battle.BattleAttr.GetBase(arg_3_1, var_3_1)

	arg_3_0._number = arg_3_0._tempData.arg_list.number * var_3_2 * 0.0001
	arg_3_0._numberBase = arg_3_0._number

	if arg_3_0._attrBound then
		math = var_5
		arg_3_0._numberBase = var_5.min(arg_3_0._numberBase, arg_3_0._attrBound)
	end

	arg_3_0._attrID = arg_3_0._tempData.arg_list.attr_group_ID

	return
end

return
