-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorDetailView.lua

module("logic.extensions.supervisor.view.SupervisorDetailView", package.seeall)

local M = class("SupervisorDetailView", ViewComponent)

function M:buildUI()
	self._btnUpgrade = self:getBtn("facility_yield_details_view_-349287854")
	self._txtTitle = self:getText("6&title_view_-788888785")
	self._txtDeviceName = self:getText("facility_yield_details_view_-1628847529")
	self._txtDeviceLv = self:getText("facility_yield_details_view_-861198366")
	self._txtDeviceDesc = self:getText("facility_yield_details_view_-324333741")

	goutil.setActive(self:getGoByPath("bg/zhuguanshi"), true)
	goutil.setActive(self:getGoByPath("content1/facility_icon/zhuguanshi"), true)

	self._goProductIcon = self:getGo("facility_yield_details_view_-2076788158")
	self._txtProductTitle = self:getText("facility_yield_details_view_-942405310")
	self._txtProductValueAll = self:getText("facility_yield_details_view_-894415307")
	self._imgProdectValueAdd1Bg = self:getImage("facility_yield_details_view_-272852578")
	self._txtProductValueAdd1 = self:getText("facility_yield_details_view_-1971476288")
	self._imgProdectValueAdd2Bg = self:getImage("facility_yield_details_view_-444389593")
	self._txtProductValueAdd2 = self:getText("facility_yield_details_view_-296914281")
	self._goMoodIcon = self:getGo("facility_yield_details_view_686403396")
	self._txtMoodTitle = self:getText("facility_yield_details_view_1908690522")
	self._txtMoodValueAll = self:getText("facility_yield_details_view_-17638271")
	self._imgMoodValueAdd1Bg = self:getImage("facility_yield_details_view_1937748410")
	self._txtMoodValueAdd1 = self:getText("facility_yield_details_view_-1438586250")

	self:_buildUnlockUI()
end

function M:_buildUnlockUI()
	self._txtUnlockRoomTitle = self:getText("facility_yield_details_view_1983393019")
	self._txtUnlockWorkerTitle = self:getText("facility_yield_details_view_-1720383915")

	local unlockRoomItemRoot = self:getGo("facility_yield_details_view_-1022886767")
	local item1 = goutil.findChild(unlockRoomItemRoot, "order_item1")

	self._unlockShelterRoomItem = Astral.LuaComponentContainer.Add(item1, RoomOrderIconItem)

	self._unlockShelterRoomItem:setVisible(true)
	self._unlockShelterRoomItem:setName(lang("tip_supervisor_lang_15"))
	self._unlockShelterRoomItem:setIcon(IconType.HouseWorkShop, "room_workshop1")

	local item2 = goutil.findChild(unlockRoomItemRoot, "order_item2")

	self._unlockSmallRoomItem = Astral.LuaComponentContainer.Add(item2, RoomOrderIconItem)

	self._unlockSmallRoomItem:setVisible(true)
	self._unlockSmallRoomItem:setName(lang("tip_supervisor_lang_16"))
	self._unlockSmallRoomItem:setIcon(IconType.HouseWorkShop, "room_workshop2")

	local item3 = goutil.findChild(unlockRoomItemRoot, "order_item3")

	self._unlockBigRoomItem = Astral.LuaComponentContainer.Add(item3, RoomOrderIconItem)

	self._unlockBigRoomItem:setVisible(true)
	self._unlockBigRoomItem:setName(lang("tip_supervisor_lang_17"))
	self._unlockBigRoomItem:setIcon(IconType.HouseWorkShop, "room_workshop3")

	local unlockWorkerItemRoot = self:getGo("facility_yield_details_view_-159515791")

	self._arrayUnlockWorkerItem = {}

	for i = 1, 3 do
		local itemGO = goutil.findChild(unlockWorkerItemRoot, string.format("duty_item%s", i))
		local workerItem = Astral.LuaComponentContainer.Add(itemGO, RoomOrderIconItem)

		workerItem:setVisible(true)
		table.insert(self._arrayUnlockWorkerItem, workerItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnUpgrade:AddClickListener(self._onClickBtnUpgrade, self)
end

function M:unbindEvents()
	self._btnUpgrade:RemoveClickListener()
end

function M:_setEvents(isOn)
	if isOn then
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
	else
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
	end
end

function M:onEnter()
	self:initView()
	self:refreshView()
	self:_setEvents(true)
end

function M:onExit()
	self:_setEvents(false)
end

function M:initView()
	self._txtTitle.text = lang("tip_supervisor_lang_1")
	self._txtDeviceName.text = lang("tip_supervisor_lang_1")
	self._txtProductTitle.text = lang("tip_supervisor_lang_2")
	self._txtMoodTitle.text = lang("tip_supervisor_lang_3")
	self._txtUnlockRoomTitle.text = lang("tip_supervisor_lang_4")
	self._txtUnlockWorkerTitle.text = lang("tip_supervisor_lang_5")
end

function M:refreshView()
	local lv = SupervisorModel.instance:getSupervisorLv()

	self._txtDeviceLv.text = string.format("Lv.%s", lv)
	self._txtDeviceDesc.text = SupervisorModel.instance:getDescription()

	local min = MathUtil.preciseDecimal(SupervisorModel.instance:getProductCostSec() / 60, 1)

	self._txtProductValueAll.text = string.format(lang("tip_minute_format"), min)

	local productHero = MathUtil.preciseDecimal(SupervisorModel.instance:getProductHero(), 0)
	local productHeroStr = productHero > 0 and string.format("%s%%", productHero) or ""

	self._txtProductValueAdd1.text = productHeroStr

	goutil.setActive(self._imgProdectValueAdd1Bg.gameObject, productHero > 0)

	local productHouseRatio = MathUtil.preciseDecimal(SupervisorModel.instance:getProductHouseRatio(), 0)
	local productHouseRatioStr = productHouseRatio > 0 and string.format("%s%%", productHouseRatio) or ""

	self._txtProductValueAdd2.text = productHouseRatioStr

	goutil.setActive(self._imgProdectValueAdd2Bg.gameObject, productHouseRatio > 0)

	self._txtMoodValueAdd1.text = ""

	goutil.setActive(self._imgMoodValueAdd1Bg.gameObject, false)

	self._txtMoodValueAll.text = MathUtil.preciseDecimal(SupervisorModel.instance:getTotalMoodCost() * 60, 1)

	self._unlockShelterRoomItem:setNum(SupervisorModel.instance:getShelterRoomUnlockCount())
	self._unlockSmallRoomItem:setNum(SupervisorModel.instance:getSmallRoomUnlockCount())
	self._unlockBigRoomItem:setNum(SupervisorModel.instance:getBigRoomUnlockCount())

	local unlockJobCount = SupervisorModel.instance:getJobCount()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Supervisor]

	for idx, workerItem in ipairs(self._arrayUnlockWorkerItem) do
		local unlock = idx <= unlockJobCount
		local jobCode = jobCodeList[idx]
		local cfg = HouseConfig.instance:getConfigByKey(ConfigName.HouseWorker, jobCode)

		workerItem:setLock(not unlock)
		workerItem:setName(cfg.jobName)
		workerItem:setIcon(IconType.HouseCompile, cfg.icon)
	end

	local maxLv = SupervisorConfig.instance:getMaxLv()

	goutil.setActive(self._btnUpgrade.gameObject, lv < maxLv)
end

function M:_onClickBtnUpgrade()
	ViewMgr.instance:open(ViewName.SupervisorUpgrade)
end

function M:_onSupervisorInfoReply()
	self:refreshView()
end

function M:_onSupervisorInfoChange()
	self:refreshView()
end

return M
