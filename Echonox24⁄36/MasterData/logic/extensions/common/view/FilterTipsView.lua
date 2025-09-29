-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/common/view/FilterTipsView.lua

module("logic.extensions.common.view.FilterTipsView", package.seeall)

local M = class("FilterTipsView", ViewComponent)

function M:buildUI()
	self._btnClose = self:getBtn("4&middle_tips_common_bg_-1205189576")
	self._btnEnsure = self:getBtn("team_filter_tips_1106889858")
	self._btnReset = self:getBtn("team_filter_tips_204764303")
	self._arrayFilterCell = {
		self:getGoByPath("allContent/fiterScroll/ViewPort/Content/sort"),
		self:getGoByPath("allContent/fiterScroll/ViewPort/Content/quality"),
		self:getGoByPath("allContent/fiterScroll/ViewPort/Content/career"),
		self:getGoByPath("allContent/fiterScroll/ViewPort/Content/camp")
	}
	self._arrayFilterTGP = {
		self:getGo("team_filter_tips_-1705430043"),
		self:getGo("team_filter_tips_-1449548662"),
		self:getGo("team_filter_tips_-1685624025"),
		self:getGo("team_filter_tips_-983491001")
	}
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnClose:AddClickListener(self._onClickBtnClose, self)
	self._btnEnsure:AddClickListener(self._onClickBtnEnsure, self)
	self._btnReset:AddClickListener(self._onClickBtnReset, self)
end

function M:unbindEvents()
	self._btnClose:RemoveClickListener()
	self._btnEnsure:RemoveClickListener()
	self._btnReset:RemoveClickListener()
end

function M:onEnter()
	self._paramData = self:getFirstParam() or {}
	self._filterDataList = self._paramData.filterDataList or {}
	self._filterSelectedIdx = {}

	for _, filterData in ipairs(self._filterDataList) do
		local idxs = {}

		if filterData.selectedIdxs and #filterData.selectedIdxs > 0 then
			table.insertto(idxs, filterData.selectedIdxs)
		end

		table.insert(self._filterSelectedIdx, idxs)
	end

	self._filterItemList = {}

	self:initFilterItems()
	self:refreshFilterItems()
end

function M:onExit()
	for _, tgpGO in ipairs(self._arrayFilterTGP) do
		goutil.clearChildren(tgpGO)
	end
end

function M:initFilterItems()
	local function _createItem(rootGO, dataIdx, filterIdx, filterName)
		local itemGO = self:getResInstance(ResName.Common_team_filter_tab)

		goutil.addChildToParent(itemGO, rootGO)

		local filterItem = Astral.LuaComponentContainer.Add(itemGO, FilterTipsItem)

		self._filterItemList[dataIdx][filterIdx] = filterItem

		filterItem:setListIndex(dataIdx)
		filterItem:setFilterIndex(filterIdx)
		filterItem:setClickCallback(self._onClickFilterItem, self)
		filterItem:setName(filterName)
	end

	for i, cell in ipairs(self._arrayFilterCell) do
		local filterData = self._filterDataList[i]

		if filterData then
			goutil.setActive(cell, true)

			self._filterItemList[i] = {}

			local tgpGO = self._arrayFilterTGP[i]
			local txtTitle = goutil.findChildTextComponent(cell, "sign/Text")

			txtTitle.text = filterData.titleName

			_createItem(tgpGO, i, 0, lang("tip_common_all"))

			for idx, filterName in ipairs(filterData.filterTypeNameList) do
				_createItem(tgpGO, i, idx, filterName)
			end
		else
			goutil.setActive(cell, false)
		end
	end
end

function M:refreshFilterItems()
	for i, items in ipairs(self._filterItemList) do
		local idxList = self._filterSelectedIdx[i]
		local isAll = #idxList == 0

		for idx, item in pairs(items) do
			if isAll then
				item:setSelected(idx == 0)
			elseif table.indexof(idxList, idx) then
				item:setSelected(true)
			else
				item:setSelected(false)
			end
		end
	end
end

function M:_onClickBtnClose()
	self:close()
end

function M:_onClickBtnEnsure()
	if self._paramData.ensureCallback then
		self._paramData.ensureCallback(self._paramData.ensureTarget, self._filterSelectedIdx)
	end

	self:close()
end

function M:_onClickBtnReset()
	for _, list in ipairs(self._filterSelectedIdx) do
		table.clear(list)
	end

	self:refreshFilterItems()
end

function M:_onClickFilterItem(listIdx, filterIdx)
	local idxList = self._filterSelectedIdx[listIdx]

	if filterIdx == 0 then
		table.clear(idxList)
	else
		local i = table.indexof(idxList, filterIdx)

		if i then
			table.remove(idxList, i)
		else
			table.insert(idxList, filterIdx)
		end

		local filterData = self._filterDataList[listIdx]

		if #filterData.filterTypeNameList == #idxList then
			table.clear(idxList)
		end
	end

	self:refreshFilterItems()
end

return M
