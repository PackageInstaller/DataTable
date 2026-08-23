local var_0_0 = g.core.const.ConstMgr.QUALITY_TYPE
local var_0_1 = g.core.const.ConstMgr.SoundConst
local CommonLineUpArtifactPop = class("CommonLineUpArtifactPop", require("app.fairyGUI.infoPop.UI_CommonLineUpArtifactPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/infoPop/infoPop",
		resName = "CommonLineUpArtifactPop",
		pkgName = "infoPop",
		isFullScreen = true
	})
end)

function CommonLineUpArtifactPop:ctor(arg_2_1)
	self._isFilter = arg_2_1.isFilter
	self._allList = arg_2_1.allList or {}
	self._clickCheckFunc = arg_2_1.clickCheckFunc
	self._sortFunc = arg_2_1.sortFunc or self:_getDefaultSortFunc()
	self._isLineUpFunc = arg_2_1.isLineUpCall
	self._isRelated = arg_2_1.isRelated
	self._filterStr = arg_2_1.filterStr
	self._itemUrl = arg_2_1.itemUrl
	self._sound = arg_2_1.sound or var_0_1.Sound.FOG_NIGHTMARE_LINEUP_SLIDE
	self._cellParam = arg_2_1.cellParam
	self._qualitySelectedIndex = 0
	self._curArtifactList = {}
	self._artifactList = {}
	self._tabQualitys = var_0_0.TabQuality[var_0_0.NEW_QUALITY_CTRL.ARTIFACT]

	self:_initView()
end

function CommonLineUpArtifactPop:onLoad()
	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_3_0:setHook("listEnter", handler(self, self._updateView))

	if var_3_0 then
		var_3_0:play()
	end
end

function CommonLineUpArtifactPop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_artifactList:setDefaultItem(self._itemUrl)
	self.m_artifactList:setVirtual()
	self.m_artifactList:setItemRenderer(handler(self, self._onRenderArtifactList))
	self.m_artifactList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onArtifactListClickItem))

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

function CommonLineUpArtifactPop:_onFilterChanged(arg_5_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:_updateView()
end

function CommonLineUpArtifactPop:_updateView()
	self._curArtifactList = self:_getData()

	if #self._curArtifactList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_artifactList:setNumItems(#self._curArtifactList)
		self.m_artifactList:transitionShowCells("enter_right", 0.03)
	end
end

function CommonLineUpArtifactPop:_isLinkArtifact(arg_7_1)
	return self._cellParam.knightAdvId == arg_7_1:getBelongToKnightAvdIdIncludingMainRole() and not arg_7_1:isDemo()
end

function CommonLineUpArtifactPop:_getData()
	local var_8_0 = self._tabQualitys[self._qualitySelectedIndex].quality or 0
	local var_8_1 = self._artifactList[var_8_0]

	if not self._artifactList[var_8_0] then
		var_8_1 = {}

		for iter_8_0, iter_8_1 in pairs(self._allList) do
			if var_8_0 == 0 then
				table.insert(var_8_1, iter_8_1)
			elseif iter_8_1:getQuality() == var_8_0 then
				table.insert(var_8_1, iter_8_1)
			end
		end

		table.sort(var_8_1, self._sortFunc)

		self._artifactList[var_8_0] = var_8_1
	end

	local var_8_2 = {}

	if self._isFilter and self._isLineUpFunc then
		for iter_8_2, iter_8_3 in pairs(var_8_1) do
			if not self._isLineUpFunc(iter_8_3) or self:_isLinkArtifact(iter_8_3) then
				table.insert(var_8_2, iter_8_3)
			end
		end
	else
		var_8_2 = var_8_1
	end

	return var_8_2
end

function CommonLineUpArtifactPop:_getDefaultSortFunc()
	return function(arg_10_0, arg_10_1)
		if self._isRelated then
			local var_10_0 = self._isRelated(arg_10_0)

			if var_10_0 ~= self._isRelated(arg_10_1) then
				return var_10_0
			end
		end

		if self._isLineUpFunc then
			local var_10_1 = self._isLineUpFunc(arg_10_0)

			if var_10_1 ~= self._isLineUpFunc(arg_10_1) then
				return var_10_1
			end
		end

		local var_10_2 = arg_10_0:getQuality()
		local var_10_3 = arg_10_1:getQuality()

		if var_10_2 ~= var_10_3 then
			return var_10_3 < var_10_2
		end

		local var_10_4 = arg_10_0:getStar()
		local var_10_5 = arg_10_1:getStar()

		if var_10_4 ~= var_10_5 then
			return var_10_5 < var_10_4
		end

		return arg_10_0:getAdvanceId() > arg_10_1:getAdvanceId()
	end
end

function CommonLineUpArtifactPop:_onRenderArtifactList(arg_11_1, arg_11_2)
	arg_11_2:updateCell(self._curArtifactList[arg_11_1 + 1], self._cellParam)
end

function CommonLineUpArtifactPop:_onBack()
	if not self._isOnBack then
		self._isOnBack = true

		local var_12_0 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_12_0 then
			var_12_0:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		end
	end
end

function CommonLineUpArtifactPop:_onTabListItemRender(arg_14_1, arg_14_2)
	arg_14_2:setTitle(self._tabQualitys[arg_14_1].name or 0)
end

function CommonLineUpArtifactPop:_onTabListClickItem(arg_15_1)
	local var_15_0 = self.m_tabList:getSelectedIndex()

	if var_15_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_15_0

	self:_updateView()
end

function CommonLineUpArtifactPop:_onArtifactListClickItem(arg_16_1)
	local var_16_0 = self._curArtifactList[arg_16_1:getDataValue() + 1]

	if var_16_0 then
		if self._clickCheckFunc then
			if self._clickCheckFunc(var_16_0) then
				self:_onClickClose()
			end
		else
			self:_onClickClose()
		end
	end
end

function CommonLineUpArtifactPop:_onClickClose(arg_17_1)
	if arg_17_1 then
		if not self.m_bgPanel:containPoint((arg_17_1:getInput():getTouch():getLocation())) then
			self:_onBack()
		end
	else
		self:_onBack()
	end
end

return CommonLineUpArtifactPop
