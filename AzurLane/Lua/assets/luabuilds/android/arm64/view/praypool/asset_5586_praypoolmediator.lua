class = var_0_10000

local var_0_0 = "PrayPoolMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

function var_0_1.register(arg_1_0)
	local var_1_0 = arg_1_0
	local var_1_1 = arg_1_0.bind

	PrayPoolConst = var_1_10004

	var_1_1(var_1_0, var_1_10004.CLICK_INDEX_BTN, function(arg_2_0, arg_2_1)
		local var_2_0 = arg_1_0
		local var_2_1 = var_2.addSubLayers

		Context = var_2_10005

		local var_2_2 = var_2_10005.New
		local var_2_3 = {}

		CustomIndexLayer = var_2_10008
		var_2_3.viewComponent = var_2_10008
		CustomIndexMediator = var_2_10008
		var_2_3.mediator = var_2_10008
		var_2_3.data = arg_2_1

		var_2_1(var_2_0, var_2_2(var_2_3))

		return
	end)

	local var_1_2 = arg_1_0
	local var_1_3 = arg_1_0.bind

	PrayPoolConst = var_4

	var_1_3(var_1_2, var_4.CLICK_BUILD_BTN, function(arg_3_0, arg_3_1)
		local var_3_0 = arg_1_0
		local var_3_1 = var_2.sendNotification

		PrayPoolConst = var_2_10005

		var_3_1(var_3_0, var_2_10005.BUILD_PRAY_POOL_CMD, arg_3_1)

		return
	end)

	local var_1_4 = arg_1_0
	local var_1_5 = arg_1_0.bind

	PrayPoolConst = var_4

	var_1_5(var_1_4, var_4.START_BUILD_SHIP_EVENT, function(arg_4_0, arg_4_1, arg_4_2, arg_4_3)
		local var_4_0 = arg_1_0
		local var_4_1 = var_4.sendNotification

		GAME = var_2_10007

		local var_4_2 = var_2_10007.ACTIVITY_OPERATION
		local var_4_3 = {
			cmd = 2,
			buildId = arg_4_1
		}

		ActivityConst = var_2_10009
		var_4_3.activity_id = var_2_10009.ACTIVITY_PRAY_POOL
		var_4_3.arg1 = arg_4_2
		var_4_3.arg2 = arg_4_3

		var_4_1(var_4_0, var_4_2, var_4_3)

		return
	end)

	getProxy = var_1_5
	ActivityProxy = var_1_4

	local var_1_6 = var_1_5(var_1_4)

	getProxy = var_1_10002
	PrayProxy = var_4

	local var_1_7 = var_1_10002(var_4)
	local var_1_8 = var_2.getPageState(var_1_7)

	PrayProxy = var_4

	if var_1_8 ~= var_4.STAGE_BUILD_SUCCESS then
		local var_1_9 = var_1_6
		local var_1_10 = var_1_6.getActivityById

		ActivityConst = var_1_10006

		if var_1_10(var_1_9, var_1_10006.ACTIVITY_PRAY_POOL) then
			local var_1_11 = var_3
			local var_1_12 = var_3.getData1(var_1_11)
			local var_1_13 = var_3:getData1List()

			if var_1_12 then
				table = var_1_11

				local var_1_14 = var_1_11.indexof

				pg = var_1_10008

				if var_1_14(var_1_10008.activity_ship_create.all, var_1_12, 1) then
					var_2:setSelectedPoolNum(var_1_12)
					var_2:setSelectedShipList(var_1_13)

					local var_1_15 = var_2
					local var_1_16 = var_2.updatePageState

					PrayProxy = var_9

					var_1_16(var_1_15, var_9.STAGE_BUILD_SUCCESS)
				end
			end
		end
	end

	return
end

function var_0_1.listNotificationInterests(arg_5_0)
	local var_5_0 = {}

	PrayPoolConst = var_1_10002
	var_5_0[1] = var_1_10002.BUILD_PRAY_POOL_SUCCESS

	return var_5_0
end

function var_0_1.handleNotification(arg_6_0, arg_6_1)
	local var_6_0 = arg_6_1
	local var_6_1 = arg_6_1.getName(var_6_0)
	local var_6_2 = arg_6_1:getBody()

	PrayPoolConst = var_6_0

	if var_6_1 == var_6_0.BUILD_PRAY_POOL_SUCCESS then
		local var_6_3 = arg_6_0.viewComponent

		var_4.switchPage(var_6_3, var_6_2)
	end

	return
end

return var_0_1
