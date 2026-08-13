class = var_0_10000

local var_0_0 = "BuildShipProxy"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003(".NetProxy"))

var_0_1.ADDED = "BuildShipProxy ADDED"
var_0_1.TIMEUP = "BuildShipProxy TIMEUP"
var_0_1.UPDATED = "BuildShipProxy UPDATED"
var_0_1.REMOVED = "BuildShipProxy REMOVED"
var_0_1.DRAW_COUNT_UPDATE = "BuildShipProxy DRAW_COUNT_UPDATE"
var_0_1.REGULAR_BUILD_POOL_COUNT_UPDATE = "BuildShipProxy.REGULAR_BUILD_POOL_COUNT_UPDATE"

function var_0_1.register(arg_1_0)
	arg_1_0:on(12024, function(arg_2_0)
		arg_1_0.data = {}
		arg_1_0.workCount = arg_2_0.worklist_count
		arg_1_0.drawCount1 = arg_2_0.draw_count_1

		local var_2_0 = arg_1_0

		var_2_0.drawCount10 = arg_2_0.draw_count_10
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.worklist_list) do
			BuildShip = var_2_10006

			local var_2_1 = var_2_10006.New(iter_2_1)

			var_2_10006.setId(var_2_1, iter_2_0)

			table = var_7

			var_7.insert(arg_1_0.data, var_2_10006)
		end

		local var_2_2 = arg_1_0

		var_1.setBuildShipState(var_2_2)

		arg_1_0.regularExchangeCount = arg_2_0.exchange_count

		return
	end)

	return
end

function var_0_1.GetPools(arg_3_0)
	local var_3_0 = {}

	getProxy = var_1_10002
	ActivityProxy = var_1_10004

	local var_3_1 = var_1_10002(var_1_10004)

	ipairs = var_1_10003

	local var_3_2 = var_3_1
	local var_3_3 = var_3_1.getActivitiesByTypes
	local var_3_4 = {}

	ActivityConst = var_1_10009
	var_3_4[1] = var_1_10009.ACTIVITY_TYPE_BUILDSHIP_1
	ActivityConst = var_9
	var_3_4[2] = var_9.ACTIVITY_TYPE_NEWSERVER_BUILD

	for iter_3_0, iter_3_1 in var_1_10003(var_3_3(var_3_2, var_3_4)) do
		local var_3_5 = {}

		table = var_9

		var_9.insert(var_3_5, function(arg_4_0)
			if iter_3_1 then
				local var_4_0 = iter_3_1

				if not var_1.isEnd(var_4_0) then
					arg_4_0()
				end
			end

			return
		end)

		table = var_9

		var_9.insert(var_3_5, function(arg_5_0)
			pg = var_2_10001

			local var_5_0 = var_2_10001.ship_data_create_exchange[iter_3_1.id]
			local var_5_1 = iter_3_1
			local var_5_2 = var_2.getConfig(var_5_1, "type")

			ActivityConst = var_2_10003

			if var_5_2 == var_2_10003.ACTIVITY_TYPE_NEWSERVER_BUILD and iter_3_1.data2 >= var_5_0.exchange_available_times then
				-- block empty
			else
				arg_5_0()
			end

			return
		end)

		seriesAsync = var_9

		var_9(var_3_5, function()
			table = var_2_10000

			local var_6_0 = var_2_10000.insert
			local var_6_1 = var_3_0

			BuildShipActivityPool = var_2_10003

			local var_6_2 = var_2_10003.New
			local var_6_3 = {
				activityId = iter_3_1.id
			}
			local var_6_4 = iter_3_1

			var_6_3.id = var_6.getConfig(var_6_4, "config_id")
			BuildShipPool = var_6
			var_6_3.mark = var_6.BUILD_POOL_MARK_NEW

			var_6_0(var_6_1, var_6_2(var_6_3))

			return
		end)
	end

	table = var_3

	local var_3_6 = var_3.insert
	local var_3_7 = var_3_0

	BuildShipPool = iter_3_0

	local var_3_8 = iter_3_0.New
	local var_3_9 = {
		id = 2
	}

	BuildShipPool = var_9
	var_3_9.mark = var_9.BUILD_POOL_MARK_LIGHT

	var_3_6(var_3_7, var_3_8(var_3_9))

	table = var_3_6

	local var_3_10 = var_3_6.insert
	local var_3_11 = var_3_0

	BuildShipPool = var_6

	local var_3_12 = var_6.New
	local var_3_13 = {
		id = 3
	}

	BuildShipPool = var_9
	var_3_13.mark = var_9.BUILD_POOL_MARK_HEAVY

	var_3_10(var_3_11, var_3_12(var_3_13))

	table = var_3_10

	local var_3_14 = var_3_10.insert
	local var_3_15 = var_3_0

	BuildShipPool = var_6

	local var_3_16 = var_6.New
	local var_3_17 = {
		id = 1
	}

	BuildShipPool = var_9
	var_3_17.mark = var_9.BUILD_POOL_MARK_SPECIAL

	var_3_14(var_3_15, var_3_16(var_3_17))

	return var_3_0
end

function var_0_1.GetPoolsWithoutNewServer(arg_7_0)
	local var_7_0 = arg_7_0:GetPools()

	_ = var_1_10002

	return var_1_10002.select(var_7_0, function(arg_8_0)
		local var_8_0

		if arg_8_0:IsActivity() then
			var_8_0 = arg_8_0:IsNewServerBuild()
		end

		return not var_8_0
	end)
end

function var_0_1.setBuildShipState(arg_9_0)
	arg_9_0:removeBuildTimer()

	arg_9_0.buildIndex = 0
	arg_9_0.buildTimers = {}

	local var_9_0 = 0

	ipairs = var_1_10002

	local var_9_1

	if not arg_9_0.data then
		var_9_1 = {}
	end

	for iter_9_0, iter_9_1 in var_1_10002(var_9_1) do
		if var_9_0 == arg_9_0:getMaxWorkCount() then
			break
		end

		if not iter_9_1:isFinish() then
			arg_9_0.buildIndex = iter_9_0
			var_9_0 = var_9_0 + 1

			arg_9_0:addBuildTimer()
		end

		if iter_9_1:isFinish() then
			BuildShip = var_9_2

			local var_9_2

			if not var_9_2.FINISH then
				BuildShip = var_9_2
				var_9_2 = var_9_2.ACTIVE
			end

			iter_9_1.state = var_9_2
		end
	end

	return
end

function var_0_1.getNextBuildShip(arg_10_0)
	local var_10_0

	if arg_10_0.data[arg_10_0.buildIndex + 1] then
		local var_10_1 = var_2.state

		BuildShip = var_1_10004

		if var_10_1 == var_1_10004.INACTIVE then
			arg_10_0.buildIndex = arg_10_0.buildIndex + 1
			var_10_0 = var_2
		end
	end

	return var_10_0
end

function var_0_1.activeNextBuild(arg_11_0)
	if arg_11_0:getNextBuildShip() then
		var_1:active()
		arg_11_0:updateBuildShip(arg_11_0.buildIndex, var_1)
		arg_11_0:addBuildTimer()
	end

	return
end

function var_0_1.addBuildTimer(arg_12_0)
	local var_12_0 = arg_12_0.buildIndex

	if arg_12_0.buildTimers[var_12_0] then
		var_1_10004 = arg_12_0.buildTimers[var_12_0]

		var_2.Stop(var_1_10004)

		arg_12_0.buildTimers[var_12_0] = nil
	end

	local function var_12_1()
		local var_13_0 = arg_12_0

		var_0.activeNextBuild(var_13_0)

		local var_13_1 = arg_12_0.data[var_12_0]

		var_0.finish(var_13_1)

		local var_13_2 = arg_12_0.data[var_12_0]

		var_0.display(var_13_2, "- build finish -")

		local var_13_3 = arg_12_0

		var_0.updateBuildShip(var_13_3, var_12_0, arg_12_0.data[var_12_0])

		return
	end

	local var_12_2 = arg_12_0.data[var_12_0].finishTime

	pg = var_1_10004

	local var_12_3 = var_1_10004.TimeMgr.GetInstance()

	if var_12_2 - var_4.GetServerTime(var_12_3) > 0 then
		local var_12_4 = arg_12_0.buildTimers

		Timer = var_1_10005
		var_12_4[var_12_0] = var_1_10005.New(function()
			local var_14_0 = arg_12_0.buildTimers[var_12_0]

			var_0.Stop(var_14_0)

			arg_12_0.buildTimers[var_12_0] = nil

			var_12_1()

			return
		end, var_3, 1)

		local var_12_5 = arg_12_0.buildTimers[var_12_0]

		var_4.Start(var_12_5)
	else
		var_12_1()
	end

	return
end

function var_0_1.getMaxWorkCount(arg_15_0)
	return arg_15_0.workCount
end

function var_0_1.getBuildShipCount(arg_16_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_16_0.data)
end

function var_0_1.removeBuildTimer(arg_17_0)
	pairs = var_1_10001

	local var_17_0

	if not arg_17_0.buildTimers then
		var_17_0 = {}
	end

	for iter_17_0, iter_17_1 in var_1_10001(var_17_0) do
		iter_17_1:Stop()
	end

	arg_17_0.buildTimers = nil

	return
end

function var_0_1.remove(arg_18_0)
	arg_18_0:removeBuildTimer()

	if arg_18_0.exchangeItemTimer then
		local var_18_0 = arg_18_0.exchangeItemTimer

		var_1.Stop(var_18_0)

		arg_18_0.exchangeItemTimer = nil
	end

	return
end

function var_0_1.getBuildShip(arg_19_0, arg_19_1)
	Clone = var_1_10002

	return var_1_10002(arg_19_0.data[arg_19_1])
end

function var_0_1.getFinishCount(arg_20_0)
	local var_20_0 = 0

	pairs = var_1_10002

	for iter_20_0, iter_20_1 in var_1_10002(arg_20_0.data) do
		local var_20_1 = iter_20_1.state

		BuildShip = var_1_10008

		if var_20_1 == var_1_10008.FINISH then
			var_20_0 = var_20_0 + 1
		end
	end

	return var_20_0
end

function var_0_1.getNeedFinishCount(arg_21_0)
	table = var_1_10001

	return var_1_10001.getCount(arg_21_0.data) - arg_21_0:getFinishCount()
end

function var_0_1.getActiveCount(arg_22_0)
	local var_22_0 = 0

	pairs = var_1_10002

	for iter_22_0, iter_22_1 in var_1_10002(arg_22_0.data) do
		local var_22_1 = iter_22_1.state

		BuildShip = var_1_10008

		if var_22_1 == var_1_10008.ACTIVE then
			var_22_0 = var_22_0 + 1
		end
	end

	return var_22_0
end

function var_0_1.getFinishedIndex(arg_23_0)
	ipairs = var_1_10001

	for iter_23_0, iter_23_1 in var_1_10001(arg_23_0.data) do
		local var_23_0 = iter_23_1.state

		BuildShip = var_1_10007

		if var_23_0 == var_1_10007.FINISH then
			return iter_23_0
		end
	end

	return
end

function var_0_1.canBuildShip(arg_24_0, arg_24_1)
	local var_24_0 = arg_24_0
	local var_24_1 = arg_24_0.getActiveCount(var_24_0)

	pg = var_1_10003

	local var_24_2 = var_1_10003.ship_data_create_material[arg_24_1]

	getProxy = var_24_0
	BagProxy = var_1_10006

	local var_24_3 = var_24_0(var_1_10006)

	if var_4.getItemById(var_24_3, var_24_2.use_item) and var_5.count >= var_24_2.number_1 then
		getProxy = var_6
		PlayerProxy = var_8

		local var_24_4 = var_6(var_8)

		return var_6.getData(var_24_4).gold >= var_24_2.use_gold and var_24_1 == 0
	end

	return
end

function var_0_1.getActiveOrFinishedCount(arg_25_0)
	local var_25_0 = 0

	pairs = var_1_10002

	for iter_25_0, iter_25_1 in var_1_10002(arg_25_0.data) do
		local var_25_1 = iter_25_1.state

		BuildShip = var_1_10008

		if var_25_1 ~= var_1_10008.ACTIVE then
			local var_25_2 = iter_25_1.state

			BuildShip = var_1_10008

			if var_25_2 == var_1_10008.FINISH then
				var_25_0 = var_25_0 + 1
			end
		end
	end

	return var_25_0
end

function var_0_1.getDrawCount(arg_26_0)
	return {
		drawCount1 = arg_26_0.drawCount1,
		drawCount10 = arg_26_0.drawCount10
	}
end

function var_0_1.increaseDrawCount(arg_27_0, arg_27_1)
	if arg_27_1 == 1 then
		arg_27_0.drawCount1 = arg_27_0.drawCount1 + 1
	elseif arg_27_1 == 10 then
		arg_27_0.drawCount10 = arg_27_0.drawCount10 + 1
	end

	arg_27_0:sendNotification(var_0_1.DRAW_COUNT_UPDATE, arg_27_0:getDrawCount())

	return
end

function var_0_1.addBuildShip(arg_28_0, arg_28_1)
	assert = var_1_10002
	isa = var_1_10004

	local var_28_0 = arg_28_1

	BuildShip = var_1_10007

	var_1_10002(var_1_10004(var_28_0, var_1_10007), "should be an instance of BuildShip")

	table = var_1_10002

	var_1_10002.insert(arg_28_0.data, arg_28_1)

	local var_28_1 = arg_28_0

	if arg_28_0.getActiveCount(var_28_1) < arg_28_0:getMaxWorkCount() then
		local var_28_2 = arg_28_1

		var_28_1 = arg_28_1.setState
		BuildShip = var_1_10007

		var_28_1(var_28_2, var_1_10007.ACTIVE)

		arg_28_0.buildIndex = #arg_28_0.data

		arg_28_0:addBuildTimer()
	elseif var_2 == var_3 then
		local var_28_3 = arg_28_1

		var_28_1 = arg_28_1.setState
		BuildShip = var_1_10007

		var_28_1(var_28_3, var_1_10007.INACTIVE)
	else
		assert = var_28_1

		var_28_1(false, "激活的建船数量大于最大数量")
	end

	arg_28_0:sendNotification(var_0_1.ADDED, arg_28_1:clone())

	return
end

function var_0_1.finishBuildShip(arg_29_0, arg_29_1)
	if arg_29_0.buildTimers[arg_29_1] then
		arg_29_0.buildTimers[arg_29_1].func()
	end

	return
end

function var_0_1.updateBuildShip(arg_30_0, arg_30_1, arg_30_2)
	assert = var_1_10003
	isa = var_1_10005

	local var_30_0 = arg_30_2

	BuildShip = var_1_10008

	var_1_10003(var_1_10005(var_30_0, var_1_10008), "should be an instance of BuildShip")

	arg_30_0.data[arg_30_1] = arg_30_2:clone()

	arg_30_0:sendNotification(var_0_1.UPDATED, {
		index = arg_30_1,
		buildShip = arg_30_2:clone()
	})

	return
end

function var_0_1.removeBuildShipByIndex(arg_31_0, arg_31_1)
	local var_31_0 = arg_31_0.data[arg_31_1]
	local var_31_1 = var_2.clone(var_31_0)

	assert = var_1_10003

	var_1_10003(var_31_1 ~= nil, "buildShip should exist")

	arg_31_0.lastPoolType = arg_31_0.data[arg_31_1].type
	table = var_3

	var_3.remove(arg_31_0.data, arg_31_1)
	arg_31_0:sendNotification(var_0_1.REMOVED, {
		index = arg_31_1,
		buildShip = var_31_1
	})

	return
end

function var_0_1.getSkipBatchBuildFlag(arg_32_0)
	local var_32_0

	if not arg_32_0.skipBatchFlag then
		var_32_0 = false
	end

	return var_32_0
end

function var_0_1.setSkipBatchBuildFlag(arg_33_0, arg_33_1)
	arg_33_0.skipBatchFlag = arg_33_1

	return
end

function var_0_1.getLastBuildShipPoolType(arg_34_0)
	local var_34_0

	if not arg_34_0.lastPoolType then
		var_34_0 = 0
	end

	return var_34_0
end

function var_0_1.getSupportShipCost(arg_35_0)
	pg = var_1_10001

	return var_1_10001.gameset.supports_config.description[1]
end

function var_0_1.changeRegularExchangeCount(arg_36_0, arg_36_1)
	math = var_1_10002

	local var_36_0 = var_1_10002.clamp
	local var_36_1 = arg_36_0.regularExchangeCount + arg_36_1
	local var_36_2 = 0

	pg = var_1_10006

	local var_36_3 = var_1_10006.ship_data_create_exchange

	REGULAR_BUILD_POOL_EXCHANGE_ID = var_1_10007
	arg_36_0.regularExchangeCount = var_36_0(var_36_1, var_36_2, var_36_3[var_1_10007].exchange_request)

	arg_36_0:sendNotification(var_0_1.REGULAR_BUILD_POOL_COUNT_UPDATE)

	return
end

function var_0_1.getRegularExchangeCount(arg_37_0)
	return arg_37_0.regularExchangeCount
end

return var_0_1
