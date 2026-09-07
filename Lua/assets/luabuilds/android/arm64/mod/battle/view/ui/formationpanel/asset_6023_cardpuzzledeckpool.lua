ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleDeckPool = class("CardPuzzleDeckPool")
ys.Battle.CardPuzzleDeckPool.__name = "CardPuzzleDeckPool"

function ys.Battle.CardPuzzleDeckPool:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()

	return
end

function ys.Battle.CardPuzzleDeckPool:SetCardPuzzleComponent(arg_2_1)
	self._cardPuzzleInfo = arg_2_1
	self._deck = self._cardPuzzleInfo:GetDeck()

	self._deck:RegisterEventListener(self, var_0_2.UPDATE_CARDS, self.onUpdateDeckCard)
	self:onUpdateDeckCard()

	return
end

function ys.Battle.CardPuzzleDeckPool:onUpdateDeckCard(arg_3_1)
	setText(self._deckCountLabel, self._deck:GetLength())

	return
end

function ys.Battle.CardPuzzleDeckPool:init()
	var_0_0.EventListener.AttachEventListener(self)

	self._tf = self._go.transform
	self._deckCountLabel = self._tf:Find("count/text")

	setText(self._tf:Find("label"), i18n("card_puzzle_deck"))

	return
end

function ys.Battle.CardPuzzleDeckPool.Dispose(arg_5_0)
	arg_5_0._deckCountLabel = nil
	arg_5_0._tf = nil

	return
end

return
