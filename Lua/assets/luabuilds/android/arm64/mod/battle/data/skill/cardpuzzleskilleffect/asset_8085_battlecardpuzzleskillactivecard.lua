ys = ys or {}

local var_0_0 = ys.Battle.BattleFleetCardPuzzleCardManageComponent
local BattleCardPuzzleSkillActiveCard = class("BattleCardPuzzleSkillActiveCard", ys.Battle.BattleCardPuzzleSkillEffect)

ys.Battle.BattleCardPuzzleSkillActiveCard = BattleCardPuzzleSkillActiveCard
BattleCardPuzzleSkillActiveCard.__name = "BattleCardPuzzleSkillActiveCard"

function BattleCardPuzzleSkillActiveCard:Ctor(arg_1_1)
	BattleCardPuzzleSkillActiveCard.super.Ctor(self, arg_1_1)

	self._activeFrom = self._tempData.arg_list.active_from or 0
	self._activeID = self._tempData.arg_list.active_ID_list
	self._activeLabel = self._tempData.arg_list.active_label_list
	self._activeAll = self._tempData.arg_list.active_all

	return
end

function BattleCardPuzzleSkillActiveCard:SkillEffectHandler()
	local var_2_0 = {}

	var_2_0.value = self._activeID or self._activeLabel
	var_2_0.total = self._activeAll

	if self._activeID then
		var_2_0.type = var_0_0.SEARCH_BY_ID or var_0_0.SEARCH_BY_LABEL
	end

	for iter_2_0, iter_2_1 in ipairs((self._card:GetClient():GetCardPileByIndex(self._activeFrom):Search(var_2_0))) do
		iter_2_1:Active()
	end

	self:Finale()

	return
end

return
