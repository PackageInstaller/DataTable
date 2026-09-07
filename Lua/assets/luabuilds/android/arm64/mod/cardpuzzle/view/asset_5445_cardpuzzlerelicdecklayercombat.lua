local CardPuzzleRelicDeckLayerCombat = class("CardPuzzleRelicDeckLayerCombat", CardPuzzleRelicDeckLayer)

function CardPuzzleRelicDeckLayerCombat:getUIName()
	return "CardTowerGiftDeckCombat"
end

function CardPuzzleRelicDeckLayerCombat:init()
	CardPuzzleRelicDeckLayerCombat.super.init(self)
	onButton(self, self._tf:Find("backBtn"), function()
		self:OnBackward()

		return
	end, SFX_PANEL)

	return
end

function CardPuzzleRelicDeckLayerCombat:OnBackward()
	self:emit(CardPuzzleCardDeckMediator.CLOSE_LAYER)

	return CardPuzzleRelicDeckLayerCombat.super.OnBackward(self)
end

function CardPuzzleRelicDeckLayerCombat:willExit()
	return
end

return CardPuzzleRelicDeckLayerCombat
