local CardTowerCardDeckLayerCombat = class("CardTowerCardDeckLayerCombat", CardPuzzleCardDeckLayer)

function CardTowerCardDeckLayerCombat:getUIName()
	return "CardTowerCardDeckCombat"
end

function CardTowerCardDeckLayerCombat:init()
	CardTowerCardDeckLayerCombat.super.init(self)

	self.labelCH = self._tf:Find("label/ch")
	self.labelEN = self._tf:Find("label/en")

	setText(self.labelEN, i18n("card_battle_card details"))

	self.switchToggle = self._tf:Find("switch_toggle/toggle")

	setText(self._tf:Find("switch_toggle/toggle/hand"), i18n("card_battle_card details_switchto_deck"))
	setText(self._tf:Find("switch_toggle/toggle/deck"), i18n("card_battle_card details_switchto_hand"))
	onToggle(self, self.switchToggle, function(arg_3_0)
		if arg_3_0 then
			self:showHand()
		else
			self:showDeck()
		end

		return
	end)

	self.empty = self._tf:Find("empty")

	setText(self._tf:Find("empty/label_en"), i18n("card_battle_card_empty_en"))
	setText(self._tf:Find("empty/label_ch"), i18n("card_battle_card_empty_ch"))
	onButton(self, self._tf:Find("backBtn"), function()
		self:OnBackward()

		return
	end, SFX_PANEL)

	return
end

function CardTowerCardDeckLayerCombat:showHand()
	setText(self.labelCH, i18n("card_battle_card details_hand"))

	self.cards = self.hand

	self:RefreshCards()

	return
end

function CardTowerCardDeckLayerCombat:showDeck()
	setText(self.labelCH, i18n("card_battle_card details_deck"))

	self.cards = self.deck

	self:RefreshCards()

	return
end

function CardTowerCardDeckLayerCombat:didEnter()
	triggerToggle(self.switchToggle, false)

	return
end

function CardTowerCardDeckLayerCombat:SetCards(arg_8_1, arg_8_2)
	self.deck = arg_8_1
	self.hand = arg_8_2

	return
end

function CardTowerCardDeckLayerCombat:RefreshCards()
	setActive(self.empty, #self.cards == 0)
	self.cardListComp:SetTotalCount(#self.cards)

	return
end

function CardTowerCardDeckLayerCombat:OnBackward()
	self:emit(CardPuzzleCardDeckMediator.CLOSE_LAYER)

	return CardTowerCardDeckLayerCombat.super.OnBackward(self)
end

function CardTowerCardDeckLayerCombat:willExit()
	return
end

return CardTowerCardDeckLayerCombat
