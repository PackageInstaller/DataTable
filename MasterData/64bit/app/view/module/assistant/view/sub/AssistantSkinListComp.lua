local AssistantSkinListComp = class("AssistantSkinListComp", require("app.fairyGUI.assistant.UI_AssistantSkinListComp"))

function AssistantSkinListComp:ctor()
	self._len = 0

	self.m_list:setVirtual()
	self.m_list:doFairyBatching(false)
	self.m_list:setItemRenderer(handler(self, self._onSkinRenderer))
	self.m_list:addEventListener(fgui.UIEventType.Scroll, handler(self, self._onListScroll))
	self.m_list:addEventListener(fgui.UIEventType.ScrollEnd, handler(self, self._onListScrollEnd))
	self:addListen(self.m_list)
end

function AssistantSkinListComp:initComp(arg_2_1)
	self._skinList = arg_2_1.skinList
	self._len = #self._skinList
	self._knight = arg_2_1.knight
	self._cellWidth = self.m_list:getFromPool():getWidth()
	self._listColumnGap = self.m_list:getColumnGap()

	self.m_list:setNumItems(self._len + 3)

	local var_2_0 = 1

	if not arg_2_1.skinId or arg_2_1.skinId == 0 then
		var_2_0 = 1
	else
		for iter_2_0, iter_2_1 in ipairs(self._skinList) do
			if arg_2_1.skinId == iter_2_1.id then
				var_2_0 = iter_2_0 + 1

				break
			end
		end
	end

	self.m_list:scrollToView(var_2_0 - 1)
	self:_onListScroll()
	self:_onListScrollEnd()
end

function AssistantSkinListComp:receiveCompEvent(arg_3_1)
	if arg_3_1 == "AssistantSkinCellClick" then
		self.m_list:scrollToView(({
			...
		})[1] - 1, true)
	end
end

function AssistantSkinListComp:_onSkinRenderer(arg_4_1, arg_4_2)
	if arg_4_1 > 0 and arg_4_1 < self._len + 2 then
		arg_4_2:setVisible(true)

		if arg_4_1 == 1 then
			arg_4_2:updateCell({
				knight = self._knight:getBaseInfo()
			}, arg_4_1)
		else
			arg_4_2:updateCell({
				skin = self._skinList[arg_4_1 - 1]
			}, arg_4_1)
		end

		self:updateCellIsInUse(arg_4_2)
	else
		arg_4_2:setVisible(false)
	end
end

function AssistantSkinListComp:updateCellIsInUse(arg_5_1)
	if g.core.common.ModuleUnlock:isModuleUnlock(g.core.const.ConstMgr.FUNCTION_TYPE.ASSISTANT_ADV) then
		arg_5_1:updateIsInUse(false)

		local var_5_0 = g.core.model.User:isInNominateList(self._knight:getBaseInfo().advance_id)

		if var_5_0 > 0 and g.core.model.User:getNominateList()[var_5_0].skinId == arg_5_1:getSkinId() then
			arg_5_1:updateIsInUse(true)
		end
	end
end

function AssistantSkinListComp:updateAllCellIsInUse()
	for iter_6_0 = 1, self.m_list:numChildren() do
		local var_6_0 = self.m_list:getChildAt(iter_6_0 - 1)

		if var_6_0:isVisible() then
			self:updateCellIsInUse(var_6_0)
		end
	end
end

function AssistantSkinListComp:_onListScroll()
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

function AssistantSkinListComp:_onListScrollEnd()
	local var_8_0 = self:getWidth() / 2
	local var_8_1

	for iter_8_0 = 2, self.m_list:numChildren() do
		local var_8_2 = self.m_list:getChildAt(iter_8_0 - 1)
		local var_8_3 = math.abs(var_8_0 - self:globalToLocal((var_8_2:localToGlobal(cc.p(var_8_2:getWidth() / 2, 0)))).x)
		local var_8_4

		if var_8_3 < 99999 then
			var_8_1 = var_8_2
			var_8_4 = var_8_3
		end
	end

	if var_8_1 then
		self:dispatchCompEvent("AssistantSkinSwitch", var_8_1.info)
	end
end

return AssistantSkinListComp
