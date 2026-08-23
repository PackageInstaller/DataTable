local var_0_0 = g.core.const.ConstMgr.SoundConst
local var_0_1 = g.core.const.ConstMgr.BASE_CONST
local var_0_2 = 5
local CommonLineUpKnightPop = class("CommonLineUpKnightPop", require("app.fairyGUI.infoPop.UI_CommonLineUpKnightPop"), function()
	return fgui.GComponent:create({
		pkgName = "infoPop",
		isFullScreen = true,
		pkgPath = "ui/infoPop/infoPop",
		resName = "CommonLineUpKnightPop"
	}, ...)
end)

function CommonLineUpKnightPop:ctor(arg_2_1)
	self._allList = arg_2_1.allList or {}
	self._clickCheckFunc = arg_2_1.clickCheckFunc
	self._sortFunc = arg_2_1.sortFunc or self:_getDefaultSortFunc()
	self._isLineUpFunc = arg_2_1.isLineUpCall
	self._isFilter = arg_2_1.isFilter
	self._filterStr = arg_2_1.filterStr
	self._itemUrl = arg_2_1.itemUrl
	self._gotoStr = arg_2_1.gotoStr
	self._sound = arg_2_1.sound or var_0_0.Sound.FOG_NIGHTMARE_LINEUP_SLIDE
	self._cellParam = arg_2_1.cellParam
	self._lockGroup = arg_2_1.group or 0
	self._knightList = {}
	self._groupSelectedIndex = 0
	self._isPlayerEnter = false

	self:_initView()
end

function CommonLineUpKnightPop:_initView()
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClickClose))
	self.m_groupList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onGroupListClickItem))
	self.m_cardList:setDefaultItem(self._itemUrl)
	self.m_cardList:setVirtual()
	self.m_cardList:setItemRenderer(handler(self, self._onRendererKnightList))
	self.m_cardList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
	self.m_gotoBtn:addClickListener(handler(self, self._onGoToClick))

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

	if self._gotoStr and self._gotoStr ~= "" then
		self.m_isShowGotoController:setSelectedIndex(1)
		self.m_gotoBtn:setTitle(self._gotoStr)
	end

	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	if var_3_0 then
		self._isPlayerEnter = true

		var_3_0:setHook("listEnter", handler(self, self.updateView))
		var_3_0:play()
	end

	if self._sound and self._sound ~= "" then
		g.core.sound.SoundManager:playSound(self._sound)
	end
end

function CommonLineUpKnightPop:_onFilterChanged(arg_4_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:updateView()
end

function CommonLineUpKnightPop:_onGoToClick()
	self:dispatchCompEvent("common_lineup_knight_pop_goto", {})
	self:_onClickClose()
end

function CommonLineUpKnightPop:_onGroupListClickItem(arg_6_1)
	local var_6_0 = self.m_groupList:getSelectedIndex()

	if var_6_0 == self._groupSelectedIndex then
		return
	end

	self._groupSelectedIndex = var_6_0

	self:updateView()
end

function CommonLineUpKnightPop:_onClickCell(arg_7_1)
	local var_7_0 = self._knightList[arg_7_1:getDataValue() + 1]

	if not var_7_0 or var_0_1.HAS_PUT_CHECK and not var_7_0:isPut() then
		g.core.module.ModuleManager:tip(g.core.lang:get(1159))

		return
	end

	if self._clickCheckFunc then
		if self._clickCheckFunc(var_7_0) then
			self:_onClickClose()
		end
	else
		self:dispatchCompEvent("common_lineup_click_knight", {
			struct = var_7_0
		})
		self:_onClickClose()
	end
end

function CommonLineUpKnightPop:_onRendererKnightList(arg_8_1, arg_8_2)
	arg_8_2:updateCell(self._knightList[arg_8_1 + 1], self._cellParam)
end

function CommonLineUpKnightPop:onLoad()
	self.m_groupList:setNumItems(var_0_2)
	self.m_groupList:setSelectedIndex(self._groupSelectedIndex)
	self.m_runnerBanner:init({
		target = self.m_groupList
	})

	if not self._isPlayerEnter then
		self:updateView()
	end
end

function CommonLineUpKnightPop:updateView()
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in pairs(self._allList) do
		if iter_10_1:isOwn() and (self._groupSelectedIndex == 0 or iter_10_1:getGroup() == self._groupSelectedIndex) then
			if self._isFilter and self._isLineUpFunc then
				if not self._isLineUpFunc(iter_10_1) then
					table.insert(var_10_0, iter_10_1)
				end
			else
				table.insert(var_10_0, iter_10_1)
			end
		end
	end

	table.sort(var_10_0, self._sortFunc)

	self._knightList = var_10_0

	if #var_10_0 == 0 then
		self.m_isEmptyController:setSelectedIndex(1)

		if self._lockGroup ~= 0 then
			if self._groupSelectedIndex == 0 or self._groupSelectedIndex == self._lockGroup then
				self.m_emptyComp:setTitle(g.core.lang:get(500165))
			else
				self.m_emptyComp:setTitle(g.core.lang:get(200046))
			end
		end
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_cardList:setNumItems(#var_10_0)
		self.m_cardList:transitionShowCells("listCrosbandBUiRightIn_cell", 0.03)
	end
end

function CommonLineUpKnightPop:_getDefaultSortFunc()
	return function(arg_12_0, arg_12_1)
		if self._isLineUpFunc then
			local var_12_0 = self._isLineUpFunc(arg_12_0)

			if var_12_0 ~= self._isLineUpFunc(arg_12_1) then
				return var_12_0
			end
		end

		local var_12_1 = arg_12_0:getQuality()
		local var_12_2 = arg_12_1:getQuality()

		if var_12_1 ~= var_12_2 then
			return var_12_2 < var_12_1
		end

		local var_12_3 = arg_12_0:getStarLv()
		local var_12_4 = arg_12_1:getStarLv()

		if var_12_3 ~= var_12_4 then
			return var_12_4 < var_12_3
		end

		return arg_12_0:getBaseId() > arg_12_1:getBaseId()
	end
end

function CommonLineUpKnightPop:_onClickClose(arg_13_1)
	if self._isOnClose then
		return
	end

	if (arg_13_1 or nil) and not self.m_bgImage:containPoint((arg_13_1:getInput():getTouch():getLocation())) then
		self.m_cardList:setTouchable(false)

		self._isOnClose = true

		local var_13_1 = self:getView():getSharedTrans("back", "CommonRightPanelAnim", self.m_content)

		if var_13_1 then
			var_13_1:play(function()
				g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
			end)
		else
			g.core.module.ModuleManager:onlyPopSelfByDisplay(self)
		end
	end
end

function CommonLineUpKnightPop:onUnload()
	self._isPlayerEnter = false
end

return CommonLineUpKnightPop
