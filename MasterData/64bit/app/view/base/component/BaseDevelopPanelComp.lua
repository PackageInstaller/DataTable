local BaseDevelopPanelComp = class("BaseDevelopPanelComp", require("app.fairyGUI.base_new.UI_BaseDevListComp"))

function BaseDevelopPanelComp:ctor()
	self._objData = {}
	self._devCompMap = {}
	self._tabData = {}
	self._preTabNum = 0
	self._selectKnightAdvId = 0
	self._selectIndex = -1
	self._curComp = nil
	self._inWaitCount = 0

	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickItem))
end

function BaseDevelopPanelComp:_onClickItem()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end, 0.5)
end

function BaseDevelopPanelComp:initConfig(arg_4_1)
	return
end

function BaseDevelopPanelComp:updateDevPanel(arg_5_1)
	if arg_5_1 then
		self._objData = arg_5_1.data or {}
	end

	self._redCustomData = arg_5_1 and arg_5_1.customData
	self._tokenListData = arg_5_1.tokenListData or {}
	self._selectedIndex = arg_5_1.selectedIndex or 0

	local var_5_0 = arg_5_1.tabData or {}
	local var_5_1 = {}

	for iter_5_0 = 1, #var_5_0 do
		if var_5_0[iter_5_0].show and var_5_0[iter_5_0].show(self._objData) then
			table.insert(var_5_1, var_5_0[iter_5_0])
		end
	end

	self._tabData = var_5_1

	local var_5_4 = 1

	if arg_5_1.initTabType then
		var_5_4 = self:getTabIndexByType(arg_5_1.initTabType)
	end

	self.m_tabList:updateTab({
		tabs = self._tabData,
		initIndex = var_5_4,
		data = self._objData,
		customData = self._redCustomData,
		listener = handler(self, self._onChangeTab),
		effect = {
			scale = 1,
			remove = true,
			name = "eff_ui_knight_tab",
			isLoop = false
		}
	})

	if var_5_4 then
		self.m_tabList:setSelectedIndex(var_5_4 - 1)
	end

	self.m_tabList:refreshRedPoint()

	return var_5_4
end

function BaseDevelopPanelComp:_updateDevCompByIndex(arg_6_1, arg_6_2, arg_6_3)
	if arg_6_2.knight and not arg_6_2.needRefresh then
		if arg_6_2.knight._advanceId == self._selectKnightAdvId and arg_6_1 == self._selectIndex then
			return
		end

		self._selectIndex = arg_6_1
		self._selectKnightAdvId = arg_6_2.knight._advanceId
	end

	for iter_6_0, iter_6_1 in pairs(self._devCompMap) do
		iter_6_1:setVisible(iter_6_0 == arg_6_3)
	end

	self._curComp = self._devCompMap[arg_6_3]

	if not self._curComp then
		if self._tabData[arg_6_1].comp == "" then
			return
		end

		local var_6_0 = string.split(self._tabData[arg_6_1].comp, "/")
		local var_6_1 = fgui.UIPackage:createObject(var_6_0[1], var_6_0[2], self)

		self:addChild(var_6_1)

		if self._tabData[arg_6_1].pos then
			var_6_1:setPosition(self._tabData[arg_6_1].pos.x, self._tabData[arg_6_1].pos.y)
		end

		self._devCompMap[self._tabData[arg_6_1].index] = var_6_1
		self._curComp = var_6_1
	else
		self._curComp:setVisible(true)
	end

	if self._curComp then
		if self._tabData[arg_6_1].isCenter then
			self._curComp:updateView({
				tokenListData = self._tokenListData,
				selectedIndex = self._selectedIndex
			})
		else
			self._curComp:updateView({
				data = arg_6_2
			})
		end
	end

	self._preTabNum = #self._tabData
end

function BaseDevelopPanelComp:getDevCompByType(arg_7_1)
	if self._devCompMap[arg_7_1] then
		return self._devCompMap[arg_7_1]
	end
end

function BaseDevelopPanelComp:getTabIndexByType(arg_8_1)
	for iter_8_0, iter_8_1 in ipairs(self._tabData) do
		if iter_8_1.index and iter_8_1.index == arg_8_1 then
			if iter_8_1.cond then
				local var_8_0, var_8_1 = iter_8_1.cond(nil, self._objData)

				return var_8_1 and iter_8_0 or 1
			else
				return iter_8_0
			end
		end
	end

	return 1
end

function BaseDevelopPanelComp:refreshFuncUnlock()
	self.m_tabList:refreshFuncUnlock()
end

function BaseDevelopPanelComp:updateRedTab()
	self.m_tabList:refreshRedPoint()
end

function BaseDevelopPanelComp:_onChangeTab(arg_11_1, arg_11_2)
	self:dispatchCompEvent("BaseDevelopPanelComp_tab", {
		tabData = self._tabData[arg_11_1],
		tabType = self._tabData[arg_11_1].index
	})

	if self._curComp and self._curComp.m_backTransition then
		if self._inWaitCount > 0 then
			self._inWaitCount = self._inWaitCount - 1

			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self:_updateDevCompWithAnimation(arg_11_1, self._objData, self._tabData[arg_11_1].index)
	else
		self:_updateDevCompWithAnimation(arg_11_1, self._objData, self._tabData[arg_11_1].index)
	end
end

function BaseDevelopPanelComp:_updateDevCompWithAnimation(arg_12_1, arg_12_2, arg_12_3)
	self:_updateDevCompByIndex(arg_12_1, arg_12_2, arg_12_3)

	if self._curComp and self._curComp.m_enterTransition then
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

		self._inWaitCount = self._inWaitCount + 1

		self._curComp.m_enterTransition:play(handler(self, self.onAnimEnd))
	end
end

function BaseDevelopPanelComp:onAnimEnd()
	if self._inWaitCount > 0 then
		self._inWaitCount = self._inWaitCount - 1

		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
	end
end

function BaseDevelopPanelComp:switchToTab(arg_14_1)
	for iter_14_0, iter_14_1 in ipairs(self._tabData) do
		if iter_14_1.index == arg_14_1 then
			self:_onChangeTab(iter_14_0, self.m_tabList)

			break
		end
	end
end

function BaseDevelopPanelComp:onUnload()
	if self._inWaitCount > 0 then
		for iter_15_0 = 1, self._inWaitCount do
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		end

		self._inWaitCount = 0
	end
end

return BaseDevelopPanelComp
