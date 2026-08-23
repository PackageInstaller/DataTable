local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local GveLineUpUniteTokenPop = class("GveLineUpUniteTokenPop", require("app.fairyGUI.gve.UI_GveLineUpUniteTokenPop"), function()
	return fgui.GComponent:create({
		pkgPath = "ui/gve/gve",
		resName = "GveLineUpUniteTokenPop",
		pkgName = "gve",
		isFullScreen = true
	})
end)
local var_0_3 = g.core.model.User

function GveLineUpUniteTokenPop:ctor()
	self._formationData = var_0_0:getGveFormationData()
	self._qualitySelectedIndex = 0
	self._tokenList = {}
	self._curTokenList = {}
	self._isFilter = false
	self._tabQualitys = var_0_1.TabQuality[var_0_1.NEW_QUALITY_CTRL.UNITETOKEN]

	self:_initView()
end

function GveLineUpUniteTokenPop:onLoad()
	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_3_0:setHook("listEnter", handler(self, self._updateView))

	if var_3_0 then
		var_3_0:play(function()
			return
		end)
	end
end

function GveLineUpUniteTokenPop:_initView()
	self.m_tabList:setVirtual(self)
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_tokenList:setVirtual(self)
	self.m_tokenList:setItemRendererAsync1(handler(self, self._onRenderTokenList))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_tokenList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTokenListClickItem))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClose))
	self.m_filterBtn:addClickListener(handler(self, self._onFilterChanged))
	self.m_filterBtn:setSelected(self._isFilter)
end

function GveLineUpUniteTokenPop:_onFilterChanged(arg_6_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:_updateView()
end

function GveLineUpUniteTokenPop:_updateView()
	self._curTokenList = self:_getData()

	if #self._curTokenList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_tokenList:setNumItems(#self._curTokenList)
		self.m_tokenList:transitionShowCells("enter_right", 0.03)
	end
end

function GveLineUpUniteTokenPop:_getData()
	local var_8_0 = {}
	local var_8_1 = self._tabQualitys[self._qualitySelectedIndex].quality or 0

	self._tokenList[var_8_1] = self._tokenList[var_8_1] or var_0_3.uniteTokenData:getTokenListByQuality(var_8_1)

	if self._isFilter then
		for iter_8_0, iter_8_1 in pairs(self._tokenList[var_8_1]) do
			if not self._formationData:checkUniteIsLineUp(iter_8_1:getAdvanceId()) then
				table.insert(var_8_0, iter_8_1)
			end
		end
	else
		var_8_0 = self._tokenList[var_8_1]
	end

	table.sort(var_8_0, function(arg_9_0, arg_9_1)
		local var_9_0 = self._formationData:checkUniteIsLineUp(arg_9_0:getAdvanceId())

		if var_9_0 ~= self._formationData:checkUniteIsLineUp(arg_9_1:getAdvanceId()) then
			return var_9_0
		end

		local var_9_1 = arg_9_0:getQuality()
		local var_9_2 = arg_9_1:getQuality()

		if var_9_1 ~= var_9_2 then
			return var_9_2 < var_9_1
		end

		return arg_9_0:getBaseId() > arg_9_1:getBaseId()
	end)

	return var_8_0
end

function GveLineUpUniteTokenPop:_onRenderTokenList(arg_10_1, arg_10_2)
	arg_10_2:updateCell(self._curTokenList[arg_10_1 + 1], nil)
end

function GveLineUpUniteTokenPop:_onBack()
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

function GveLineUpUniteTokenPop:_onTabListClickItem(arg_13_1)
	local var_13_0 = self.m_tabList:getSelectedIndex()

	if var_13_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_13_0

	self:_updateView()
end

function GveLineUpUniteTokenPop:_onTabListItemRender(arg_14_1, arg_14_2)
	arg_14_2:setTitle(self._tabQualitys[arg_14_1].name or 0)
end

function GveLineUpUniteTokenPop:_onTokenListClickItem()
	local var_15_0 = self._curTokenList[self.m_tokenList:getSelectedIndex() + 1]

	if var_15_0 and var_15_0:getAdvanceId() > 0 then
		self:dispatchCompEvent("gve_formation_lineup_unite", {
			struct = var_15_0
		})
		self:_onBack()
	end
end

function GveLineUpUniteTokenPop:_onClose(arg_16_1)
	if not self.m_bgPanel:containPoint((arg_16_1:getInput():getTouch():getLocation())) then
		self:_onBack()
	end
end

return GveLineUpUniteTokenPop
