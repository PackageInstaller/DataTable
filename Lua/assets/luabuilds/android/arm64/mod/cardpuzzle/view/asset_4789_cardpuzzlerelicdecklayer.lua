local CardPuzzleRelicDeckLayer = class("CardPuzzleRelicDeckLayer", BaseUI)

function CardPuzzleRelicDeckLayer:getUIName()
	return "CardTowerGiftDeckUI"
end

function CardPuzzleRelicDeckLayer:isLayer()
	return false
end

function CardPuzzleRelicDeckLayer:init()
	self.giftListRect = self._tf:Find("Container")
	self.giftListComp = self.giftListRect:GetComponent("LScrollRect")

	function self.giftListComp.onUpdateItem(arg_4_0, arg_4_1)
		local var_4_0 = CardPuzzleRelicView.New((tf(arg_4_1)))

		var_4_0:SetData(self.gifts[arg_4_0 + 1])
		var_4_0:UpdateView()
		onButton(self, arg_4_1, function()
			self:ShowRelicDetail(arg_4_0)

			return
		end, SFX_PANEL)
		TweenItemAlphaAndWhite(arg_4_1)

		return
	end

	return
end

function CardPuzzleRelicDeckLayer:ShowRelicDetail(arg_6_1)
	self:emit(CardPuzzleRelicDeckMediator.SHOW_GIFT, {
		giftData = self.gifts[arg_6_1 + 1]
	})

	return
end

function CardPuzzleRelicDeckLayer:SetGifts(arg_7_1)
	self.gifts = arg_7_1

	return
end

function CardPuzzleRelicDeckLayer:didEnter()
	self.giftListComp:SetTotalCount(#self.gifts)

	return
end

function CardPuzzleRelicDeckLayer:OnBackward()
	self:closeView()

	return true
end

function CardPuzzleRelicDeckLayer:willExit()
	pg.m02:sendNotification(CardTowerStageMediator.CARDTOWER_STAGE_REMOVE_SUBVIEW, self._tf)

	return
end

return CardPuzzleRelicDeckLayer
