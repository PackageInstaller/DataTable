local MysteryOtherOpeComp = class("MysteryOtherOpeComp", require("app.fairyGUI.mystery.UI_MysteryOtherOpeComp"))

function MysteryOtherOpeComp:ctor()
	self.m_playerList:setVirtual()
	self.m_playerList:setItemRenderer(handler(self, self._renderListItem))
	self.m_playerList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self.onItemClick))
	self.m_playerList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_playerList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onListScrollEnd))
end

function MysteryOtherOpeComp:setShowState(arg_2_1)
	if arg_2_1 then
		self:setVisible(true)
		self.m_enterTransition:play()
	else
		self.m_backTransition:play(handler(self, self._onBackTransitionEnd))
	end
end

function MysteryOtherOpeComp:_onBackTransitionEnd()
	self:setVisible(false)
end

function MysteryOtherOpeComp:updateOtherList(arg_4_1)
	self.m_btnComp:setVisible(false)
	self.m_playerList:setSelectedIndex(-1)

	self._items = arg_4_1

	self.m_playerList:setNumItems(#arg_4_1)
end

function MysteryOtherOpeComp:_onListScroll()
	self:showOpeComp()
end

function MysteryOtherOpeComp:_onListScrollEnd()
	self:showOpeComp()
end

function MysteryOtherOpeComp:onItemClick()
	self:showOpeComp()
end

function MysteryOtherOpeComp:showOpeComp()
	if self.m_playerList:getSelectedIndex() == -1 then
		self.m_btnComp:setVisible(false)

		return
	end

	local var_8_0 = #self.m_playerList:getChildren()
	local var_8_1 = self.m_playerList:itemIndexToChildIndex(self.m_playerList:getSelectedIndex())

	if var_8_1 < 0 or var_8_1 > var_8_0 - 1 then
		self.m_btnComp:setVisible(false)

		return
	end

	local var_8_2 = self.m_playerList:getChildAt(var_8_1)

	self.m_btnComp:setVisible(true)
	self.m_btnComp:updateOtherBtnComp(self._items[self.m_playerList:getSelectedIndex() + 1])

	local var_8_3 = self:globalToLocal((var_8_2:localToGlobal(cc.p(0, 0))))

	self.m_btnComp:setPosition(var_8_3.x + 150, var_8_3.y + var_8_2:getHeight() / 2)
end

function MysteryOtherOpeComp:_renderListItem(arg_9_1, arg_9_2)
	arg_9_2:updateOtherCell(self._items[arg_9_1 + 1])
end

return MysteryOtherOpeComp
