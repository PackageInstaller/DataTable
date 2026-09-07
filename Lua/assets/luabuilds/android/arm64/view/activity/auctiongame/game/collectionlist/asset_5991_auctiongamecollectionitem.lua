local AuctionGameCollectionItem = class("AuctionGameCollectionItem", import("view.base.BasePanel"))

function AuctionGameCollectionItem:Ctor(arg_1_1, arg_1_2)
	self._go = arg_1_1.gameObject

	AuctionGameCollectionItem.super.Ctor(self, self._go)

	self._parentClass = arg_1_2

	self:attach(arg_1_2)
	self:Init()

	return
end

function AuctionGameCollectionItem:Init()
	return
end

function AuctionGameCollectionItem:didEnter(arg_3_1)
	if self.id == arg_3_1 then
		return
	end

	self.id = arg_3_1

	setScrollText(self.uiNameText, pg.auction_collection[arg_3_1].name)
	setText(self.uiPriceText, StringHelper.ForamtNumber(pg.auction_collection[arg_3_1].value))

	self.uiIconImage.sprite = nil

	setActive(self.uiIconImage, false)
	LoadSpriteAsync(pg.auction_collection[arg_3_1].icon, function(arg_4_0)
		if not IsNil(self.uiIconImage) then
			self.uiIconImage.sprite = arg_4_0

			setActive(self.uiIconImage, true)
		end

		return
	end)
	LoadSpriteAtlasAsync("ui/auctiongameui_atlas", string.format("rarity%s", pg.auction_collection[arg_3_1].rarity), function(arg_5_0)
		if not IsNil(self.uiRarityImage) then
			self.uiRarityImage.sprite = arg_5_0
		end

		return
	end)

	local var_3_0 = pg.auction_collection[arg_3_1].contour[1]
	local var_3_1 = pg.auction_collection[arg_3_1].contour[2]

	for iter_3_0 = 1, 9 do
		setActive(self[string.format("uiContourItem%s", iter_3_0)], var_3_1 >= math.ceil(iter_3_0 / 3) and var_3_0 >= (iter_3_0 - 1) % 3 + 1)
	end

	return
end

function AuctionGameCollectionItem:ShowLockState()
	setActive(self.uiLockGo, not (table.keyof(getProxy(AuctionGameBaseProxy):GetUnlockCollectionList(), self.id) ~= nil))

	return
end

function AuctionGameCollectionItem:willExit()
	self:detach()

	return
end

return AuctionGameCollectionItem
