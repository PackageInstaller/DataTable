local var_0_0 = g.core.model.User.wushTowerData
local WushTowerGoToComp = class("WushTowerGoToComp", require("app.fairyGUI.wushTower.UI_WushTowerGoToComp"))

function WushTowerGoToComp:ctor()
	self._cards = {}
	self._parcelInfo = nil

	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onRenderCardList))
end

function WushTowerGoToComp:updateCardList(arg_2_1)
	self._parcelInfo = arg_2_1
	self._cards = var_0_0:getCards()

	if #self._cards > 0 then
		self._cards = var_0_0:sortCardByParcelInfo(self._parcelInfo, self._cards)

		self.m_cardList:setNumItems(#self._cards)
	else
		self.m_isEmptyController:setSelectedIndex(1)
	end
end

function WushTowerGoToComp:_onRenderCardList(arg_3_1, arg_3_2)
	arg_3_2:updateTowerCardCell(self._cards[arg_3_1 + 1], self._parcelInfo)
end

return WushTowerGoToComp
