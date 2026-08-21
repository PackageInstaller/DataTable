local var_0_0 = class("EventProxy", import(".NetProxy"))

function var_0_0.register(arg_1_0)
	arg_1_0.eventDic = {}
	arg_1_0.countDownList = {}
	arg_1_0.lastFlushTime = 0

	arg_1_0:on(13002, function(arg_2_0)
		arg_1_0.maxFleetNums = arg_2_0.max_team

		arg_1_0:updateAll(arg_2_0.collection_list)

		return
	end)
	arg_1_0:on(13011, function(arg_3_0)
		arg_1_0:updateInfoList(underscore.map(arg_3_0.collection, function(arg_4_0)
			local var_4_0 = EventInfo.New(arg_4_0)

			if not arg_1_0:existEvent(var_4_0.id) then
				arg_1_0.eventForMsg = var_4_0
			end

			return var_4_0
		end))

		arg_1_0.virgin = true

		return
	end)

	return
end

function var_0_0.timeCall(arg_5_0)
	return {
		[ProxyRegister.SecondCall] = function(arg_6_0)
			arg_5_0:updateTime()

			return
		end
	}
end

function var_0_0.updateAll(arg_7_0, arg_7_1)
	arg_7_0.eventDic = {}
	arg_7_0.countDownList = {}
	arg_7_0.lastFlushTime = pg.TimeMgr.GetInstance():GetServerTime()

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = EventInfo.New(iter_7_1)

		arg_7_0.eventDic[var_7_0.id] = var_7_0

		if var_7_0:GetState() == EventInfo.StateActive then
			table.insert(arg_7_0.countDownList, var_7_0.id)
		end
	end

	table.sort(arg_7_0.countDownList, CompareFuncs({
		function(arg_8_0)
			return arg_7_0.eventDic[arg_8_0].finishTime
		end
	}))
	arg_7_0:CheckAddActivityEvent()
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inEvent")
	arg_7_0.facade:sendNotification(GAME.EVENT_LIST_UPDATE)

	return
end

function var_0_0.updateInfoList(arg_9_0, arg_9_1)
	if #arg_9_1 == 0 then
		return
	end

	local var_9_0 = false

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if not instanceof(iter_9_1, EventInfo) or iter_9_1:GetState() == EventInfo.StateExpire then
			arg_9_0.eventDic[iter_9_1.id] = nil
		else
			arg_9_0.eventDic[iter_9_1.id] = iter_9_1

			if iter_9_1:GetState() == EventInfo.StateActive then
				var_9_0 = true

				table.insert(arg_9_0.countDownList, iter_9_1.id)
			end
		end
	end

	if var_9_0 then
		table.sort(arg_9_0.countDownList, CompareFuncs({
			function(arg_10_0)
				return arg_9_0.eventDic[arg_10_0].finishTime
			end
		}))
	end

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inEvent")
	arg_9_0.facade:sendNotification(GAME.EVENT_LIST_UPDATE)

	return
end

function var_0_0.getActiveShipIds(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.eventDic) do
		if iter_11_1:GetState() ~= EventInfo.StateNone then
			for iter_11_2, iter_11_3 in ipairs(iter_11_1.shipIds) do
				table.insert({}, iter_11_3)
			end
		end
	end

	return {}
end

function var_0_0.existEvent(arg_12_0, arg_12_1)
	return arg_12_0.eventDic[arg_12_1] and arg_12_0.eventDic[arg_12_1]:GetState() ~= EventInfo.StateExpire
end

function var_0_0.getEventInfo(arg_13_0, arg_13_1)
	return Clone(arg_13_0.eventDic[arg_13_1])
end

function var_0_0.countByState(arg_14_0, arg_14_1)
	local var_14_0 = 0

	for iter_14_0, iter_14_1 in pairs(arg_14_0.eventDic) do
		if iter_14_1:GetState() == arg_14_1 then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_0.hasFinishState(arg_15_0)
	if arg_15_0:countByState(EventInfo.StateFinish) > 0 then
		return true
	end

	return
end

function var_0_0.countBusyFleetNums(arg_16_0)
	local var_16_0 = 0

	for iter_16_0, iter_16_1 in pairs(arg_16_0.eventDic) do
		if not iter_16_1:IsActivityType() and iter_16_1:GetState() > EventInfo.StateNone then
			var_16_0 = var_16_0 + 1
		end
	end

	return var_16_0
end

function var_0_0.updateTime(arg_17_0)
	local var_17_0 = false

	while #arg_17_0.countDownList > 0 and arg_17_0.eventDic[arg_17_0.countDownList[1]]:GetState() == EventInfo.StateFinish do
		var_17_0 = true

		table.remove(arg_17_0.countDownList, 1)
	end

	if var_17_0 then
		arg_17_0:sendNotification(GAME.EVENT_FINISH_UPDATE)
	end

	return
end

function var_0_0.getEventList(arg_18_0)
	return underscore(arg_18_0.eventDic):chain():values():filter(function(arg_19_0)
		return arg_19_0:GetState() ~= EventInfo.StateExpire
	end):map(function(arg_20_0)
		return Clone(arg_20_0)
	end):value()
end

function var_0_0.getActiveEvents(arg_21_0)
	return underscore(arg_21_0.eventDic):chain():values():filter(function(arg_22_0)
		return arg_22_0:GetState() == EventInfo.StateActive
	end):value()
end

function var_0_0.fillRecommendShip(arg_23_0, arg_23_1)
	for iter_23_0, iter_23_1 in ipairs((getProxy(BayProxy):getDelegationRecommendShips(arg_23_1))) do
		table.insert(arg_23_1.shipIds, iter_23_1)
	end

	return
end

function var_0_0.fillRecommendShipLV1(arg_24_0, arg_24_1)
	for iter_24_0, iter_24_1 in ipairs((getProxy(BayProxy):getDelegationRecommendShipsLV1(arg_24_1))) do
		table.insert(arg_24_1.shipIds, iter_24_1)
	end

	return
end

function var_0_0.checkNightEvent(arg_25_0)
	local var_25_9000
	local var_25_0 = pg.TimeMgr.GetInstance()
	local var_25_1 = var_25_0.GetServerHour(var_25_9000)
	local var_25_2 = getGameset("night_collection_begin")[1]
	local var_25_3 = getGameset("night_collection_end")[1]
	local var_25_4 = math.clamp(var_25_1, var_25_2, var_25_0 + 24 - 1)

	return (var_25_1 == var_25_4 or var_25_1 + 24 == math.clamp(var_25_1 + 24, var_25_2, var_25_3 + 24 - 1)) and not underscore.any(underscore.values(arg_25_0.eventDic), function(arg_26_0)
		local var_26_0 = arg_26_0:GetCountDownTime()

		return arg_26_0.template.type == EventConst.EVENT_TYPE_NIGHT and (not var_26_0 or var_26_0 > 0)
	end)
end

function var_0_0.checkZeroHourEvent(arg_27_0)
	local var_27_0 = pg.TimeMgr.GetInstance()

	return var_27_0:GetTimeToNextTime(arg_27_0.lastFlushTime) <= var_27_0:GetServerTime()
end

function var_0_0.CanJoinEvent(arg_28_0, arg_28_1)
	if not arg_28_1:reachNum() then
		local var_28_1 = i18n("event_minimus_ship_numbers", arg_28_1.template.ship_num)

		return
	end

	if not arg_28_1:reachLevel() then
		local var_28_3 = i18n("event_level_unreached")

		return
	end

	if not arg_28_1:reachTypes() then
		local var_28_5 = i18n("event_type_unreached")

		return
	end

	if not arg_28_1:IsActivityType() and not arg_28_0:CanStartEvent() then
		pg.TipsMgr.GetInstance():ShowTips(i18n("event_fleet_busy"))

		return
	end

	local var_28_6 = arg_28_1:GetCountDownTime()

	if var_28_6 and var_28_6 < 0 then
		local var_28_8 = i18n("event_over_time_expired")

		return
	end

	local var_28_9 = getProxy(PlayerProxy):getData()

	if arg_28_1:getOilConsume() > var_28_9.oil then
		local var_28_10

		if not ItemTipPanel.ShowOilBuyTip(arg_28_1:getOilConsume()) then
			var_28_10 = i18n("common_no_oil")
		end

		return false, var_28_10
	end

	local var_28_11 = pg.collection_template[arg_28_1.id]

	if pg.collection_template[arg_28_1.id] then
		local var_28_12 = var_28_11.drop_oil_max or 0

		if var_28_9:OilMax(var_28_12) then
			return false, i18n("oil_max_tip_title") .. i18n("resource_max_tip_eventstart")
		end

		local var_28_13 = var_28_11.drop_gold_max or 0

		if var_28_9:GoldMax(var_28_13) then
			return false, i18n("gold_max_tip_title") .. i18n("resource_max_tip_eventstart")
		end
	end

	return true
end

function var_0_0.CanFinishEvent(arg_29_0, arg_29_1)
	if not arg_29_1.template then
		return false
	end

	local var_29_0 = getProxy(PlayerProxy):getData()
	local var_29_1 = arg_29_1.template.drop_oil_max or 0

	if var_29_0:OilMax(var_29_1) then
		return false, i18n("oil_max_tip_title") .. i18n("resource_max_tip_event")
	end

	local var_29_2 = arg_29_1.template.drop_gold_max or 0

	if var_29_0:GoldMax(var_29_2) then
		return false, i18n("gold_max_tip_title") .. i18n("resource_max_tip_event")
	end

	return true
end

function var_0_0.GetEventByActivityId(arg_30_0, arg_30_1)
	for iter_30_0, iter_30_1 in pairs(arg_30_0.eventDic) do
		if iter_30_1:BelongActivity(arg_30_1) then
			return iter_30_1
		end
	end

	return
end

function var_0_0.GetEventListForCommossionInfo(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = 0
	local var_31_3 = 0
	local var_31_4 = 0
	local var_31_5 = 0
	local var_31_6 = {}

	_.each(arg_31_0:getEventList(), function(arg_32_0)
		if arg_32_0:IsActivityType() then
			switch(arg_32_0:GetState(), {
				[EventInfo.StateNone] = function()
					var_31_5 = var_31_5 + 1

					return
				end,
				[EventInfo.StateActive] = function()
					var_31_4 = var_31_4 + 1

					return
				end,
				[EventInfo.StateFinish] = function()
					var_31_3 = var_31_3 + 1

					return
				end
			})
		else
			switch(arg_32_0:GetState(), {
				[EventInfo.StateNone] = function()
					return
				end,
				[EventInfo.StateActive] = function()
					var_31_1 = var_31_1 + 1

					table.insert(var_31_6, arg_32_0)

					return
				end,
				[EventInfo.StateFinish] = function()
					var_31_0 = var_31_0 + 1

					table.insert(var_31_6, arg_32_0)

					return
				end
			})
		end

		return
	end)

	return {}, 0 + 0, 0 + 0, arg_31_0.maxFleetNums - (0 + 0) + 0
end

function var_0_0.CheckAddActivityEvent(arg_39_0)
	for iter_39_0, iter_39_1 in pairs(arg_39_0.eventDic) do
		if iter_39_1:IsActivityType() then
			table.insert({}, {
				id = iter_39_1.id
			})
		end
	end

	for iter_39_2, iter_39_3 in ipairs(getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_COLLECTION_EVENT)) do
		if iter_39_3 and not iter_39_3:isEnd() then
			table.insertto({}, iter_39_3:GetCollectionList())
		end
	end

	arg_39_0:updateInfoList({})

	return #{} > 0
end

function var_0_0.CanStartEvent(arg_40_0)
	return arg_40_0:countBusyFleetNums() < arg_40_0.maxFleetNums
end

return var_0_0
