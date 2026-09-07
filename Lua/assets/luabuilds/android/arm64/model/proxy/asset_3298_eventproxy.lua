local EventProxy = class("EventProxy", import(".NetProxy"))

function EventProxy:register()
	self.eventDic = {}
	self.countDownList = {}
	self.lastFlushTime = 0

	self:on(13002, function(arg_2_0)
		self.maxFleetNums = arg_2_0.max_team

		self:updateAll(arg_2_0.collection_list)

		return
	end)
	self:on(13011, function(arg_3_0)
		getProxy(ChapterAutoProxy):RecordNewEventIds(underscore.map(arg_3_0.collection, function(arg_4_0)
			return arg_4_0.id
		end))
		self:updateInfoList(underscore.map(arg_3_0.collection, function(arg_5_0)
			local var_5_0 = EventInfo.New(arg_5_0)

			if not self:existEvent(var_5_0.id) then
				self.eventForMsg = var_5_0
			end

			return var_5_0
		end))

		self.virgin = true

		return
	end)

	return
end

function EventProxy:timeCall()
	return {
		[ProxyRegister.SecondCall] = function(arg_7_0)
			self:updateTime()

			return
		end
	}
end

function EventProxy:updateAll(arg_8_1)
	self.eventDic = {}
	self.countDownList = {}
	self.lastFlushTime = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_8_0, iter_8_1 in ipairs(arg_8_1) do
		local var_8_0 = EventInfo.New(iter_8_1)

		self.eventDic[var_8_0.id] = var_8_0

		if var_8_0:GetState() == EventInfo.StateActive then
			table.insert(self.countDownList, var_8_0.id)
		end
	end

	table.sort(self.countDownList, CompareFuncs({
		function(arg_9_0)
			return self.eventDic[arg_9_0].finishTime
		end
	}))
	self:CheckAddActivityEvent()
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inEvent")
	self.facade:sendNotification(GAME.EVENT_LIST_UPDATE)

	return
end

function EventProxy:updateInfoList(arg_10_1)
	if #arg_10_1 == 0 then
		return
	end

	local var_10_0 = false

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		if not instanceof(iter_10_1, EventInfo) or iter_10_1:GetState() == EventInfo.StateExpire then
			self.eventDic[iter_10_1.id] = nil
		else
			self.eventDic[iter_10_1.id] = iter_10_1

			if iter_10_1:GetState() == EventInfo.StateActive then
				var_10_0 = true

				table.insert(self.countDownList, iter_10_1.id)
			end
		end
	end

	if var_10_0 then
		table.sort(self.countDownList, CompareFuncs({
			function(arg_11_0)
				return self.eventDic[arg_11_0].finishTime
			end
		}))
	end

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inEvent")
	self.facade:sendNotification(GAME.EVENT_LIST_UPDATE)

	return
end

function EventProxy:getActiveShipIds()
	local var_12_0 = {}

	for iter_12_0, iter_12_1 in pairs(self.eventDic) do
		if iter_12_1:GetState() ~= EventInfo.StateNone then
			for iter_12_2, iter_12_3 in ipairs(iter_12_1.shipIds) do
				table.insert(var_12_0, iter_12_3)
			end
		end
	end

	return var_12_0
end

function EventProxy:existEvent(arg_13_1)
	return self.eventDic[arg_13_1] and self.eventDic[arg_13_1]:GetState() ~= EventInfo.StateExpire
end

function EventProxy:getEventInfo(arg_14_1)
	return Clone(self.eventDic[arg_14_1])
end

function EventProxy:countByState(arg_15_1)
	local var_15_0 = 0

	for iter_15_0, iter_15_1 in pairs(self.eventDic) do
		if iter_15_1:GetState() == arg_15_1 then
			var_15_0 = var_15_0 + 1
		end
	end

	return var_15_0
end

function EventProxy:hasFinishState()
	if self:countByState(EventInfo.StateFinish) > 0 then
		return true
	end

	return
end

function EventProxy:countBusyFleetNums()
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in pairs(self.eventDic) do
		if not iter_17_1:IsActivityType() and iter_17_1:GetState() > EventInfo.StateNone then
			var_17_0 = var_17_0 + 1
		end
	end

	return var_17_0
end

function EventProxy:updateTime()
	local var_18_0 = false

	while #self.countDownList > 0 and self.eventDic[self.countDownList[1]]:GetState() == EventInfo.StateFinish do
		var_18_0 = true

		table.remove(self.countDownList, 1)
	end

	if var_18_0 then
		self:sendNotification(GAME.EVENT_FINISH_UPDATE)
	end

	return
end

function EventProxy:getEventList()
	return underscore(self.eventDic):chain():values():filter(function(arg_20_0)
		return arg_20_0:GetState() ~= EventInfo.StateExpire
	end):map(function(arg_21_0)
		return Clone(arg_21_0)
	end):value()
end

function EventProxy:getActiveEvents()
	return underscore(self.eventDic):chain():values():filter(function(arg_23_0)
		return arg_23_0:GetState() == EventInfo.StateActive
	end):value()
end

function EventProxy:fillRecommendShip(arg_24_1)
	for iter_24_0, iter_24_1 in ipairs((getProxy(BayProxy):getDelegationRecommendShips(arg_24_1))) do
		table.insert(arg_24_1.shipIds, iter_24_1)
	end

	return
end

function EventProxy:fillRecommendShipLV1(arg_25_1)
	for iter_25_0, iter_25_1 in ipairs((getProxy(BayProxy):getDelegationRecommendShipsLV1(arg_25_1))) do
		table.insert(arg_25_1.shipIds, iter_25_1)
	end

	return
end

function EventProxy:checkNightEvent()
	local var_26_0 = pg.TimeMgr.GetInstance()
	local var_26_1 = var_26_0:GetServerHour()
	local var_26_2 = getGameset("night_collection_begin")[1]

	return (var_26_1 == math.clamp(var_26_1, var_26_2, var_26_0 + 24 - 1) or var_26_1 + 24 == math.clamp(var_26_1 + 24, var_26_2, getGameset("night_collection_end")[1] + 24 - 1)) and not underscore.any(underscore.values(self.eventDic), function(arg_27_0)
		local var_27_0 = arg_27_0:GetCountDownTime()

		return arg_27_0.template.type == EventConst.EVENT_TYPE_NIGHT and (not var_27_0 or var_27_0 > 0)
	end)
end

function EventProxy:checkZeroHourEvent()
	local var_28_0 = pg.TimeMgr.GetInstance()

	return var_28_0:GetTimeToNextTime(self.lastFlushTime) <= var_28_0:GetServerTime()
end

function EventProxy:CanJoinEvent(arg_29_1)
	if not arg_29_1:reachNum() then
		local var_29_1 = i18n("event_minimus_ship_numbers", arg_29_1.template.ship_num)

		return
	end

	if not arg_29_1:reachLevel() then
		local var_29_3 = i18n("event_level_unreached")

		return
	end

	if not arg_29_1:reachTypes() then
		local var_29_5 = i18n("event_type_unreached")

		return
	end

	if not arg_29_1:IsActivityType() and not self:CanStartEvent() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("event_fleet_busy"))

		return
	end

	local var_29_6 = arg_29_1:GetCountDownTime()

	if var_29_6 and var_29_6 < 0 then
		local var_29_8 = i18n("event_over_time_expired")

		return
	end

	local var_29_9 = getProxy(PlayerProxy):getData()

	if arg_29_1:getOilConsume() > var_29_9.oil then
		return false, (not ItemTipPanel.ShowOilBuyTip(arg_29_1:getOilConsume()) or nil) and i18n("common_no_oil")
	end

	local var_29_11 = pg.collection_template[arg_29_1.id]

	if pg.collection_template[arg_29_1.id] then
		if var_29_9:OilMax(var_29_11.drop_oil_max or 0) then
			return false, i18n("oil_max_tip_title") .. i18n("resource_max_tip_eventstart")
		end

		if var_29_9:GoldMax(var_29_11.drop_gold_max or 0) then
			return false, i18n("gold_max_tip_title") .. i18n("resource_max_tip_eventstart")
		end
	end

	return true
end

function EventProxy:CanFinishEvent(arg_30_1)
	if not arg_30_1.template then
		return false
	end

	local var_30_0 = getProxy(PlayerProxy):getData()

	if var_30_0:OilMax(arg_30_1.template.drop_oil_max or 0) then
		return false, i18n("oil_max_tip_title") .. i18n("resource_max_tip_event")
	end

	if var_30_0:GoldMax(arg_30_1.template.drop_gold_max or 0) then
		return false, i18n("gold_max_tip_title") .. i18n("resource_max_tip_event")
	end

	return true
end

function EventProxy:GetEventByActivityId(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(self.eventDic) do
		if iter_31_1:BelongActivity(arg_31_1) then
			return iter_31_1
		end
	end

	return
end

function EventProxy:GetEventListForCommossionInfo()
	local var_32_0 = 0
	local var_32_1 = 0
	local var_32_3 = 0
	local var_32_4 = 0
	local var_32_5 = 0
	local var_32_6 = {}

	_.each(self:getEventList(), function(arg_33_0)
		if arg_33_0:IsActivityType() then
			switch(arg_33_0:GetState(), {
				[EventInfo.StateNone] = function()
					var_32_5 = var_32_5 + 1

					return
				end,
				[EventInfo.StateActive] = function()
					var_32_4 = var_32_4 + 1

					return
				end,
				[EventInfo.StateFinish] = function()
					var_32_3 = var_32_3 + 1

					return
				end
			})
		else
			switch(arg_33_0:GetState(), {
				[EventInfo.StateNone] = function()
					return
				end,
				[EventInfo.StateActive] = function()
					var_32_1 = var_32_1 + 1

					table.insert(var_32_6, arg_33_0)

					return
				end,
				[EventInfo.StateFinish] = function()
					var_32_0 = var_32_0 + 1

					table.insert(var_32_6, arg_33_0)

					return
				end
			})
		end

		return
	end)

	return var_32_6, 0 + 0, 0 + 0, self.maxFleetNums - (0 + 0) + 0
end

function EventProxy:CheckAddActivityEvent()
	local var_40_0 = {}

	for iter_40_0, iter_40_1 in pairs(self.eventDic) do
		if iter_40_1:IsActivityType() then
			table.insert(var_40_0, {
				id = iter_40_1.id
			})
		end
	end

	for iter_40_2, iter_40_3 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT)) do
		if iter_40_3 and not iter_40_3:isEnd() then
			table.insertto(var_40_0, iter_40_3:GetCollectionList())
		end
	end

	self:updateInfoList(var_40_0)

	return #var_40_0 > 0
end

function EventProxy:CanStartEvent()
	return self:countBusyFleetNums() < self.maxFleetNums
end

return EventProxy
