local AuctionGameMainEventMsgLayer = class("AuctionGameMainEventMsgLayer", import("view.base.BaseUI"))

function AuctionGameMainEventMsgLayer:getUIName()
	return "AuctionGameMainEventMsgUI"
end

function AuctionGameMainEventMsgLayer:init()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBgBtn
		}
	})
	setText(self.uiCancelText, i18n("auction_cancel"))
	setText(self.uiConfirmText, i18n("auction_confirm"))
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiCancelBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiConfirmBtn, function()
		existCall(self.contextData.callback)
		self:closeView()

		return
	end, SFX_PANEL)

	return
end

function AuctionGameMainEventMsgLayer:didEnter()
	setText(self.uiNameText, pg.auction_event[self.contextData.eventID].name)
	setText(self.uiDescText, pg.auction_event[self.contextData.eventID].describe)
	LoadSpriteAsync(pg.auction_event[self.contextData.eventID].icon, function(arg_8_0)
		if not IsNil(self.uiIconImage) then
			self.uiIconImage.sprite = arg_8_0
		end

		return
	end)

	return
end

function AuctionGameMainEventMsgLayer:willExit()
	self:UnOverlayPanel(self._tf)

	return
end

return AuctionGameMainEventMsgLayer
