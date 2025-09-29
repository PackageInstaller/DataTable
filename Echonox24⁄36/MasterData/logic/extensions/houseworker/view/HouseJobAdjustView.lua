-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/houseworker/view/HouseJobAdjustView.lua

module("logic.extensions.houseworker.view.HouseJobAdjustView", package.seeall)

local M = class("HouseJobAdjustView", ViewComponent)
local RoomType = HouseEnum.RoomType

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._titleTxt = self:getText("1&title_view_-788888785")
	self._titleTxt.text = lang("tip_work_view")
	self._toggleGroup = ToggleTabControl.New()
	self._tabContentGo = self:getGo("room_adjust_schedule_view1_683530217")
	self._goTab = goutil.findChild(self._tabContentGo, "dorm_tab")
	self._loopListHelper = LoopListHelper.New(self:getGo("room_adjust_schedule_view1_-265711406"))

	self._loopListHelper:InitListView(0, self._onCellUpdate, self)

	self._mapBgImg = {
		[RoomType.Supervisor] = self:getGoByPath("bg/zhuguanshi"),
		[RoomType.Trading] = self:getGoByPath("bg/maoyizhan"),
		[RoomType.Manufacturing] = self:getGoByPath("bg/zhizaochang"),
		[RoomType.Shelter] = self:getGoByPath("bg/shourongshi")
	}
end

function M:destroyUI()
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
	GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshCellContent, self)
end

function M:_unbindEvents()
	GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._refreshCellContent, self)
end

function M:onEnter()
	IconLoader.bindSpriteAtlas(IconType.DynSpriteAtlas_Room)
	self:_bindEvents()
	self:_initTabGroup()

	self._activeIndex = -1

	local pageIndex = 1
	local info = self:getFirstParam()

	if info and info.pageIndex then
		pageIndex = info.pageIndex
	end

	self._toggleGroup:selectTab(pageIndex)
end

function M:onExit()
	self:_unbindEvents()
	self:_clearTabGroup()
	self._loopListHelper:ClearCells()

	self._jobCoList = nil
	self._activeIndex = nil

	IconLoader.unbindSpriteAtlas(IconType.DynSpriteAtlas_Room)
end

function M:_initTabGroup()
	self._tabList = {}

	self._toggleGroup:setViewPager(self)

	local configList = HouseWorkerModel.instance:getAllRoomConfig()

	for i, cfgCoList in ipairs(configList) do
		if cfgCoList[1].roomType ~= HouseEnum.WorkType.Shelter or not not HouseWorkerModel.instance:getIsShelterRoomUnlock(cfgCoList[1].zoneId) then
			local tabGO = goutil.cloneAndSetParent(self._goTab, self._tabContentGo.transform, "tab_" .. i)

			goutil.setActive(tabGO, true)
			table.insert(self._tabList, tabGO)
			self._toggleGroup:addToggleTab(tabGO:GetComponent(UIComponentType.SpaceXToggle))

			local txtName1 = goutil.findChildTextComponent(tabGO, "normal/txtDorm")
			local txtName2 = goutil.findChildTextComponent(tabGO, "select/txtDorm")

			txtName1.text = cfgCoList[1].roomName
			txtName2.text = cfgCoList[1].roomName
		end
	end
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

function M:_refreshRightView()
	local cfgCoList = HouseWorkerModel.instance:getRoomConfigByIndex(self._activeIndex)

	self._jobCoList = cfgCoList

	self._loopListHelper:SetListItemCount(#self._jobCoList, true)
	self._loopListHelper:RefreshAllShownItem()
	self._loopListHelper:MoveToItemIndex(0)

	for type, bg in pairs(self._mapBgImg) do
		goutil.setActive(bg, type == cfgCoList[1].roomType)
	end
end

function M:_refreshCellContent()
	self._loopListHelper:RefreshAllShownItem()
end

function M:_onCellUpdate(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local itemData = self._jobCoList[curIndex]
	local item = self._loopListHelper:NewListViewItem("adjust_schedule_item")
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, HouseJobAdjustCell)

	shower:setData(itemData)

	return item
end

return M
