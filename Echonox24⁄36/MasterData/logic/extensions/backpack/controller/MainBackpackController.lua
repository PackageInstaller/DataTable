-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/backpack/controller/MainBackpackController.lua

module("logic.extensions.backpack.controller.MainBackpackController", package.seeall)

local M = class("MainBackpackController", BaseController)
local BackpackChangedType = CommEnum.MainBackpackRefreshType
local BackpackShowType = CommEnum.MainBackpackShowType

function M:ctor()
	M.super.ctor(self)
end

function M:onInit()
	self:_addEvent()
end

function M:_addEvent()
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.onItemModelChanged, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_TO_SWITCH_SHOW_TYPE, self._onSwitchBackpackShowType, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_FILTER_EVENT, self._dealFilterEvent, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_SORT_ITEM_CLICK, self._onClickSortItem, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_ITEM_CLICK_EVENT, self._onItemClick, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_EQUIP_SUIT_ITEM_CLICK, self._onClickEquipSuitItem, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_ENTER_RECYCLE, self._onEnterRecycle, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_EXIT_RECYCLE, self._onExitRecycle, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_RECYCLE_QUICK_SELECT_CLICK, self._onClickRecycleQuickSelect, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_RECYCLE_ITEM_SUB_CLICK, self._onClickRecycleSub, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_DO_RECYCLE, self._onConfirmRecycle, self)
	GlobalDispatcher:addEventListener(EventType.BACKPACK_PAGE_RECYCLE_REPLY, self._onRecycleReplied, self)
	GlobalDispatcher:addEventListener(EventType.D6_INFO_REFRESH, self.onItemModelChanged, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_INFO_REFRESH, self.onItemModelChanged, self)
end

function M:onItemModelChanged(e)
	if MainBackpackModel.instance:isInRecycling() then
		return
	end

	MainBackpackModel.instance:checkItemChanged()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.ItemModel)
end

function M:_onSwitchBackpackShowType(e, showType)
	MainBackpackModel.instance:setCurShowType(showType)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.SwitchPage)
end

function M:_dealFilterEvent(e)
	MainBackpackModel.instance:refilter()
	MainBackpackModel.instance:resetAutoSelect()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.Filter)
end

function M:_onItemClick(e, itemData, cellGo, cellIndex)
	local reason, isShowTips = MainBackpackModel.instance:setCurSelecedItem(itemData)

	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, reason)

	if isShowTips then
		GlobalDispatcher:dispatchEvent(itemData:getItemMarkType(), itemData, cellGo, cellIndex, true, true, false, true)
	end
end

function M:_onClickSortItem(e, BackpackItemSortData)
	if not BackpackItemSortData then
		printError("排序数据为空，请检查")

		return
	end

	MainBackpackModel.instance:resort(BackpackItemSortData)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.Sort)
end

function M:_onClickEquipSuitItem(e, suitMo, dices)
	MainBackpackModel.instance:onEquipSuitChanged(suitMo, dices)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.Filter)
end

function M:_onClickRecycleQuickSelect(e, selectInfo, isAdd)
	if not selectInfo then
		printError("筛选数据为空，请检查")

		return
	end

	if isAdd then
		MainBackpackModel.instance:addRecycleQuickItems(selectInfo)
	else
		MainBackpackModel.instance:removeRecycleQuickItems(selectInfo)
	end

	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.RecycleChanged)
end

function M:_onClickRecycleSub(e, itemData)
	if not itemData then
		printError("筛选数据为空，请检查")

		return
	end

	MainBackpackModel.instance:subRecycleItem(itemData)
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.RecycleChanged)
end

function M:_onEnterRecycle(e)
	MainBackpackModel.instance:enterRecycle()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.RecycleEnter)
end

function M:_onExitRecycle(e)
	MainBackpackModel.instance:exitRecycle()
	MainBackpackModel.instance:resetAutoSelect()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.RecycleExit)
end

function M:_onConfirmRecycle(e, showType)
	if not showType then
		return
	end

	local curShowType = MainBackpackModel.instance:getCurShowType()

	if curShowType ~= showType then
		printError("背包回收数据和显示类型不一致，请检查")

		return
	end

	if not MainBackpackModel.instance:isInRecycling() then
		printError("当前未处于回收状态，不能进行回收，请检查")

		return
	end

	local uuids = MainBackpackModel.instance:getRecycleUUids()

	if not uuids or #uuids < 1 then
		return
	end

	if curShowType == BackpackShowType.EchoShowType then
		EchoItemAgent.instance:sendDecomposeEchoItemRequest(uuids)
	elseif curShowType == BackpackShowType.EquipShowType then
		EquipmentAgent.instance:sendEquipDecomposeRequest(uuids, BackpackShowType.EquipShowType)
	elseif curShowType == BackpackShowType.D6ShowType then
		EquipmentAgent.instance:sendDiceDecomposeRequest(uuids)
	end
end

function M:_onRecycleReplied(e, showType)
	local curShowType = MainBackpackModel.instance:getCurShowType()

	if curShowType ~= showType then
		printError("背包回收数据和显示类型不一致，请检查")

		return
	end

	if not MainBackpackModel.instance:isInRecycling() then
		printError("当前未处于回收状态，不能进行回收，请检查")

		return
	end

	MainBackpackModel.instance:onRecycleReplied()
	GlobalDispatcher:dispatchEvent(EventType.BACKPACK_PAGE_DATA_CHANGED, BackpackChangedType.RecycleReplied)
end

M.instance = M.New()

return M
