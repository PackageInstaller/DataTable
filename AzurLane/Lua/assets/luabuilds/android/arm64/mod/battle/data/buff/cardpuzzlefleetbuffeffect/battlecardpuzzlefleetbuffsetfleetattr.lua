ys = ys or {}

local var_0_0 = class("BattleCardPuzzleFleetBuffSetFleetAttr", ys.Battle.BattleFleetBuffEffect)

ys.Battle.BattleCardPuzzleFleetBuffSetFleetAttr = var_0_0
var_0_0.__name = "BattleCardPuzzleFleetBuffSetFleetAttr"
var_0_0.FX_TYPE = ys.Battle.BattleBuffEffect.FX_TYPE_MOD_ATTR

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0._tempData = Clone(arg_1_1)
	arg_1_0._type = arg_1_0._tempData.type

	arg_1_0:SetActive()

	return
end

function var_0_0.GetEffectType(arg_2_0)
	return var_0_0.FX_TYPE
end

function var_0_0.SetArgs(arg_3_0, arg_3_1, arg_3_2)
	var_0_0.super.SetArgs(arg_3_0, arg_3_1, arg_3_2)

	arg_3_0._group = arg_3_0._tempData.arg_list.group or arg_3_0._fleetBuff:GetID()
	arg_3_0._attr = arg_3_0._tempData.arg_list.attr
	arg_3_0._number = arg_3_0._tempData.arg_list.number

	if arg_3_0._tempData.arg_list.enhance_formula then
		arg_3_0._number = DBGformula.parseFormula(arg_3_0._tempData.arg_list.enhance_formula, arg_3_1:GetAttrManager()) + arg_3_0._number
	end

	arg_3_0._cache = arg_3_0._tempData.arg_list.maintain
	arg_3_0._numberBase = arg_3_0._number

	return
end

function var_0_0.onRemove(arg_4_0)
	if arg_4_0._cache then
		arg_4_0._number = 0
	end

	arg_4_0:onTrigger()

	return
end

function var_0_0.GetGroup(arg_5_0)
	return arg_5_0._group
end

function var_0_0.GetNumber(arg_6_0)
	return arg_6_0._number * arg_6_0._fleetBuff:GetStack()
end

function var_0_0.IsSameAttr(arg_7_0, arg_7_1)
	return arg_7_0._attr == arg_7_1
end

function var_0_0.onTrigger(arg_8_0)
	arg_8_0._cardPuzzleComponent:UpdateAttrBySet(arg_8_0._attr, arg_8_0:GetNumber())

	return
end

return
