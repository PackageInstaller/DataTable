ys = ys or {}

local var_0_0 = ys.Battle.BattleCardPuzzleFormulas
local BattleCardPuzzleSkillSetFleetAttr = class("BattleCardPuzzleSkillSetFleetAttr", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillSetFleetAttr = BattleCardPuzzleSkillSetFleetAttr
BattleCardPuzzleSkillSetFleetAttr.__name = "BattleCardPuzzleSkillSetFleetAttr"

function BattleCardPuzzleSkillSetFleetAttr:Ctor(arg_1_1, arg_1_2)
	BattleCardPuzzleSkillSetFleetAttr.super.Ctor(self, arg_1_1, arg_1_2)

	self._attr = self._tempData.arg_list.attr
	self._number = self._tempData.arg_list.number
	self._enhance = self._tempData.arg_list.enhance_formula

	return
end

function BattleCardPuzzleSkillSetFleetAttr:SkillEffectHandler(arg_2_1)
	local var_2_0 = self._number

	if self._enhance then
		var_2_0 = var_2_0 + var_0_0.parseFormula(self._enhance, self:GetCardPuzzleComponent():GetAttrManager())
	end

	self:GetCardPuzzleComponent():UpdateAttrBySet(self._attr, var_2_0)
	self:Finale()

	return
end

return
