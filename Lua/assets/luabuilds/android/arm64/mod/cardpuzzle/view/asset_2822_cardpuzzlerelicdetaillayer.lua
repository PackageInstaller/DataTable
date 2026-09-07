local CardPuzzleRelicDetailLayer = class("CardPuzzleRelicDetailLayer", BaseUI)

function CardPuzzleRelicDetailLayer:getUIName()
	return "CardTowerGiftDetailUI"
end

function CardPuzzleRelicDetailLayer:init()
	return
end

function CardPuzzleRelicDetailLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	setImageSprite(self._tf:Find("Gift/Icon"), LoadSprite(self.contextData.giftData:GetIconPath(), ""))
	setText(self._tf:Find("Gift/Name"), self.contextData.giftData:GetName())
	setText(self._tf:Find("Gift/Desc"), self.contextData.giftData:GetDesc())
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CardPuzzleRelicDetailLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return CardPuzzleRelicDetailLayer
