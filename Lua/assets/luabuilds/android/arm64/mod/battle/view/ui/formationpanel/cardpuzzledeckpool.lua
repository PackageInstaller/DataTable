ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleDeckPool = class("CardPuzzleDeckPool")
ys.Battle.CardPuzzleDeckPool.__name = "CardPuzzleDeckPool"

function ys.Battle.CardPuzzleDeckPool.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function ys.Battle.CardPuzzleDeckPool.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._cardPuzzleInfo = arg_2_1
	arg_2_0._deck = arg_2_0._cardPuzzleInfo:GetDeck()

	arg_2_0._deck:RegisterEventListener(arg_2_0, var_0_2.UPDATE_CARDS, arg_2_0.onUpdateDeckCard)
	arg_2_0:onUpdateDeckCard()

	return
end

function ys.Battle.CardPuzzleDeckPool.onUpdateDeckCard(arg_3_0, arg_3_1)
	setText(arg_3_0._deckCountLabel, arg_3_0._deck:GetLength())

	return
end

function ys.Battle.CardPuzzleDeckPool.init(arg_4_0)
	var_0_0.EventListener.AttachEventListener(arg_4_0)

	arg_4_0._tf = arg_4_0._go.transform
	arg_4_0._deckCountLabel = arg_4_0._tf:Find("count/text")

	setText(arg_4_0._tf:Find("label"), i18n("card_puzzle_deck"))

	return
end

function ys.Battle.CardPuzzleDeckPool.Dispose(arg_5_0)
	arg_5_0._deckCountLabel = nil
	arg_5_0._tf = nil

	return
end

return
