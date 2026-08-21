ys = ys or {}

local var_0_0 = class("BattleBuffAddAttrRatio", ys.Battle.BattleBuffAddAttr)

ys.Battle.BattleBuffAddAttrRatio = var_0_0
var_0_0.__name = "BattleBuffAddAttrRatio"

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
	arg_3_0._attrBound = arg_3_0._tempData.arg_list.attrBound

	local var_3_0 = arg_3_0._tempData.arg_list.convertAttr or arg_3_0._attr

	arg_3_0._number = arg_3_0._tempData.arg_list.number * var_0.Battle.BattleAttr.GetBase(arg_3_1, var_3_0) * 0.0001
	arg_3_0._numberBase = arg_3_0._number

	if arg_3_0._attrBound then
		arg_3_0._numberBase = math.min(arg_3_0._numberBase, arg_3_0._attrBound)
	end

	arg_3_0._attrID = arg_3_0._tempData.arg_list.attr_group_ID

	return
end

return
