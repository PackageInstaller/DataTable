ys = ys or {}

local var_0_0 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local BattleCardPuzzleSkillCreateCard = class("BattleCardPuzzleSkillCreateCard", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillCreateCard = BattleCardPuzzleSkillCreateCard
BattleCardPuzzleSkillCreateCard.__name = "BattleCardPuzzleSkillCreateCard"
BattleCardPuzzleSkillCreateCard.MOVE_OP_Add = "Add"
BattleCardPuzzleSkillCreateCard.MOVE_OP_BOTTOM = "Bottom"

function BattleCardPuzzleSkillCreateCard:Ctor(arg_1_1)
	BattleCardPuzzleSkillCreateCard.super.Ctor(self, arg_1_1)

	self._cardID = self._tempData.arg_list.card_id
	self._moveTo = self._tempData.arg_list.move_to
	self._moveOP = self._tempData.arg_list.move_op or var_0_0.FUNC_NAME_ADD
	self._op = self._tempData.arg_list.shuffle or 1

	return
end

function BattleCardPuzzleSkillCreateCard:SkillEffectHandler()
	local var_2_0 = self._card:GetClient()
	local var_2_1 = var_2_0:GetCardPileByIndex(self._moveTo)

	var_2_1[self._moveOP](var_2_1, (var_2_0:GenerateCard(self._cardID)))

	if self._op == 1 then
		var_2_1:Shuffle()
	end

	self:Finale()

	return
end

return
