ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys
class = var_0_10001

local var_0_1 = var_0_10001("BattleCardPuzzleFleetBuffSetFleetAttr", var_0.Battle.BattleFleetBuffEffect)

var_0.Battle.BattleCardPuzzleFleetBuffSetFleetAttr = var_0_1
var_0_1.__name = "BattleCardPuzzleFleetBuffSetFleetAttr"
var_0_1.FX_TYPE = var_0.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function var_0_1.Ctor(arg_1_0, arg_1_1)
	Clone = var_1_10002
	arg_1_0._tempData = var_1_10002(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	arg_1_0:SetActive()

	return
end

function var_0_1.GetEffectType(arg_2_0)
	return var_0_1.FX_TYPE
end

function var_0_1.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	var_0_1.super.SetArgs(arg_3_0, arg_3_1, arg_3_2)

	local var_3_1

	if not arg_3_0._tempData.arg_list.group then
		local var_3_0 = arg_3_0._fleetBuff

		var_3_1 = var_3.GetID(var_3_0)
	end

	arg_3_0._group = var_3_1
	arg_3_0._attr = arg_3_0._tempData.arg_list.attr
	arg_3_0._number = arg_3_0._tempData.arg_list.number

	if arg_3_0._tempData.arg_list.enhance_formula then
		local var_3_2 = arg_3_0._tempData.arg_list.enhance_formula

		DBGformula = var_1_10004
		arg_3_0._number = var_1_10004.parseFormula(var_3_2, arg_3_1:GetAttrManager()) + arg_3_0._number
	end

	arg_3_0._cache = arg_3_0._tempData.arg_list.maintain
	arg_3_0._numberBase = arg_3_0._number

	return
end

function var_0_1.onRemove(arg_4_0)
	if arg_4_0._cache then
		arg_4_0._number = 0
	end

	arg_4_0:onTrigger()

	return
end

function var_0_1.GetGroup(arg_5_0)
	return arg_5_0._group
end

function var_0_1.GetNumber(arg_6_0)
	local var_6_0 = arg_6_0._number
	local var_6_1 = arg_6_0._fleetBuff

	return var_6_0 * var_2.GetStack(var_6_1)
end

function var_0_1.IsSameAttr(arg_7_0, arg_7_1)
	return arg_7_0._attr == arg_7_1
end

function var_0_1.onTrigger(arg_8_0)
	local var_8_0 = arg_8_0._cardPuzzleComponent

	var_1.UpdateAttrBySet(var_8_0, arg_8_0._attr, arg_8_0:GetNumber())

	return
end

return
