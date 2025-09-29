-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/supervisor/view/SupervisorMaterialView.lua

module("logic.extensions.supervisor.view.SupervisorMaterialView", package.seeall)

local M = class("SupervisorMaterialView", ViewComponent)
local kRequestInterval = 600

function M:ctor()
	M.super.ctor(self)
end

function M:buildUI()
	self._txtTitle = self:getText("1&title_view_-788888785")

	goutil.setActive(self:getGoByPath("bg/zhuguanshi"), true)

	self._txtProductTitle = self:getText("room_orders_view_1951350930")
	self._txtProductValueAll = self:getText("room_orders_view_-919362882")
	self._imgProdectValueAdd1Bg = self:getImage("facility_holding_report_view_112648220")
	self._txtProductValueAdd1 = self:getText("facility_holding_report_view_1824317230")
	self._imgProdectValueAdd2Bg = self:getImage("facility_holding_report_view_1532334896")
	self._txtProductValueAdd2 = self:getText("facility_holding_report_view_323610558")
	self._txtMoodTitle = self:getText("room_orders_view_955794245")
	self._txtMoodValueAll = self:getText("room_orders_view_-1492452091")
	self._imgMoodValueAdd1Bg = self:getImage("room_orders_view_-669567249")
	self._txtMoodValueAdd1 = self:getText("room_orders_view_-1160306784")

	local workerItemGO1 = goutil.findChild(self:getGo("room_orders_view_-1306594165"), "room_head")

	self._workerItem1 = Astral.LuaComponentContainer.Add(workerItemGO1, RoomWorkerItem)

	self._workerItem1:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO2 = goutil.findChild(self:getGo("room_orders_view_-1420932701"), "room_head")

	self._workerItem2 = Astral.LuaComponentContainer.Add(workerItemGO2, RoomWorkerItem)

	self._workerItem2:setClickCallback(self._onClickWorkerItem, self)

	local workerItemGO3 = goutil.findChild(self:getGo("room_orders_view_1912493006"), "room_head")

	self._workerItem3 = Astral.LuaComponentContainer.Add(workerItemGO3, RoomWorkerItem)

	self._workerItem3:setClickCallback(self._onClickWorkerItem, self)

	self._arrayWorkerItem = {
		self._workerItem1,
		self._workerItem2,
		self._workerItem3
	}

	local contentGO = self:getGo("room_orders_view_2053887595")
	local productGO1 = goutil.findChild(contentGO, "room_orders_item1")

	goutil.setActive(productGO1, false)

	local productGO2 = goutil.findChild(contentGO, "room_orders_item2")

	self._productCell = Astral.LuaComponentContainer.Add(productGO2, RoomProductCell)

	self._productCell:setBtnGetCallback(self._onClickGetMaterial, self)

	local productGO3 = goutil.findChild(contentGO, "room_orders_item3")

	goutil.setActive(productGO3, false)

	self._refreshTimer = SchedulerCtrl.New(self._refreshProgress, self)
	self._requestTimer = SchedulerCtrl.New(self._requestHeroFeatureAgent, self)
end

function M:destroyUI()
	self._refreshTimer:clear()

	self._refreshTimer = nil

	self._requestTimer:clear()

	self._requestTimer = nil
end

function M:bindEvents()
	return
end

function M:unbindEvents()
	return
end

function M:_setEvents(isOn)
	if isOn then
		self._requestTimer:restart(kRequestInterval, true)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:addEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
	else
		self._requestTimer:stop()
		self._refreshTimer:stop()
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_REPLY, self._onSupervisorInfoReply, self)
		GlobalDispatcher:removeEventListener(EventType.SUPERVISOR_INFO_CHANGE, self._onSupervisorInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.HERO_MOOD_UPDATE, self._onMoodUpdate, self)
	end
end

function M:onEnter()
	self:initView()
	self:refreshView()
	self:_setEvents(true)
	self:_requestHeroFeatureAgent()
end

function M:onExit()
	self:_setEvents(false)
end

function M:_requestHeroFeatureAgent()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Supervisor]

	for i, jobCode in ipairs(jobCodeList) do
		local heroId = HouseWorkerModel.instance:getCurrWorkingHero(jobCode)

		if heroId then
			HouseAgent.instance:sendGetSingleHeroFeatureRequest(heroId)
		end
	end
end

function M:initView()
	self._txtTitle.text = lang("tip_supervisor_lang_1")
	self._txtProductTitle.text = lang("tip_supervisor_lang_2")
	self._txtMoodTitle.text = lang("tip_supervisor_lang_3")
end

function M:refreshView()
	self:_refreshValue()
	self:_refreshWorkers()
	self:_refreshProduct()
end

function M:_refreshValue()
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

function M:_refreshProduct()
	local itemId = SupervisorConfig.instance:getProductId()

	self._productCell:setLock(false)
	self._productCell:setNoPlan(false)
	self._productCell:setBtnGetVisible(true)
	self._productCell:setMaterial(itemId)

	local currStore = SupervisorModel.instance:getCurrStore()
	local limitStore = SupervisorModel.instance:getLimitStore()

	self._productCell:setDoing(currStore <= 0)
	self._productCell:setStore(currStore, limitStore)
	self:_refreshProgress()
	self._refreshTimer:stop()

	if not SupervisorModel.instance:isStoreFulled() then
		self._refreshTimer:restart(1, true)
	end
end

function M:_refreshProgress()
	local progress = 1
	local remainTime = 0

	if not SupervisorModel.instance:isStoreFulled() then
		progress = SupervisorModel.instance:getNextProductProgress()
		remainTime = SupervisorModel.instance:getRemainTimeToFull()
	end

	self._productCell:setProgress(progress, remainTime)
end

function M:_onClickWorkerItem(item)
	local idx = table.indexof(self._arrayWorkerItem, item) or 1
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(HouseEnum.SUPERVISOR_ROOM_ID)

	ViewMgr.instance:open(ViewName.JobDetail, {
		roomIndex = jobConfigList[1].houseIndex,
		clickIndex = idx
	})
end

function M:_onClickGetMaterial()
	local currStore = SupervisorModel.instance:getCurrStore()

	if currStore > 0 then
		SupervisorAgent.instance:sendReceiveManagerStoreRequest()
	else
		FloatWordMgr.instance:show(lang("tip_supervisor_lang_6"))
	end
end

function M:_onSupervisorInfoReply()
	self:refreshView()
end

function M:_onSupervisorInfoChange()
	self:refreshView()
end

function M:_onMoodUpdate()
	self:_refreshWorkers()
end

return M
