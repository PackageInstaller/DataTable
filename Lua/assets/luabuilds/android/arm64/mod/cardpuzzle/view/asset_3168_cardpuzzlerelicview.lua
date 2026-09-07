local CardPuzzleRelicView = class("CardPuzzleRelicView")

function CardPuzzleRelicView:Ctor(arg_1_1)
	self._tf = tf(arg_1_1)

	return
end

function CardPuzzleRelicView:SetData(arg_2_1)
	self.data = arg_2_1

	return
end

function CardPuzzleRelicView:UpdateView()
	setImageSprite(self._tf:Find("Icon"), LoadSprite(self.data:GetIconPath(), ""), true)
	setText(self._tf:Find("Name"), self.data:GetName())
	setText(self._tf:Find("Detail"), self.data:GetDesc())
	TweenItemAlphaAndWhite(go(self._tf))

	return
end

function CardPuzzleRelicView:Clear()
	ClearTweenItemAlphaAndWhite(go(self._tf))

	return
end

return CardPuzzleRelicView
