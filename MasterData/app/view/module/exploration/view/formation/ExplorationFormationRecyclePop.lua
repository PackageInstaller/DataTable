local var_0_0 = g.core.event.enum
local var_0_1 = g.core.event.EventManager
local var_0_2 = g.core.network.GameNetProxy
local var_0_3 = g.core.model.User.explorationData
local var_0_4 = g.core.const.ConstMgr.ExplorationConst
local var_0_5 = g.core.common.Goods
local ExplorationFormationRecyclePop = class("ExplorationFormationRecyclePop", require("app.fairyGUI.exploration.UI_ExplorationFormationRecyclePop"), function()
	return fgui.GComponent:create({
		resName = "ExplorationFormationRecyclePop",
		pkgPath = "ui/exploration/exploration",
		pkgName = "exploration"
	}, ...)
end)

function ExplorationFormationRecyclePop:ctor()
	self:showAtCenter()

	self._tabSel = var_0_4.BAG_TYPE.KNIGHT
	self._formationData = var_0_3:getFormationData()
	self._sellValue = 0
	self._sellList = {}
	self._selectedList = {}
	self._sellCfgDict = {}

	self.m_sellList:setVirtual()
	self.m_sellList:setItemRenderer(handler(self, self._onRenderSellList))
	self.m_sellList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onClickCell))
	self.m_tabSelController:addEventListener(fgui.UIEventType.Changed, handler(self, self._onTabSelChanged))
	self.m_selectAllBtn:addEventListener(fgui.UIEventType.Changed, handler(self, self._onClickSelectAllBtn))
	self.m_recycleBtn:addClickListener(handler(self, self._onClickRecycleBtn))
	var_0_3:recycleLineUpKnightHasChecked()
end

function ExplorationFormationRecyclePop:_updateView()
	if self._tabSel == var_0_4.BAG_TYPE.KNIGHT then
		self._sellList = self._formationData:getWithinKnightListByFilter(handler(self, self._filterIsUsing))
		self._selectedList = {}

		self:sortList()
		self.m_emptyLabel:setTitle(g.core.lang:get(420663))
	end

	local var_3_0 = #self._sellList

	self.m_sellList:setNumItems(#self._sellList)
	self.m_isEmptyController:setSelectedIndex(var_3_0 == 0 and 1 or 0)
	self.m_valueComp:updateByTVS({
		type = var_0_5.TYPE_RESOURCE,
		value = var_0_5.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
		size = self._sellValue
	})
	self.m_ownComp:updateByTVS({
		type = var_0_5.TYPE_RESOURCE,
		value = var_0_5.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
		size = g.core.model.User.resourceData:getResourceById(var_0_5.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE)
	})
end

function ExplorationFormationRecyclePop:_filterIsUsing(arg_4_1)
	local var_4_0 = arg_4_1:getServerId()

	return self._formationData:isWithinKnight(var_4_0) and not self._formationData:isUsingKnight(var_4_0) and not self._formationData:isOtherUserKnight(var_4_0)
end

function ExplorationFormationRecyclePop:_onRenderSellList(arg_5_1, arg_5_2)
	arg_5_2:updateCell(self._sellList[arg_5_1 + 1], var_0_4.EMBRYO_TYPE[self._tabSel])
	arg_5_2:setSelected(checkbool(self._selectedList[arg_5_1 + 1]))
end

function ExplorationFormationRecyclePop:_onTabSelChanged()
	self._tabSel = self.m_tabSelController:getSelectedIndex()
end

function ExplorationFormationRecyclePop:_onClickSelectAllBtn()
	local var_7_0 = self.m_selectAllBtn:isSelected()

	for iter_7_0 = 1, self.m_sellList:numChildren() do
		self.m_sellList:getChildAt(iter_7_0 - 1):setSelected(var_7_0)
	end

	self._selectedList = {}
	self._sellValue = 0

	for iter_7_1, iter_7_2 in ipairs(self._sellList) do
		self._selectedList[iter_7_1] = var_7_0

		if var_7_0 then
			self._sellValue = self._sellValue + self._formationData:getEmbryoCfg(var_0_4.EMBRYO_TYPE[self._tabSel], iter_7_2:getQuality(), (self:getStarNum(iter_7_2, var_0_4.EMBRYO_TYPE[self._tabSel]))).sell_price
		end
	end

	self.m_valueComp:updateByTVS({
		type = var_0_5.TYPE_RESOURCE,
		value = var_0_5.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
		size = self._sellValue
	})
end

function ExplorationFormationRecyclePop:_onClickRecycleBtn()
	local var_8_0 = {}

	for iter_8_0, iter_8_1 in pairs(self._selectedList) do
		if iter_8_1 then
			table.insert(var_8_0, self._sellList[iter_8_0]:getServerId())
		end
	end

	if #var_8_0 > 0 then
		var_0_2:send_C2S_Exploration_Sell({
			unique_id = var_8_0,
			tp = var_0_4.EMBRYO_TYPE[self._tabSel]
		})
	else
		g.core.module.ModuleManager:tip(g.core.lang:get(420685))
	end
end

function ExplorationFormationRecyclePop:_onClickCell(arg_9_1)
	local var_9_0 = arg_9_1:getDataValue()
	local var_9_1 = not checkbool(self._selectedList[var_9_0 + 1])

	self._selectedList[var_9_0 + 1] = var_9_1

	self:_checkIsAllSelect()

	local var_9_2 = self._formationData:getEmbryoCfg(var_0_4.EMBRYO_TYPE[self._tabSel], self._sellList[var_9_0 + 1]:getQuality(), (self:getStarNum(self._sellList[var_9_0 + 1], var_0_4.EMBRYO_TYPE[self._tabSel])))

	self._sellValue = var_9_1 and self._sellValue + var_9_2.sell_price or self._sellValue - var_9_2.sell_price

	self.m_valueComp:updateByTVS({
		type = var_0_5.TYPE_RESOURCE,
		value = var_0_5.RESOURCE.TYPE_EXPLORATION_COMMON_RESOURCE,
		size = self._sellValue
	})
end

function ExplorationFormationRecyclePop:_checkIsAllSelect()
	local var_10_0 = 0

	for iter_10_0, iter_10_1 in pairs(self._selectedList) do
		if iter_10_1 then
			var_10_0 = var_10_0 + 1
		end
	end

	self.m_selectAllBtn:setSelected(var_10_0 == #self._sellList)
end

function ExplorationFormationRecyclePop:_onS2CSell(arg_11_1, arg_11_2, arg_11_3)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_3.awards or {}) do
		if not var_11_0[1] then
			var_11_0[1] = iter_11_1
		else
			var_11_0[1].size = var_11_0[1].size + iter_11_1.size
		end
	end

	g.core.module.ModuleManager:awardSummary(var_11_0)

	self._sellValue = 0

	self:_updateView()
end

function ExplorationFormationRecyclePop:getStarNum(arg_12_1, arg_12_2)
	if arg_12_2 == var_0_5.TYPE_KNIGHT then
		return arg_12_1:getStarLv()
	elseif arg_12_2 == var_0_5.TYPE_ARTIFACT then
		return arg_12_1:getStar()
	elseif arg_12_2 == var_0_5.TYPE_UNITETOKEN then
		return arg_12_1:getStarLevel()
	elseif arg_12_2 == var_0_5.TYPE_PET then
		return arg_12_1:getStarNum()
	end

	return 0
end

function ExplorationFormationRecyclePop:onLoad()
	var_0_1:addEventListener(var_0_0.EVENT_NET_S2C_EXPLORATION_SELL, self._onS2CSell, self)
	self:_updateView()
end

function ExplorationFormationRecyclePop:sortList()
	table.sort(self._sellList, function(arg_15_0, arg_15_1)
		local var_15_0 = arg_15_0:getQuality()
		local var_15_1 = arg_15_1:getQuality()

		if var_15_0 ~= var_15_1 then
			return var_15_0 < var_15_1
		end

		local var_15_2 = arg_15_0:getStarLv()
		local var_15_3 = arg_15_1:getStarLv()

		if var_15_2 ~= var_15_3 then
			return var_15_2 < var_15_3
		end

		return arg_15_0:getAdvanceId() < arg_15_1:getAdvanceId()
	end)
end

return ExplorationFormationRecyclePop
