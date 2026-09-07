local AuctionGameCollectionRarityItem = class("AuctionGameCollectionRarityItem", import("view.base.BasePanel"))

function AuctionGameCollectionRarityItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameCollectionRarityItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameCollectionRarityItem:Init()
	onButton(self, self.uiBtn, function()
		self:emit(AuctionGameCollectionListLayer.ON_SWITCH_RARITY, self.rarity)

		return
	end, SFX_PANE)

	return
end

function AuctionGameCollectionRarityItem:didEnter(arg_4_1)
	setText(self.uiText, i18n("auction_game_rarity_" .. arg_4_1))

	self.rarity = arg_4_1

	setActive(self._go, true)
	self:SetSelectedRarity(0)

	return
end

function AuctionGameCollectionRarityItem:SetSelectedRarity(arg_5_1)
	local var_5_0 = self.rarity == arg_5_1

	setActive(self.uiSelectedGo, self.rarity == arg_5_1)
	setTextColor(self.uiText, var_5_0 and Color.NewHex("#FFFFFF") or Color.NewHex("#393a3c"))

	return
end

function AuctionGameCollectionRarityItem:willExit()
	self:detach()

	return
end

return AuctionGameCollectionRarityItem
