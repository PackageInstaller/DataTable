local var_0_0 = g.core.model.User
local KnightSkinBookShowListComp = class("KnightSkinBookShowListComp", require("app.fairyGUI.knightSkinBook.UI_KnightSkinBookShowListComp"))

function KnightSkinBookShowListComp:ctor()
	self._curIndex = -1
	self._skinBookList = {}
	self._len = 0
	self._knight = {}
	self._cellWidth = 0
	self._listColumnGap = 0
	self._showList = {}

	self.m_list:setVirtual()
	self.m_list:doFairyBatching(false)
	self:addListen(self.m_list)
	self.m_list:setItemRenderer(handler(self, self._onSkinRenderer))
	self.m_list:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickList))
end

function KnightSkinBookShowListComp:initComp(arg_2_1)
	self._curIndex = -1
	self._skinBookList = arg_2_1.skinBookList
	self._len = #self._skinBookList
	self._knight = arg_2_1.knight

	if self._knight:isMain() then
		self._knightName = var_0_0:getName() or self._knight:getBaseInfo().name
	end

	self._cellWidth = self.m_list:getFromPool():getWidth()
	self._listColumnGap = self.m_list:getColumnGap()

	self.m_list:setNumItems(self._len + 2)

	self._curIndex = 1

	for iter_2_0, iter_2_1 in ipairs(self._skinBookList) do
		if arg_2_1.curSkin.id == iter_2_1.id then
			self._curIndex = iter_2_0

			break
		end
	end

	if self._curIndex > 1 then
		self.m_list:scrollToView(self._curIndex - 1)
	else
		self:_onListScroll()
	end

	self:_disPatchRefreshEvent(self._curIndex)
end

function KnightSkinBookShowListComp:_onClickList(arg_3_1)
	self._curIndex = arg_3_1:getDataValue()

	self:_disPatchRefreshEvent(self._curIndex)
end

function KnightSkinBookShowListComp:_disPatchRefreshEvent(arg_4_1)
	self:dispatchCompEvent("KnightSkinSwitch", self.m_list:getChildAt((self.m_list:itemIndexToChildIndex(arg_4_1))).info)
end

function KnightSkinBookShowListComp:scrollStart()
	self.m_list:scrollToView(self._curIndex - 1, true)
end

function KnightSkinBookShowListComp:_onSkinRenderer(arg_6_1, arg_6_2)
	if arg_6_1 > 0 and arg_6_1 < self._len + 1 then
		arg_6_2:setVisible(true)
		arg_6_2:updateCell(self._skinBookList[arg_6_1], arg_6_1)
	else
		arg_6_2:setVisible(false)
	end
end

function KnightSkinBookShowListComp:_onListScroll()
	local var_7_0 = self:getWidth() / 2
	local var_7_1 = 0

	for iter_7_0 = 1, self.m_list:numChildren() do
		local var_7_2 = self.m_list:getChildAt(iter_7_0 - 1)
		local var_7_3 = math.abs(var_7_0 - self:globalToLocal((var_7_2:localToGlobal(cc.p(var_7_2:getWidth() / 2, 0)))).x)
		local var_7_4

		if var_7_3 <= (self._cellWidth + self._listColumnGap) * 2 then
			var_7_2:setScale(1 - 0.1 * var_7_3 / (self._cellWidth + self._listColumnGap))
		else
			var_7_2:setScale(0.8)

			var_7_4 = var_7_1
		end

		var_7_1 = math.max(var_7_1, (self.m_list:getChildIndex(var_7_2)))
	end
end

return KnightSkinBookShowListComp
