local SixthAnniversaryIslandMediator = class("SixthAnniversaryIslandMediator", import("..base.ContextMediator"))

SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT = "SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT"
SixthAnniversaryIslandMediator.OPEN_QTE_GAME = "SixthAnniversaryIslandMediator.OPEN_QTE_GAME"
SixthAnniversaryIslandMediator.INTO_ENTRANCE = "SixthAnniversaryIslandMediator.INTO_ENTRANCE"
SixthAnniversaryIslandMediator.MARK_NODE_AFTER_NEW = "SixthAnniversaryIslandMediator.MARK_NODE_AFTER_NEW"
SixthAnniversaryIslandMediator.GO_SHOP = "SixthAnniversaryIslandMediator.GO_SHOP"
SixthAnniversaryIslandMediator.OPEN_NOTE = "SixthAnniversaryIslandMediator.OPEN_NOTE"
SixthAnniversaryIslandMediator.OPEN_RES = "SixthAnniversaryIslandMediator.OPEN_RES"
SixthAnniversaryIslandMediator.DISPLAY_NODES = "SixthAnniversaryIslandMediator.DISPLAY_NODES"
SixthAnniversaryIslandMediator.DISPLAY_SHOP = "SixthAnniversaryIslandMediator.DISPLAY_SHOP"

function SixthAnniversaryIslandMediator:register()
	local var_1_0 = getProxy(ActivityProxy):getActivityByType(ActivityConst.ACTIVITY_TYPE_ISLAND)

	self.viewComponent:setActivity(var_1_0)
	self.viewComponent:setNodeIds(getProxy(SixthAnniversaryIslandProxy):GetNodeIds())
	self.viewComponent:setPlayer(getProxy(PlayerProxy):getData())

	local var_1_1 = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_id")
	local var_1_2 = {
		type = 2
	}

	var_1_2.id = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_client").item_id
	var_1_2.count = getProxy(MiniGameProxy):GetHubByHubId(var_1_1).count

	self.viewComponent:setResDrop(var_1_2, pg.mini_game_hub[var_1_1].reborn_times)
	self:bind(SixthAnniversaryIslandMediator.TRIGGER_NODE_EVENT, function(arg_2_0, arg_2_1, arg_2_2)
		self:sendNotification(GAME.ISLAND_EVENT_TRIGGER, {
			act_id = var_1_0.id,
			node_id = arg_2_1,
			op = arg_2_2
		})

		return
	end)
	self:bind(SixthAnniversaryIslandMediator.OPEN_QTE_GAME, function(arg_3_0, arg_3_1, arg_3_2)
		self:addSubLayers(Context.New({
			mediator = IslandQTEMiniGameMediator,
			viewComponent = IslandQTEMiniGameLayer,
			data = {
				mark = arg_3_1,
				finishCallback = arg_3_2
			}
		}))

		return
	end)
	self:bind(SixthAnniversaryIslandMediator.OPEN_NOTE, function(arg_4_0)
		self:addSubLayers(Context.New({
			mediator = IslandTaskMediator,
			viewComponent = IslandTaskScene,
			data = {}
		}))

		return
	end)
	self:bind(SixthAnniversaryIslandMediator.OPEN_RES, function(arg_5_0, arg_5_1, arg_5_2)
		self:addSubLayers(Context.New({
			mediator = SixthAnniversaryIslandItemWindowMediator,
			viewComponent = SixthAnniversaryIslandItemWindowLayer,
			data = {
				drop = arg_5_1,
				text = arg_5_2
			}
		}))

		return
	end)
	self:bind(SixthAnniversaryIslandMediator.INTO_ENTRANCE, function(arg_6_0, arg_6_1)
		switch(arg_6_1, {
			flowerfield = function()
				self:addSubLayers(Context.New({
					mediator = IslandFlowerFieldMediator,
					viewComponent = IslandFlowerFieldLayer,
					data = {}
				}))

				return
			end,
			minigame1 = function()
				self:sendNotification(GAME.GO_MINI_GAME, 52)

				return
			end,
			minigame2 = function()
				self:sendNotification(GAME.GO_MINI_GAME, 53)

				return
			end,
			minigame3 = function()
				self:sendNotification(GAME.GO_MINI_GAME, 54)

				return
			end,
			island = function()
				self.viewComponent:closeView()

				return
			end,
			hotspringtask = function()
				self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SPRING_TASK)

				return
			end,
			hotspring = function()
				self:sendNotification(GAME.GO_SCENE, SCENE.ANNIVERSARY_ISLAND_SPRING)

				return
			end
		})

		return
	end)
	self:bind(SixthAnniversaryIslandMediator.MARK_NODE_AFTER_NEW, function(arg_14_0, arg_14_1)
		self:sendNotification(GAME.ISLAND_NODE_MARK, {
			act_id = var_1_0.id,
			node_id = arg_14_1
		})

		return
	end)
	self:bind(SixthAnniversaryIslandMediator.GO_SHOP, function(arg_15_0)
		self:addSubLayers(Context.New({
			mediator = SixthAnniversaryIslandShopMediator,
			viewComponent = SixthAnniversaryIslandShopLayer
		}))

		return
	end)

	return
end

function SixthAnniversaryIslandMediator:initNotificationHandleDic()
	self.handleDic = {
		[GAME.ISLAND_EVENT_TRIGGER_DONE] = function(arg_17_0, arg_17_1)
			local var_17_0 = arg_17_1:getBody()
			local var_17_1 = {}

			if #var_17_0.awards > 0 then
				table.insert(var_17_1, function(arg_18_0)
					arg_17_0.viewComponent:emit(BaseUI.ON_ACHIEVE, var_17_0.awards, arg_18_0)

					return
				end)
			end

			seriesAsync(var_17_1, function()
				arg_17_0.viewComponent:afterTriggerEvent(var_17_0.node_id)

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
				local var_24_1 = {
					type = 2
				}

				var_24_1.id = getProxy(ActivityProxy):getActivityById(ActivityConst.ISLAND_GAME_ID):getConfig("config_client").item_id
				var_24_1.count = getProxy(MiniGameProxy):GetHubByHubId(var_24_0).count

				arg_24_0.viewComponent:setResDrop(var_24_1, pg.mini_game_hub[var_24_0].reborn_times)
			end

			return
		end,
		[SixthAnniversaryIslandMediator.DISPLAY_NODES] = function(arg_25_0, arg_25_1)
			local var_25_0 = arg_25_1:getBody()

			if var_25_0 and #var_25_0 > 0 and not arg_25_0.viewComponent:focusList(var_25_0, LeanTweenType.easeInOutSine) then
				pg.TipsMgr.GetInstance():ShowTips(i18n("islandnode_tips8"))
			end

			return
		end,
		[SixthAnniversaryIslandMediator.DISPLAY_SHOP] = function(arg_26_0, arg_26_1)
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

return SixthAnniversaryIslandMediator
