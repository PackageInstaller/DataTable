local var_0_0 = g.core.model.User.gveDataMgr
local var_0_1 = g.core.const.ConstMgr.QUALITY_TYPE
local GveLineUpPetPop = class("GveLineUpPetPop", require("app.fairyGUI.gve.UI_GveLineUpPetPop"), function()
	return fgui.GComponent:create({
		resName = "GveLineUpPetPop",
		pkgPath = "ui/gve/gve",
		isFullScreen = true,
		pkgName = "gve"
	})
end)
local var_0_3 = g.core.model.User

function GveLineUpPetPop:ctor()
	self._formationData = var_0_0:getGveFormationData()
	self._qualitySelectedIndex = 0
	self._petList = {}
	self._curPetList = {}
	self._isFilter = true
	self._tabQualitys = var_0_1.TabQuality[var_0_1.NEW_QUALITY_CTRL.PET]

	self:_initView()
end

function GveLineUpPetPop:onLoad()
	local var_3_0 = self:getView():getSharedTrans("enter", "CommonRightPanelAnim", self.m_content)

	var_3_0:setHook("listEnter", handler(self, self._updateView))

	if var_3_0 then
		var_3_0:play(function()
			return
		end)
	end
end

function GveLineUpPetPop:_initView()
	self.m_tabList:setVirtual()
	self.m_tabList:setItemRenderer(handler(self, self._onTabListItemRender))
	self.m_tabList:setNumItems(table.nums(self._tabQualitys))
	self.m_tabList:setSelectedIndex(self._qualitySelectedIndex)
	self.m_petList:setVirtual(self)
	self.m_petList:setItemRendererAsync1(handler(self, self._onRenderPetList))
	self.m_tabList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTabListClickItem))
	self.m_petList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onTokenListClickItem))
	self:addEventListener(fgui.UIEventType.TouchBegin, handler(self, self._onClose))
	self.m_filterBtn:addClickListener(handler(self, self._onFilterChanged))
	self.m_filterBtn:setSelected(self._isFilter)
end

function GveLineUpPetPop:_onFilterChanged(arg_6_1)
	self._isFilter = self.m_filterBtn:isSelected()

	self:_updateView()
end

function GveLineUpPetPop:_updateView()
	self._curPetList = self:_getData()

	if #self._curPetList == 0 then
		self.m_isEmptyController:setSelectedIndex(1)
	else
		self.m_isEmptyController:setSelectedIndex(0)
		self.m_petList:setNumItems(#self._curPetList)
		self.m_petList:transitionShowCells("enter_right", 0.03)
	end
end

function GveLineUpPetPop:_getData()
	local var_8_0 = {}
	local var_8_1 = self._tabQualitys[self._qualitySelectedIndex].quality or 0

	self._petList[var_8_1] = self._petList[var_8_1] or var_8_1 == 0 and var_0_3.petsData:getOwnPetArr() or var_0_3.petsData:getOwnPetArrByFilter(function(arg_9_0)
		return arg_9_0:getQuality() == var_8_1
	end)

	if self._isFilter then
		for iter_8_0, iter_8_1 in pairs(self._petList[var_8_1]) do
			if not self._formationData:checkPetIsLineUp(iter_8_1:getSid()) then
				table.insert(var_8_0, iter_8_1)
			end
		end
	else
		var_8_0 = self._petList[var_8_1]
	end

	table.sort(var_8_0, function(arg_10_0, arg_10_1)
		local var_10_0 = self._formationData:checkPetIsLineUp(arg_10_0:getSid())

		if var_10_0 ~= self._formationData:checkPetIsLineUp(arg_10_1:getSid()) then
			return var_10_0
		end

		local var_10_1 = arg_10_0:getQuality()
		local var_10_2 = arg_10_1:getQuality()

		if var_10_1 ~= var_10_2 then
			return var_10_2 < var_10_1
		end

		local var_10_3 = arg_10_0:getStarNum()
		local var_10_4 = arg_10_1:getStarNum()

		if var_10_3 ~= var_10_4 then
			return var_10_4 < var_10_3
		end

		return arg_10_0:getAdvanceId() > arg_10_1:getAdvanceId()
	end)

	return var_8_0
end

function GveLineUpPetPop:_onRenderPetList(arg_11_1, arg_11_2)
	arg_11_2:updateCellByGvePop({
		petData = self._curPetList[arg_11_1 + 1]
	})
end

function GveLineUpPetPop:_onBack()
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

function GveLineUpPetPop:_onTabListClickItem(arg_14_1)
	local var_14_0 = self.m_tabList:getSelectedIndex()

	if var_14_0 == self._qualitySelectedIndex then
		return
	end

	self._qualitySelectedIndex = var_14_0

	self:_updateView()
end

function GveLineUpPetPop:_onTabListItemRender(arg_15_1, arg_15_2)
	arg_15_2:setTitle(self._tabQualitys[arg_15_1].name or 0)
end

function GveLineUpPetPop:_onTokenListClickItem()
	local var_16_0 = self._curPetList[self.m_petList:getSelectedIndex() + 1]

	if var_16_0 then
		self:dispatchCompEvent("gve_formation_lineup_pet", {
			struct = var_16_0
		})
		self:_onBack()
	end
end

function GveLineUpPetPop:_onClose(arg_17_1)
	if not self.m_bgPanel:containPoint((arg_17_1:getInput():getTouch():getLocation())) then
		self:_onBack()
	end
end

return GveLineUpPetPop
