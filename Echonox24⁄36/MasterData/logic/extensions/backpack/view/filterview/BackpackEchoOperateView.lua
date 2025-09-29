-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/view/filterview/BackpackEchoOperateView.lua

module("logic.extensions.backpack.view.filterview.BackpackEchoOperateView", package.seeall)

local M = class("BackpackEchoOperateView", ViewComponent)
local dropDown2type = {
	CommEnum.CareerFilterType.All,
	CommEnum.CareerFilterType.Sentinel,
	CommEnum.CareerFilterType.Assault,
	CommEnum.CareerFilterType.Sniper,
	CommEnum.CareerFilterType.Super,
	CommEnum.CareerFilterType.Heavy,
	CommEnum.CareerFilterType.Cure,
	CommEnum.CareerFilterType.Puzzle
}
local index2SortType = {
	CommEnum.MainBackpackSortType.Quality,
	CommEnum.MainBackpackSortType.Time
}
local defaultSortType = CommEnum.MainBackpackSortType.Quality
local EchoShowType = CommEnum.MainBackpackShowType.EchoShowType

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._rootGo = self:getGo("backpack_view_copy_-1774642231")
	self._dropDown = self:getUIComponent("backpack_view_copy_329668700", UIComponentType.SpaceXDropDown)
	self._dropMaskBtn = Astral.ButtonAdapter.GetFrom(self._dropDown.gameObject, "DropMaskButton")
	self._goUpFilterCareer = self:getGo("backpack_view_copy_-1421323176")
	self._goDownFilterCareer = self:getGo("backpack_view_copy_-2093014218")

	goutil.setActive(self._dropMaskBtn.gameObject, false)

	self._btnSort = self:getBtn("backpack_view_copy_-1185146591")
	self._sortText = self:getText("backpack_view_copy_-1603630422")
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "down")
	self._sortItems = {}

	for i = 1, 2 do
		local sortItem = goutil.findChild(self._sortItemsParent, "Content/Item" .. i)
		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItem)
		local sortType = index2SortType[i]

		itemView:setData(BackpackItemSortData.New(sortType, false))
		itemView:setEvent(EventType.BACKPACK_SORT_ITEM_CLICK)
		itemView:setSelect(sortType == defaultSortType)
		table.insert(self._sortItems, itemView)
	end

	self._btnMask = self:getBtn("backpack_view_copy_-861743299")

	goutil.setActive(self._btnMask.gameObject, false)
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnSort:AddClickListener(self._onClickSortBtn, self)
	self._dropDown:AddOnValueChange(self._onDropDownChanged, self)
	self._dropDown:AddOnDropDownListShow(self._onDropDownCareerShow, self)
	self._dropMaskBtn:AddClickListener(self._onClickMaskBtn, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:unbindEvents()
	self._btnSort:RemoveClickListener()
	self._dropDown:RemoveAllListener()
	self._dropMaskBtn:RemoveClickListener()
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_PAGE_DATA_CHANGED, self._onBackpackPageDataChanged, self)
	GlobalDispatcher:removeEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchShowType, self)
end

function M:onEnter()
	self._curCareerId = CommEnum.CommonAll
	self._curSort = nil

	goutil.setActive(self._sortItemsParent, false)
	goutil.setActive(self._sortUpGo, false)
	goutil.setActive(self._sortDownGo, true)
	self:_refreshSort()
end

function M:onExit()
	return
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._dropMaskBtn.gameObject, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onClickSortBtn()
	local active = not self._sortItemsParent.activeSelf

	goutil.setActive(self._sortItemsParent, active)
	goutil.setActive(self._btnMask.gameObject, active)
	goutil.setActive(self._dropMaskBtn.gameObject, active)
end

function M:_onDropDownCareerShow(show)
	if show then
		goutil.setActive(self._goUpFilterCareer, false)
		goutil.setActive(self._goDownFilterCareer, true)
	else
		goutil.setActive(self._goUpFilterCareer, true)
		goutil.setActive(self._goDownFilterCareer, false)
	end
end

function M:_onClickRecycleBtn()
	goutil.setActive(self._sortItemsParent, false)
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._dropMaskBtn.gameObject, false)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_ENTER_RECYCLE)
end

function M:_onSwitchShowType(e, showType)
	local isShow = showType == EchoShowType

	goutil.setActive(self._rootGo, isShow)

	if isShow then
		self._btnMask:RemoveClickListener()
		self._btnMask:AddClickListener(self._onClickMaskBtn, self)
		goutil.setActive(self._dropMaskBtn.gameObject, false)
	end
end

function M:_onBackpackPageDataChanged(e, changeType)
	local curShowType = MainBackpackModel.instance:getCurShowType()
	local isShowEcho = curShowType == EchoShowType and not MainBackpackModel.instance:isEmpty()

	goutil.setActive(self._rootGo, isShowEcho)

	if isShowEcho and changeType == CommEnum.MainBackpackRefreshType.Sort then
		self:_refreshSort()
	end
end

function M:_onDropDownChanged(index)
	local filter = MainBackpackModel.instance:getCurFilterCfg()

	if filter then
		local carrer = dropDown2type[index + 1]

		if carrer ~= CommEnum.CareerFilterType.All then
			carrer = MultipleEnumUtil.getOneMultipleValue(carrer)
		end

		filter:setCareerFilterType(carrer)
		GlobalDispatcher:dispatchEvent(EventType.BACKPACK_FILTER_EVENT)
	end
end

function M:_refreshCapacity()
	local has = #MainBackpackModel.instance:getCurShownItems()
end

function M:_refreshSort()
	local BackpackItemSortData = MainBackpackModel.instance:getCurSortData()

	if BackpackItemSortData then
		self._sortText.text = BackpackItemSortData:getName()

		local isUp = BackpackItemSortData.isUp

		goutil.setActive(self._sortUpGo, isUp)
		goutil.setActive(self._sortDownGo, not isUp)

		for index, item in ipairs(self._sortItems) do
			item:setSelect(index2SortType[index] == BackpackItemSortData.sortType)
		end
	else
		goutil.setActive(self._sortUpGo, false)
		goutil.setActive(self._sortDownGo, true)

		for i, itemView in ipairs(self._sortItems) do
			local sortData = itemView:getData()

			sortData.isUp = false

			itemView:setSelect(sortData.sortType == defaultSortType)
			itemView:showUp(false)
		end
	end
end

return M
