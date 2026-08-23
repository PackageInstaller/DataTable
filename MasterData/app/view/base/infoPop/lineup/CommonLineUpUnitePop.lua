local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.const.ConstMgr.BASE_CONST
local CommonLineUpUnitePop = class("CommonLineUpUnitePop", require("app.fairyGUI.infoPop.UI_CommonLineUpUnitePop"), function()
	return fgui.GComponent:create({
		resName = "CommonLineUpUnitePop",
		pkgPath = "ui/infoPop/infoPop",
		isFullScreen = true,
		pkgName = "infoPop"
	})
end)

function CommonLineUpUnitePop:ctor(arg_2_1)
	if arg_2_1.topTabInfo then
		self._topTabInfo = arg_2_1.topTabInfo
		self._allDataDic = arg_2_1.allList
		self._topTabSwitchListener = arg_2_1.topTabSwitchListener
		self._allList = {}
	else
		self._allList = arg_2_1.allList or {}
	end

	self._clickCheckFunc = arg_2_1.clickCheckFunc
	self._sortFunc = arg_2_1.sortFunc or self:_getDefaultSortFunc()
	self._isLineUpFunc = arg_2_1.isLineUpCall
	self._isFilter = arg_2_1.isFilter
	self._filterStr = arg_2_1.filterStr
	self._itemUrl = arg_2_1.itemUrl
	self._sound = arg_2_1.sound or var_0_0.Sound.FOG_NIGHTMARE_LINEUP_SLIDE
	self._cellParam = arg_2_1.cellParam
	self._qualitySelectedIndex = 0
	self._curTokenList = {}
	self._tokenList = {}
	self._tabQualitys = var_0_1.TabQuality[var_0_1.NEW_QUALITY_CTRL.UNITETOKEN]

	self:_initView()
end

function CommonLineUpUnitePop:onLoad()
	g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_WAIT)

	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_3_0:setHook("listEnter", handler(self, self._onShowList))

	if var_3_0 then
		var_3_0:play(handler(self, self._onEnterAnimFinish))
	end
end

function CommonLineUpUnitePop:_onEnterAnimFinish()
	g.core.common.Scheduler:newScheduleOnce(function()
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_GUIDE_READY)
		g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
	end, 0)

	self._isWeakGuideReady = true
end

function CommonLineUpUnitePop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_tabList:setVirtual()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_tokenList:setDefaultItem(self._itemUrl)
	self.m_tokenList:setVirtual()
	self.m_tokenList:setItemRenderer(handler(self, self._onRenderTokenList))
	self.m_tokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTokenListClickItem))

	if self._isFilter == nil then
		self.m_filterBtn:setVisible(false)
	else
		self.m_filterBtn:addClickListener(handler(self, self._onFilterChanged))
		self.m_filterBtn:setSelected(self._isFilter)
		self.m_filterBtn:setVisible(true)

		if self._filterStr then
			self.m_filterBtn:setTitle(self._filterStr)
		end
	end

	if self._topTabInfo then
		self.m_topTabList:setVirtual(self)
		self.m_topTabList:doFairyBatching(false)
		self.m_topTabList:setItemRenderer(handler(self, self._onRenderTopTabItem))
		self.m_topTabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickTopTabItem))
		self.m_topTabList:setNumItems(#self._topTabInfo)
		self.m_topTabList:setVisible(true)
		self.m_topTabList:setSelectedIndex(0)
	end

	if self._sound and self._sound ~= "" then
		g.core.sound.SoundManager:playSound(self._sound)
	end
end

function CommonLineUpUnitePop:_onFilterChanged(arg_7_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:_updateView()
end

function CommonLineUpUnitePop:_updateView()
	self._curTokenList = self:_getData()

	if #self._curTokenList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_tokenList:setNumItems(#self._curTokenList)
		self.m_tokenList:transitionShowCells("enter_right", 0.03)
	end
end

function CommonLineUpUnitePop:_getData()
	local var_9_0 = self._tabQualitys[self._qualitySelectedIndex].quality or 0

	if not self._tokenList[var_9_0] then
		self._tokenList[var_9_0] = {}

		for iter_9_0, iter_9_1 in pairs(self._allList) do
			if var_9_0 == 0 then
				table.insert(self._tokenList[var_9_0], iter_9_1)
			elseif iter_9_1:getQuality() == var_9_0 then
				table.insert(self._tokenList[var_9_0], iter_9_1)
			end
		end
	end

	local var_9_2 = {}

	if self._isFilter then
		for iter_9_2, iter_9_3 in pairs(self._tokenList[var_9_0]) do
			if not self._isLineUpFunc(iter_9_3) then
				table.insert(var_9_2, iter_9_3)
			end
		end
	else
		var_9_2 = self._tokenList[var_9_0]
	end

	table.sort(var_9_2, self._sortFunc)

	return var_9_2
end

function CommonLineUpUnitePop:_getDefaultSortFunc()
	return function(arg_11_0, arg_11_1)
		if self._isLineUpFunc then
			local var_11_0 = self._isLineUpFunc(arg_11_0)

			if var_11_0 ~= self._isLineUpFunc(arg_11_1) then
				return var_11_0
			end
		end

		local var_11_1 = arg_11_0:getQuality()
		local var_11_2 = arg_11_1:getQuality()

		if var_11_1 ~= var_11_2 then
			return var_11_2 < var_11_1
		end

		return arg_11_0:getBaseId() > arg_11_1:getBaseId()
	end
end

function CommonLineUpUnitePop:_onRenderTokenList(arg_12_1, arg_12_2)
	arg_12_2:updateCell(self._curTokenList[arg_12_1 + 1], self._cellParam)
end

function CommonLineUpUnitePop:_onBack()
	if not self._isOnBack then
		self._isOnBack = true

		local var_13_0 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_13_0 then
			var_13_0:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		end
	end
end

function CommonLineUpUnitePop:_onTabListClickItem(arg_15_1)
	local var_15_0 = self.m_tabList:getSelectedIndex()

	if var_15_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_15_0

	self:_updateView()
end

function CommonLineUpUnitePop:_onTabListItemRender(arg_16_1, arg_16_2)
	arg_16_2:setTitle(self._tabQualitys[arg_16_1].name or 0)
end

function CommonLineUpUnitePop:_onTokenListClickItem(arg_17_1)
	local var_17_0 = self._curTokenList[arg_17_1:getDataValue() + 1]

	if var_17_0 then
		if var_0_2.HAS_PUT_CHECK and var_17_0:getPut() == 0 then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		if self._clickCheckFunc then
			if self._clickCheckFunc(var_17_0) then
				self:_onClickClose()
			else
				return
			end
		else
			self:dispatchCompEvent("common_lineup_click_unite", {
				struct = var_17_0
			})
			self:_onClickClose()
		end
	end
end

function CommonLineUpUnitePop:_onClickClose(arg_18_1)
	if arg_18_1 then
		if not self.m_bgPanel:containPoint((arg_18_1:getInput():getTouch():getLocation())) then
			self:_onBack()
		end
	else
		self:_onBack()
	end
end

function CommonLineUpUnitePop:_onRenderTopTabItem(arg_19_1, arg_19_2)
	arg_19_2:setTitle(self._topTabInfo[arg_19_1 + 1])
end

function CommonLineUpUnitePop:_onClickTopTabItem()
	if self._isWeakGuideReady then
		g.core.common.Scheduler:newScheduleOnce(function()
			g.core.event.EventManager:dispatchEvent(g.core.event.enum.EVENT_WEAK_GUIDE_READY)
		end, 0)
	end

	local var_20_0 = self.m_topTabList:getSelectedIndex()

	self._allList = self._allDataDic[var_20_0 + 1]
	self._tokenList = {}

	self:_onFilterChanged()

	if self._topTabSwitchListener then
		self:_topTabSwitchListener(var_20_0)
	end
end

function CommonLineUpUnitePop:_onShowList()
	if self._topTabInfo then
		self:_onClickTopTabItem()
	else
		self:_updateView()
	end
end

return CommonLineUpUnitePop
