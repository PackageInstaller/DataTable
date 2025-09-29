-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseDormAdjustView.lua

module("logic.extensions.houseworker.view.HouseDormAdjustView", package.seeall)

local M = class("HouseDormAdjustView", ViewComponent)

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._toggleGroup = ToggleTabControl.New()
	self._tabContentGo = self:getUIComponent("room_adjust_schedule_view1_683530217")
	self._goTab = goutil.findChild(self._tabContentGo, "dorm_tab")
	self._loopListHelper = LoopListHelper.New(self:getGo("room_adjust_schedule_view1_-265711406"))

	self._loopListHelper:InitListView(0, self._updateScheduleCell, self)
	goutil.setActive(self:getGoByPath("bg/sushe"), true)
	goutil.setActive(self:getGoByPath("bg/zhuguanshi"), false)
	goutil.setActive(self:getGoByPath("bg/maoyizhan"), false)
	goutil.setActive(self:getGoByPath("bg/zhizaochang"), false)
	goutil.setActive(self:getGoByPath("bg/shourongshi"), false)
end

function M:destroyUI()
	self._btnReturn = nil
	self._btnHome = nil

	self._loopListHelper:Dispose()

	self._loopListHelper = nil

	self._toggleGroup:destroy()

	self._toggleGroup = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_bindEvents()
	GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshRightView, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshRightView, self)
end

function M:onEnter()
	self._showerList = {}

	self:_bindEvents()

	self._zoneList = LivingFacilitiesZoneController.instance:getAllDorm()

	self:_initTabGroup()

	self._activeIndex = 1

	local pageIndex = 1
	local info = self:getFirstParam()

	if info and info.pageIndex then
		pageIndex = info.pageIndex
	end

	self._toggleGroup:selectTab(pageIndex)

	if #self._zoneList ~= 0 then
		self:_refreshRightView()
	end
end

function M:_initTabGroup()
	self._tabList = {}

	self._toggleGroup:setViewPager(self)

	for i, zone in ipairs(self._zoneList) do
		local tabGO = goutil.cloneAndSetParent(self._goTab, self._tabContentGo.transform, "tab_" .. i)

		goutil.setActive(tabGO, true)
		table.insert(self._tabList, tabGO)
		self._toggleGroup:addToggleTab(tabGO:GetComponent(UIComponentType.SpaceXToggle))

		local txtName1 = goutil.findChildTextComponent(tabGO, "normal/txtDorm")
		local txtName2 = goutil.findChildTextComponent(tabGO, "select/txtDorm")

		txtName1.text = zone:getName()
		txtName2.text = zone:getName()
	end
end

function M:onExit()
	for i, shower in ipairs(self._showerList) do
		shower:onExit()
	end

	self:_unbindEvents()
	self:_clearTabGroup()
	self._loopListHelper:ClearCells()

	self._bunkList = nil
	self._activeIndex = nil
end

function M:_clearTabGroup()
	self._toggleGroup:clear()

	for _, tabGO in ipairs(self._tabList) do
		goutil.destroy(tabGO)
	end

	self._tabList = nil
end

function M:setPage(tabIndex)
	local needReflash = self._activeIndex ~= tabIndex

	self._activeIndex = tabIndex

	if needReflash then
		self:_refreshRightView()
	end
end

function M:_onClickReturn()
	self:back()
end

function M:_onClickHome()
	self:close()
	HouseMainFacade.instance:onClickHome()
end

function M:_refreshRightView()
	local zone = self._zoneList[self._activeIndex]

	self._bunkList = zone:getBunkList()

	self._loopListHelper:SetListItemCount(zone:getHeroCount(), true)
	self._loopListHelper:RefreshAllShownItem()
	self._loopListHelper:MoveToItemIndex(0)
end

function M:_updateScheduleCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._loopListHelper:NewListViewItem("adjust_schedule_item")
	local bunkInfo = self._bunkList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, AdjustScheduleItemView)
	local zone = self._zoneList[self._activeIndex]

	shower:setCellData(bunkInfo, curIndex, zone)
	table.insert(self._showerList, shower)

	return item
end

return M
