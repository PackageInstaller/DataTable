local BuildShipMediator = class("BuildShipMediator", import("...base.ContextMediator"))

BuildShipMediator.OPEN_DESTROY = "BuildShipMediator OPEN_CHUANWUSTART"
BuildShipMediator.OPEN_START_PROJECT = "BuildShipMediator OPEN_START_PROJECT"
BuildShipMediator.ACTIVITY_OPERATION = "BuildShipMediator ACTIVITY_OPERATION"
BuildShipMediator.OPEN_PROJECT_LIST = "BuildShipMediator OPEN_PROJECT_LIST"
BuildShipMediator.REMOVE_PROJECT_LIST = "BuildShipMediator REMOVE_PROJECT_LIST"
BuildShipMediator.ON_BUILD = "BuildShipMediator ON_BUILD"
BuildShipMediator.ACT_ON_BUILD = "BuildShipMediator ACT_ON_BUILD"
BuildShipMediator.ON_UPDATE_ACT = "BuildShipMediator ON_UPDATE_ACT"
BuildShipMediator.ON_UPDATE_FREE_BUILD_ACT = "BuildShipMediator ON_UPDATE_FREE_BUILD_ACT"
BuildShipMediator.SIMULATION_BATTLE = "BuildShipMediator SIMULATION_BATTLE"
BuildShipMediator.ON_SUPPORT_SHOP = "BuildShipMediator ON_SUPPORT_SHOP"
BuildShipMediator.OPEN_PRAY_PAGE = "BuildShipMediator OPEN_PRAY_PAGE"
BuildShipMediator.CLOSE_PRAY_PAGE = "BuildShipMediator CLOSE_PRAY_PAGE"
BuildShipMediator.ON_BUILDPOOL_EXCHANGE = "BuildShipMediator:ON_BUILDPOOL_EXCHANGE"
BuildShipMediator.ON_BUILDPOOL_UR_EXCHANGE = "BuildShipMediator.ON_BUILDPOOL_UR_EXCHANGE"
BuildShipMediator.ON_SUPPORT_EXCHANGE = "BuildShipMediator:ON_SUPPORT_EXCHANGE"

function BuildShipMediator:register()
	local var_1_0 = getProxy(PlayerProxy):getData()

	self.viewComponent:setPlayer(var_1_0)

	self.useItem = pg.ship_data_create_material[1].use_item

	self.viewComponent:setUseItem((getProxy(BagProxy):getItemById(self.useItem)))
	self.viewComponent:setFlagShip((getProxy(BayProxy):getShipById(var_1_0.character)))

	local var_1_1 = getProxy(BuildShipProxy)

	self.viewComponent:setStartCount(table.getCount((var_1_1:getRawData())))
	self:bind(BuildShipMediator.ON_SUPPORT_SHOP, function()
		self:sendNotification(GAME.GO_SCENE, SCENE.SHOP, {
			warp = NewShopsScene.TYPE_MEDAL
		})

		return
	end)
	self:bind(BuildShipMediator.OPEN_DESTROY, function(arg_3_0)
		local var_3_0 = {
			blockLock = true,
			mode = DockyardScene.MODE_DESTROY,
			selectedMax = getGameset("ship_select_limit")[1],
			leftTopInfo = i18n("word_destroy"),
			onShip = ShipStatus.canDestroyShip
		}

		var_3_0.ignoredIds = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true
		})
		var_3_0.preView = self.viewComponent.__cname

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, var_3_0)

		return
	end)
	self:bind(BuildShipMediator.OPEN_PROJECT_LIST, function(arg_4_0)
		if self.facade:hasMediator(BuildShipDetailMediator.__cname) then
			return
		end

		self:addSubLayers(Context.New({
			mediator = BuildShipDetailMediator,
			viewComponent = BuildShipDetailLayer,
			data = {
				groupName = self.viewComponent:getGroupName()
			}
		}))

		return
	end)
	self:bind(BuildShipMediator.REMOVE_PROJECT_LIST, function(arg_5_0)
		local var_5_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(BuildShipDetailMediator)

		if var_5_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_5_0
			})
		end

		return
	end)
	self:bind(BuildShipMediator.ON_BUILD, function(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
		self:sendNotification(GAME.BUILD_SHIP, {
			buildId = arg_6_1,
			count = arg_6_2,
			isTicket = arg_6_3
		})

		return
	end)
	self:bind(BuildShipMediator.ACT_ON_BUILD, function(arg_7_0, arg_7_1, arg_7_2, arg_7_3, arg_7_4)
		self:sendNotification(GAME.ACTIVITY_OPERATION, {
			cmd = 1,
			activity_id = arg_7_1,
			arg1 = arg_7_3,
			arg2 = arg_7_4 and 1 or 0,
			buildId = arg_7_2
		})

		return
	end)
	self:bind(BuildShipMediator.ON_SUPPORT_EXCHANGE, function(arg_8_0, arg_8_1)
		self:sendNotification(GAME.SUPPORT_SHIP, {
			count = arg_8_1
		})

		return
	end)
	self:bind(BuildShipMediator.ON_UPDATE_ACT, function(arg_9_0)
		self.viewComponent:setPools(getProxy(BuildShipProxy):GetPools())
		self.viewComponent:checkPage()

		return
	end)
	self:bind(BuildShipMediator.OPEN_PRAY_PAGE, function(arg_10_0)
		self:addSubLayers(Context.New({
			mediator = PrayPoolMediator,
			viewComponent = PrayPoolScene,
			data = {
				groupName = self.viewComponent:getGroupName()
			}
		}))

		return
	end)
	self:bind(BuildShipMediator.CLOSE_PRAY_PAGE, function(arg_11_0)
		local var_11_0 = getProxy(ContextProxy):getCurrentContext():getContextByMediator(PrayPoolMediator)

		if var_11_0 then
			self:sendNotification(GAME.REMOVE_LAYERS, {
				context = var_11_0
			})
		end

		return
	end)
	self:bind(BuildShipMediator.SIMULATION_BATTLE, function(arg_12_0, arg_12_1)
		self:sendNotification(GAME.BEGIN_STAGE, {
			system = SYSTEM_SIMULATION,
			stageId = arg_12_1
		})

		return
	end)
	self:bind(BuildShipMediator.ON_BUILDPOOL_EXCHANGE, function(arg_13_0, arg_13_1)
		self:sendNotification(GAME.ACTIVITY_BUILD_POOL_EXCHANGE, {
			activity_id = arg_13_1
		})

		return
	end)
	self:bind(BuildShipMediator.ON_BUILDPOOL_UR_EXCHANGE, function(arg_14_0)
		self:addSubLayers(Context.New({
			viewComponent = BuildShipRegularExchangeLayer,
			mediator = BuildShipRegularExchangeMediator
		}))

		return
	end)
	self.viewComponent:updateQueueTip((var_1_1:getFinishCount()))
	self.viewComponent:setPools(getProxy(BuildShipProxy):GetPools())

	if self.contextData.goToPray == true then
		self.viewComponent:switchPage(self.viewComponent.PAGE_PRAY, true)
	end

	return
end

function BuildShipMediator:buildFinishComeback()
	local var_15_0 = getProxy(BuildShipProxy)

	if table.getCount(var_15_0:getData()) == 0 and self.viewComponent then
		local var_15_1 = BuildShip.getPageFromPoolType(var_15_0:getLastBuildShipPoolType()) or BuildShipScene.PAGE_BUILD

		if var_15_1 == BuildShipScene.PAGE_PRAY then
			local var_15_2 = getProxy(ActivityProxy):getActivityById(ActivityConst.ACTIVITY_PRAY_POOL)

			if not var_15_2 or var_15_2:isEnd() then
				var_15_1 = BuildShipScene.PAGE_BUILD
			end
		end

		triggerToggle(self.viewComponent.toggles[var_15_1], true)
	end

	return
end

function BuildShipMediator:listNotificationInterests()
	return {
		GAME.BUILD_SHIP_DONE,
		BagProxy.ITEM_UPDATED,
		PlayerProxy.UPDATED,
		GAME.CONFIRM_GET_SHIP,
		BuildShipProxy.ADDED,
		BuildShipProxy.REMOVED,
		GAME.BEGIN_STAGE_DONE,
		GAME.ACTIVITY_BUILD_POOL_EXCHANGE_DONE,
		GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE,
		ActivityProxy.ACTIVITY_UPDATED,
		GAME.SUPPORT_SHIP_DONE,
		BuildShipProxy.REGULAR_BUILD_POOL_COUNT_UPDATE
	}
end

function BuildShipMediator:handleNotification(arg_17_1)
	local var_17_0 = arg_17_1:getName()
	local var_17_1 = arg_17_1:getBody()

	if var_17_0 == PlayerProxy.UPDATED then
		self.viewComponent:setPlayer(var_17_1)
	elseif var_17_0 == GAME.CONFIRM_GET_SHIP then
		local var_17_2 = getProxy(BuildShipProxy)
		local var_17_3 = var_17_2:getFinishCount()

		self.viewComponent:updateQueueTip(var_17_3)

		local var_17_4 = {}

		if var_17_1.isBatch then
			var_17_2:setSkipBatchBuildFlag(false)

			local var_17_5 = {}

			for iter_17_0, iter_17_1 in ipairs(var_17_1.ships) do
				local var_17_6 = {
					type = DROP_TYPE_SHIP,
					id = iter_17_1.configId
				}

				var_17_6.count = 1
				var_17_6.virgin = iter_17_1.virgin
				var_17_6.reMetaSpecialItemVO = iter_17_1:getReMetaSpecialItemVO()
				var_17_5[#var_17_5 + 1] = var_17_6
			end

			if #var_17_5 > 0 then
				table.insert(var_17_4, function(arg_18_0)
					self.viewComponent:emit(BaseUI.ON_AWARD, {
						items = var_17_5,
						title = AwardInfoLayer.TITLE.SHIP,
						removeFunc = arg_18_0
					})

					return
				end)
			end
		end

		seriesAsync(var_17_4, function()
			if var_17_1.isBatch and var_17_3 > 0 then
				NoPosMsgBox(i18n("switch_to_shop_tip_noDockyard"), openDockyardClear, gotoChargeScene, openDockyardIntensify)
			else
				self:buildFinishComeback()
			end

			return
		end)
	elseif var_17_0 == GAME.BUILD_SHIP_DONE then
		triggerToggle(self.viewComponent.toggles[BuildShipScene.PAGE_QUEUE], true)
	elseif var_17_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setUseItem((getProxy(BagProxy):getItemById(self.useItem)))
	elseif var_17_0 == BuildShipProxy.ADDED or var_17_0 == BuildShipProxy.REMOVED then
		self.viewComponent:setStartCount(table.getCount((getProxy(BuildShipProxy):getRawData())))
	elseif var_17_0 == GAME.SUPPORT_SHIP_DONE then
		local var_17_7 = {}

		for iter_17_2, iter_17_3 in ipairs(var_17_1.ships) do
			if iter_17_3.virgin or iter_17_3:getRarity() >= 4 then
				table.insert(var_17_7, function(arg_20_0)
					self:addSubLayers(Context.New({
						mediator = NewShipMediator,
						viewComponent = NewShipLayer,
						data = {
							ship = iter_17_3
						},
						onRemoved = arg_20_0
					}))

					return
				end)
			end
		end

		seriesAsync(var_17_7, function()
			self.viewComponent:emit(BaseUI.ON_AWARD, {
				items = underscore.map(var_17_1.ships, function(arg_22_0)
					local var_22_0 = Drop.New({
						count = 1,
						type = DROP_TYPE_SHIP,
						id = arg_22_0.configId
					})

					var_22_0.virgin = arg_22_0.virgin

					return var_22_0
				end),
				title = AwardInfoLayer.TITLE.SHIP,
				removeFunc = function()
					if self.viewComponent then
						self.viewComponent.supportShipPoolPage:UpdateMedal()
					end

					return
				end
			})

			return
		end)
	elseif var_17_0 == GAME.BEGIN_STAGE_DONE then
		self:sendNotification(GAME.GO_SCENE, SCENE.COMBATLOAD, var_17_1)
	elseif var_17_0 == ActivityProxy.ACTIVITY_UPDATED then
		if var_17_1 then
			local var_17_8 = var_17_1:getConfig("type")

			if var_17_8 == ActivityConst.ACTIVITY_TYPE_BUILDSHIP_1 then
				self.viewComponent:RefreshActivityBuildPool(var_17_1)
			elseif var_17_8 == ActivityConst.ACTIVITY_TYPE_NEWSERVER_BUILD then
				if var_17_1.data2 < ((pg.ship_data_create_exchange[var_17_1.id] or {}).exchange_available_times or 0) then
					self.viewComponent:RefreshActivityBuildPool(var_17_1)
				else
					self.viewComponent:setPools(getProxy(BuildShipProxy):GetPools())
					self.viewComponent:checkPage()
				end
			elseif var_17_8 == ActivityConst.ACTIVITY_TYPE_BUILD_FREE then
				self.viewComponent:RefreshFreeBuildActivity()
			end
		end
	elseif var_17_0 == BuildShipProxy.REGULAR_BUILD_POOL_COUNT_UPDATE then
		self.viewComponent:RefreshRegularExchangeCount()
	elseif var_17_0 == GAME.ACTIVITY_BUILD_POOL_EXCHANGE_DONE or var_17_0 == GAME.REGULAR_BUILD_POOL_EXCHANGE_DONE then
		self.viewComponent:emit(BaseUI.ON_ACHIEVE, var_17_1.awards)
	end

	return
end

return BuildShipMediator
