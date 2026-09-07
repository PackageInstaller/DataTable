ys = ys or {}

local var_0_0 = ys.Battle.BattleCardPuzzleFormulas
local BattleCardPuzzleSkillAddFleetAttr = class("BattleCardPuzzleSkillAddFleetAttr", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillAddFleetAttr = BattleCardPuzzleSkillAddFleetAttr
BattleCardPuzzleSkillAddFleetAttr.__name = "BattleCardPuzzleSkillAddFleetAttr"

function BattleCardPuzzleSkillAddFleetAttr:Ctor(arg_1_1, arg_1_2)
	BattleCardPuzzleSkillAddFleetAttr.super.Ctor(self, arg_1_1, arg_1_2)

	self._attr = self._tempData.arg_list.attr
	self._number = self._tempData.arg_list.number
	self._enhance = self._tempData.arg_list.enhance_formula

	return
end

function BattleCardPuzzleSkillAddFleetAttr:SkillEffectHandler(arg_2_1)
	local var_2_0 = self._number

	if self._enhance then
		var_2_0 = var_2_0 + var_0_0.parseFormula(self._enhance, self:GetCardPuzzleComponent():GetAttrManager())
	end

	self:GetCardPuzzleComponent():AddAttrBySkill(self._attr, var_2_0)
	self:Finale()

	return
end

return
