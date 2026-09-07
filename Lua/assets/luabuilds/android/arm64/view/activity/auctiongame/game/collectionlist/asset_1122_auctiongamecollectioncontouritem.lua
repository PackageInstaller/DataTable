local AuctionGameCollectionContourItem = class("AuctionGameCollectionContourItem", import("view.base.BasePanel"))

function AuctionGameCollectionContourItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameCollectionContourItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameCollectionContourItem:Init()
	onButton(self, self.uiBtn, function()
		self:emit(AuctionGameCollectionListLayer.ON_SWITCH_CONTOUR, self.contourData)

		return
	end, SFX_PANEL)

	return
end

function AuctionGameCollectionContourItem:didEnter(arg_4_1, arg_4_2)
	self.contourData = {
		arg_4_2,
		arg_4_1
	}

	if arg_4_1 == 0 then
		setText(self.uiText, i18n("auction_game_rarity_0"))
	else
		setText(self.uiText, string.format("%s×%s", arg_4_2, arg_4_1))
	end

	setActive(self._go, true)
	self:SetSelectedContour({
		0,
		0
	})

	return
end

function AuctionGameCollectionContourItem:SetSelectedContour(arg_5_1)
	local var_5_0 = arg_5_1[1] == self.contourData[1] and arg_5_1[2] == self.contourData[2]

	setActive(self.uiSelectedGo, arg_5_1[1] == self.contourData[1] and arg_5_1[2] == self.contourData[2])
	setTextColor(self.uiText, var_5_0 and Color.NewHex("#FFFFFF") or Color.NewHex("#393a3c"))

	return
end

function AuctionGameCollectionContourItem:willExit()
	self:detach()

	return
end

return AuctionGameCollectionContourItem
