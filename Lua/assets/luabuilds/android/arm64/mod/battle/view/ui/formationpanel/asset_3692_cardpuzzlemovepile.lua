ys = ys or {}

local var_0_0 = ys
local var_0_2 = ys.Battle.BattleCardPuzzleEvent

ys.Battle.CardPuzzleMovePile = class("CardPuzzleMovePile")
ys.Battle.CardPuzzleMovePile.__name = "CardPuzzleMovePile"

function ys.Battle.CardPuzzleMovePile:Ctor(arg_1_1)
	self._go = arg_1_1

	self:init()

	return
end

function ys.Battle.CardPuzzleMovePile:SetCardPuzzleComponent(arg_2_1)
	self._cardPuzzleInfo = arg_2_1
	self._moveDeck = self._cardPuzzleInfo:GetMoveDeck()

	self._moveDeck:RegisterEventListener(self, var_0_2.UPDATE_CARDS, self.onUpdateMoveCards)
	self:onUpdateMoveCards()

	return
end

function ys.Battle.CardPuzzleMovePile:onUpdateMoveCards(arg_3_1)
	setText(self._moveCountLabel, "X" .. self._moveDeck:GetLength())

	return
end

function ys.Battle.CardPuzzleMovePile.Update(arg_4_0)
	return
end

function ys.Battle.CardPuzzleMovePile:init()
	var_0_0.EventListener.AttachEventListener(self)

	self._tf = self._go.transform
	self._btnTF = self._tf:Find("card")
	self._moveCountLabel = self._btnTF:Find("count")
	self._moveProgress = self._btnTF:Find("progress"):GetComponent(typeof(Image))
	self._moveProgress.fillAmount = 1

	return
end

function ys.Battle.CardPuzzleMovePile:updateMoveProgress()
	local var_6_0 = self._moveDeck:GetGeneratePorcess()

	if var_6_0 ~= self._progressCache then
		self._moveProgress.fillAmount = var_6_0
	end

	self._progressCache = var_6_0

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
