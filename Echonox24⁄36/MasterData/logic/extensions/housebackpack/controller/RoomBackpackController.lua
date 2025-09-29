-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/housebackpack/controller/RoomBackpackController.lua

module("logic.extensions.housebackpack.controller.RoomBackpackController", package.seeall)

local M = class("RoomBackpackController", BaseController)

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:_addEvent()
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchBackpackShowType, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.onItemModelChanged, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_RECYCLE_ITEM_CLICK, self._onItemClick, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_RECYCLE_ITEM_SUB_CLICK, self._onClickRecycleSub, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_FILTER_EVENT, self._dealFilterEvent, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_ENTER_RECYCLE, self._entryRecycle, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_EXIT_RECYCLE, self._exitRecycle, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_SORT_TYPE, self._sortTypeChanged, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_FURNITURE_SUBTYPE_FILTER, self._furnitureSubTypeFilter, self)
	GlobalDispatcher:addEventListener(EventType.ROOM_BACKPACK_FURNITURE_SUIT_FILTER, self._furnitureSuitFilter, self)
end

function M:onItemModelChanged(e)
	RoomBackpackModel.instance:checkItemChanged()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_onSwitchBackpackShowType(e, showType)
	RoomBackpackModel.instance:setCurShowType(showType)
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_onItemClick(e, itemData)
	RoomBackpackModel.instance:setCurSelecedItem(itemData)
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_onClickRecycleSub(e, itemUuid, itemData)
	if not itemUuid then
		printError("筛选数据为空，请检查")

		return
	end

	RoomBackpackModel.instance:subRecycleItem(itemUuid, itemData)
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_dealFilterEvent(e, showType)
	if showType and showType == RoomBackpackModel.instance:getCurShowType() then
		RoomBackpackModel.instance:refilter()
		GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
	end
end

function M:_entryRecycle()
	if RoomBackpackModel.instance:enterRecycle() then
		GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
	end
end

function M:_exitRecycle()
	RoomBackpackModel.instance:exitRecycle()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:HandleRecycleReply()
	RoomBackpackModel.instance:clearRecycleItems()
	RoomBackpackModel.instance:trySelecedFirstItem()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_sortTypeChanged(e, sortType, acending)
	RoomBackpackModel.instance:setCurSortType(sortType, acending)
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_furnitureSubTypeFilter(e, subTypeList)
	RoomBackpackModel.instance:setFurnitureSubTypeFilterList(subTypeList)
	RoomBackpackModel.instance:refilter()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

function M:_furnitureSuitFilter(e, themeList)
	RoomBackpackModel.instance:setFurnitureSuitFilterList(themeList)
	RoomBackpackModel.instance:refilter()
	GlobalDispatcher:dispatchEvent(EventType.ROOM_BACKPACK_PAGE_DATA_CHANGED)
end

M.instance = M.New()

return M
