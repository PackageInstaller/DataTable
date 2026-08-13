ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleDeckPool = var_0_10004("CardPuzzleDeckPool")

local var_0_4 = var_0.Battle.CardPuzzleDeckPool

var_0_4.__name = "CardPuzzleDeckPool"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_4.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._cardPuzzleInfo = arg_2_1

	local var_2_0 = arg_2_0._cardPuzzleInfo

	arg_2_0._deck = var_2.GetDeck(var_2_0)

	local var_2_1 = arg_2_0._deck

	var_2.RegisterEventListener(var_2_1, arg_2_0, var_0_2.UPDATE_CARDS, arg_2_0.onUpdateDeckCard)
	arg_2_0:onUpdateDeckCard()

	return
end

function var_0_4.onUpdateDeckCard(arg_3_0, arg_3_1)
	setText = var_1_10002

	local var_3_0 = arg_3_0._deckCountLabel
	local var_3_1 = arg_3_0._deck

	var_1_10002(var_3_0, var_5.GetLength(var_3_1))

	return
end

function var_0_4.init(arg_4_0)
	var_0.EventListener.AttachEventListener(arg_4_0)

	arg_4_0._tf = arg_4_0._go.transform

	local var_4_0 = arg_4_0._tf

	arg_4_0._deckCountLabel = var_1.Find(var_4_0, "count/text")
	setText = var_1

	local var_4_1 = arg_4_0._tf
	local var_4_2 = var_3.Find(var_4_1, "label")

	i18n = var_4

	var_1(var_4_2, var_4("card_puzzle_deck"))

	return
end

function var_0_4.Dispose(arg_5_0)
	arg_5_0._deckCountLabel = nil
	arg_5_0._tf = nil

	return
end

return
