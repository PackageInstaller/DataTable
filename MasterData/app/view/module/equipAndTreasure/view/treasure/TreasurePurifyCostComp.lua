local TreasurePurifyCostComp = class("TreasurePurifyCostComp", require("app.fairyGUI.equipAndTreasure.UI_TreasurePurifyCostComp"))

function TreasurePurifyCostComp:ctor()
	self._costDataList = nil
	self._clickHandler = nil
	self._selectedIndex = 0

	self.m_costList:setVirtual(self)
	self.m_costList:setItemRenderer(handler(self, self._onCostItemRender))
	self.m_costList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onCostItemClick))
end

function TreasurePurifyCostComp:setClickHandler(arg_2_1)
	self._clickHandler = arg_2_1
end

function TreasurePurifyCostComp:updateCostShow(arg_3_1)
	self._costDataList = arg_3_1

	self.m_costList:setNumItems(#arg_3_1)
end

function TreasurePurifyCostComp:_onCostItemRender(arg_4_1, arg_4_2)
	arg_4_2:updateIconComp(self._costDataList[arg_4_1 + 1])
end

function TreasurePurifyCostComp:_onCostItemClick(arg_5_1)
	local var_5_0 = self.m_costList:getSelectedIndex() + 1

	if var_5_0 == self._selectedIndex then
		g.core.common.GlobalFunc.pushInfoPop(self._costDataList[var_5_0])

		return
	end

	self._selectedIndex = var_5_0

	if self._clickHandler then
		self._clickHandler(var_5_0, self._costDataList[var_5_0])
	end
end

function TreasurePurifyCostComp:setSelectedCostIdx(arg_6_1)
	self._selectedIndex = 0

	self.m_costList:setSelectedIndex(arg_6_1)
	self:_onCostItemClick()
end

function TreasurePurifyCostComp:getSelectCost(arg_7_1)
	if arg_7_1 then
		return self._costDataList
	else
		return self._costDataList[self.m_costList:getSelectedIndex() + 1]
	end
end

function TreasurePurifyCostComp:getSelectedCostIdx()
	return self.m_costList:getSelectedIndex()
end

return TreasurePurifyCostComp
