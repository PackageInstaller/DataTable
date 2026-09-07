local AuctionGameMainNoticeBoardLayer = class("AuctionGameMainNoticeBoardLayer", import("view.base.BaseUI"))

function AuctionGameMainNoticeBoardLayer:getUIName()
	return "AuctionGameMainNoticeBoardUI"
end

function AuctionGameMainNoticeBoardLayer:init()
	onButton(self, self.uiCloseBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)
	onButton(self, self.uiBgBtn, function()
		self:closeView()

		return
	end, SOUND_BACK)

	self.boardItemList = {}

	return
end

function AuctionGameMainNoticeBoardLayer:didEnter()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBg
		}
	})

	local var_5_0 = getProxy(AuctionGameProxy):GetPlayerList()

	for iter_5_0, iter_5_1 in ipairs(var_5_0) do
		self.boardItemList[iter_5_0] = AuctionGameMainNoticeBoardPlayer.New(self[string.format("uiPlayerTf%s", iter_5_0)], self)

		self.boardItemList[iter_5_0]:didEnter(iter_5_0)
	end

	for iter_5_2 = #var_5_0 + 1, 4 do
		setActive(self[string.format("uiPlayerTf%s", iter_5_2)], false)
	end

	return
end

function AuctionGameMainNoticeBoardLayer:willExit()
	for iter_6_0, iter_6_1 in ipairs(self.boardItemList) do
		iter_6_1:willExit()
	end

	self.boardItemList = nil

	self:UnOverlayPanel(self._tf)

	return
end

return AuctionGameMainNoticeBoardLayer
