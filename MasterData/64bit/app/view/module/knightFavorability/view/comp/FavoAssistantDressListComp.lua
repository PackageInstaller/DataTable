local var_0_0 = g.core.model.User.skinData
local FavoAssistantDressListComp = class("FavoAssistantDressListComp", require("app.fairyGUI.knightFavorability.UI_FavoAssistantDressListComp"))

function FavoAssistantDressListComp:ctor()
	self._len = 0
	self._listColumnGap = 0
	self._cellWidth = 0
	self._knightStruct = nil
	self._resIdInfoArr = {}

	self.m_dressList:setVirtual()
	self.m_dressList:doFairyBatching(false)
	self.m_dressList:setItemRenderer(handler(self, self._onSkinRenderer))
	self.m_dressList:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onTouchBegin))
	self.m_dressList:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_dressList:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onListScrollEnd))
	self.m_dressList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
end

function FavoAssistantDressListComp:updateView(arg_2_1, arg_2_2)
	self._knightStruct = arg_2_1:getBaseKnightInfo()
	self._resIdInfoArr = self:_getResIdInfoArr(self._knightStruct)
	self._len = #self._resIdInfoArr
	self._cellWidth = self.m_dressList:getFromPool():getWidth()
	self._listColumnGap = self.m_dressList:getColumnGap()

	self.m_dressList:setNumItems(self._len + 2)

	local var_2_0 = self:_getListDefaultSelectedIdx(self._resIdInfoArr, arg_2_2)

	self.m_dressList:addSelection(var_2_0, true)
	self.m_dressList:scrollToView(var_2_0 - 1)
	self:_onListScroll()
	self:_onListScrollEnd()
end

function FavoAssistantDressListComp:_onSkinRenderer(arg_3_1, arg_3_2)
	if arg_3_1 >= 1 and arg_3_1 <= self._len then
		arg_3_2:setVisible(true)
		arg_3_2:updateCell(self._resIdInfoArr[arg_3_1].resId)
	else
		arg_3_2:setVisible(false)
	end
end

function FavoAssistantDressListComp:_onTouchBegin(arg_4_1)
	arg_4_1:stopPropagation()
end

function FavoAssistantDressListComp:_onListScroll()
	local var_5_0 = self:getWidth() / 2

	for iter_5_0 = 1, self.m_dressList:numChildren() do
		local var_5_1 = self.m_dressList:getChildAt(iter_5_0 - 1)
		local var_5_2 = math.abs(var_5_0 - self:globalToLocal((var_5_1:localToGlobal(cc.p(var_5_1:getWidth() / 2, 0)))).x)

		if var_5_2 <= self._cellWidth + self._listColumnGap then
			var_5_1:setScale(1 - 0.1 * var_5_2 / (self._cellWidth + self._listColumnGap))
		else
			var_5_1:setScale(0.9)
		end
	end
end

function FavoAssistantDressListComp:_onListScrollEnd()
	local var_6_0 = self:getWidth() / 2
	local var_6_1

	for iter_6_0 = 1, self.m_dressList:numChildren() do
		local var_6_2 = self.m_dressList:getChildAt(iter_6_0 - 1)
		local var_6_4

		if var_6_2:isVisible() then
			local var_6_3 = math.abs(var_6_0 - self:globalToLocal((var_6_2:localToGlobal(cc.p(var_6_2:getWidth() / 2, 0)))).x)

			if var_6_3 < 99999 then
				var_6_4 = var_6_3
				var_6_1 = self.m_dressList:childIndexToItemIndex(iter_6_0 - 1)
			end
		end
	end

	if var_6_1 then
		self.m_dressList:setSelectedIndex(var_6_1)
		self:dispatchCompEvent("EVENT_CHANGE_SKIN", self._resIdInfoArr[var_6_1].resId)
	end
end

function FavoAssistantDressListComp:_onClickItem(arg_7_1)
	self.m_dressList:scrollToView(math.max(0, arg_7_1:getDataValue() - 1), true)
end

function FavoAssistantDressListComp:_getSortFunc()
	local var_8_0 = self._knightStruct:getSkin()

	return function(arg_9_0, arg_9_1)
		local var_9_0 = arg_9_0.skinId == var_8_0

		if arg_9_0.skinId == var_8_0 == (arg_9_1.skinId == var_8_0) then
			return arg_9_0.skinId < arg_9_1.skinId
		else
			return var_9_0
		end
	end
end

function FavoAssistantDressListComp:_getResIdInfoArr(arg_10_1)
	local var_10_0 = var_0_0:getOwnKnightSkins((arg_10_1:getAdvanceId())) or {}
	local var_10_1 = {
		{
			skinId = 0,
			resId = arg_10_1:getBaseInfo().res_id
		}
	}

	for iter_10_0, iter_10_1 in ipairs(var_10_0) do
		table.insert(var_10_1, {
			skinId = iter_10_1.id,
			resId = iter_10_1.res
		})
	end

	table.sort(var_10_1, self:_getSortFunc())

	return var_10_1
end

function FavoAssistantDressListComp:_getListDefaultSelectedIdx(arg_11_1, arg_11_2)
	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		if iter_11_1.resId == arg_11_2 then
			return iter_11_0
		end
	end

	return 1
end

return FavoAssistantDressListComp
