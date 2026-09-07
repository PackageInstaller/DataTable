local AuctionGameMainReadyLayer = class("AuctionGameMainReadyLayer", import("view.base.BaseUI"))

function AuctionGameMainReadyLayer:getUIName()
	return "AuctionGameMainReadyUI"
end

function AuctionGameMainReadyLayer:init()
	setText(self.uiContentText, i18n("auction_ready"))

	return
end

function AuctionGameMainReadyLayer:didEnter()
	return
end

function AuctionGameMainReadyLayer:willExit()
	return
end

function AuctionGameMainReadyLayer:onBackPressed()
	return
end

return AuctionGameMainReadyLayer
