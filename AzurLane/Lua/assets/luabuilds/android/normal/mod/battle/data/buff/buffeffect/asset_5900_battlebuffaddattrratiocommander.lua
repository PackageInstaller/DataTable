ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleBuffAddAttrRatioCommander", var_0.Battle.BattleBuffAddAttrRatio)

var_0.Battle.BattleBuffAddAttrRatioCommander = var_0_1
var_0_1.__name = "BattleBuffAddAttrRatioCommander"

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
	arg_3_0._attr = arg_3_0._tempData.arg_list.convertAttr

	local var_3_1 = arg_3_0._tempData.arg_list.ability
	local var_3_2 = arg_3_0._tempData.arg_list.convertRate
	local var_3_3 = arg_3_0._commander

	arg_3_0._number = var_5.getAbilitys(var_3_3)[var_3_1].value * var_3_2 * var_0.Battle.BattleAttr.GetBase(arg_3_1, arg_3_0._attr) * 0.0001
	arg_3_0._numberBase = arg_3_0._number

	return
end

return
