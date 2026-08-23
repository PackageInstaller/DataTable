local ShopOneKeyBuyCell = class("ShopOneKeyBuyCell", require("app.fairyGUI.shop.UI_ShopOneKeyBuyCell"))

function ShopOneKeyBuyCell:ctor()
	self._data = nil

	self.m_goodList:setIniter(self)
	self.m_goodList:setItemRenderer(handler(self, self._onGoodListRender))
end

function ShopOneKeyBuyCell:_onGoodListRender(arg_2_1, arg_2_2)
	if self._data.goodList[arg_2_1 + 1] then
		arg_2_2:updateCell(self._data.goodList[arg_2_1 + 1], arg_2_1, #self._data.goodList, self._data.finishcallback, self._data.progresscallback)
	end
end

function ShopOneKeyBuyCell:updateBuyCell(arg_3_1)
	self.m_typeController:setSelectedIndex(0)

	self._data = arg_3_1

	self.m_shopNameTxt:setText(arg_3_1.shopName)

	if arg_3_1.shopIcon and self.m_shopIcon then
		self.m_shopIcon:setURL(arg_3_1.shopIcon)
	end

	self.m_goodList:setNumItems(#arg_3_1.goodList)
end

function ShopOneKeyBuyCell:updateSummaryCell(arg_4_1)
	self.m_typeController:setSelectedIndex(1)

	self._data = arg_4_1

	self.m_goodList:setNumItems(#self._data.goodList)
end

function ShopOneKeyBuyCell:finishRevealNow()
	self:cancelAllSchedule()

	for iter_5_0 = 0, self.m_goodList:getNumItems() - 1 do
		local var_5_0 = self.m_goodList:getChildAt(iter_5_0)

		if var_5_0 and var_5_0.skipAnim then
			var_5_0:skipAnim()
		elseif var_5_0 and var_5_0.setVisible then
			var_5_0:setVisible(true)
		end
	end
end

return ShopOneKeyBuyCell
