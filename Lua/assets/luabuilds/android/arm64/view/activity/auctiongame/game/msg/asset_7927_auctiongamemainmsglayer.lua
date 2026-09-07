local AuctionGameMainMsgLayer = class("AuctionGameMainMsgLayer", import("view.base.BaseUI"))

function AuctionGameMainMsgLayer:getUIName()
	return "AuctionGameMainMsgUI"
end

function AuctionGameMainMsgLayer:init()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBgBtn
		}
	})
	setText(self.uiCancelText, i18n("auction_cancel"))
	setText(self.uiConfirmText, i18n("auction_confirm"))
	onButton(self, self.uiBgBtn, function()
		self:OnCloseBtn()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCloseBtn, function()
		self:OnCloseBtn()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCancelBtn, function()
		self:OnCloseBtn()

		return
	end, SOUND_BACK)
	onButton(self, self.uiConfirmBtn, function()
		existCall(self.contextData.comformCallback)
		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function AuctionGameMainMsgLayer:didEnter()
	setText(self.uiContentText, self.contextData.content)

	return
end

function AuctionGameMainMsgLayer:OnCloseBtn()
	existCall(self.contextData.cancelCallback)
	self:closeView()

	return
end

function AuctionGameMainMsgLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return AuctionGameMainMsgLayer
