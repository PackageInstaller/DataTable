ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleCardPuzzleFormulas

class = var_0_10002

local var_0_2 = var_0_10002("BattleCardPuzzleSkillAddFleetAttr", var_0.Battle.BattleCardPuzzleSkillEffect)

var_0.Battle.BattleCardPuzzleSkillAddFleetAttr = var_0_2
var_0_2.__name = "BattleCardPuzzleSkillAddFleetAttr"

function var_0_2.Ctor(arg_1_0, arg_1_1, arg_1_2)
	var_0_2.super.Ctor(arg_1_0, arg_1_1, arg_1_2)

	arg_1_0._attr = arg_1_0._tempData.arg_list.attr
	arg_1_0._number = arg_1_0._tempData.arg_list.number
	arg_1_0._enhance = arg_1_0._tempData.arg_list.enhance_formula

	return
end

function var_0_2.SkillEffectHandler(arg_2_0, arg_2_1)
	local var_2_0 = arg_2_0._number

	if arg_2_0._enhance then
		local var_2_1 = var_0_1.parseFormula
		local var_2_2 = arg_2_0._enhance
		local var_2_3 = arg_2_0:GetCardPuzzleComponent()

		var_2_0 = var_2_0 + var_2_1(var_2_2, var_6.GetAttrManager(var_2_3))
	end

	local var_2_4 = arg_2_0:GetCardPuzzleComponent()

	var_3.AddAttrBySkill(var_2_4, arg_2_0._attr, var_2_0)
	arg_2_0:Finale()

	return
end

return
