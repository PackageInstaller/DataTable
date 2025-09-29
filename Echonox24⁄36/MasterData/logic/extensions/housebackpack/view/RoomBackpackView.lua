-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/view/RoomBackpackView.lua

module("logic.extensions.housebackpack.view.RoomBackpackView", package.seeall)

local BackpackShowType = CommEnum.RoomBackpackShowType
local M = class("RoomBackpackView", ViewComponent)
local cfg = {
	[BackpackShowType.FurnitureShowType] = {
		viewUrl = "ui/views/common/tips/furniture_detail_tips.prefab",
		viewClass = RoomBackpackFurnitureFragmentView,
		cellBehaviorClass = RoomBackpackFurnitureItemCell
	},
	[BackpackShowType.DrawingShowType] = {
		viewUrl = "ui/views/common/tips/furniture_detail_tips.prefab",
		viewClass = RoomBackpackDrawingFragmentView,
		cellBehaviorClass = RoomBackpackDrawingItemCell
	},
	[BackpackShowType.BuildMaterialShowType] = {
		viewUrl = "ui/views/common/tips/furniture_detail_tips.prefab",
		viewClass = RoomBackpackBuildFragmentView,
		cellBehaviorClass = BackpackItemCell
	},
	[BackpackShowType.TradeMaterialShowType] = {
		viewUrl = "ui/views/common/tips/furniture_detail_tips.prefab",
		viewClass = RoomBackpackTradeFragmentView,
		cellBehaviorClass = BackpackItemCell
	}
}
local index2ShowType = {
	BackpackShowType.FurnitureShowType,
	BackpackShowType.DrawingShowType,
	BackpackShowType.BuildMaterialShowType,
	BackpackShowType.TradeMaterialShowType
}
local AdjustMax = 2.03
local AdjustMin = 2.12

function M:ctor()
	self._emptyNode = false
	self._hasNode = false
	self._itemCompMap = {}
end

function M:buildUI()
	self:_buildBinderViewList()
	self:_buildRightTabCtrlUI()
	self:_tryAdjustUI()
end

function M:_tryAdjustUI()
	self._needAdjustUI = GridAdaptUtil.isNeedAdjust(AdjustMax, AdjustMin)

	if self._needAdjustUI then
		LoopListUtils.SetGridColumnCountCount(self._itemGridList:GetLoopGridView(), 5)
	end
end

function M:_buildBinderViewList()
	local itemScroll = goutil.findChild(self:getGo("furniture_backpack_view_-144741789"), "scroll")

	self._itemGridList = LoopGridViewHelper.New(itemScroll)

	self._itemGridList:InitGridView(0, self._onCellUpdate, self)

	self._emptyNode = self:getGo("furniture_backpack_view_1213278758")
	self._hasNode = self:getGo("furniture_backpack_view_1117379353")
end

function M:_buildRightTabCtrlUI()
	local adapter = DynamicPagerAdapter.New()

	for index, showType in ipairs(index2ShowType) do
		adapter:registerView(cfg[showType].viewUrl, cfg[showType].viewClass)
	end

	self._viewPager = ViewPager.New(goutil.findChild(self._hasNode, "tipsPos"))

	self._viewPager:setViewPresentor(self._viewPresentor)
	self._viewPager:setAdapter(adapter)

	self._toggleTabControl = ToggleTabControl.New()

	self._toggleTabControl:setViewPager(self._viewPager)
	self._toggleTabControl:addToggleTab(self:getUIComponent("4&right_tab_content_-242000516", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("4&right_tab_content_-1578871314", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("4&right_tab_content_1651451756", UIComponentType.SpaceXToggle))
	self._toggleTabControl:addToggleTab(self:getUIComponent("4&right_tab_content_-1691267181", UIComponentType.SpaceXToggle))
end

function M:bindEvents()
	self._viewPager:setPageChangeCallBack(self._onPageChanged, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self.refreshList, self)
end

function M:unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED, self.refreshList, self)
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)

	self._jumpOut = false

	local lastShowType = RoomBackpackModel.instance:getCurShowType()

	self._toggleTabControl:selectTab(table.indexof(index2ShowType, lastShowType))
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.JUMP_VIEW_EVENT, self.handleJumpViewEvent, self)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Backpack)
	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_CharacterSystem)
	self._viewPager:clear()
end

function M:destroyUI()
	self._guiAnimation = nil

	self._viewPager:destroy()
end

function M:handleJumpViewEvent(e, jumpId)
	if not SystemJumpController.instance:canJump(jumpId) then
		return
	end

	self._jumpOut = true

	ViewMgr.instance:destroy(ViewName.RoomBackpackView, true, true)
end

function M:_onPageChanged(index)
	local showType = index2ShowType[index]

	self._curShowType = showType
	self._curItemCls = cfg[showType].cellBehaviorClass

	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_TO_SWITCH_SHOW_TYPE, showType)
end

function M:refreshList(e)
	self._curShowItems = RoomBackpackModel.instance:getCurShownItems()

	local showItemsCount = #self._curShowItems

	self:_dealHasOrEmpty(showItemsCount <= 0)
	self._itemGridList:SetListItemCount(showItemsCount)
	self._itemGridList:RefreshAllShownItem()
end

function M:_dealHasOrEmpty(isEmpty)
	goutil.setActive(self._emptyNode, isEmpty)
	goutil.setActive(self._hasNode, not isEmpty)
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._itemGridList:NewListViewItem("backpack_item")
	local itemGo = item.gameObject
	local itemGoId = itemGo:GetInstanceID()
	local oldComp = self._itemCompMap[itemGoId]

	if oldComp and oldComp ~= self._curItemCls then
		Astral.LuaComponentContainer.Remove(itemGo, oldComp)
	end

	local view = Astral.LuaComponentContainer.Add(itemGo, self._curItemCls)

	self._itemCompMap[itemGoId] = self._curItemCls

	local mo = self._curShowItems[curIndex]

	view:updateData(mo)
	view:setSelectEvent(EventType.ROOM_BACKPACK_RECYCLE_ITEM_CLICK)

	local isSelected = RoomBackpackModel.instance:isSelected(mo)

	view:onSelect(isSelected)

	return item
end

return M
