-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/manufacture/view/ManufactureMainView.lua

module("logic.extensions.manufacture.view.ManufactureMainView", package.seeall)

local M = class("ManufactureMainView", ViewComponent)
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
	self._arrayMaterialItem = {}

	for i = 1, 3 do
		local itemGO = goutil.findChild(self._goManufacturePanel, string.format("btnProduct%s", i))
		local materialItem = Astral.LuaComponentContainer.Add(itemGO, RoomProductItem)

		table.insert(self._arrayMaterialItem, materialItem)
		materialItem:setClickMaterialCallback(self._onClickItemMaterial, self)
		materialItem:setClickDetailCallback(self._onClickItemMaterialDetail, self)
	end

	self._goHideImgOpen = goutil.findChild(self._btnHideUI.gameObject, "normal")
	self._goHideImgClose = goutil.findChild(self._btnHideUI.gameObject, "hide")
	self._goTitleView = self:getGo("1&title_view_-478490097")
	self._goMoneyView = self:getGo("0&top_currency_1050779625")
	self._refreshTimer = SchedulerCtrl.New(self._refreshMaterials, self)
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
		self._refreshTimer:restart(kRefreshInterval, true)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkerChange, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	else
		self._refreshTimer:stop()
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_INFO_REPLY, self._onManufactureInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.MANUFACTURE_PLANT_INFO_CHANGE, self._onManufactureInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkerChange, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	end
end

function M:onEnter()
	self:initView()
	self:refreshViews()
	self:_setEvents(true)
	ManufactureAgent.instance:sendGetManufactureInfoRequest()
end

function M:onExit(closeReasonType)
	self:_setEvents(false)

	if closeReasonType ~= WindowType.WindowCloseReasonType.QuickCloseType then
		HouseDispatcher:dispatchEvent(HouseEventType.ON_FOCUS_ROOM_EXIST)
	end
end

function M:initView()
	self._txtTitle.text = lang("tip_manufacturer")

	goutil.setActive(self._goSupervisorPanel, false)
	goutil.setActive(self._goTradingPanel, false)
	self:hideViews(false)
end

function M:hideViews(hide)
	self._isHideViews = hide

	goutil.setActive(self._goHideImgOpen, hide)
	goutil.setActive(self._goHideImgClose, not hide)
	goutil.setActive(self._btnDetails.gameObject, not hide)
	goutil.setActive(self._btnPersonnelMgr.gameObject, not hide)
	goutil.setActive(self._goManufacturePanel, not hide)
	goutil.setActive(self._goTitleView, not hide)
	goutil.setActive(self._goMoneyView, not hide)
	goutil.setActive(self._goWorkersRoot, not hide)
end

function M:refreshViews()
	self:_refreshMaterials()
	self:_refreshWorkers()
end

function M:_refreshMaterials()
	for i = 1, 3 do
		self:refreshMaterialItem(i)
	end
end

function M:refreshMaterialItem(id)
	local item = self._arrayMaterialItem[id]
	local mo = ManufactureModel.instance:getPlantById(id)
	local schemeId = mo:getSchemeId()

	item:setVisible(true)

	if not mo:isLock() and schemeId > 0 then
		local currStore = mo:getCurrStore()
		local limitStore = ManufactureModel.instance:getPlantLimitStore()
		local progress = 1

		if currStore <= 0 then
			progress = mo:getNextProductProgress()
		end

		item:setIcon(mo:getSchemeId())
		item:setImgProgress(progress)
		item:setTextProgerss(string.format("%s/%s", currStore, limitStore))
		item:setLock(false)
		item:setNotAdd(false)
	else
		item:setImgProgress(0)
		item:setTextProgerss("")
		item:setLock(mo:isLock())
		item:setNotAdd(not mo:isLock())
	end
end

function M:_refreshWorkers()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Manufacturing]

	for idx, workerItem in ipairs(self._arrayWorkerItem) do
		local heroId = HouseWorkerModel.instance:getCurrWorkingHero(jobCodeList[idx])

		if heroId then
			workerItem:setHero(heroId)
		elseif idx <= ManufactureModel.instance:getJobCount() then
			workerItem:setNone()
		else
			workerItem:setLock()
		end
	end
end

function M:_openJobView(idx)
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(HouseEnum.MANUFACTURE_ROOM_ID)

	ViewMgr.instance:open(ViewName.JobDetail, {
		roomIndex = jobConfigList[1].houseIndex,
		clickIndex = idx
	})
end

function M:_onClickBtnDetails()
	ViewMgr.instance:open(ViewName.ManufactureDetail)
end

function M:_onClickBtnPersonnelMgr()
	self:_openJobView(1)
end

function M:_onClickBtnHideUI()
	self:hideViews(not self._isHideViews)
end

function M:_onClickItemMaterial(item)
	local idx = table.indexof(self._arrayMaterialItem, item)
	local mo = ManufactureModel.instance:getPlantById(idx)

	if not mo:isLock() then
		ViewMgr.instance:open(ViewName.ManufactureMaterial)
	else
		local lv = ManufactureConfig.instance:getUnlockLv(idx)

		FloatWordMgr.instance:show(langF("tip_manufacture_unlock_lv", lv))
	end
end

function M:_onClickItemMaterialDetail(item)
	return
end

function M:_onClickWorkerItem(item)
	local idx = table.indexof(self._arrayWorkerItem, item) or 1

	if idx <= ManufactureModel.instance:getJobCount() then
		self:_openJobView(idx)
	end
end

function M:_onManufactureInfoReply()
	self:refreshViews()
end

function M:_onManufactureInfoChange()
	self:refreshViews()
end

function M:_onHouseWorkerChange()
	ManufactureAgent.instance:sendGetManufactureInfoRequest()
end

function M:_onTickHour()
	ManufactureAgent.instance:sendGetManufactureInfoRequest()
end

return M
