local BuildShipDetailMediator = class("BuildShipDetailMediator", import("...base.ContextMediator"))

BuildShipDetailMediator.ON_QUICK = "BuildShipDetailMediator.ON_QUICK"
BuildShipDetailMediator.LAUNCH_ALL = "BuildShipDetailMediator.LAUNCH_ALL"
BuildShipDetailMediator.ON_LAUNCHED = "BuildShipDetailMediator.ON_LAUNCHED"

function BuildShipDetailMediator:register()
	self.viewComponent:updatePlayer(getProxy(PlayerProxy):getData())

	self.bagProxy = getProxy(BagProxy)

	self.viewComponent:setItems(self.bagProxy:getData())

	local var_1_0 = getProxy(BuildShipProxy)

	self.viewComponent:setProjectList(var_1_0:getData())
	self.viewComponent:setWorkCount(var_1_0:getMaxWorkCount())

	local var_1_1 = getProxy(SettingsProxy)

	self:bind(BuildShipDetailMediator.ON_QUICK, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 then
			var_1_1:setStopBuildSpeedupRemind()
			self.viewComponent:setBuildSpeedUpRemind(true)
		end

		self.isBatch = false

		self:GetShipProcess({
			arg_2_1
		})

		return
	end)
	self:bind(BuildShipDetailMediator.ON_LAUNCHED, function(arg_3_0, arg_3_1)
		self.isBatch = false

		self:GetShipProcess({
			arg_3_1
		})

		return
	end)
	self:bind(BuildShipDetailMediator.LAUNCH_ALL, function(arg_4_0, arg_4_1)
		if arg_4_1 then
			var_1_1:setStopBuildSpeedupRemind()
			self.viewComponent:setBuildSpeedUpRemind(true)
		end

		self.isBatch = true

		local var_4_0 = {}

		for iter_4_0, iter_4_1 in ipairs(var_1_0:getData()) do
			table.insert(var_4_0, iter_4_0)
		end

		self:GetShipProcess(var_4_0)

		return
	end)
	self.viewComponent:setBuildSpeedUpRemind((var_1_1:getStopBuildSpeedupRemind()))

	return
end

function BuildShipDetailMediator:GetShipProcess(arg_5_1)
	local var_5_0 = getProxy(BuildShipProxy)
	local var_5_1 = {}

	table.insert(var_5_1, function(arg_6_0)
		self:sendNotification(GAME.BUILD_SHIP_IMMEDIATELY, {
			pos_list = arg_5_1,
			callback = arg_6_0
		})

		return
	end)
	seriesAsync(var_5_1, function()
		if self.isBatch and underscore.any(arg_5_1, function(arg_8_0)
			return var_5_0:getBuildShip(arg_8_0).state ~= BuildShip.FINISH
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoLayer_error_noQuickItem"))
		end

		self:sendNotification(GAME.GET_SHIP, {
			pos_list = arg_5_1
		})

		return
	end)

	return
end

function BuildShipDetailMediator:listNotificationInterests()
	return {
		BagProxy.ITEM_UPDATED,
		GAME.GET_SHIP_DONE,
		BuildShipProxy.REMOVED,
		BuildShipProxy.UPDATED,
		PlayerProxy.UPDATED
	}
end

function BuildShipDetailMediator:handleNotification(arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == BagProxy.ITEM_UPDATED then
		self.viewComponent:setItems(self.bagProxy:getData())
		self.viewComponent:updateItem()
	elseif var_10_0 == GAME.GET_SHIP_DONE then
		local var_10_2 = getProxy(BuildShipProxy)

		self.viewComponent:setProjectList(var_10_2:getData())
		self.viewComponent:initProjectList()

		local var_10_3 = {}

		table.insert(var_10_3, function(arg_11_0)
			self.viewComponent:playGetShipAnimate(arg_11_0, var_10_1.type)

			return
		end)

		for iter_10_0, iter_10_1 in ipairs(var_10_1.ships) do
			table.insert(var_10_3, function(arg_12_0)
				local var_12_0 = var_10_2:getSkipBatchBuildFlag()

				if var_12_0 and not iter_10_1.virgin and iter_10_1:getRarity() < 4 then
					arg_12_0()
				else
					self:addSubLayers(Context.New({
						mediator = NewShipMediator,
						viewComponent = NewShipLayer,
						data = {
							ship = iter_10_1,
							canSkipBatch = not var_12_0 and iter_10_0 < #var_10_1.ships
						},
						onRemoved = arg_12_0
					}))
				end

				return
			end)
		end

		seriesAsync(var_10_3, function()
			self:sendNotification(GAME.CONFIRM_GET_SHIP, {
				isBatch = self.isBatch,
				ships = var_10_1.ships
			})

			return
		end)
	elseif var_10_0 == BuildShipProxy.UPDATED then
		self.viewComponent:updateProject(var_10_1.index, var_10_1.buildShip)
	elseif var_10_0 == PlayerProxy.UPDATED then
		self.viewComponent:updatePlayer(var_10_1)
	end

	return
end

return BuildShipDetailMediator
