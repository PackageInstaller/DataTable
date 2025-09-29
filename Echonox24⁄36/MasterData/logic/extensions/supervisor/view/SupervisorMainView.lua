-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorMainView.lua

module("logic.extensions.supervisor.view.SupervisorMainView", package.seeall)

local M = class("SupervisorMainView", ViewComponent)
local kRefreshInterval = 5

function M:ctor()
	M.super.ctor(self)

	self._isHideViews = false
end

function M:buildUI()
	self._btnDetails = self:getBtn("facility_yield_main_view_-1771619263")
	self._btnPersonnelMgr = self:getBtn("facility_yield_main_view_-1643899068")
	self._btnHideUI = self:getBtn("facility_yield_main_view_-511698712")
	self._btnTradeCenter = self:getBtn("facility_yield_main_view_-578318949")

	goutil.setActive(self._btnTradeCenter.gameObject, false)

	self._goSupervisorPanel = self:getGo("facility_yield_main_view_-1236388830")
	self._goManufacturePanel = self:getGo("facility_yield_main_view_-1609859183")
	self._goTradingPanel = self:getGo("facility_yield_main_view_-2054024879")
	self._txtTitle = self:getText("1&title_view_-788888785")

	goutil.setActive(self:getGo("facility_yield_main_view_-26135140"), false)

	self._goWorkersRoot = self:getGo("facility_yield_main_view_-1861251867")

	local workerItemGO1 = goutil.findChild(self:getGo("facility_yield_main_view_1896231206"), "room_head")

	self._workerItem1 = Astral.LuaComponentContainer.Add(workerItemGO1, RoomWorkerItem)

	self._workerItem1:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO2 = goutil.findChild(self:getGo("facility_yield_main_view_-1745727221"), "room_head")

	self._workerItem2 = Astral.LuaComponentContainer.Add(workerItemGO2, RoomWorkerItem)

	self._workerItem2:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO3 = goutil.findChild(self:getGo("facility_yield_main_view_-1542203762"), "room_head")

	self._workerItem3 = Astral.LuaComponentContainer.Add(workerItemGO3, RoomWorkerItem)

	self._workerItem3:setClickCallback(self._onClickWorkerItem, self)

	self._arrayWorkerItem = {
		self._workerItem1,
		self._workerItem2,
		self._workerItem3
	}

	local itemGO = self:getGo("facility_yield_main_view_-730937076")

	self._materialItem = Astral.LuaComponentContainer.Add(itemGO, RoomProductItem)

	self._materialItem:setClickMaterialCallback(self._onClickBtnMaterial, self)
	self._materialItem:setClickDetailCallback(self._onClickBtnMaterialDetail, self)

	self._goHideImgOpen = goutil.findChild(self._btnHideUI.gameObject, "normal")
	self._goHideImgClose = goutil.findChild(self._btnHideUI.gameObject, "hide")
	self._goTitleView = self:getGo("1&title_view_-478490097")
	self._goMoneyView = self:getGo("0&top_currency_1050779625")
	self._refreshTimer = SchedulerCtrl.New(self._refreshImgProgress, self)
end

function M:destroyUI()
	self._refreshTimer:clear()

	self._refreshTimer = nil
end

function M:bindEvents()
	self._btnDetails:AddClickListener(self._onClickBtnDetails, self)
	self._btnPersonnelMgr:AddClickListener(self._onClickBtnPersonnelMgr, self)
	self._btnHideUI:AddClickListener(self._onClickBtnHideUI, self)
end

function M:unbindEvents()
	self._btnDetails:RemoveClickListener()
	self._btnPersonnelMgr:RemoveClickListener()
	self._btnHideUI:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkerChange, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkerChange, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	end
end

function M:onEnter()
	self:initView()
	self:refreshView()
	self:_setEvents(true)
	SupervisorAgent.instance:sendGetManagerInfoRequest()
end

function M:onExit(closeReasonType)
	self:_setEvents(false)
	self._refreshTimer:stop()

	if closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
	end
end

function M:initView()
	self._txtTitle.text = lang("tip_supervisor_lang_1")

	goutil.setActive(self._goManufacturePanel, false)
	goutil.setActive(self._goTradingPanel, false)
	self:hideViews(false)
end

function M:refreshView()
	self._refreshTimer:stop()

	if SupervisorModel.instance:hasLoadedInfo() then
		local currStore = SupervisorModel.instance:getCurrStore()
		local limitStore = SupervisorModel.instance:getLimitStore()

		if not SupervisorModel.instance:isStoreFulled() then
			self:_refreshImgProgress()
			self._refreshTimer:restart(kRefreshInterval, true)
		else
			self._materialItem:setImgProgress(1)
		end

		self._materialItem:setIcon(SupervisorConfig.instance:getProductId())
		self._materialItem:setTextProgerss(string.format("%s/%s", currStore, limitStore))
		self:_refreshWorkers()
	else
		self._materialItem:setImgProgress(0)
		self._materialItem:setTextProgerss("")
	end
end

function M:_refreshImgProgress()
	local progress = SupervisorModel.instance:getNextProductProgress()

	self._materialItem:setImgProgress(progress)
end

function M:_refreshWorkers()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Supervisor]

	for idx, workerItem in ipairs(self._arrayWorkerItem) do
		local heroId = HouseWorkerModel.instance:getCurrWorkingHero(jobCodeList[idx])

		if heroId then
			workerItem:setHero(heroId)
		elseif idx <= SupervisorModel.instance:getJobCount() then
			workerItem:setNone()
		else
			workerItem:setLock()
		end
	end
end

function M:hideViews(hide)
	self._isHideViews = hide

	goutil.setActive(self._goHideImgOpen, hide)
	goutil.setActive(self._goHideImgClose, not hide)
	goutil.setActive(self._btnDetails.gameObject, not hide)
	goutil.setActive(self._btnPersonnelMgr.gameObject, not hide)
	goutil.setActive(self._goSupervisorPanel, not hide)
	goutil.setActive(self._goTitleView, not hide)
	goutil.setActive(self._goMoneyView, not hide)
	goutil.setActive(self._goWorkersRoot, not hide)
end

function M:_openJobView(idx)
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(HouseEnum.SUPERVISOR_ROOM_ID)

	ViewMgr.instance:open(ViewName.JobDetail, {
		roomIndex = jobConfigList[1].houseIndex,
		clickIndex = idx
	})
end

function M:_onClickBtnDetails()
	ViewMgr.instance:open(ViewName.SupervisorDetail)
end

function M:_onClickBtnPersonnelMgr()
	self:_openJobView(1)
end

function M:_onClickBtnHideUI()
	self:hideViews(not self._isHideViews)
end

function M:_onClickBtnMaterial()
	ViewMgr.instance:open(ViewName.SupervisorMaterial)
end

function M:_onClickBtnMaterialDetail()
	ViewMgr.instance:open(ViewName.SupervisorMaterial)
end

function M:_onClickWorkerItem(item)
	local idx = table.indexof(self._arrayWorkerItem, item) or 1

	if idx <= SupervisorModel.instance:getJobCount() then
		self:_openJobView(idx)
	end
end

function M:_onSupervisorInfoReply()
	self:refreshView()
end

function M:_onSupervisorInfoChange()
	self:refreshView()
end

function M:_onHouseWorkerChange()
	SupervisorAgent.instance:sendGetManagerInfoRequest()
end

function M:_onTickHour()
	SupervisorAgent.instance:sendGetManagerInfoRequest()
end

return M
