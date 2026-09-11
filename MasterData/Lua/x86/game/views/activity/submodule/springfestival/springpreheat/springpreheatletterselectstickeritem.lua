local SpringPreheatLetterSelectStickerItem = class("SpringPreheatLetterSelectStickerItem", (require("game.views.Sticker.StickerChooseItem")))

function SpringPreheatLetterSelectStickerItem:RefreshItem(arg_1_1)
	if arg_1_1 == 0 then
		self.lockCon_:SetSelectedState("empty")

		self.itemID_ = 0

		return
	end

	SpringPreheatLetterSelectStickerItem.super.RefreshItem(self, arg_1_1)
end

function SpringPreheatLetterSelectStickerItem:TrySelect()
	if self.itemID_ == 0 then
		self:SetSelected(true)

		return true
	end

	if PlayerData:GetSticker(self.itemID_).lock then
		self:SetSelected(false)

		return false
	end

	self:SetSelected(true)

	return true
end

function SpringPreheatLetterSelectStickerItem:RegisterClickListener(arg_3_1)
	self.clickFunc_ = arg_3_1
end

return SpringPreheatLetterSelectStickerItem
