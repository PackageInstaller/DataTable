class = var_0_10000

local var_0_0 = "BuildShipMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("...base.ContextMediator"))

var_0_1.OPEN_DESTROY = "BuildShipMediator OPEN_CHUANWUSTART"
var_0_1.OPEN_START_PROJECT = "BuildShipMediator OPEN_START_PROJECT"
var_0_1.ACTIVITY_OPERATION = "BuildShipMediator ACTIVITY_OPERATION"
var_0_1.OPEN_PROJECT_LIST = "BuildShipMediator OPEN_PROJECT_LIST"
var_0_1.REMOVE_PROJECT_LIST = "BuildShipMediator REMOVE_PROJECT_LIST"
var_0_1.ON_BUILD = "BuildShipMediator ON_BUILD"
var_0_1.ACT_ON_BUILD = "BuildShipMediator ACT_ON_BUILD"
var_0_1.ON_UPDATE_ACT = "BuildShipMediator ON_UPDATE_ACT"
var_0_1.ON_UPDATE_FREE_BUILD_ACT = "BuildShipMediator ON_UPDATE_FREE_BUILD_ACT"
var_0_1.SIMULATION_BATTLE = "BuildShipMediator SIMULATION_BATTLE"
var_0_1.ON_SUPPORT_SHOP = "BuildShipMediator ON_SUPPORT_SHOP"
var_0_1.OPEN_PRAY_PAGE = "BuildShipMediator OPEN_PRAY_PAGE"
var_0_1.CLOSE_PRAY_PAGE = "BuildShipMediator CLOSE_PRAY_PAGE"
var_0_1.ON_BUILDPOOL_EXCHANGE = "BuildShipMediator:ON_BUILDPOOL_EXCHANGE"
var_0_1.ON_BUILDPOOL_UR_EXCHANGE = "BuildShipMediator.ON_BUILDPOOL_UR_EXCHANGE"
var_0_1.ON_SUPPORT_EXCHANGE = "BuildShipMediator:ON_SUPPORT_EXCHANGE"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getData(var_1_0)
	local var_1_2 = arg_1_0.viewComponent

	var_3.setPlayer(var_1_2, var_1_1)

	getProxy = var_3
	BagProxy = var_1_2

	local var_1_3 = var_3(var_1_2)

	pg = var_1_0
	arg_1_0.useItem = var_1_0.ship_data_create_material[1].use_item

	local var_1_4 = var_1_3:getItemById(arg_1_0.useItem)
	local var_1_5 = arg_1_0.viewComponent

	var_5.setUseItem(var_1_5, var_1_4)

	getProxy = var_5
	BayProxy = var_1_5

	local var_1_6 = var_5(var_1_5)
	local var_1_7 = var_5.getShipById(var_1_6, var_1_1.character)
	local var_1_8 = arg_1_0.viewComponent

	var_7.setFlagShip(var_1_8, var_1_7)

	getProxy = var_7
	BuildShipProxy = var_1_8

	local var_1_9 = var_7(var_1_8)
	local var_1_10 = var_7.getRawData(var_1_9)
	local var_1_11 = arg_1_0.viewComponent
	local var_1_12 = var_9.setStartCount

	table = var_1_10012

	var_1_12(var_1_11, var_1_10012.getCount(var_1_10))
	arg_1_0:bind(var_0_1.ON_SUPPORT_SHOP, function()
		local var_2_0 = arg_1_0
		local var_2_1 = var_0.sendNotification

		GAME = var_2_10003

		local var_2_2 = var_2_10003.GO_SCENE

		SCENE = var_2_10004

		local var_2_3 = var_2_10004.SHOP
		local var_2_4 = {}

		NewShopsScene = var_2_10006
		var_2_4.warp = var_2_10006.TYPE_MEDAL

		var_2_1(var_2_0, var_2_2, var_2_3, var_2_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DESTROY, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = var_1.sendNotification

		GAME = var_2_10004

		local var_3_2 = var_2_10004.GO_SCENE

		SCENE = var_2_10005

		local var_3_3 = var_2_10005.DOCKYARD
		local var_3_4 = {
			blockLock = true
		}

		DockyardScene = var_2_10007
		var_3_4.mode = var_2_10007.MODE_DESTROY
		getGameset = var_7
		var_3_4.selectedMax = var_7("ship_select_limit")[1]
		i18n = var_7
		var_3_4.leftTopInfo = var_7("word_destroy")
		ShipStatus = var_7
		var_3_4.onShip = var_7.canDestroyShip
		pg = var_7

		local var_3_5 = var_7.ShipFlagMgr.GetInstance()

		var_3_4.ignoredIds = var_7.FilterShips(var_3_5, {
			isActivityNpc = true
		})
		var_3_4.preView = arg_1_0.viewComponent.__cname

		var_3_1(var_3_0, var_3_2, var_3_3, var_3_4)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PROJECT_LIST, function(arg_4_0)
		local var_4_0 = arg_1_0.facade
		local var_4_1 = var_1.hasMediator

		BuildShipDetailMediator = var_2_10004

		if var_4_1(var_4_0, var_2_10004.__cname) then
			return
		end

		local var_4_2 = arg_1_0
		local var_4_3 = var_1.addSubLayers

		Context = var_4

		local var_4_4 = var_4.New
		local var_4_5 = {}

		BuildShipDetailMediator = var_2_10007
		var_4_5.mediator = var_2_10007
		BuildShipDetailLayer = var_2_10007
		var_4_5.viewComponent = var_2_10007

		local var_4_6 = {}
		local var_4_7 = arg_1_0.viewComponent

		var_4_6.groupName = var_8.getGroupName(var_4_7)
		var_4_5.data = var_4_6

		var_4_3(var_4_2, var_4_4(var_4_5))

		return
	end)
	arg_1_0:bind(var_0_1.REMOVE_PROJECT_LIST, function(arg_5_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_5_0 = var_2_10001(var_2_10003)
		local var_5_1 = var_1.getCurrentContext(var_5_0)
		local var_5_2 = var_2.getContextByMediator

		BuildShipDetailMediator = var_2_10006

		if var_5_2(var_5_1, var_2_10006) then
			local var_5_3 = arg_1_0
			local var_5_4 = var_4.sendNotification

			GAME = var_2_10007

			var_5_4(var_5_3, var_2_10007.REMOVE_LAYERS, {
				context = var_3
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.ON_BUILD, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		local var_6_0 = arg_1_0
		local var_6_1 = var_4.sendNotification

		GAME = var_2_10007

		var_6_1(var_6_0, var_2_10007.BUILD_SHIP, {
			buildId = arg_6_1,
			count = arg_6_2,
			isTicket = arg_6_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ACT_ON_BUILD, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		local var_7_0 = arg_1_0
		local var_7_1 = var_5.sendNotification

		GAME = var_2_10008

		var_7_1(var_7_0, var_2_10008.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_7_1,
			arg1 = arg_7_3,
			arg2 = arg_7_4 and 1 or 0,
			buildId = arg_7_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SUPPORT_EXCHANGE, function(arg_8_0, arg_8_1)
		local var_8_0 = arg_1_0
		local var_8_1 = var_2.sendNotification

		GAME = var_2_10005

		var_8_1(var_8_0, var_2_10005.SUPPORT_SHIP, {
			count = arg_8_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_UPDATE_ACT, function(arg_9_0)
		local var_9_0 = arg_1_0.viewComponent
		local var_9_1 = var_1.setPools

		getProxy = var_2_10004
		BuildShipProxy = var_2_10006

		local var_9_2 = var_2_10004(var_2_10006)

		var_9_1(var_9_0, var_4.GetPools(var_9_2))

		local var_9_3 = arg_1_0.viewComponent

		var_1.checkPage(var_9_3)

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_PRAY_PAGE, function(arg_10_0)
		local var_10_0 = arg_1_0
		local var_10_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_10_2 = var_2_10004.New
		local var_10_3 = {}

		PrayPoolMediator = var_2_10007
		var_10_3.mediator = var_2_10007
		PrayPoolScene = var_2_10007
		var_10_3.viewComponent = var_2_10007

		local var_10_4 = {}
		local var_10_5 = arg_1_0.viewComponent

		var_10_4.groupName = var_8.getGroupName(var_10_5)
		var_10_3.data = var_10_4

		var_10_1(var_10_0, var_10_2(var_10_3))

		return
	end)
	arg_1_0:bind(var_0_1.CLOSE_PRAY_PAGE, function(arg_11_0)
		getProxy = var_2_10001
		ContextProxy = var_2_10003

		local var_11_0 = var_2_10001(var_2_10003)
		local var_11_1 = var_1.getCurrentContext(var_11_0)
		local var_11_2 = var_2.getContextByMediator

		PrayPoolMediator = var_2_10006

		if var_11_2(var_11_1, var_2_10006) then
			local var_11_3 = arg_1_0
			local var_11_4 = var_4.sendNotification

			GAME = var_2_10007

			var_11_4(var_11_3, var_2_10007.REMOVE_LAYERS, {
				context = var_3
			})
		end

		return
	end)
	arg_1_0:bind(var_0_1.SIMULATION_BATTLE, function(arg_12_0, arg_12_1)
		local var_12_0 = arg_1_0
		local var_12_1 = var_2.sendNotification

		GAME = var_2_10005

		local var_12_2 = var_2_10005.BEGIN_STAGE
		local var_12_3 = {}

		SYSTEM_SIMULATION = var_2_10007
		var_12_3.system = var_2_10007
		var_12_3.stageId = arg_12_1

		var_12_1(var_12_0, var_12_2, var_12_3)

		return
	end)
	arg_1_0:bind(var_0_1.ON_BUILDPOOL_EXCHANGE, function(arg_13_0, arg_13_1)
		local var_13_0 = arg_1_0
		local var_13_1 = var_2.sendNotification

		GAME = var_2_10005

		var_13_1(var_13_0, var_2_10005.ACTIVITY_BUILD_POOL_EXCHANGE, {
			activity_id = arg_13_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_BUILDPOOL_UR_EXCHANGE, function(arg_14_0)
		local var_14_0 = arg_1_0
		local var_14_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_14_2 = var_2_10004.New
		local var_14_3 = {}

		BuildShipRegularExchangeLayer = var_2_10007
		var_14_3.viewComponent = var_2_10007
		BuildShipRegularExchangeMediator = var_2_10007
		var_14_3.mediator = var_2_10007

		var_14_1(var_14_0, var_14_2(var_14_3))

		return
	end)

	local var_1_13 = var_7:getFinishCount()
	local var_1_14 = arg_1_0.viewComponent

	var_10.updateQueueTip(var_1_14, var_1_13)

	local var_1_15 = arg_1_0.viewComponent
	local var_1_16 = var_10.setPools

	getProxy = var_13
	BuildShipProxy = var_1_10015

	local var_1_17 = var_13(var_1_10015)

	var_1_16(var_1_15, var_13.GetPools(var_1_17))

	if arg_1_0.contextData.goToPray == true then
		local var_1_18 = arg_1_0.viewComponent

		var_10.switchPage(var_1_18, arg_1_0.viewComponent.PAGE_PRAY, true)
	end

	return
end

function var_0_1.buildFinishComeback(arg_15_0)
	getProxy = var_1_10001
	BuildShipProxy = var_1_10003

	local var_15_0 = var_1_10001(var_1_10003)

	table = var_1_10002

	if var_1_10002.getCount(var_15_0:getData()) == 0 and arg_15_0.viewComponent then
		BuildShip = var_2

		local var_15_1 = var_2.getPageFromPoolType
		local var_15_2 = var_15_0
		local var_15_3

		if not var_15_1(var_15_0.getLastBuildShipPoolType(var_15_2)) then
			BuildShipScene = var_15_3
			var_15_3 = var_15_3.PAGE_BUILD
		end

		BuildShipScene = var_1_10003

		local var_15_5

		if var_15_3 == var_1_10003.PAGE_PRAY then
			getProxy = var_15_5
			ActivityProxy = var_1_10005

			local var_15_4 = var_15_5(var_1_10005)

			var_15_5 = var_15_5.getActivityById
			ActivityConst = var_15_2

			if not var_15_5(var_15_4, var_15_2.ACTIVITY_PRAY_POOL) or var_15_5:isEnd() then
				BuildShipScene = var_4
				var_15_3 = var_4.PAGE_BUILD
			end
		end

		triggerToggle = var_15_5

		var_15_5(arg_15_0.viewComponent.toggles[var_15_3], true)
	end

	return
end

function var_0_1.listNotificationInterests(arg_16_0)
	local var_16_0 = {}

	GAME = var_1_10002
	var_16_0[1] = var_1_10002.BUILD_SHIP_DONE
	BagProxy = var_2
	var_16_0[2] = var_2.ITEM_UPDATED
	PlayerProxy = var_2
	var_16_0[3] = var_2.UPDATED
	GAME = var_2
	var_16_0[4] = var_2.CONFIRM_GET_SHIP
	BuildShipProxy = var_2
	var_16_0[5] = var_2.ADDED
	BuildShipProxy = var_2
	var_16_0[6] = var_2.REMOVED
	GAME = var_2
	var_16_0[7] = var_2.BEGIN_STAGE_DONE
	GAME = var_2
	var_16_0[8] = var_2.ACTIVITY_BUILD_POOL_EXCHANGE_DONE
	GAME = var_2
	var_16_0[9] = var_2.REGULAR_BUILD_POOL_EXCHANGE_DONE
	ActivityProxy = var_2
	var_16_0[10] = var_2.ACTIVITY_UPDATED
	GAME = var_2
	var_16_0[11] = var_2.SUPPORT_SHIP_DONE
	BuildShipProxy = var_2
	var_16_0[12] = var_2.REGULAR_BUILD_POOL_COUNT_UPDATE

	return var_16_0
end

function var_0_1.handleNotification(arg_17_0, arg_17_1)
	local var_17_0 = arg_17_1
	local var_17_1 = arg_17_1.getName(var_17_0)
	local var_17_2 = arg_17_1
	local var_17_3 = arg_17_1.getBody(var_17_2)

	PlayerProxy = var_17_0

	if var_17_1 == var_17_0.UPDATED then
		var_1_10006 = arg_17_0.viewComponent

		var_4.setPlayer(var_1_10006, var_17_3)

		goto label_17_0
	end

	GAME = var_4

	if var_17_1 == var_4.CONFIRM_GET_SHIP then
		getProxy = var_4
		BuildShipProxy = var_1_10006
		var_1_10007 = var_4(var_1_10006)
		var_17_2 = var_4.getFinishCount(var_1_10007)
		iter_17_2 = arg_17_0.viewComponent

		var_1_10006.updateQueueTip(iter_17_2, var_17_2)

		var_1_10006 = {}

		if var_17_3.isBatch then
			var_4:setSkipBatchBuildFlag(false)

			var_1_10007 = {}
			ipairs = iter_17_2

			for iter_17_0, iter_17_1 in iter_17_2(var_17_3.ships) do
				local var_17_4 = {}

				DROP_TYPE_SHIP = var_1_10014
				var_17_4.type = var_1_10014
				var_17_4.id = iter_17_1.configId
				var_17_4.count = 1
				var_17_4.virgin = iter_17_1.virgin
				var_17_4.reMetaSpecialItemVO = iter_17_1:getReMetaSpecialItemVO()
				var_1_10007[#var_1_10007 + 1] = var_17_4
			end

			if #var_1_10007 > 0 then
				table = iter_17_2

				iter_17_2.insert(var_1_10006, function(arg_18_0)
					local var_18_0 = arg_17_0.viewComponent
					local var_18_1 = var_1.emit

					BaseUI = var_2_10004

					local var_18_2 = var_2_10004.ON_AWARD
					local var_18_3 = {
						items = var_1_10007
					}

					AwardInfoLayer = var_6
					var_18_3.title = var_6.TITLE.SHIP
					var_18_3.removeFunc = arg_18_0

					var_18_1(var_18_0, var_18_2, var_18_3)

					return
				end)
			end
		end

		seriesAsync = var_1_10007

		var_1_10007(var_1_10006, function()
			if var_17_3.isBatch and var_17_2 > 0 then
				NoPosMsgBox = var_0
				i18n = var_2_10002

				local var_19_0 = var_2_10002("switch_to_shop_tip_noDockyard")

				openDockyardClear = var_2_10003
				gotoChargeScene = var_4
				openDockyardIntensify = var_2_10005

				var_0(var_19_0, var_2_10003, var_4, var_2_10005)
			else
				local var_19_1 = arg_17_0

				var_0.buildFinishComeback(var_19_1)
			end

			return
		end)

		goto label_17_0
	end

	GAME = var_4

	if var_17_1 == var_4.BUILD_SHIP_DONE then
		triggerToggle = var_4
		var_1_10006 = arg_17_0.viewComponent.toggles
		BuildShipScene = var_1_10007

		var_4(var_1_10006[var_1_10007.PAGE_QUEUE], true)

		goto label_17_0
	end

	BagProxy = var_4

	if var_17_1 == var_4.ITEM_UPDATED then
		getProxy = var_4
		BagProxy = var_1_10006
		var_1_10007 = var_4(var_1_10006)
		var_17_2 = var_4.getItemById(var_1_10007, arg_17_0.useItem)
		iter_17_2 = arg_17_0.viewComponent

		var_1_10006.setUseItem(iter_17_2, var_17_2)

		goto label_17_0
	end

	BuildShipProxy = var_4

	if var_17_1 ~= var_4.ADDED then
		BuildShipProxy = var_17_5

		local var_17_5

		if var_17_1 == var_17_5.REMOVED then
			getProxy = var_17_5
			BuildShipProxy = var_1_10006
			var_1_10006 = var_17_5(var_1_10006)
			var_17_5 = var_17_5.getRawData(var_1_10006)
			var_1_10007 = arg_17_0.viewComponent
			var_17_2 = var_17_2.setStartCount
			table = iter_17_2

			var_17_2(var_1_10007, iter_17_2.getCount(var_17_5))

			goto label_17_0
		end

		GAME = var_17_5

		local var_17_6

		if var_17_1 == var_17_5.SUPPORT_SHIP_DONE then
			var_17_6 = {}
			ipairs = var_17_2

			for iter_17_2, iter_17_3 in var_17_2(var_17_3.ships) do
				if not iter_17_3.virgin then
					iter_17_1 = iter_17_3

					if iter_17_3.getRarity(iter_17_1) >= 4 then
						table = var_1_10010

						var_1_10010.insert(var_17_6, function(arg_20_0)
							local var_20_0 = arg_17_0
							local var_20_1 = var_1.addSubLayers

							Context = var_2_10004

							local var_20_2 = var_2_10004.New
							local var_20_3 = {}

							NewShipMediator = var_2_10007
							var_20_3.mediator = var_2_10007
							NewShipLayer = var_2_10007
							var_20_3.viewComponent = var_2_10007
							var_20_3.data = {
								ship = iter_17_3
							}
							var_20_3.onRemoved = arg_20_0

							var_20_1(var_20_0, var_20_2(var_20_3))

							return
						end)
					end
				end
			end

			seriesAsync = var_5

			var_5(var_17_6, function()
				local var_21_0 = arg_17_0.viewComponent
				local var_21_1 = var_0.emit

				BaseUI = var_2_10003

				local var_21_2 = var_2_10003.ON_AWARD
				local var_21_3 = {}

				underscore = var_2_10005
				var_21_3.items = var_2_10005.map(var_17_3.ships, function(arg_22_0)
					Drop = var_3_10001

					local var_22_0 = var_3_10001.New
					local var_22_1 = {
						count = 1
					}

					DROP_TYPE_SHIP = var_3_10004
					var_22_1.type = var_3_10004
					var_22_1.id = arg_22_0.configId

					local var_22_2 = var_22_0(var_22_1)

					var_22_2.virgin = arg_22_0.virgin

					return var_22_2
				end)
				AwardInfoLayer = var_5
				var_21_3.title = var_5.TITLE.SHIP

				function var_21_3.removeFunc()
					if arg_17_0.viewComponent then
						local var_23_0 = arg_17_0.viewComponent.supportShipPoolPage

						var_0.UpdateMedal(var_23_0)
					end

					return
				end

				var_21_1(var_21_0, var_21_2, var_21_3)

				return
			end)

			goto label_17_0
		end

		GAME = var_17_6

		local var_17_7

		if var_17_1 == var_17_6.BEGIN_STAGE_DONE then
			var_1_10006 = arg_17_0
			var_17_7 = arg_17_0.sendNotification
			GAME = var_1_10007
			var_1_10007 = var_1_10007.GO_SCENE
			SCENE = iter_17_2

			var_17_7(var_1_10006, var_1_10007, iter_17_2.COMBATLOAD, var_17_3)

			goto label_17_0
		end

		ActivityProxy = var_17_7

		if var_17_1 == var_17_7.ACTIVITY_UPDATED then
			if var_17_3 then
				var_1_10007 = var_4

				local var_17_8 = var_4.getConfig(var_1_10007, "type")

				ActivityConst = var_1_10006

				if var_17_8 == var_1_10006.ACTIVITY_TYPE_BUILDSHIP_1 then
					local var_17_9 = arg_17_0.viewComponent

					var_6.RefreshActivityBuildPool(var_17_9, var_4)
				else
					ActivityConst = var_6

					local var_17_10

					if var_17_8 == var_6.ACTIVITY_TYPE_NEWSERVER_BUILD then
						pg = var_17_10

						if not var_17_10.ship_data_create_exchange[var_4.id] then
							var_17_10 = {}
						end

						var_1_10007 = var_4.data2

						local var_17_11

						if not var_17_10.exchange_available_times then
							var_17_11 = 0
						end

						if var_1_10007 < var_17_11 then
							local var_17_12 = arg_17_0.viewComponent

							var_1_10007.RefreshActivityBuildPool(var_17_12, var_4)
						else
							local var_17_13 = arg_17_0.viewComponent

							var_1_10007 = var_1_10007.setPools
							getProxy = var_1_10010
							BuildShipProxy = iter_17_1

							local var_17_14 = var_1_10010(iter_17_1)

							var_1_10007(var_17_13, var_10.GetPools(var_17_14))

							local var_17_15 = arg_17_0.viewComponent

							var_1_10007.checkPage(var_17_15)
						end
					else
						ActivityConst = var_17_10

						if var_17_8 == var_17_10.ACTIVITY_TYPE_BUILD_FREE then
							local var_17_16 = arg_17_0.viewComponent

							var_6.RefreshFreeBuildActivity(var_17_16)
						end
					end
				end
			end

			goto label_17_0
		end

		BuildShipProxy = var_4

		if var_17_1 == var_4.REGULAR_BUILD_POOL_COUNT_UPDATE then
			local var_17_17 = arg_17_0.viewComponent

			var_4.RefreshRegularExchangeCount(var_17_17)

			goto label_17_0
		end

		GAME = var_4

		if var_17_1 ~= var_4.ACTIVITY_BUILD_POOL_EXCHANGE_DONE then
			GAME = var_4

			if var_17_1 == var_4.REGULAR_BUILD_POOL_EXCHANGE_DONE then
				local var_17_18 = arg_17_0.viewComponent
				local var_17_19 = var_4.emit

				BaseUI = var_1_10007

				var_17_19(var_17_18, var_1_10007.ON_ACHIEVE, var_17_3.awards)
			end

			::label_17_0::

			return
		end
	end
end

return var_0_1
