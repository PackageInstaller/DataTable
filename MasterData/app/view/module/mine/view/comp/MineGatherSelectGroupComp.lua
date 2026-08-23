local MineGatherSelectGroupComp = class("MineGatherSelectGroupComp", require("app.fairyGUI.mine.UI_MineGatherSelectGroupComp"))

function MineGatherSelectGroupComp:ctor()
	self.m_selectList:setVirtual()
	self.m_selectList:setItemRenderer(handler(self, self._onRenderSelectList))
	self.m_selectList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickQuality))
	self:addClickListener(handler(self, self._onClickOpenSelection))
end

function MineGatherSelectGroupComp:_onClickQuality()
	local var_2_0 = self.m_selectList:getSelectedIndex()

	self.m_title:setText(self._selectMap[var_2_0 + 1])
	self:dispatchCompEvent("onCheckCityQuality", {
		index = var_2_0 + 1
	})
end

function MineGatherSelectGroupComp:setSelectionData(arg_3_1)
	self._selectMap = arg_3_1

	self.m_title:setText(self._selectMap[1])
	self.m_selectList:setNumItems(#arg_3_1)
	self.m_selectList:resizeToFit(#arg_3_1)
	self.m_selectList:setSelectedIndex(0)
end

function MineGatherSelectGroupComp:_onClickOpenSelection()
	self.m_stateController:setSelectedIndex(self.m_stateController:getSelectedIndex() == 0 and 1 or 0)
end

function MineGatherSelectGroupComp:_onRenderSelectList(arg_5_1, arg_5_2)
	arg_5_2:setTitle(self._selectMap[arg_5_1 + 1])
end

return MineGatherSelectGroupComp
