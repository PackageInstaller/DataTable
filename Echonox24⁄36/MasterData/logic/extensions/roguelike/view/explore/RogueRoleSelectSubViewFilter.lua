-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/roguelike/view/explore/RogueRoleSelectSubViewFilter.lua

module("logic.extensions.roguelike.view.explore.RogueRoleSelectSubViewFilter", package.seeall)

local RogueRoleSortData = class("RogueRoleSortData")

function RogueRoleSortData:ctor(RogueSortType, isUp)
	self.sortType = RogueSortType
	self.isUp = isUp or false
end

function RogueRoleSortData:getName()
	return CommEnum.RogueSortType2Name[self.sortType]
end

local defaultSortType = CommEnum.RogueSortType.Attr
local M = class("RogueRoleSelectSubViewFilter", ViewComponent)

function M:ctor()
	self.super.ctor(self)

	self._isFilterUp = false
end

function M:buildUI()
	self._btnFilter = self:getBtn("3&common_filter_-1115847681")
	self._txtBtnFilter = self:getText("3&common_filter_-250765097")
	self._goUpBtnFilter = self:getGo("3&common_filter_198063371")
	self._goDownBtnFilter = self:getGo("3&common_filter_75483329")
	self._btnSort = self:getBtn("common_filter_-1115847681")
	self._sortText = self:getText("common_filter_-250765097")
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "content/up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "content/down")
	self._sortItems = {}
	self._sortItemTemp = goutil.findChild(self._sortItemsParent, "Content/Item1")

	goutil.setActive(self._sortItemTemp, false)

	local itemsParent = goutil.findChild(self._sortItemsParent, "Content")

	self._filterRoot = self:getGo("3&common_filter_-55329758")
	self._filterCanvasGroup = self._filterRoot:GetComponent(ComponentType.CanvasGroup)
	self._btnMask = Astral.ButtonAdapter.Get(goutil.findChild(self._filterRoot, "click"))

	goutil.setActive(self._btnMask.gameObject, false)

	for i = 1, 2 do
		local sortItem = goutil.clone(self._sortItemTemp)

		goutil.setActive(sortItem, true)
		goutil.addChildToParent(sortItem, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItemNew)

		itemView:setData(RogueRoleSortData.New(i, false))
		itemView:setEvent(EventType.ROGUE_FILTER_SELECT_ROLE)
		table.insert(self._sortItems, itemView)

		if i == defaultSortType then
			itemView:setSelect(true)

			self._sortData = itemView:getData()
		else
			itemView:setSelect(false)
		end
	end

	goutil.setActive(self._sortItemsParent, false)
end

function M:bindEvents()
	self._btnSort:AddClickListener(self._onClickSortBtn, self)
	self._btnMask:AddClickListener(self._onClickMaskBtn, self)
end

function M:unbindEvents()
	self._btnSort:RemoveClickListener()
	self._btnMask:RemoveClickListener()
end

function M:onEnter()
	self:setEvent(true)
	self:updateFilterState()
	self:_refreshSort()
end

function M:onExit()
	self:setEvent(false)
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ROGUE_FILTER_SELECT_ROLE, self._onSelectRoleFilter, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ROGUE_FILTER_SELECT_ROLE, self._onSelectRoleFilter, self)
	end
end

function M:_onSelectRoleFilter(sender, sortData)
	if not sortData then
		printError("排序数据为空，请检查")

		return
	end

	self._sortData = sortData

	self:_refreshSort()
end

function M:_refreshSort()
	self._sortText.text = self._sortData:getName()

	local isUp = self._sortData.isUp

	goutil.setActive(self._sortUpGo, isUp)
	goutil.setActive(self._sortDownGo, not isUp)

	for index, item in ipairs(self._sortItems) do
		item:setSelect(index == self._sortData.sortType)
	end
end

function M:onClickFilter()
	self._isFilterUp = not self._isFilterUp

	self:updateFilterState()
	GlobalDispatcher:dispatchEvent(EventType.ROGUE_FILTER_SELECT_ROLE, self._isFilterUp)
end

function M:updateFilterState()
	goutil.setActive(self._goUpBtnFilter, self._isFilterUp)
	goutil.setActive(self._goDownBtnFilter, not self._isFilterUp)
end

function M:_onClickSortBtn()
	local active = not self._sortItemsParent.activeSelf

	goutil.setActive(self._sortItemsParent, active)
	goutil.setActive(self._btnMask.gameObject, active)
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._sortItemsParent, false)
end

return M
