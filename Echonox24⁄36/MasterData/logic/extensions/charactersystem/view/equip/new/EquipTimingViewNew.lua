-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/charactersystem/view/equip/new/EquipTimingViewNew.lua

module("logic.extensions.charactersystem.view.equip.new.EquipTimingViewNew", package.seeall)

local M = class("EquipTimingViewNew", ViewComponent)
local index2SortType = {
	CommEnum.MainBackpackSortType.Quality,
	CommEnum.MainBackpackSortType.Time
}
local defaultSortType = CommEnum.MainBackpackSortType.Quality
local defaultSortFun = BackpackUtil.QaDownSort

function M:buildUI()
	local attributePanelGo = self:getGo("2&attriubte_d6_right_tips_copy_-1908349022")

	self._attrPanelView = Astral.LuaComponentContainer.Add(attributePanelGo, D6AttrTimingComponentNew)
	self._goEmpty = self:getGo("equip_function_view_copy_796131512")
	self._diceScroll = LoopGridViewHelper.New(self:getGo("equip_function_view_copy_1450231555"))

	self._diceScroll:InitGridView(0, self._onCellUpdate, self)

	self._btnEmptyClick = Astral.ButtonAdapter.Get(goutil.findChild(self._goEmpty, "empty_unit/btnGain"))
	self._filterBtnParent = self:getGo("6&common_filter_-55329758")
	self._filterCanvasGroup = self._filterBtnParent:GetComponent(ComponentType.CanvasGroup)
	self._btnFilter = self:getBtn("6&common_filter_1742265756")

	local filterGo = goutil.findChild(self.mainGO, "d6_filter_tips")

	self._d6FilterComp = Astral.LuaComponentContainer.Add(filterGo, D6FilterComponent)

	self._d6FilterComp:OnBuildUI()
	self._d6FilterComp:setEvent(EventType.EQUIP_TIMING_FILTER_EVENT)
	self._d6FilterComp:setVisible(false)

	self._btnMask = self:getBtn("6&common_filter_-2087941579")

	goutil.setActive(self._btnMask.gameObject, false)

	self._btnSort = self:getBtn("common_filter_-1115847681")
	self._sortText = self:getText("common_filter_-250765097")
	self._sortItemsParent = goutil.findChild(self._btnSort.gameObject, "Template")
	self._sortUpGo = goutil.findChild(self._btnSort.gameObject, "content/up")
	self._sortDownGo = goutil.findChild(self._btnSort.gameObject, "content/down")
	self._sortItems = {}
	self._sortItemTemp = goutil.findChild(self._sortItemsParent, "Content/Item1")

	goutil.setActive(self._sortItemTemp, false)

	local itemsParent = goutil.findChild(self._sortItemsParent, "Content")

	for i = 1, 2 do
		local sortItem = goutil.clone(self._sortItemTemp)

		goutil.setActive(sortItem, true)
		goutil.addChildToParent(sortItem, itemsParent)

		local itemView = Astral.LuaComponentContainer.Add(sortItem, BackpackSortItemNew)
		local sortType = index2SortType[i]
		local itemData = BackpackItemSortData.New(sortType)

		itemView:setData(itemData)
		itemView:setEvent(EventType.EQUIP_TIMING_SORT_ITEM_CLICK)
		table.insert(self._sortItems, itemView)

		if sortType == defaultSortType then
			itemView:setSelect(true)

			self._sortData = itemData
		else
			itemView:setSelect(false)
		end
	end

	self._timingContent = self:getGo("equip_function_view_copy_687383730")

	goutil.setActive(self._sortItemsParent, false)
	goutil.setActive(self._timingContent, false)
end

function M:destroyUI()
	self._d6FilterComp:OnDestroy()
	self._attrPanelView:OnDestroy()

	self._moList = nil
	self._curTimingSelectD6 = nil
end

function M:bindEvents()
	self._btnFilter:AddClickListener(self._onClickFilterBtn, self)
	self._btnSort:AddClickListener(self._onClickSortBtn, self)
	self._btnMask:AddClickListener(self._onClickMaskBtn, self)
	self._btnEmptyClick:AddClickListener(self._onClickEmpty, self)
	self._attrPanelView:bindEvents()
end

function M:unbindEvents()
	self._btnFilter:RemoveClickListener()
	self._btnSort:RemoveClickListener()
	self._btnMask:RemoveClickListener()
	self._attrPanelView:unbindEvents()
	self._btnEmptyClick:RemoveClickListener()
end

function M:onEnter()
	GlobalDispatcher:addEventListener(EventType.EQUIP_TIMING_D6_SELECTED, self._onD6Selected, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_TIMING_RESULT, self._showEquipTimingResultView, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_TIMING_SORT_ITEM_CLICK, self._onClickSortItem, self)
	GlobalDispatcher:addEventListener(EventType.EQUIP_TIMING_FILTER_EVENT, self._onFiltered, self)
	GlobalDispatcher:addEventListener(EventType.D6_INFO_REFRESH, self.onD6Changed, self)
	GlobalDispatcher:addEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.onD6Changed, self)
end

function M:onHide()
	return
end

function M:onShow()
	self._moList = EquipIntensifyModel.instance:getAllTimingD6Item()
	self._sortFun = BackpackUtil.getSortFun(self._sortData)

	table.sort(self._moList, self._sortFun)
	self:_setAutoSelectItem()
	self:_refreshList()
	self:_refreshSort()

	local filterCfg = EquipIntensifyModel.instance:getFilterCfg()

	self._d6FilterComp:setData(filterCfg)
	self._attrPanelView:setData(self._curTimingSelectD6)
end

function M:onExit()
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TIMING_D6_SELECTED, self._onD6Selected, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TIMING_RESULT, self._showEquipTimingResultView, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TIMING_SORT_ITEM_CLICK, self._onClickSortItem, self)
	GlobalDispatcher:removeEventListener(EventType.EQUIP_TIMING_FILTER_EVENT, self._onFiltered, self)
	GlobalDispatcher:removeEventListener(EventType.D6_INFO_REFRESH, self.onD6Changed, self)
	GlobalDispatcher:removeEventListener(EventType.ITEM_MODEL_CHANGED_ANY, self.onD6Changed, self)
end

function M:_onClickEmpty()
	local jumpId = 12000001

	if not SystemJumpController.instance:canJump(jumpId, true) then
		return
	end

	EquipIntensifyModel.instance:setJumpToD6()
	GlobalDispatcher:dispatchEvent(EventType.JUMP_VIEW_EVENT, jumpId)
end

function M:_onClickSortBtn()
	local active = not self._sortItemsParent.activeSelf

	goutil.setActive(self._sortItemsParent, active)
	goutil.setActive(self._btnMask.gameObject, active)
end

function M:_onClickFilterBtn()
	if self._sortItemsParent.activeSelf then
		goutil.setActive(self._sortItemsParent, false)
		goutil.setActive(self._btnMask.gameObject, false)

		return
	end

	self._d6FilterComp:setVisible(true)
end

function M:_onClickMaskBtn()
	goutil.setActive(self._btnMask.gameObject, false)
	goutil.setActive(self._sortItemsParent, false)
end

function M:_onClickClearBtn()
	goutil.setActive(self._btnClearFilter.gameObject, false)
	EquipIntensifyModel.instance:clearTimingFilter()

	self._moList = EquipIntensifyModel.instance:getAllTimingD6Item()

	table.sort(self._moList, self._sortFun or defaultSortFun)
	self:_refreshList()
end

function M:_onClickSortItem(e, BackpackItemSortData)
	if not BackpackItemSortData then
		printError("排序数据为空，请检查")

		return
	end

	self._sortData = BackpackItemSortData
	self._sortFun = BackpackUtil.getSortFun(BackpackItemSortData)

	table.sort(self._moList, self._sortFun)
	self:_refreshSort()
	self._diceScroll:RefreshAllShownItem()
end

function M:_onFiltered(e, isReset)
	self._moList = EquipIntensifyModel.instance:getAllTimingD6Item()

	self:_setAutoSelectItem()
	self:_refreshList()
	self._attrPanelView:setData(self._curTimingSelectD6)
end

function M:_onD6Selected(e, d6Item)
	self._curTimingSelectD6 = d6Item

	self._attrPanelView:setData(d6Item)
	self._diceScroll:RefreshAllShownItem()
end

function M:onD6Changed(e)
	if self._viewPresentor:inUIStatus(EquipEnum.MainUIStatus.Timing) then
		self._attrPanelView:refreshLockAndDiscard()
		self._diceScroll:RefreshAllShownItem()
	end
end

function M:_showEquipTimingResultView()
	local equipMo = EquipIntensifyModel.instance:getOperatingEquip()
	local holeIndex = EquipIntensifyModel.instance:getTimingHoleIndex()
	local fixedD6Mo = equipMo:getFixedD6ByHoleIndex(holeIndex)

	ViewMgr.instance:open(ViewName.EquipTimingAnimation, fixedD6Mo)
end

function M:_refreshList()
	self._diceScroll:SetListItemCount(#self._moList)
	self._diceScroll:RefreshAllShownItem()

	local isEmpty = #self._moList == 0

	goutil.setActive(self._goEmpty, isEmpty)

	self._filterCanvasGroup.alpha = isEmpty and 0.2 or 1
end

function M:_refreshSort()
	self._sortText.text = self._sortData:getName()

	local isUp = self._sortData.isUp

	goutil.setActive(self._sortUpGo, isUp)
	goutil.setActive(self._sortDownGo, not isUp)

	for index, item in ipairs(self._sortItems) do
		item:setSelect(index2SortType[index] == self._sortData.sortType)
	end
end

function M:_onCellUpdate(curIndex)
	curIndex = curIndex + 1

	local item = self._diceScroll:NewListViewItem("backpack_item")

	Astral.TransformUtil.SetLocalScale(item.gameObject.transform, 1.09, 1.09, 1)

	local view = Astral.LuaComponentContainer.Add(item.gameObject, TimingD6ItemCell)
	local mo = self._moList[curIndex]

	view:updateData(mo)
	view:onSelect(self._curTimingSelectD6 and mo:getUuid() == self._curTimingSelectD6:getUuid())

	return item
end

function M:_setAutoSelectItem()
	if not self._moList or #self._moList == 0 then
		self._curTimingSelectD6 = nil
	else
		BackpackUtil.setOriginOrder(self._moList)
		table.sort(self._moList, self._sortFun or defaultSortFun)

		if self._curTimingSelectD6 then
			local uuid = self._curTimingSelectD6:getUuid()

			self._curTimingSelectD6 = nil

			for _, d6 in ipairs(self._moList) do
				if d6:getUuid() == uuid then
					self._curTimingSelectD6 = d6

					break
				end
			end
		end

		if not self._curTimingSelectD6 then
			self._curTimingSelectD6 = self._moList[1]
		end
	end
end

return M
