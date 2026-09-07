local CardPuzzleCardDetailLayer = class("CardPuzzleCardDetailLayer", BaseUI)

function CardPuzzleCardDetailLayer:getUIName()
	return "CardTowerCardDetailUI"
end

function CardPuzzleCardDetailLayer:init()
	self.cardView = CardPuzzleCardView.New(self._tf:Find("CardTowerCard"))
	self.keywordList = self._tf:Find("KeywordList")

	return
end

local var_0_1 = {
	168,
	220
}

function CardPuzzleCardDetailLayer:didEnter()
	onButton(self, self._tf:Find("BG"), function()
		self:closeView()

		return
	end, SFX_CANCEL)
	self.cardView:SetData(self.contextData.cardData)
	self.cardView:UpdateView()
	setAnchoredPosition(self.keywordList, {
		x = var_0_1[showPreview and 2 or 1]
	})

	local var_3_0 = _.filter(self.contextData.cardData:GetKeywords(), function(arg_5_0)
		return arg_5_0.affix_type == CardPuzzleCardView.AFFIX_TYPE.SCHOOL or arg_5_0.affix_type == CardPuzzleCardView.AFFIX_TYPE.AFFIX and arg_5_0.show == 0
	end)

	UIItemList.StaticAlign(self.keywordList, self.keywordList:GetChild(0), #var_3_0, function(arg_6_0, arg_6_1, arg_6_2)
		if arg_6_0 ~= UIItemList.EventUpdate then
			return
		end

		local var_6_0 = var_3_0[arg_6_1 + 1]

		setText(arg_6_2:Find("Title"), var_3_0[arg_6_1 + 1].name)
		setText(arg_6_2:Find("Text"), var_6_0.discript)
		setText(arg_6_2:Find("Title/EN"), var_6_0.name_EN)

		return
	end)
	pg.UIMgr.GetInstance():BlurPanel(self._tf)

	return
end

function CardPuzzleCardDetailLayer:willExit()
	pg.UIMgr.GetInstance():UnOverlayPanel(self._tf)

	return
end

return CardPuzzleCardDetailLayer
