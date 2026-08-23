local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.const.ConstMgr.BASE_CONST
local CommonLineUpPetPop = class("CommonLineUpPetPop", require("app.fairyGUI.infoPop.UI_CommonLineUpPetPop"), function()
	return fgui.GComponent:create({
		resName = "CommonLineUpPetPop",
		pkgPath = "ui/infoPop/infoPop",
		isFullScreen = true,
		pkgName = "infoPop"
	})
end)

function CommonLineUpPetPop:ctor(arg_2_1)
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
	self._curPetList = {}
	self._petList = {}
	self._tabQualitys = var_0_1.TabQuality[var_0_1.NEW_QUALITY_CTRL.PET]

	self:_initView()
end

function CommonLineUpPetPop:onLoad()
	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_3_0:setHook("listEnter", handler(self, self._onShowList))

	if var_3_0 then
		var_3_0:play()
	end
end

function CommonLineUpPetPop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_petList:setDefaultItem(self._itemUrl)
	self.m_petList:setVirtual()
	self.m_petList:setItemRenderer(handler(self, self._onRenderPetList))
	self.m_petList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onPetListClickItem))

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

function CommonLineUpPetPop:_onFilterChanged(arg_5_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:_updateView()
end

function CommonLineUpPetPop:_updateView()
	self._curPetList = self:_getData()

	if #self._curPetList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_petList:setNumItems(#self._curPetList)
		self.m_petList:transitionShowCells("enter_right", 0.03)
	end
end

function CommonLineUpPetPop:_getData()
	local var_7_0 = self._tabQualitys[self._qualitySelectedIndex].quality or 0

	if not self._petList[var_7_0] then
		self._petList[var_7_0] = {}

		for iter_7_0, iter_7_1 in pairs(self._allList) do
			if var_7_0 == 0 then
				table.insert(self._petList[var_7_0], iter_7_1)
			elseif iter_7_1:getQuality() == var_7_0 then
				table.insert(self._petList[var_7_0], iter_7_1)
			end
		end
	end

	local var_7_2 = {}

	if self._isFilter then
		for iter_7_2, iter_7_3 in pairs(self._petList[var_7_0]) do
			if not self._isLineUpFunc(iter_7_3) then
				table.insert(var_7_2, iter_7_3)
			end
		end
	else
		var_7_2 = self._petList[var_7_0]
	end

	table.sort(var_7_2, self._sortFunc)

	return var_7_2
end

function CommonLineUpPetPop:_getDefaultSortFunc()
	return function(arg_9_0, arg_9_1)
		if self._isLineUpFunc then
			local var_9_0 = self._isLineUpFunc(arg_9_0)

			if var_9_0 ~= self._isLineUpFunc(arg_9_1) then
				return var_9_0
			end
		end

		local var_9_1 = arg_9_0:getQuality()
		local var_9_2 = arg_9_1:getQuality()

		if var_9_1 ~= var_9_2 then
			return var_9_2 < var_9_1
		end

		local var_9_3 = arg_9_0:getStarNum()
		local var_9_4 = arg_9_1:getStarNum()

		if var_9_3 ~= var_9_4 then
			return var_9_4 < var_9_3
		end

		return arg_9_0:getAdvanceId() > arg_9_1:getAdvanceId()
	end
end

function CommonLineUpPetPop:_onRenderPetList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._curPetList[arg_10_1 + 1], self._cellParam)
end

function CommonLineUpPetPop:_onBack()
	if not self._isOnBack then
		self._isOnBack = true

		local var_11_0 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_11_0 then
			var_11_0:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		end
	end
end

function CommonLineUpPetPop:_onTabListClickItem(arg_13_1)
	local var_13_0 = self.m_tabList:getSelectedIndex()

	if var_13_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_13_0

	self:_updateView()
end

function CommonLineUpPetPop:_onTabListItemRender(arg_14_1, arg_14_2)
	arg_14_2:setTitle(self._tabQualitys[arg_14_1].name or 0)
end

function CommonLineUpPetPop:_onPetListClickItem(arg_15_1)
	local var_15_0 = self._curPetList[arg_15_1:getDataValue() + 1]

	if var_15_0 then
		if var_0_2.HAS_PUT_CHECK and not var_15_0:isPut() then
			g.core.module.ModuleManager:tip(g.core.lang:get(1159))

			return
		end

		if self._clickCheckFunc then
			if self._clickCheckFunc(var_15_0) then
				self:_onClickClose()
			else
				return
			end
		else
			self:dispatchCompEvent("common_lineup_click_pet", {
				struct = var_15_0
			})
			self:_onClickClose()
		end
	end
end

function CommonLineUpPetPop:_onClickClose(arg_16_1)
	if arg_16_1 then
		if not self.m_bgPanel:containPoint((arg_16_1:getInput():getTouch():getLocation())) then
			self:_onBack()
		end
	else
		self:_onBack()
	end
end

function CommonLineUpPetPop:_onRenderTopTabItem(arg_17_1, arg_17_2)
	arg_17_2:setTitle(self._topTabInfo[arg_17_1 + 1])
end

function CommonLineUpPetPop:_onClickTopTabItem()
	local var_18_0 = self.m_topTabList:getSelectedIndex()

	self._allList = self._allDataDic[var_18_0 + 1]
	self._petList = {}

	self:_onFilterChanged()

	if self._topTabSwitchListener then
		self:_topTabSwitchListener(var_18_0)
	end
end

function CommonLineUpPetPop:_onShowList()
	if self._topTabInfo then
		self:_onClickTopTabItem()
	else
		self:_updateView()
	end
end

return CommonLineUpPetPop
