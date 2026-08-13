class = var_0_10000

local var_0_0 = "EventProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

function var_0_1.register(arg_1_0)
	arg_1_0.eventDic = {}
	arg_1_0.countDownList = {}
	arg_1_0.lastFlushTime = 0

	arg_1_0:on(13002, function(arg_2_0)
		arg_1_0.maxFleetNums = arg_2_0.max_team

		local var_2_0 = arg_1_0

		var_1.updateAll(var_2_0, arg_2_0.collection_list)

		return
	end)
	arg_1_0:on(13011, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.updateInfoList

		underscore = var_2_10004

		var_3_1(var_3_0, var_2_10004.map(arg_3_0.collection, function(arg_4_0)
			EventInfo = var_3_10001

			local var_4_0 = var_3_10001.New(arg_4_0)
			local var_4_1 = arg_1_0

			if not var_2.existEvent(var_4_1, var_4_0.id) then
				arg_1_0.eventForMsg = var_4_0
			end

			return var_4_0
		end))

		arg_1_0.virgin = true

		return
	end)

	return
end

function var_0_1.timeCall(arg_5_0)
	local var_5_0 = {}

	ProxyRegister = var_1_10002
	var_5_0[var_1_10002.SecondCall] = function(arg_6_0)
		local var_6_0 = arg_5_0

		var_1.updateTime(var_6_0)

		return
	end

	return var_5_0
end

function var_0_1.updateAll(arg_7_0, arg_7_1)
	arg_7_0.eventDic = {}
	arg_7_0.countDownList = {}
	pg = var_2

	local var_7_0 = var_2.TimeMgr.GetInstance()

	arg_7_0.lastFlushTime = var_2.GetServerTime(var_7_0)
	ipairs = var_2

	for iter_7_0, iter_7_1 in var_2(arg_7_1) do
		EventInfo = var_1_10007
		var_1_10007 = var_1_10007.New(iter_7_1)
		arg_7_0.eventDic[var_1_10007.id] = var_1_10007

		local var_7_1 = var_1_10007:GetState()

		EventInfo = var_9

		if var_7_1 == var_9.StateActive then
			table = var_7_1

			var_7_1.insert(arg_7_0.countDownList, var_1_10007.id)
		end
	end

	table = var_2

	local var_7_2 = var_2.sort
	local var_7_3 = arg_7_0.countDownList

	CompareFuncs = iter_7_0

	var_7_2(var_7_3, iter_7_0({
		function(arg_8_0)
			return arg_7_0.eventDic[arg_8_0].finishTime
		end
	}))
	arg_7_0:CheckAddActivityEvent()

	pg = var_2

	local var_7_4 = var_2.ShipFlagMgr.GetInstance()

	var_2.UpdateFlagShips(var_7_4, "inEvent")

	local var_7_5 = arg_7_0.facade
	local var_7_6 = var_2.sendNotification

	GAME = var_5

	var_7_6(var_7_5, var_5.EVENT_LIST_UPDATE)

	return
end

function var_0_1.updateInfoList(arg_9_0, arg_9_1)
	if #arg_9_1 == 0 then
		return
	end

	local var_9_0 = false

	ipairs = var_1_10003

	for iter_9_0, iter_9_1 in var_1_10003(arg_9_1) do
		instanceof = var_1_10008

		local var_9_1 = iter_9_1

		EventInfo = var_1_10011

		if var_1_10008(var_9_1, var_1_10011) then
			var_1_10008 = iter_9_1:GetState()
			EventInfo = var_1_10009

			if var_1_10008 == var_1_10009.StateExpire then
				var_1_10008 = arg_9_0.eventDic
				var_1_10008[iter_9_1.id] = nil
			else
				var_1_10008 = arg_9_0.eventDic
				var_1_10008[iter_9_1.id] = iter_9_1
				var_1_10008 = iter_9_1:GetState()
				EventInfo = var_1_10009

				if var_1_10008 == var_1_10009.StateActive then
					var_9_0 = true
					table = var_1_10008

					var_1_10008.insert(arg_9_0.countDownList, iter_9_1.id)
				end
			end
		end
	end

	local var_9_2

	if var_9_0 then
		table = var_9_2
		var_9_2 = var_9_2.sort

		local var_9_3 = arg_9_0.countDownList

		CompareFuncs = iter_9_0

		var_9_2(var_9_3, iter_9_0({
			function(arg_10_0)
				return arg_9_0.eventDic[arg_10_0].finishTime
			end
		}))
	end

	pg = var_9_2

	local var_9_4 = var_9_2.ShipFlagMgr.GetInstance()

	var_3.UpdateFlagShips(var_9_4, "inEvent")

	local var_9_5 = arg_9_0.facade
	local var_9_6 = var_3.sendNotification

	GAME = var_6

	var_9_6(var_9_5, var_6.EVENT_LIST_UPDATE)

	return
end

function var_0_1.getActiveShipIds(arg_11_0)
	local var_11_0 = {}

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.eventDic) do
		local var_11_1 = iter_11_1:GetState()

		EventInfo = var_1_10008

		if var_11_1 ~= var_1_10008.StateNone then
			ipairs = var_11_1

			for iter_11_2, iter_11_3 in var_11_1(iter_11_1.shipIds) do
				table = var_1_10012

				var_1_10012.insert(var_11_0, iter_11_3)
			end
		end
	end

	return var_11_0
end

function var_0_1.existEvent(arg_12_0, arg_12_1)
	local var_12_1

	if arg_12_0.eventDic[arg_12_1] then
		local var_12_0 = arg_12_0.eventDic[arg_12_1]

		var_12_1 = var_12_1.GetState(var_12_0)
		EventInfo = var_1_10003
		var_12_1 = var_12_1 ~= var_1_10003.StateExpire
	end

	return var_12_1
end

function var_0_1.getEventInfo(arg_13_0, arg_13_1)
	Clone = var_1_10002

	return var_1_10002(arg_13_0.eventDic[arg_13_1])
end

function var_0_1.countByState(arg_14_0, arg_14_1)
	local var_14_0 = 0

	pairs = var_1_10003

	for iter_14_0, iter_14_1 in var_1_10003(arg_14_0.eventDic) do
		if iter_14_1:GetState() == arg_14_1 then
			var_14_0 = var_14_0 + 1
		end
	end

	return var_14_0
end

function var_0_1.hasFinishState(arg_15_0)
	local var_15_0 = arg_15_0
	local var_15_1 = arg_15_0.countByState

	EventInfo = var_1_10004

	if var_15_1(var_15_0, var_1_10004.StateFinish) > 0 then
		return true
	end

	return
end

function var_0_1.countBusyFleetNums(arg_16_0)
	local var_16_0 = 0

	pairs = var_1_10002

	for iter_16_0, iter_16_1 in var_1_10002(arg_16_0.eventDic) do
		if not iter_16_1:IsActivityType() then
			local var_16_1 = iter_16_1:GetState()

			EventInfo = var_1_10008

			if var_1_10008.StateNone < var_16_1 then
				var_16_0 = var_16_0 + 1
			end
		end
	end

	return var_16_0
end

function var_0_1.updateTime(arg_17_0)
	local var_17_0 = false

	::label_17_0::

	if #arg_17_0.countDownList > 0 then
		local var_17_1 = arg_17_0.eventDic[arg_17_0.countDownList[1]]
		local var_17_2 = var_2.GetState(var_17_1)

		EventInfo = var_3

		if var_17_2 == var_3.StateFinish then
			repeat
				var_17_0 = true
				table = var_17_2

				var_17_2.remove(arg_17_0.countDownList, 1)

				goto label_17_0
			until true
		end
	end

	if var_17_0 then
		local var_17_3 = arg_17_0
		local var_17_4 = arg_17_0.sendNotification

		GAME = var_1_10005

		var_17_4(var_17_3, var_1_10005.EVENT_FINISH_UPDATE)
	end

	return
end

function var_0_1.getEventList(arg_18_0)
	underscore = var_1_10001

	local var_18_0 = var_1_10001(arg_18_0.eventDic)
	local var_18_1 = var_1.chain(var_18_0)
	local var_18_2 = var_1.values(var_18_1)
	local var_18_3 = var_1.filter(var_18_2, function(arg_19_0)
		local var_19_0 = arg_19_0:GetState()

		EventInfo = var_2_10002

		return var_19_0 ~= var_2_10002.StateExpire
	end)
	local var_18_4 = var_1.map(var_18_3, function(arg_20_0)
		Clone = var_2_10001

		return var_2_10001(arg_20_0)
	end)

	return var_1.value(var_18_4)
end

function var_0_1.getActiveEvents(arg_21_0)
	underscore = var_1_10001

	local var_21_0 = var_1_10001(arg_21_0.eventDic)
	local var_21_1 = var_1.chain(var_21_0)
	local var_21_2 = var_1.values(var_21_1)
	local var_21_3 = var_1.filter(var_21_2, function(arg_22_0)
		local var_22_0 = arg_22_0:GetState()

		EventInfo = var_2_10002

		return var_22_0 == var_2_10002.StateActive
	end)

	return var_1.value(var_21_3)
end

function var_0_1.fillRecommendShip(arg_23_0, arg_23_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_23_0 = var_1_10002(var_1_10004)
	local var_23_1 = var_2.getDelegationRecommendShips(var_23_0, arg_23_1)

	ipairs = var_1_10004

	for iter_23_0, iter_23_1 in var_1_10004(var_23_1) do
		table = var_1_10009

		var_1_10009.insert(arg_23_1.shipIds, iter_23_1)
	end

	return
end

function var_0_1.fillRecommendShipLV1(arg_24_0, arg_24_1)
	getProxy = var_1_10002
	BayProxy = var_1_10004

	local var_24_0 = var_1_10002(var_1_10004)
	local var_24_1 = var_2.getDelegationRecommendShipsLV1(var_24_0, arg_24_1)

	ipairs = var_1_10004

	for iter_24_0, iter_24_1 in var_1_10004(var_24_1) do
		table = var_1_10009

		var_1_10009.insert(arg_24_1.shipIds, iter_24_1)
	end

	return
end

function var_0_1.checkNightEvent(arg_25_0)
	pg = var_1_10001

	local var_25_0 = var_1_10001.TimeMgr.GetInstance()
	local var_25_1 = var_1.GetServerHour(var_25_0)

	getGameset = var_1_10002

	local var_25_2 = var_1_10002("night_collection_begin")[1]

	getGameset = var_25_0

	local var_25_3 = var_25_0("night_collection_end")[1]

	math = var_4

	local var_25_5

	if var_25_1 ~= var_4.clamp(var_25_1, var_25_2, var_25_3 + 24 - 1) then
		local var_25_4 = var_25_1 + 24

		math = var_25_6

		if var_25_4 ~= var_25_6.clamp(var_25_1 + 24, var_25_2, var_25_3 + 24 - 1) then
			var_25_5 = false

			goto label_25_0
		end
	end

	var_25_5 = true

	do
		local var_25_6
	end

	::label_25_0::

	if var_25_5 then
		::label_25_1::

		underscore = var_25_6
		var_25_6 = var_25_6.any
		underscore = var_7
		var_25_6 = not var_25_6(var_7.values(arg_25_0.eventDic), function(arg_26_0)
			local var_26_0 = arg_26_0
			local var_26_1 = arg_26_0.GetCountDownTime(var_26_0)
			local var_26_2 = arg_26_0.template.type

			EventConst = var_26_0

			return var_26_2 == var_26_0.EVENT_TYPE_NIGHT and (not var_26_1 or var_26_1 > 0)
		end)
	end

	return var_25_6
end

function var_0_1.checkZeroHourEvent(arg_27_0)
	pg = var_1_10001

	local var_27_0 = var_1_10001.TimeMgr.GetInstance()

	return var_1.GetTimeToNextTime(var_27_0, arg_27_0.lastFlushTime) <= var_1:GetServerTime()
end

function var_0_1.CanJoinEvent(arg_28_0, arg_28_1)
	if not arg_28_1:reachNum() then
		local var_28_0 = false

		i18n = var_1_10003
		var_1_10003 = var_1_10003("event_minimus_ship_numbers", arg_28_1.template.ship_num)

		return
	end

	if not arg_28_1:reachLevel() then
		local var_28_1 = false

		i18n = var_1_10003
		var_1_10003 = var_1_10003("event_level_unreached")

		return
	end

	if not arg_28_1:reachTypes() then
		local var_28_2 = false

		i18n = var_1_10003

		local var_28_3 = var_1_10003("event_type_unreached")

		return
	end

	local var_28_4 = arg_28_1

	if not arg_28_1.IsActivityType(var_28_4) and not arg_28_0:CanStartEvent() then
		pg = var_3

		local var_28_5 = var_3.TipsMgr.GetInstance()
		local var_28_6 = var_3.ShowTips

		i18n = var_1_10006

		var_28_6(var_28_5, var_1_10006("event_fleet_busy"))

		return
	end

	local var_28_7 = arg_28_1

	if arg_28_1.GetCountDownTime(var_28_7) and var_3 < 0 then
		var_28_4 = false
		i18n = var_28_7

		local var_28_8 = var_28_7("event_over_time_expired")

		return
	end

	getProxy = var_28_4
	PlayerProxy = var_1_10006

	local var_28_9 = var_28_4(var_1_10006)
	local var_28_10 = var_4.getData(var_28_9)
	local var_28_11 = arg_28_1:getOilConsume()

	if var_28_10.oil < var_28_11 then
		var_28_11 = nil
		ItemTipPanel = var_7

		if not var_7.ShowOilBuyTip(arg_28_1:getOilConsume()) then
			i18n = var_7
			var_28_11 = var_7("common_no_oil")
		end

		return false, var_28_11
	end

	pg = var_28_11

	if var_28_11.collection_template[arg_28_1.id] then
		local var_28_12

		if not var_6.drop_oil_max then
			var_28_12 = 0
		end

		local var_28_13 = var_28_10

		if var_28_10.OilMax(var_28_13, var_28_12) then
			local var_28_14 = false

			i18n = var_1_10009

			local var_28_15 = var_1_10009("oil_max_tip_title")

			i18n = var_28_13

			return var_28_14, var_28_15 .. var_28_13("resource_max_tip_eventstart")
		end

		local var_28_16

		if not var_6.drop_gold_max then
			var_28_16 = 0
		end

		local var_28_17 = var_28_10

		if var_28_10.GoldMax(var_28_17, var_28_16) then
			local var_28_18 = false

			i18n = var_28_13

			local var_28_19 = var_28_13("gold_max_tip_title")

			i18n = var_28_17

			return var_28_18, var_28_19 .. var_28_17("resource_max_tip_eventstart")
		end
	end

	return true
end

function var_0_1.CanFinishEvent(arg_29_0, arg_29_1)
	if not arg_29_1.template then
		return false
	end

	getProxy = var_1_10003
	PlayerProxy = var_1_10005

	local var_29_0 = var_1_10003(var_1_10005)
	local var_29_1 = var_3.getData(var_29_0)
	local var_29_2

	if not var_2.drop_oil_max then
		var_29_2 = 0
	end

	local var_29_3 = var_29_1

	if var_29_1.OilMax(var_29_3, var_29_2) then
		local var_29_4 = false

		i18n = var_1_10006

		local var_29_5 = var_1_10006("oil_max_tip_title")

		i18n = var_29_3

		return var_29_4, var_29_5 .. var_29_3("resource_max_tip_event")
	end

	local var_29_6

	if not var_2.drop_gold_max then
		var_29_6 = 0
	end

	local var_29_7 = var_29_1

	if var_29_1.GoldMax(var_29_7, var_29_6) then
		local var_29_8 = false

		i18n = var_29_3

		local var_29_9 = var_29_3("gold_max_tip_title")

		i18n = var_29_7

		return var_29_8, var_29_9 .. var_29_7("resource_max_tip_event")
	end

	return true
end

function var_0_1.GetEventByActivityId(arg_30_0, arg_30_1)
	pairs = var_1_10002

	for iter_30_0, iter_30_1 in var_1_10002(arg_30_0.eventDic) do
		if iter_30_1:BelongActivity(arg_30_1) then
			return iter_30_1
		end
	end

	return
end

function var_0_1.GetEventListForCommossionInfo(arg_31_0)
	local var_31_0 = 0
	local var_31_1 = 0
	local var_31_2 = 0
	local var_31_3 = 0
	local var_31_4 = 0
	local var_31_5 = 0
	local var_31_6 = {}

	_ = var_1_10008

	var_1_10008.each(arg_31_0:getEventList(), function(arg_32_0)
		if arg_32_0:IsActivityType() then
			switch = var_1

			local var_32_0 = arg_32_0
			local var_32_1 = arg_32_0.GetState(var_32_0)
			local var_32_2 = {}

			EventInfo = var_32_0
			var_32_2[var_32_0.StateNone] = function()
				var_31_5 = var_31_5 + 1

				return
			end
			EventInfo = var_5
			var_32_2[var_5.StateActive] = function()
				var_31_4 = var_31_4 + 1

				return
			end
			EventInfo = var_5
			var_32_2[var_5.StateFinish] = function()
				var_31_3 = var_31_3 + 1

				return
			end

			var_1(var_32_1, var_32_2)
		else
			switch = var_1

			local var_32_3 = arg_32_0
			local var_32_4 = arg_32_0.GetState(var_32_3)
			local var_32_5 = {}

			EventInfo = var_32_3
			var_32_5[var_32_3.StateNone] = function()
				return
			end
			EventInfo = var_5
			var_32_5[var_5.StateActive] = function()
				var_31_1 = var_31_1 + 1
				table = var_0

				var_0.insert(var_31_6, arg_32_0)

				return
			end
			EventInfo = var_5
			var_32_5[var_5.StateFinish] = function()
				var_31_0 = var_31_0 + 1
				table = var_0

				var_0.insert(var_31_6, arg_32_0)

				return
			end

			var_1(var_32_4, var_32_5)
		end

		return
	end)

	local var_31_7 = var_31_0 + var_31_3
	local var_31_8 = var_31_1 + var_31_4
	local var_31_9 = arg_31_0.maxFleetNums - (var_31_0 + var_31_1) + var_31_5

	return var_31_6, var_31_7, var_31_8, var_31_9
end

function var_0_1.CheckAddActivityEvent(arg_39_0)
	local var_39_0 = {}

	pairs = var_1_10002

	for iter_39_0, iter_39_1 in var_1_10002(arg_39_0.eventDic) do
		if iter_39_1:IsActivityType() then
			table = var_1_10007

			var_1_10007.insert(var_39_0, {
				id = iter_39_1.id
			})
		end
	end

	ipairs = var_2
	getProxy = var_4
	ActivityProxy = iter_39_1

	local var_39_1 = var_4(iter_39_1)
	local var_39_2 = var_4.getActivitiesByType

	ActivityConst = var_1_10007

	for iter_39_2, iter_39_3 in var_2(var_39_2(var_39_1, var_1_10007.ACTIVITY_TYPE_COLLECTION_EVENT)) do
		if iter_39_3 and not iter_39_3:isEnd() then
			table = var_7

			var_7.insertto(var_39_0, iter_39_3:GetCollectionList())
		end
	end

	arg_39_0:updateInfoList(var_39_0)

	return #var_39_0 > 0
end

function var_0_1.CanStartEvent(arg_40_0)
	return arg_40_0:countBusyFleetNums() < arg_40_0.maxFleetNums
end

return var_0_1
