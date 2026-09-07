ys = ys or {}

local var_0_0 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local BattleCardPuzzleSkillMoveCard = class("BattleCardPuzzleSkillMoveCard", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillMoveCard = BattleCardPuzzleSkillMoveCard
BattleCardPuzzleSkillMoveCard.__name = "BattleCardPuzzleSkillMoveCard"

function BattleCardPuzzleSkillMoveCard:Ctor(arg_1_1)
	BattleCardPuzzleSkillMoveCard.super.Ctor(self, arg_1_1)

	self._moveFrom = self._tempData.arg_list.move_from or 0
	self._moveTo = self._tempData.arg_list.move_to
	self._moveID = self._tempData.arg_list.move_ID_list
	self._moveLabel = self._tempData.arg_list.move_label_list
	self._moveOP = self._tempData.arg_list.move_op or var_0_0.FUNC_NAME_ADD
	self._moveOther = self._tempData.arg_list.move_other
	self._moveAll = self._tempData.arg_list.move_all
	self._op = self._tempData.arg_list.shuffle or 1

	return
end

function BattleCardPuzzleSkillMoveCard:MoveCardAfterCast()
	if self._moveID or self._moveLabel then
		return BattleCardPuzzleSkillMoveCard.super.MoveCardAfterCast(self)
	else
		return self._moveTo
	end

	return
end

function BattleCardPuzzleSkillMoveCard:SkillEffectHandler()
	local var_3_0 = self._card:GetClient()
	local var_3_1 = var_3_0:GetCardPileByIndex(self._moveTo)
	local var_3_2 = var_3_0:GetCardPileByIndex(self._moveFrom)

	if self._moveID then
		for iter_3_0, iter_3_1 in ipairs((var_3_2:Search({
			value = self._moveID,
			type = var_0_0.SEARCH_BY_ID,
			total = self._moveAll
		}))) do
			var_3_1[self._moveOP](var_3_1, iter_3_1)
			var_3_2:Remove(iter_3_1, self._moveTo)
		end
	elseif self._moveLabel then
		for iter_3_2, iter_3_3 in ipairs((var_3_2:Search({
			value = self._moveLabel,
			type = var_0_0.SEARCH_BY_LABEL,
			total = self._moveAll
		}))) do
			var_3_1[self._moveOP](var_3_1, iter_3_3)
			var_3_2:Remove(iter_3_3, self._moveTo)
		end
	elseif self._moveOther then
		for iter_3_4, iter_3_5 in ipairs((var_3_2:GetCardList())) do
			if iter_3_5 ~= self._card then
				var_3_1[self._moveOP](var_3_1, iter_3_5)
				var_3_2:Remove(iter_3_5, self._moveTo)
			end
		end
	else
		var_3_1[self._moveOP](var_3_1, self._card)
	end

	if self._op == 1 then
		var_3_1:Shuffle()
	end

	self:Finale()

	return
end

return
