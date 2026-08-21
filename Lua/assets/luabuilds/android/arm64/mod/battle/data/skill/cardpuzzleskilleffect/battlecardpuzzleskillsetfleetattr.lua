ys = ys or {}

local var_0_0 = ys.Battle.BattleCardPuzzleFormulas
local var_0_1 = class("BattleCardPuzzleSkillSetFleetAttr", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillSetFleetAttr = var_0_1
var_0_1.__name = "BattleCardPuzzleSkillSetFleetAttr"

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_1.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._attr = arg_1_0._tempData.arg_list.attr
	arg_1_0._number = arg_1_0._tempData.arg_list.number
	arg_1_0._enhance = arg_1_0._tempData.arg_list.enhance_formula

	return
end

function var_0_1.SkillEffectHandler(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._number

	if arg_2_0._enhance then
		var_2_0 = var_2_0 + var_0_0.parseFormula(arg_2_0._enhance, arg_2_0:GetCardPuzzleComponent():GetAttrManager())
	end

	arg_2_0:GetCardPuzzleComponent():UpdateAttrBySet(arg_2_0._attr, var_2_0)
	arg_2_0:Finale()

	return
end

return
