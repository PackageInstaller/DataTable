local var_0_0 = g.core.model.User
local KnightSkinListComp = class("KnightSkinListComp", require("app.fairyGUI.knight.UI_KnightSkinListComp"))

function KnightSkinListComp:ctor()
	self._curIndex = -1
	self._skinList = {}
	self._len = 0
	self._knightStruct = {}
	self._cellWidth = 0
	self._listColumnGap = 0
	self._showList = {}

	self.m_list:setVirtual()
	self.m_list:doFairyBatching(false)
	self.m_list:setItemRenderer(handler(self, self._onSkinRenderer))
	self.m_list:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_list:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickList))
	self:addListen(self.m_list)
end

function KnightSkinListComp:initComp(arg_2_1)
	self._curIndex = -1
	self._skinList = arg_2_1.skinList
	self._len = #self._skinList
	self._knightStruct = arg_2_1.knightStruct
	self._knightName = self._knightStruct:getName()
	self._cellWidth = self.m_list:getFromPool():getWidth()
	self._listColumnGap = self.m_list:getColumnGap()

	self.m_list:setNumItems(self._len + 3)

	local var_2_0 = self._knightStruct:getInfo().skin

	self._curIndex = 1

	if not var_2_0 or var_2_0 == 0 then
		self._curIndex = 1
	end

	for iter_2_0, iter_2_1 in ipairs(self._skinList) do
		if var_2_0 == iter_2_1.id then
			self._curIndex = iter_2_0 + 1

			break
		end
	end

	self:_disPatchRefreshEvent(self._curIndex)

	if self._curIndex > 1 then
		self.m_list:scrollToView(self._curIndex - 1)
	else
		self:_onListScroll()
	end
end

function KnightSkinListComp:_onClickList(arg_3_1)
	self._curIndex = arg_3_1:getDataValue()

	self:_disPatchRefreshEvent(self._curIndex)
end

function KnightSkinListComp:_disPatchRefreshEvent(arg_4_1)
	local var_4_0 = self.m_list:itemIndexToChildIndex(arg_4_1)

	if var_4_0 < 0 then
		return
	end

	self:dispatchCompEvent("knightSkin_KnightSkinSwitch", self.m_list:getChildAt(var_4_0):getCellData())
end

function KnightSkinListComp:scrollStart()
	self.m_list:scrollToView(self._curIndex - 1, true)
end

function KnightSkinListComp:_onSkinRenderer(arg_6_1, arg_6_2)
	if arg_6_1 > 0 and arg_6_1 < self._len + 2 then
		arg_6_2:setVisible(true)

		if arg_6_1 == 1 then
			arg_6_2:updateCell({
				knightInfo = self._knightStruct:getBaseInfo(),
				name = self._knightName
			}, arg_6_1)
		else
			local var_6_0 = self._skinList[arg_6_1 - 1]

			arg_6_2:updateCell({
				skinInfo = self._skinList[arg_6_1 - 1]
			}, arg_6_1)

			if var_0_0.skinData:getSkinState(var_6_0.id) == 1 then
				self._showList[arg_6_1] = var_6_0.id
			end
		end
	else
		arg_6_2:setVisible(false)
	end
end

function KnightSkinListComp:_onListScroll()
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

function KnightSkinListComp:_onListScrollEnd()
	local var_8_0 = self:getWidth() / 2
	local var_8_1
	local var_8_2 = false
	local var_8_3 = -1

	for iter_8_0 = 2, self.m_list:numChildren() do
		local var_8_4 = self.m_list:getChildAt(iter_8_0 - 1)
		local var_8_5 = math.abs(var_8_0 - self:globalToLocal((var_8_4:localToGlobal(cc.p(var_8_4:getWidth() / 2, 0)))).x)
		local var_8_6

		if var_8_5 < 99999 then
			var_8_1 = var_8_4
			var_8_6 = var_8_5
			var_8_3 = iter_8_0
		end
	end

	if self._curIndex ~= var_8_3 then
		var_8_2 = true
		self._curIndex = var_8_3
	end

	if var_8_2 then
		self:dispatchCompEvent("knightSkin_KnightSkinSwitch", var_8_1:getCellData())
	end
end

function KnightSkinListComp:onUnload()
	if next(self._showList) then
		for iter_9_0, iter_9_1 in pairs(self._showList) do
			var_0_0.skinData:setSkinDress(iter_9_1)
		end

		self._showList = {}
	end
end

return KnightSkinListComp
