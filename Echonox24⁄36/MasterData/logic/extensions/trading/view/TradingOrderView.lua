-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/extensions/trading/view/TradingOrderView.lua

module("logic.extensions.trading.view.TradingOrderView", package.seeall)

local TradingHeroMoodCell = class("TradingHeroMoodCell")

function TradingHeroMoodCell:ctor(comContainer)
	self._go = comContainer.gameObject

	self:_onInit()
end

function TradingHeroMoodCell:_onInit()
	self._fillImg = goutil.findChildImageComponent(self._go, "mood2/fill")
	self._moodIcon = goutil.findChildImageComponent(self._go, "mood2/moodIcon")
end

function TradingHeroMoodCell:updateMood(mood)
	local type = HouseWorkerModel.instance:getMoodInterval(mood)
	local maxMood = HouseConfig.instance:getHouseConst("MoodMax").numValue

	if type == 1 then
		IconLoader.setSprite(self._moodIcon, IconType.DynSpriteAtlas_Room, "room_mood_1")

		self._fillImg.color = Astral.ColorUtil.ParseColor("#9EBF9A")
	elseif type == 2 then
		IconLoader.setSprite(self._moodIcon, IconType.DynSpriteAtlas_Room, "room_mood_2")

		self._fillImg.color = Astral.ColorUtil.ParseColor("#C1B063")
	else
		IconLoader.setSprite(self._moodIcon, IconType.DynSpriteAtlas_Room, "room_mood_3")

		self._fillImg.color = Astral.ColorUtil.ParseColor("#E44B4B")
	end

	self._moodIcon.color = Astral.ColorUtil.ParseColor("#FFFFFF")
	self._fillImg.fillAmount = mood / maxMood
end

local TAB_TYPE = {
	DAILY = 1,
	WEEKLY = 2
}
local M = class("TradingOrderView", ViewComponent)

function M:ctor()
	M.super.ctor(self)

	self._orderItems = {}
end

function M:buildUI()
	self._txtProductivity = self:getText("trade_order_view_copy_1638208713")
	self._txtProductivityAdd1 = self:getText("trade_order_view_copy_1167657341")
	self._txtProductivityAdd2 = self:getText("trade_order_view_copy_1953427086")
	self._txtMoodValue = self:getText("trade_order_view_copy_-1048237061")
	self._txtMoodValueAdd = self:getText("trade_order_view_copy_-1163202684")
	self._btnDailyOrder = self:getUIComponent("trade_order_view_1712554548", UIComponentType.SpaceXToggle)
	self._btnWeeklyOrder = self:getUIComponent("trade_order_view_922522847", UIComponentType.SpaceXToggle)
	self._traOrderContent = self:getGo("trade_order_view_1686370864").transform
	self._goOrderItem = self:getGo("trade_order_view_1712133431")
	self._toggleGroup = self:getUIComponent("trade_order_view_-890259465", UIComponentType.SpaceXToggleGroup)
	self._txtDaily1 = goutil.findChildTextComponent(self._btnDailyOrder.gameObject, "click/Text")
	self._txtDaily2 = goutil.findChildTextComponent(self._btnDailyOrder.gameObject, "noclick/Text (1)")
	self._txtWeekly1 = goutil.findChildTextComponent(self._btnWeeklyOrder.gameObject, "click/Text")
	self._txtWeekly2 = goutil.findChildTextComponent(self._btnWeeklyOrder.gameObject, "noclick/Text (1)")
	self._goWorkerParent = self:getGo("trade_order_view_copy_685000872")
	self._arrayWorkerItem = {}

	for i = 1, 3 do
		local workerItemGO = goutil.findChild(self._goWorkerParent, string.format("headPos%s/room_head", i))
		local workerItem = Astral.LuaComponentContainer.Add(workerItemGO, RoomWorkerItem)

		workerItem:setClickCallback(self._onClickWorkerItem, self)
		table.insert(self._arrayWorkerItem, workerItem)
	end
end

function M:destroyUI()
	return
end

function M:bindEvents()
	self._btnDailyOrder:AddListener(self._clickDailyOrder, self)
	self._btnWeeklyOrder:AddListener(self._clickWeeklyOrder, self)
end

function M:unbindEvents()
	self._btnDailyOrder:RemoveListener()
	self._btnWeeklyOrder:RemoveListener()
end

function M:onEnter()
	self:setEvent(true)

	local param = self:getFirstParam()

	if param then
		if param.orderType == 2 then
			self._curTabType = TAB_TYPE.WEEKLY
		else
			self._curTabType = TAB_TYPE.DAILY
		end
	else
		self._curTabType = TAB_TYPE.DAILY
	end

	self._toggleGroup:TryActiveChildOn(self._curTabType == TAB_TYPE.DAILY and self._btnDailyOrder or self._btnWeeklyOrder, true)
	self:showCurOrders()
	self:showCurWorker()
	self:updateStatus()
end

function M:onExit()
	return
end

function M:onExitFinished()
	self:setEvent(false)
end

function M:updateStatus()
	local mo = TradingModel.instance:getTradePostMo()
	local surplus = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue
	local add1GO = self._txtProductivityAdd1.gameObject.transform.parent.gameObject

	if mo:getHeroAdd() == 0 then
		goutil.setActive(add1GO, false)
	else
		goutil.setActive(add1GO, true)

		self._txtProductivityAdd1.text = mo:getEnterHeroAdd()
	end

	local productHouseRatio = MathUtil.preciseDecimal(TradingModel.instance:getProductHouseRatio(), 0)
	local productHouseRatioStr = productHouseRatio > 0 and string.format("%s%%", productHouseRatio) or ""
	local add2GO = self._txtProductivityAdd2.gameObject.transform.parent.gameObject

	if productHouseRatio == 0 then
		goutil.setActive(add2GO, false)
	else
		goutil.setActive(add2GO, true)

		self._txtProductivityAdd2.text = productHouseRatioStr
	end

	self._txtProductivity.text = TextFormatter.formatExpireTime(surplus / mo:getSpeed() * 60)
	self._txtMoodValue.text = MathUtil.preciseDecimal(SupervisorModel.instance:getTotalMoodCost() * 60, 1)

	local moodAddGO = self._txtMoodValueAdd.gameObject.transform.parent.gameObject

	goutil.setActive(moodAddGO, false)

	self._txtMoodValueAdd.text = "+0%"
end

function M:setEvent(add)
	if add then
		GlobalDispatcher:addEventListener(EventType.TRADING_ORDER_LIST, self._onOrderListChange, self)
		GlobalDispatcher:addEventListener(EventType.TRADING_POST_INFO, self._onPostInfoChange, self)
		GlobalDispatcher:addEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkerChange, self)
		GlobalDispatcher:addEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	else
		GlobalDispatcher:removeEventListener(EventType.TRADING_ORDER_LIST, self._onOrderListChange, self)
		GlobalDispatcher:removeEventListener(EventType.TRADING_POST_INFO, self._onPostInfoChange, self)
		GlobalDispatcher:removeEventListener(EventType.ChangeHouseWorkerSucceed, self._onHouseWorkerChange, self)
		GlobalDispatcher:removeEventListener(EventType.FW_CLOCK_TICKHOUR, self._onTickHour, self)
	end
end

function M:_clickDailyOrder(tab, isOn)
	if isOn then
		self._curTabType = TAB_TYPE.DAILY

		self:showCurOrders()
	end
end

function M:_clickWeeklyOrder(tab, isOn)
	if isOn then
		self._curTabType = TAB_TYPE.WEEKLY

		self:showCurOrders()
	end
end

function M:_openJobView(idx)
	local jobConfigList = HouseWorkerModel.instance:getJobConfigListByRoomId(HouseEnum.TRADING_ROOM_ID)

	ViewMgr.instance:open(ViewName.JobDetail, {
		roomIndex = jobConfigList[1].houseIndex,
		clickIndex = idx
	})
end

function M:_onClickWorkerItem(item)
	local idx = table.indexof(self._arrayWorkerItem, item) or 1

	if idx <= TradingModel.instance:getJobCount() then
		self:_openJobView(idx)
	end
end

function M:showCurWorker()
	local jobCodeList = HouseEnum.WorkType2JobCodeList[HouseEnum.WorkType.Trading]

	for idx, workerItem in ipairs(self._arrayWorkerItem) do
		local heroId = HouseWorkerModel.instance:getCurrWorkingHero(jobCodeList[idx])

		if heroId then
			workerItem:setHero(heroId)
		elseif idx <= TradingModel.instance:getJobCount() then
			workerItem:setNone()
		else
			workerItem:setLock()
		end
	end
end

function M:_onPostInfoChange()
	self:showCurWorker()
	self:updateStatus()
end

function M:_onOrderListChange()
	self:showCurOrders()
	self:updateStatus()
end

function M:_onHouseWorkerChange()
	self:showCurWorker()
	self:updateStatus()
end

function M:_onTickHour()
	self:showCurWorker()
	self:updateStatus()
end

function M:showCurOrders()
	for i = 0, self._traOrderContent.childCount - 1 do
		goutil.setActive(self._traOrderContent:GetChild(i).gameObject, false)
	end

	local dailyOrderIds = TradingModel.instance:getDailyOrder()
	local weeklyOrderIds = TradingModel.instance:getWeeklyOrder()
	local mo = TradingModel.instance:getTradePostMo()
	local co = TradingConfig.instance:getHouseCoByLevel(mo:getLevel())
	local maxDailyOrderCount = co.maxDailyOrder
	local maxWeeklyOrderCount = co.maxWeeklyOrder
	local dailyCount = #dailyOrderIds
	local weeklyCount = #weeklyOrderIds
	local dayOrderText = lang("tip_day_order") .. "%s/%d"
	local weekOrderText = lang("tip_week_order") .. "%s/%d"

	self._txtDaily1.text = string.format(dayOrderText, dailyCount, maxDailyOrderCount)
	self._txtDaily2.text = string.format(dayOrderText, dailyCount, maxDailyOrderCount)
	self._txtWeekly1.text = string.format(weekOrderText, weeklyCount, maxWeeklyOrderCount)
	self._txtWeekly2.text = string.format(weekOrderText, weeklyCount, maxWeeklyOrderCount)

	if self._curTabType == TAB_TYPE.DAILY then
		for k, v in ipairs(dailyOrderIds) do
			local item = self._orderItems[k]

			if not item then
				local go = Astral.GameObjectUtil.CloneAndSetParent(self._goOrderItem, self._traOrderContent, nil)

				item = Astral.LuaComponentContainer.Add(go, TradingOrderItem)
				self._orderItems[k] = item
			end

			local data = {}
			local co1 = TradingConfig.instance:getConfigByKey(ConfigName.TradeOrderDetail, v)

			data.id = v
			data.type = lang("tip_day_order")
			data.orderType = self._curTabType
			data.orderIndex = k
			data.name = co1.name
			data.icon = co1.icon
			data.quality = co1.quality

			item:updateData(data)
		end

		local nextCount = maxDailyOrderCount >= #dailyOrderIds + 1 and #dailyOrderIds + 1 or maxDailyOrderCount

		for i = #dailyOrderIds + 1, nextCount do
			local idx = i
			local item = self._orderItems[idx]

			if not item then
				local go = Astral.GameObjectUtil.CloneAndSetParent(self._goOrderItem, self._traOrderContent, nil)

				item = Astral.LuaComponentContainer.Add(go, TradingOrderItem)
				self._orderItems[idx] = item
			end

			local data = {}

			data.id = v
			data.type = lang("tip_day_order")
			data.orderType = self._curTabType
			data.orderIndex = idx
			data.name = i == #dailyOrderIds + 1 and "" or ""
			data.isToGet = i == #dailyOrderIds + 1
			data.isNone = i > #dailyOrderIds + 1
			data.icon = nil
			data.quality = nil

			if i == #dailyOrderIds + 1 then
				local needProductivity = TradingConfig.instance:getConstCoByKey("OrderProductivity").numValue
				local curProductivity = TradingModel.instance:getTradePostMo():getProductivity()
				local surplusProductivity = needProductivity - curProductivity

				data.productivity = {}
				data.productivity.total = needProductivity
				data.productivity.surplus = surplusProductivity
				data.speed = TradingModel.instance:getTradePostMo():getSpeed()
			end

			item:updateData(data)
		end
	else
		for k, v in ipairs(weeklyOrderIds) do
			local item = self._orderItems[k]

			if not item then
				local go = Astral.GameObjectUtil.CloneAndSetParent(self._goOrderItem, self._traOrderContent, nil)

				item = Astral.LuaComponentContainer.Add(go, TradingOrderItem)
				self._orderItems[k] = item
			end

			local data = {}
			local co1 = TradingConfig.instance:getConfigByKey(ConfigName.TradeOrderDetail, v)

			data.id = v
			data.type = lang("tip_week_order")
			data.orderType = self._curTabType
			data.orderIndex = k
			data.name = co1.name
			data.icon = co1.icon
			data.quality = co1.quality

			item:updateData(data)
		end
	end
end

return M
