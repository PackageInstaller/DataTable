ys = var_0_10000

local var_0_0

var_0_0 = var_0_10000 or {}
ys = ys

local var_0_1 = var_0.Battle.BattleConfig
local var_0_2 = var_0.Battle.BattleCardPuzzleEvent
local var_0_3 = var_0.Battle

class = var_0_10004
var_0_3.CardPuzzleMovePile = var_0_10004("CardPuzzleMovePile")

local var_0_4 = var_0.Battle.CardPuzzleMovePile

var_0_4.__name = "CardPuzzleMovePile"

function var_0_4.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function var_0_4.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._cardPuzzleInfo = arg_2_1

	local var_2_0 = arg_2_0._cardPuzzleInfo

	arg_2_0._moveDeck = var_2.GetMoveDeck(var_2_0)

	local var_2_1 = arg_2_0._moveDeck

	var_2.RegisterEventListener(var_2_1, arg_2_0, var_0_2.UPDATE_CARDS, arg_2_0.onUpdateMoveCards)
	arg_2_0:onUpdateMoveCards()

	return
end

function var_0_4.onUpdateMoveCards(arg_3_0, arg_3_1)
	setText = var_1_10002

	local var_3_0 = arg_3_0._moveCountLabel
	local var_3_1 = "X"
	local var_3_2 = arg_3_0._moveDeck

	var_1_10002(var_3_0, var_3_1 .. var_5.GetLength(var_3_2))

	return
end

function var_0_4.Update(arg_4_0)
	return
end

function var_0_4.init(arg_5_0)
	var_0.EventListener.AttachEventListener(arg_5_0)

	arg_5_0._tf = arg_5_0._go.transform

	local var_5_0 = arg_5_0._tf

	arg_5_0._btnTF = var_1.Find(var_5_0, "card")

	local var_5_1 = arg_5_0._btnTF

	arg_5_0._moveCountLabel = var_1.Find(var_5_1, "count")

	local var_5_2 = arg_5_0._btnTF
	local var_5_3 = var_1.Find(var_5_2, "progress")
	local var_5_4 = var_1.GetComponent

	typeof = var_3
	Image = var_1_10004
	arg_5_0._moveProgress = var_5_4(var_5_3, var_3(var_1_10004))
	arg_5_0._moveProgress.fillAmount = 1

	return
end

function var_0_4.updateMoveProgress(arg_6_0)
	local var_6_0 = arg_6_0._moveDeck

	if var_1.GetGeneratePorcess(var_6_0) ~= arg_6_0._progressCache then
		arg_6_0._moveProgress.fillAmount = var_1
	end

	arg_6_0._progressCache = var_1

	return
end

function var_0_4.Dispose(arg_7_0)
	arg_7_0._moveCountLabel = nil
	arg_7_0._moveProgress = nil
	arg_7_0._btnTF = nil
	arg_7_0._tf = nil

	return
end

return
