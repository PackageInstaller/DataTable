local SpringPreheatChooseStickersView = class("SpringPreheatChooseStickersView", (require("game.views.Sticker.ChooseStickersView")))

function SpringPreheatChooseStickersView:AddUIListeners()
	for iter_1_0, iter_1_1 in ipairs(self.sizeTgl_) do
		self:AddBtnListener(iter_1_1, nil, function()
			self.curSize_ = iter_1_0

			self:RefreshIcon()
			self:RefreshBtn()
			self:RefreshSize()

			if self.curID_ == self.oldStickerID_ then
				if self.params_.onChangeStickerSize then
					self.params_.onChangeStickerSize(self.curIndex_, self.curID_, self.curSize_)
				end

				self:Back()
			end
		end)
	end

	self:AddBtnListener(self.useBtn_, nil, function()
		if self.curID_ == self.oldStickerID_ and self.curSize_ == self.info_.size then
			self.curID_ = 0
		end

		if self.params_.onChangeSticker then
			self.params_.onChangeSticker(self.curIndex_, self.curID_, self.curSize_)
		end

		self:Back()
	end)
	self:AddBtnListener(self.bgBtn_, nil, function()
		self:Back()
	end)
end

return SpringPreheatChooseStickersView
