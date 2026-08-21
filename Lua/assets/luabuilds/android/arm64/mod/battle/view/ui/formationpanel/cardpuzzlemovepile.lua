ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleMovePile = class("CardPuzzleMovePile")
ys.Battle.CardPuzzleMovePile.__name = "CardPuzzleMovePile"

function ys.Battle.CardPuzzleMovePile.Ctor(arg_1_0, arg_1_1)
	arg_1_0._go = arg_1_1

	arg_1_0:init()

	return
end

function ys.Battle.CardPuzzleMovePile.SetCardPuzzleComponent(arg_2_0, arg_2_1)
	arg_2_0._cardPuzzleInfo = arg_2_1
	arg_2_0._moveDeck = arg_2_0._cardPuzzleInfo:GetMoveDeck()

	arg_2_0._moveDeck:RegisterEventListener(arg_2_0, var_0_2.UPDATE_CARDS, arg_2_0.onUpdateMoveCards)
	arg_2_0:onUpdateMoveCards()

	return
end

function ys.Battle.CardPuzzleMovePile.onUpdateMoveCards(arg_3_0, arg_3_1)
	setText(arg_3_0._moveCountLabel, "X" .. arg_3_0._moveDeck:GetLength())

	return
end

function ys.Battle.CardPuzzleMovePile.Update(arg_4_0)
	return
end

function ys.Battle.CardPuzzleMovePile.init(arg_5_0)
	var_0_0.EventListener.AttachEventListener(arg_5_0)

	arg_5_0._tf = arg_5_0._go.transform
	arg_5_0._btnTF = arg_5_0._tf:Find("card")
	arg_5_0._moveCountLabel = arg_5_0._btnTF:Find("count")
	arg_5_0._moveProgress = arg_5_0._btnTF:Find("progress"):GetComponent(typeof(Image))
	arg_5_0._moveProgress.fillAmount = 1

	return
end

function ys.Battle.CardPuzzleMovePile.updateMoveProgress(arg_6_0)
	local var_6_0 = arg_6_0._moveDeck:GetGeneratePorcess()

	if var_6_0 ~= arg_6_0._progressCache then
		arg_6_0._moveProgress.fillAmount = var_6_0
	end

	arg_6_0._progressCache = var_6_0

	return
end

function ys.Battle.CardPuzzleMovePile.Dispose(arg_7_0)
	arg_7_0._moveCountLabel = nil
	arg_7_0._moveProgress = nil
	arg_7_0._btnTF = nil
	arg_7_0._tf = nil

	return
end

return
