local AuctionGameMainRoundOverLayer = class("AuctionGameMainRoundOverLayer", import("view.base.BaseUI"))

function AuctionGameMainRoundOverLayer:getUIName()
	return "AuctionGameMainRoundOverUI"
end

function AuctionGameMainRoundOverLayer:init()
	self.boardItemList = {}

	return
end

function AuctionGameMainRoundOverLayer:didEnter()
	self:OverlayPanel(self._tf, {
		pbList = {
			self.uiBg
		}
	})

	local var_3_0 = AuctionGameTools.GetPlayerNoSortList(getProxy(AuctionGameProxy):GetRound())

	for iter_3_0, iter_3_1 in ipairs(var_3_0) do
		self.boardItemList[iter_3_0] = AuctionGameMainRoundOverPlayer.New(self[string.format("uiPlayerTf%s", iter_3_0)], self)

		self.boardItemList[iter_3_0]:didEnter(iter_3_1.data)
	end

	for iter_3_2 = #var_3_0 + 1, 4 do
		setActive(self[string.format("uiPlayerTf%s", iter_3_2)], false)
	end

	return
end

function AuctionGameMainRoundOverLayer:willExit()
	for iter_4_0, iter_4_1 in ipairs(self.boardItemList) do
		iter_4_1:willExit()
	end

	self.boardItemList = nil

	self:UnOverlayPanel(self._tf)

	return
end

function AuctionGameMainRoundOverLayer:onBackPressed()
	return
end

return AuctionGameMainRoundOverLayer
