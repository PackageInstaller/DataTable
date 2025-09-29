-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/livingfacilities/view/LivingFacilitiesAdjustScheduleView.lua

module("logic.extensions.livingfacilities.view.LivingFacilitiesAdjustScheduleView", package.seeall)

local M = class("LivingFacilitiesAdjustScheduleView", ViewComponent)
local RoomType = HouseEnum.RoomType

function M:buildUI()
	self._txtRoomName = self:getTextByPath("content1/name/txtHint2")
	self._txtLevel = self:getTextByPath("content1/level/txtLevel")
	self._txtHint = self:getText("room_adjust_schedule_view2_1083585040")
	self._txtNum = self:getText("room_adjust_schedule_view2_-317702612")
	self._adjustScheduleScrollGo = self:getGo("room_adjust_schedule_view2_-1037029159")
	self._adjustScheduleLoopList = LoopListHelper.New(self._adjustScheduleScrollGo)

	self._adjustScheduleLoopList:InitListView(0, self._updateScheduleCell, self)

	self._btnAdjustSchedule = self:getBtn("room_adjust_schedule_view2_1015058094")
	self._btnReturn = self:getBtn("0&title_view_-878360263")
	self._btnHome = self:getBtn("0&title_view_1398742689")

	goutil.setActive(self._btnAdjustSchedule.gameObject, false)

	self._mapBgImg = {
		[RoomType.Supervisor] = self:getGoByPath("bg/zhuguanshi"),
		[RoomType.Trading] = self:getGoByPath("bg/maoyizhan"),
		[RoomType.Manufacturing] = self:getGoByPath("bg/zhizaochang"),
		[RoomType.Shelter] = self:getGoByPath("bg/shourongshi"),
		[RoomType.Living] = self:getGoByPath("bg/sushe")
	}
	self._mapIconImg = {
		[RoomType.Supervisor] = self:getGoByPath("content1/facility_icon/zhuguanshi"),
		[RoomType.Trading] = self:getGoByPath("content1/facility_icon/maoyizhan"),
		[RoomType.Manufacturing] = self:getGoByPath("content1/facility_icon/zhizaochang"),
		[RoomType.Living] = self:getGoByPath("content1/facility_icon/sushe")
	}
	self._hintGo = self:getGo("room_adjust_schedule_view2_-124512097")
	self._markView = Astral.LuaComponentContainer.Add(self._hintGo, LivingFacilitiesMarkView)
end

function M:destroyUI()
	self._adjustScheduleLoopList:Dispose()

	self._adjustScheduleLoopList = nil
	self._txtRoomName = nil
	self._txtLevel = nil
	self._txtHint = nil
	self._txtNum = nil
	self._adjustScheduleScrollGo = nil
	self._btnAdjustSchedule = nil
	self._btnReturn = nil
	self._btnHome = nil
	self._zoneMo = nil
	self._showerList = nil
end

function M:bindEvents()
	self._btnAdjustSchedule:AddClickListener(self._onClickAdjustSchedule, self)
	self._btnReturn:AddClickListener(self._onClickReturn, self)
	self._btnHome:AddClickListener(self._onClickHome, self)
end

function M:unbindEvents()
	self._btnAdjustSchedule:RemoveClickListener()
	self._btnReturn:RemoveClickListener()
	self._btnHome:RemoveClickListener()
end

function M:_setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self.refreshView, self)
		HouseDispatcher:addEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self.refreshView, self)
	else
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self.refreshView, self)
		HouseDispatcher:removeEventListener(HouseEventType.HOUSE_FURNITURES_UPDATE, self.refreshView, self)
	end
end

function M:onEnter()
	self._showerList = {}
	self._zoneMo = self:getFirstParam() or LivingFacilitiesZoneController.instance:getCurrentZoneMo()

	if self:getFirstParam() then
		self._openType = 1
	end

	self:refreshView()
	self:_setEvent(true)
end

function M:onExit()
	for i, shower in ipairs(self._showerList) do
		shower:onExit()
	end

	self:_setEvent(false)
	self._adjustScheduleLoopList:ClearCells()
end

function M:_onClickReturn()
	self:close()

	if self._openType ~= 1 then
		ViewMgr.instance:open(ViewName.LivingFacilitiesMain)
	end
end

function M:_onClickHome()
	HouseMainFacade.instance:onClickHome()
end

function M:_onClickAdjustSchedule()
	return
end

function M:refreshView()
	self:_refreshLivingFacilitiesMark()

	self._txtRoomName.text = self._zoneMo:getName()
	self._txtNum.text = string.format("%d/%d", self._zoneMo:getInRoomHeroCount(), self._zoneMo:getHeroCount())
	self._txtLevel.text = string.format("Lv %d", self._zoneMo:getAtmosphereLevel())
	self._bunkList = self._zoneMo:getBunkList()

	self._adjustScheduleLoopList:SetListItemCount(self._zoneMo:getHeroCount(), true)
	self._adjustScheduleLoopList:RefreshAllShownItem()

	local roomType = RoomType.Living

	for type, bg in pairs(self._mapBgImg) do
		goutil.setActive(bg, type == roomType)
	end

	for type, icon in pairs(self._mapIconImg) do
		goutil.setActive(icon, type == roomType)
	end
end

function M:_refreshLivingFacilitiesMark()
	local zoneId = self._zoneMo:getId()
	local genderMark = LivingFacilitiesZoneModel.instance:getGenderMarkCO(zoneId)
	local campMark = LivingFacilitiesZoneModel.instance:getCampMarkCO(zoneId)

	self._markView:updateData(genderMark, campMark)
end

function M:_updateScheduleCell(curIndex)
	if curIndex < 0 then
		return
	end

	curIndex = curIndex + 1

	local item = self._adjustScheduleLoopList:NewListViewItem("adjust_schedule_item")
	local bunkInfo = self._bunkList[curIndex]
	local shower = Astral.LuaComponentContainer.Add(item.gameObject, AdjustScheduleItemView)

	shower:setCellData(bunkInfo, curIndex, self._zoneMo)
	table.insert(self._showerList, shower)

	return item
end

return M
