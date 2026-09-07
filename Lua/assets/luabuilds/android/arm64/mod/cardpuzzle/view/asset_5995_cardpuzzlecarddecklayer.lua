local CardPuzzleCardDeckLayer = class("CardPuzzleCardDeckLayer", BaseUI)

function CardPuzzleCardDeckLayer:getUIName()
	return "CardTowerCardDeckUI"
end

function CardPuzzleCardDeckLayer:isLayer()
	return false
end

function CardPuzzleCardDeckLayer:init()
	self.cardListRect = self._tf:Find("Container")
	self.cardListComp = self.cardListRect:GetComponent("LScrollRect")

	function self.cardListComp.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = CardPuzzleCardView.New((tf(arg_4_1):GetChild(0)))

		var_4_0:SetData(self.cards[arg_4_0 + 1])
		var_4_0:UpdateView()
		onButton(self, arg_4_1, function()
			self:ShowCardDetail(arg_4_0)

			return
		end, SFX_PANEL)

		return
	end

	return
end

function CardPuzzleCardDeckLayer:ShowCardDetail(arg_6_1)
	self:emit(CardPuzzleCardDeckMediator.SHOW_CARD, {
		cardData = self.cards[arg_6_1 + 1]
	})

	return
end

function CardPuzzleCardDeckLayer:SetCards(arg_7_1)
	self.cards = arg_7_1

	return
end

function CardPuzzleCardDeckLayer:didEnter()
	self:RefreshCards()

	return
end

function CardPuzzleCardDeckLayer:RefreshCards()
	self.cardListComp:SetTotalCount(#self.cards)

	return
end

function CardPuzzleCardDeckLayer:OnBackward()
	self:closeView()

	return true
end

function CardPuzzleCardDeckLayer:willExit()
	pg.m02:sendNotification(CardTowerStageMediator.CARDTOWER_STAGE_REMOVE_SUBVIEW, self._tf)

	return
end

return CardPuzzleCardDeckLayer
