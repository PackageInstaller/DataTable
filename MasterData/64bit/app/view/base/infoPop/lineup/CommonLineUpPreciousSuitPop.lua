local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_2 = g.core.const.ConstMgr.BASE_CONST
local CommonLineUpPreciousSuitPop = class("CommonLineUpPreciousSuitPop", require("app.fairyGUI.infoPop.UI_CommonLineUpPreciousSuitPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = true,
		pkgPath = "ui/infoPop/infoPop",
		resName = "CommonLineUpPreciousSuitPop"
	})
end)

function CommonLineUpPreciousSuitPop:ctor(arg_2_1)
	self._allList = arg_2_1.allList or {}
	self._clickCheckFunc = arg_2_1.clickCheckFunc
	self._sortFunc = arg_2_1.sortFunc or self:_getDefaultSortFunc()
	self._isLineUpFunc = arg_2_1.isLineUpCall
	self._isFilter = arg_2_1.isFilter
	self._filterStr = arg_2_1.filterStr
	self._itemUrl = arg_2_1.itemUrl
	self._sound = arg_2_1.sound or var_0_0.Sound.FOG_NIGHTMARE_LINEUP_SLIDE
	self._cellParam = arg_2_1.cellParam
	self._qualitySelectedIndex = 0
	self._curSkillList = {}
	self._skillList = {}
	self._tabQualitys = var_0_1.TabQuality[var_0_1.NEW_QUALITY_CTRL.PRECIOUS]

	self:_initView()
end

function CommonLineUpPreciousSuitPop:onLoad()
	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_3_0:setHook("listEnter", handler(self, self._updateView))

	if var_3_0 then
		var_3_0:play()
	end
end

function CommonLineUpPreciousSuitPop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_tabList:setVirtual()
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_skillList:setDefaultItem(self._itemUrl)
	self.m_skillList:setVirtual()
	self.m_skillList:setItemRenderer(handler(self, self._onRenderSkillList))
	self.m_skillList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onSkillListClickItem))

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

	if self._sound and self._sound ~= "" then
		g.core.sound.SoundManager:playSound(self._sound)
	end
end

function CommonLineUpPreciousSuitPop:_onFilterChanged(arg_5_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:_updateView()
end

function CommonLineUpPreciousSuitPop:_updateView()
	self._curSkillList = self:_getData()

	if #self._curSkillList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_skillList:setNumItems(#self._curSkillList)
		self.m_skillList:transitionShowCells("enter_right", 0.03)
	end
end

function CommonLineUpPreciousSuitPop:_getData()
	local var_7_0 = self._tabQualitys[self._qualitySelectedIndex].quality or 0

	if not self._skillList[var_7_0] then
		self._skillList[var_7_0] = {}

		for iter_7_0, iter_7_1 in pairs(self._allList) do
			if var_7_0 == 0 then
				table.insert(self._skillList[var_7_0], iter_7_1)
			elseif iter_7_1:getQuality() == var_7_0 then
				table.insert(self._skillList[var_7_0], iter_7_1)
			end
		end
	end

	local var_7_2 = {}

	if self._isFilter then
		for iter_7_2, iter_7_3 in pairs(self._skillList[var_7_0]) do
			if not self._isLineUpFunc(iter_7_3) then
				table.insert(var_7_2, iter_7_3)
			end
		end
	else
		var_7_2 = self._skillList[var_7_0]
	end

	table.sort(var_7_2, self._sortFunc)

	return var_7_2
end

function CommonLineUpPreciousSuitPop:_getDefaultSortFunc()
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

		local var_9_3 = arg_9_0:getStar()
		local var_9_4 = arg_9_1:getStar()

		if var_9_3 ~= var_9_4 then
			return var_9_4 < var_9_3
		end

		return arg_9_0:getSuitGroup() > arg_9_1:getSuitGroup()
	end
end

function CommonLineUpPreciousSuitPop:_onRenderSkillList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._curSkillList[arg_10_1 + 1], self._cellParam)
end

function CommonLineUpPreciousSuitPop:_onBack()
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

function CommonLineUpPreciousSuitPop:_onTabListClickItem(arg_13_1)
	local var_13_0 = self.m_tabList:getSelectedIndex()

	if var_13_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_13_0

	self:_updateView()
end

function CommonLineUpPreciousSuitPop:_onTabListItemRender(arg_14_1, arg_14_2)
	arg_14_2:setTitle(self._tabQualitys[arg_14_1].name or 0)
end

function CommonLineUpPreciousSuitPop:_onSkillListClickItem(arg_15_1)
	local var_15_0 = self._curSkillList[arg_15_1:getDataValue() + 1]

	if var_15_0 then
		if var_0_2.HAS_PUT_CHECK and var_15_0:getCfg().put == 0 then
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
			self:dispatchCompEvent("common_lineup_click_precious_suit", {
				struct = var_15_0
			})
			self:_onClickClose()
		end
	end
end

function CommonLineUpPreciousSuitPop:_onClickClose(arg_16_1)
	if arg_16_1 then
		if not self.m_bgPanel:containPoint((arg_16_1:getInput():getTouch():getLocation())) then
			self:_onBack()
		end
	else
		self:_onBack()
	end
end

return CommonLineUpPreciousSuitPop
