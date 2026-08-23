local BagNewPropCfg = require("app.view.module.bagNew.const.BagNewPropCfg")
local var_0_1 = g.core.model.User.treasureData
local BagNewTreasureToolComp = class("BagNewTreasureToolComp", require("app.fairyGUI.bagNew.UI_BagNewTreasureToolComp"))

function BagNewTreasureToolComp:ctor()
	self.m_filterList:setVirtual()
	self.m_filterList:setItemRenderer(handler(self, self._onFilterItemRenderer))
	self.m_filterList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onFilterClick))
	self.m_sortList:setVirtual()
	self.m_sortList:setItemRenderer(handler(self, self._onSortItemRenderer))
	self.m_sortList:addEventListener(fgui.UIEventType.ClickItem, handler(self, self._onSortClick))
	self.m_closeComp:addClickListener(handler(self, self._onCloseClick))
	self.m_allBtn:addClickListener(handler(self, self._onClickFilterAll))
	self.m_defaultBtn:addClickListener(handler(self, self._onClickDefault))
	self.m_scoreBtn:addClickListener(handler(self, self._onClickScore))
end

function BagNewTreasureToolComp:updateWithFilter(arg_2_1)
	self._filterIndex = -1
	self._selFilter = arg_2_1 or BagNewPropCfg.TREASURE_FILTER.DEFAULT

	local var_2_0 = var_0_1:getAllCanSelectName()

	self.m_typeController:setSelectedIndex(0)

	self._filter = var_2_0

	self.m_filterList:setNumItems(#var_2_0)
	self:setVisible(true)
	self.m_selAllController:setSelectedIndex(self._filter.all.id == self._selFilter and 0 or 1)
	self.m_filterList:setSelectedIndex(self._filterIndex)
end

function BagNewTreasureToolComp:_onFilterItemRenderer(arg_3_1, arg_3_2)
	arg_3_2:updateItem(self._filter[arg_3_1 + 1])

	if self._selFilter == self._filter[arg_3_1 + 1].id then
		self._filterIndex = arg_3_1
	end
end

function BagNewTreasureToolComp:_onFilterClick(arg_4_1)
	self:dispatchCompEvent("BagTreasureFilterEvent", self._filter[arg_4_1:getDataValue() + 1])
	self:_onCloseClick()
end

function BagNewTreasureToolComp:updateWithSort(arg_5_1)
	self._selSort = arg_5_1 or BagNewPropCfg.TREASURE_SORT.DEFAULT
	self._sortIndex = -1

	local var_5_0 = var_0_1:getAllSortType()

	self.m_typeController:setSelectedIndex(1)

	self._sort = var_5_0

	self.m_sortList:setNumItems(#var_5_0)
	self:setVisible(true)
	self.m_defaultBtn:setTitle(self._sort.default.name)
	self.m_scoreBtn:setTitle(self._sort.score.name)
	self.m_defaultBtn:setSelected(false)
	self.m_scoreBtn:setSelected(false)

	if self._sort.default.poolType == self._selSort then
		self.m_defaultBtn:setSelected(true)
	elseif self._sort.score.poolType == self._selSort then
		self.m_scoreBtn:setSelected(true)
	end

	self.m_sortList:setSelectedIndex(self._sortIndex)
end

function BagNewTreasureToolComp:_onSortItemRenderer(arg_6_1, arg_6_2)
	arg_6_2:setTitle(self._sort[arg_6_1 + 1].name)

	if self._sort[arg_6_1 + 1].poolType == self._selSort then
		self._sortIndex = arg_6_1
	end
end

function BagNewTreasureToolComp:_onSortClick(arg_7_1)
	self:dispatchCompEvent("BagTreasureSortEvent", self._sort[arg_7_1:getDataValue() + 1])
	self:_onCloseClick()
end

function BagNewTreasureToolComp:_onCloseClick()
	self:setVisible(false)
end

function BagNewTreasureToolComp:_onClickFilterAll()
	self:dispatchCompEvent("BagTreasureFilterEvent", self._filter.all)
	self:_onCloseClick()
end

function BagNewTreasureToolComp:_onClickDefault()
	self:dispatchCompEvent("BagTreasureSortEvent", self._sort.default)
	self:_onCloseClick()
end

function BagNewTreasureToolComp:_onClickScore()
	self:dispatchCompEvent("BagTreasureSortEvent", self._sort.score)
	self:_onCloseClick()
end

return BagNewTreasureToolComp
