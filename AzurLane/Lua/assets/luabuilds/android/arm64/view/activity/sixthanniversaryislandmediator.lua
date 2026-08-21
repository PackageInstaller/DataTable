local var_0_0 = class("SixthAnniversaryIslandMediator", import("..base.ContextMediator"))

var_0_0.TRIGGER_NODE_EVENT = "SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT"
var_0_0.OPEN_QTE_GAME = "SixthAnniversaryIslandMediator.OPEN_QTE_GAME"
var_0_0.INTO_ENTRANCE = "SixthAnniversaryIslandMediator.INTO_ENTRANCE"
var_0_0.MARK_NODE_AFTER_NEW = "SixthAnniversaryIslandMediator.MARK_NODE_AFTER_NEW"
var_0_0.GO_SHOP = "SixthAnniversaryIslandMediator.GO_SHOP"
var_0_0.OPEN_NOTE = "SixthAnniversaryIslandMediator.OPEN_NOTE"
var_0_0.OPEN_RES = "SixthAnniversaryIslandMediator.OPEN_RES"
var_0_0.DISPLAY_NODES = "SixthAnniversaryIslandMediator.DISPLAY_NODES"
var_0_0.DISPLAY_SHOP = "SixthAnniversaryIslandMediator.DISPLAY_SHOP"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:setActivity((getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)))
	arg_1_0.viewComponent:setNodeIds(getProxy(SixthAnniversaryIslandProxy):GetNodeIds())
	arg_1_0.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	local var_1_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_id")

	;({
		type = 2
	}).id = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_client").item_id
	;({
		type = 2
	}).count = getProxy(MiniGameProxy):GetHubByHubId(var_1_0).count

	arg_1_0.viewComponent:setResDrop({
		type = 2
	}, pg.mini_game_hub[var_1_0].reborn_times)
	arg_1_0:bind(var_0_0.TRIGGER_NODE_EVENT, function(arg_2_0, arg_2_1, arg_2_2)
		arg_1_0:sendNotification(GAME.ISLAND_EVENT_TRIGGER, {
			act_id = var_0.id,
			node_id = arg_2_1,
			op = arg_2_2
		})

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_QTE_GAME, function(arg_3_0, arg_3_1, arg_3_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = IslandQTEMiniGameMediator,
			viewComponent = IslandQTEMiniGameLayer,
			data = {
				mark = arg_3_1,
				finishCallback = arg_3_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_NOTE, function(arg_4_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = IslandTaskMediator,
			viewComponent = IslandTaskScene,
			data = {}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.OPEN_RES, function(arg_5_0, arg_5_1, arg_5_2)
		arg_1_0:addSubLayers(Context.New({
			mediator = SixthAnniversaryIslandItemWindowMediator,
			viewComponent = SixthAnniversaryIslandItemWindowLayer,
			data = {
				drop = arg_5_1,
				text = arg_5_2
			}
		}))

		return
	end)
	arg_1_0:bind(var_0_0.INTO_ENTRANCE, function(arg_6_0, arg_6_1)
		switch(arg_6_1, {
			flowerfield = function()
				arg_1_0:addSubLayers(Context.New({
					mediator = IslandFlowerFieldMediator,
					viewComponent = IslandFlowerFieldLayer,
					data = {}
				}))

				return
			end,
			minigame1 = function()
				arg_1_0:sendNotification(GAME.GO_MINI_GAME, 52)

				return
			end,
			minigame2 = function()
				arg_1_0:sendNotification(GAME.GO_MINI_GAME, 53)

				return
			end,
			minigame3 = function()
				arg_1_0:sendNotification(GAME.GO_MINI_GAME, 54)

				return
			end,
			island = function()
				arg_1_0.viewComponent:closeView()

				return
			end,
			hotspringtask = function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SPRING_TASK)

				return
			end,
			hotspring = function()
				arg_1_0:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SPRING)

				return
			end
		})

		return
	end)
	arg_1_0:bind(var_0_0.MARK_NODE_AFTER_NEW, function(arg_14_0, arg_14_1)
		arg_1_0:sendNotification(GAME.ISLAND_NODE_MARK, {
			act_id = var_0.id,
			node_id = arg_14_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.GO_SHOP, function(arg_15_0)
		arg_1_0:addSubLayers(Context.New({
			mediator = SixthAnniversaryIslandShopMediator,
			viewComponent = SixthAnniversaryIslandShopLayer
		}))

		return
	end)

	return
end

function var_0_0.initNotificationHandleDic(arg_16_0)
	arg_16_0.handleDic = {
		[GAME.ISLAND_EVENT_TRIGGER_DONE] = function(arg_17_0, arg_17_1)
			if #arg_17_1:getBody().awards > 0 then
				table.insert({}, function(arg_18_0)
					arg_17_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_0.awards, arg_18_0)

					return
				end)
			end

			seriesAsync({}, function()
				arg_17_0.viewComponent:afterTriggerEvent(var_0.node_id)

				return
			end)

			return
		end,
		[GAME.ISLAND_NODE_MARK_DONE] = function(arg_20_0, arg_20_1)
			arg_20_0.viewComponent:refreshNode(arg_20_1:getBody().node_id)

			return
		end,
		[GAME.ZERO_HOUR_OP_DONE] = function(arg_21_0, arg_21_1)
			getProxy(SixthAnniversaryIslandProxy):CheckAndRequest(function()
				arg_21_0.viewComponent.nodeItemList:align(#arg_21_0.viewComponent.ids)
				arg_21_0.viewComponent:refreshDailyPanel()

				return
			end)

			return
		end,
		[PlayerProxy.UPDATED] = function(arg_23_0, arg_23_1)
			arg_23_0.viewComponent:setPlayer((arg_23_1:getBody()))

			return
		end,
		[MiniGameProxy.ON_HUB_DATA_UPDATE] = function(arg_24_0, arg_24_1)
			local var_24_0 = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_id")

			if arg_24_1:getBody().id == var_24_0 then
				({
					type = 2
				}).id = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_client").item_id
				;({
					type = 2
				}).count = getProxy(MiniGameProxy):GetHubByHubId(var_24_0).count

				arg_24_0.viewComponent:setResDrop({
					type = 2
				}, pg.mini_game_hub[var_24_0].reborn_times)
			end

			return
		end,
		[var_0_0.DISPLAY_NODES] = function(arg_25_0, arg_25_1)
			local var_25_0 = arg_25_1:getBody()

			if var_25_0 and #var_25_0 > 0 and not arg_25_0.viewComponent:focusList(var_25_0, LeanTweenType.easeInOutSine) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("islandnode_tips8"))
			end

			return
		end,
		[var_0_0.DISPLAY_SHOP] = function(arg_26_0, arg_26_1)
			arg_26_0:addSubLayers(Context.New({
				mediator = SixthAnniversaryIslandShopMediator,
				viewComponent = SixthAnniversaryIslandShopLayer
			}))

			return
		end,
		[GAME.ISLAND_FLOWER_GET_DONE] = function(arg_27_0, arg_27_1)
			for iter_27_0, iter_27_1 in pairs(getProxy(SixthAnniversaryIslandProxy):GetNodeDic()) do
				if iter_27_1:getConfig("type") == 5 and iter_27_1:getConfig("params")[1] == "flowerfield" then
					arg_27_0.viewComponent:refreshNode(iter_27_0)
				end
			end

			return
		end,
		[ActivityProxy.ACTIVITY_UPDATED] = function(arg_28_0, arg_28_1)
			if arg_28_1:getBody().id == ActivityConst.ISLAND_TASK_ID then
				arg_28_0.viewComponent:updateTaskTip()
			end

			return
		end
	}

	return
end

return var_0_0
