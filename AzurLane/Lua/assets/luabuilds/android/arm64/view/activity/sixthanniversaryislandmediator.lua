class = var_0_10000

local var_0_0 = "SixthAnniversaryIslandMediator"

import = var_0_10003

local var_0_1 = var_0_10000(var_0_0, var_0_10003("..base.ContextMediator"))

var_0_1.TRIGGER_NODE_EVENT = "SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT"
var_0_1.OPEN_QTE_GAME = "SixthAnniversaryIslandMediator.OPEN_QTE_GAME"
var_0_1.INTO_ENTRANCE = "SixthAnniversaryIslandMediator.INTO_ENTRANCE"
var_0_1.MARK_NODE_AFTER_NEW = "SixthAnniversaryIslandMediator.MARK_NODE_AFTER_NEW"
var_0_1.GO_SHOP = "SixthAnniversaryIslandMediator.GO_SHOP"
var_0_1.OPEN_NOTE = "SixthAnniversaryIslandMediator.OPEN_NOTE"
var_0_1.OPEN_RES = "SixthAnniversaryIslandMediator.OPEN_RES"
var_0_1.DISPLAY_NODES = "SixthAnniversaryIslandMediator.DISPLAY_NODES"
var_0_1.DISPLAY_SHOP = "SixthAnniversaryIslandMediator.DISPLAY_SHOP"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	ActivityProxy = var_1_10003

	local var_1_0 = var_1_10001(var_1_10003)
	local var_1_1 = var_1.getActivityByType

	ActivityConst = var_1_10004

	local var_1_2 = var_1_1(var_1_0, var_1_10004.ACTIVITY_TYPE_ISLAND)
	local var_1_3 = arg_1_0.viewComponent

	var_2.setActivity(var_1_3, var_1_2)

	local var_1_4 = arg_1_0.viewComponent
	local var_1_5 = var_2.setNodeIds

	getProxy = var_5
	SixthAnniversaryIslandProxy = var_1_10007

	local var_1_6 = var_5(var_1_10007)

	var_1_5(var_1_4, var_5.GetNodeIds(var_1_6))

	local var_1_7 = arg_1_0.viewComponent
	local var_1_8 = var_2.setPlayer

	getProxy = var_5
	PlayerProxy = var_1_6

	local var_1_9 = var_5(var_1_6)

	var_1_8(var_1_7, var_5.getData(var_1_9))

	getProxy = var_1_8
	ActivityProxy = var_1_7

	local var_1_10 = var_1_8(var_1_7)
	local var_1_11 = var_2.getActivityById

	ActivityConst = var_5

	local var_1_12 = var_1_11(var_1_10, var_5.ISLAND_GAME_ID)
	local var_1_13 = var_2.getConfig(var_1_12, "config_id")
	local var_1_14 = arg_1_0.viewComponent
	local var_1_15 = var_3.setResDrop
	local var_1_16 = {
		type = 2
	}

	getProxy = var_1_9
	ActivityProxy = var_1_10009

	local var_1_17 = var_1_9(var_1_10009)
	local var_1_18 = var_7.getActivityById

	ActivityConst = var_1_10010

	local var_1_19 = var_1_18(var_1_17, var_1_10010.ISLAND_GAME_ID)

	var_1_16.id = var_7.getConfig(var_1_19, "config_client").item_id
	getProxy = var_7
	MiniGameProxy = var_1_19

	local var_1_20 = var_7(var_1_19)

	var_1_16.count = var_7.GetHubByHubId(var_1_20, var_1_13).count
	pg = var_7

	var_1_15(var_1_14, var_1_16, var_7.mini_game_hub[var_1_13].reborn_times)
	arg_1_0:bind(var_0_1.TRIGGER_NODE_EVENT, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10006

		var_2_1(var_2_0, var_2_10006.ISLAND_EVENT_TRIGGER, {
			act_id = var_1_2.id,
			node_id = arg_2_1,
			op = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_QTE_GAME, function(arg_3_0, arg_3_1, arg_3_2)
		local var_3_0 = arg_1_0
		local var_3_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_3_2 = var_2_10006.New
		local var_3_3 = {}

		IslandQTEMiniGameMediator = var_2_10009
		var_3_3.mediator = var_2_10009
		IslandQTEMiniGameLayer = var_2_10009
		var_3_3.viewComponent = var_2_10009
		var_3_3.data = {
			mark = arg_3_1,
			finishCallback = arg_3_2
		}

		var_3_1(var_3_0, var_3_2(var_3_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_NOTE, function(arg_4_0)
		local var_4_0 = arg_1_0
		local var_4_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_4_2 = var_2_10004.New
		local var_4_3 = {}

		IslandTaskMediator = var_2_10007
		var_4_3.mediator = var_2_10007
		IslandTaskScene = var_2_10007
		var_4_3.viewComponent = var_2_10007
		var_4_3.data = {}

		var_4_1(var_4_0, var_4_2(var_4_3))

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_RES, function(arg_5_0, arg_5_1, arg_5_2)
		local var_5_0 = arg_1_0
		local var_5_1 = var_3.addSubLayers

		Context = var_2_10006

		local var_5_2 = var_2_10006.New
		local var_5_3 = {}

		SixthAnniversaryIslandItemWindowMediator = var_2_10009
		var_5_3.mediator = var_2_10009
		SixthAnniversaryIslandItemWindowLayer = var_2_10009
		var_5_3.viewComponent = var_2_10009
		var_5_3.data = {
			drop = arg_5_1,
			text = arg_5_2
		}

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.INTO_ENTRANCE, function(arg_6_0, arg_6_1)
		switch = var_2_10002

		var_2_10002(arg_6_1, {
			flowerfield = function()
				local var_7_0 = arg_1_0
				local var_7_1 = var_0.addSubLayers

				Context = var_3_10003

				local var_7_2 = var_3_10003.New
				local var_7_3 = {}

				IslandFlowerFieldMediator = var_3_10006
				var_7_3.mediator = var_3_10006
				IslandFlowerFieldLayer = var_3_10006
				var_7_3.viewComponent = var_3_10006
				var_7_3.data = {}

				var_7_1(var_7_0, var_7_2(var_7_3))

				return
			end,
			minigame1 = function()
				local var_8_0 = arg_1_0
				local var_8_1 = var_0.sendNotification

				GAME = var_3_10003

				var_8_1(var_8_0, var_3_10003.GO_MINI_GAME, 52)

				return
			end,
			minigame2 = function()
				local var_9_0 = arg_1_0
				local var_9_1 = var_0.sendNotification

				GAME = var_3_10003

				var_9_1(var_9_0, var_3_10003.GO_MINI_GAME, 53)

				return
			end,
			minigame3 = function()
				local var_10_0 = arg_1_0
				local var_10_1 = var_0.sendNotification

				GAME = var_3_10003

				var_10_1(var_10_0, var_3_10003.GO_MINI_GAME, 54)

				return
			end,
			island = function()
				local var_11_0 = arg_1_0.viewComponent

				var_0.closeView(var_11_0)

				return
			end,
			hotspringtask = function()
				local var_12_0 = arg_1_0
				local var_12_1 = var_0.sendNotification

				GAME = var_3_10003

				local var_12_2 = var_3_10003.GO_SCENE

				SCENE = var_3_10004

				var_12_1(var_12_0, var_12_2, var_3_10004.ANNIVERSARY_ISLAND_SPRING_TASK)

				return
			end,
			hotspring = function()
				local var_13_0 = arg_1_0
				local var_13_1 = var_0.sendNotification

				GAME = var_3_10003

				local var_13_2 = var_3_10003.GO_SCENE

				SCENE = var_3_10004

				var_13_1(var_13_0, var_13_2, var_3_10004.ANNIVERSARY_ISLAND_SPRING)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_1.MARK_NODE_AFTER_NEW, function(arg_14_0, arg_14_1)
		local var_14_0 = arg_1_0
		local var_14_1 = var_2.sendNotification

		GAME = var_2_10005

		var_14_1(var_14_0, var_2_10005.ISLAND_NODE_MARK, {
			act_id = var_1_2.id,
			node_id = arg_14_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.GO_SHOP, function(arg_15_0)
		local var_15_0 = arg_1_0
		local var_15_1 = var_1.addSubLayers

		Context = var_2_10004

		local var_15_2 = var_2_10004.New
		local var_15_3 = {}

		SixthAnniversaryIslandShopMediator = var_2_10007
		var_15_3.mediator = var_2_10007
		SixthAnniversaryIslandShopLayer = var_2_10007
		var_15_3.viewComponent = var_2_10007

		var_15_1(var_15_0, var_15_2(var_15_3))

		return
	end)

	return
end

function var_0_1.initNotificationHandleDic(arg_16_0)
	local var_16_0 = {}

	GAME = var_1_10002
	var_16_0[var_1_10002.ISLAND_EVENT_TRIGGER_DONE] = function(arg_17_0, arg_17_1)
		local var_17_0 = arg_17_1:getBody()
		local var_17_1 = {}

		if #var_17_0.awards > 0 then
			table = var_4

			var_4.insert(var_17_1, function(arg_18_0)
				local var_18_0 = arg_17_0.viewComponent
				local var_18_1 = var_1.emit

				BaseUI = var_3_10004

				var_18_1(var_18_0, var_3_10004.ON_ACHIEVE, var_17_0.awards, arg_18_0)

				return
			end)
		end

		seriesAsync = var_4

		var_4(var_17_1, function()
			local var_19_0 = arg_17_0.viewComponent

			var_0.afterTriggerEvent(var_19_0, var_17_0.node_id)

			return
		end)

		return
	end
	GAME = var_2
	var_16_0[var_2.ISLAND_NODE_MARK_DONE] = function(arg_20_0, arg_20_1)
		local var_20_0 = arg_20_1:getBody()
		local var_20_1 = arg_20_0.viewComponent

		var_3.refreshNode(var_20_1, var_20_0.node_id)

		return
	end
	GAME = var_2
	var_16_0[var_2.ZERO_HOUR_OP_DONE] = function(arg_21_0, arg_21_1)
		getProxy = var_2_10002
		SixthAnniversaryIslandProxy = var_2_10004

		local var_21_0 = var_2_10002(var_2_10004)

		var_2.CheckAndRequest(var_21_0, function()
			local var_22_0 = arg_21_0.viewComponent.nodeItemList

			var_0.align(var_22_0, #arg_21_0.viewComponent.ids)

			local var_22_1 = arg_21_0.viewComponent

			var_0.refreshDailyPanel(var_22_1)

			return
		end)

		return
	end
	PlayerProxy = var_2
	var_16_0[var_2.UPDATED] = function(arg_23_0, arg_23_1)
		local var_23_0 = arg_23_1:getBody()
		local var_23_1 = arg_23_0.viewComponent

		var_3.setPlayer(var_23_1, var_23_0)

		return
	end
	MiniGameProxy = var_2
	var_16_0[var_2.ON_HUB_DATA_UPDATE] = function(arg_24_0, arg_24_1)
		local var_24_0 = arg_24_1:getBody()

		getProxy = var_2_10003
		ActivityProxy = var_2_10005

		local var_24_1 = var_2_10003(var_2_10005)
		local var_24_2 = var_3.getActivityById

		ActivityConst = var_2_10006

		local var_24_3 = var_24_2(var_24_1, var_2_10006.ISLAND_GAME_ID)
		local var_24_4 = var_3.getConfig(var_24_3, "config_id")

		if var_24_0.id == var_24_4 then
			local var_24_5 = arg_24_0.viewComponent
			local var_24_6 = var_4.setResDrop
			local var_24_7 = {
				type = 2
			}

			getProxy = var_2_10008
			ActivityProxy = var_2_10010

			local var_24_8 = var_2_10008(var_2_10010)
			local var_24_9 = var_8.getActivityById

			ActivityConst = var_2_10011

			local var_24_10 = var_24_9(var_24_8, var_2_10011.ISLAND_GAME_ID)

			var_24_7.id = var_8.getConfig(var_24_10, "config_client").item_id
			getProxy = var_8
			MiniGameProxy = var_24_10

			local var_24_11 = var_8(var_24_10)

			var_24_7.count = var_8.GetHubByHubId(var_24_11, var_24_4).count
			pg = var_8

			var_24_6(var_24_5, var_24_7, var_8.mini_game_hub[var_24_4].reborn_times)
		end

		return
	end
	var_16_0[var_0_1.DISPLAY_NODES] = function(arg_25_0, arg_25_1)
		if arg_25_1:getBody() and #var_2 > 0 then
			local var_25_0 = arg_25_0.viewComponent
			local var_25_1 = var_3.focusList
			local var_25_2 = var_2

			LeanTweenType = var_2_10007

			if not var_25_1(var_25_0, var_25_2, var_2_10007.easeInOutSine) then
				pg = var_3

				local var_25_3 = var_3.TipsMgr.GetInstance()
				local var_25_4 = var_3.ShowTips

				i18n = var_25_2

				var_25_4(var_25_3, var_25_2("islandnode_tips8"))
			end
		end

		return
	end
	var_16_0[var_0_1.DISPLAY_SHOP] = function(arg_26_0, arg_26_1)
		local var_26_0 = arg_26_0
		local var_26_1 = arg_26_0.addSubLayers

		Context = var_2_10005

		local var_26_2 = var_2_10005.New
		local var_26_3 = {}

		SixthAnniversaryIslandShopMediator = var_2_10008
		var_26_3.mediator = var_2_10008
		SixthAnniversaryIslandShopLayer = var_2_10008
		var_26_3.viewComponent = var_2_10008

		var_26_1(var_26_0, var_26_2(var_26_3))

		return
	end
	GAME = var_2
	var_16_0[var_2.ISLAND_FLOWER_GET_DONE] = function(arg_27_0, arg_27_1)
		pairs = var_2_10002
		getProxy = var_2_10004
		SixthAnniversaryIslandProxy = var_2_10006

		local var_27_0 = var_2_10004(var_2_10006)

		for iter_27_0, iter_27_1 in var_2_10002(var_4.GetNodeDic(var_27_0)) do
			if iter_27_1:getConfig("type") == 5 and iter_27_1:getConfig("params")[1] == "flowerfield" then
				local var_27_1 = arg_27_0.viewComponent

				var_7.refreshNode(var_27_1, iter_27_0)
			end
		end

		return
	end
	ActivityProxy = var_2
	var_16_0[var_2.ACTIVITY_UPDATED] = function(arg_28_0, arg_28_1)
		local var_28_0 = arg_28_1
		local var_28_1 = arg_28_1.getBody(var_28_0).id

		ActivityConst = var_28_0

		if var_28_1 == var_28_0.ISLAND_TASK_ID then
			local var_28_2 = arg_28_0.viewComponent

			var_3.updateTaskTip(var_28_2)
		end

		return
	end
	arg_16_0.handleDic = var_16_0

	return
end

return var_0_1
