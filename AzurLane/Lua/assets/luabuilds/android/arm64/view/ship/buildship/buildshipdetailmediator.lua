local var_0_0 = class("BuildShipDetailMediator", import("...base.ContextMediator"))

var_0_0.ON_QUICK = "BuildShipDetailMediator.ON_QUICK"
var_0_0.LAUNCH_ALL = "BuildShipDetailMediator.LAUNCH_ALL"
var_0_0.ON_LAUNCHED = "BuildShipDetailMediator.ON_LAUNCHED"

function var_0_0.register(arg_1_0)
	arg_1_0.viewComponent:updatePlayer(getProxy(PlayerProxy):getData())

	arg_1_0.bagProxy = getProxy(BagProxy)

	arg_1_0.viewComponent:setItems(arg_1_0.bagProxy:getData())

	local var_1_0 = getProxy(BuildShipProxy)

	arg_1_0.viewComponent:setProjectList(var_1_0:getData())
	arg_1_0.viewComponent:setWorkCount(var_1_0:getMaxWorkCount())

	local var_1_1 = getProxy(SettingsProxy)

	arg_1_0:bind(var_0_0.ON_QUICK, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 then
			var_1_1:setStopBuildSpeedupRemind()
			arg_1_0.viewComponent:setBuildSpeedUpRemind(true)
		end

		arg_1_0.isBatch = false

		arg_1_0:GetShipProcess({
			arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.ON_LAUNCHED, function(arg_3_0, arg_3_1)
		arg_1_0.isBatch = false

		arg_1_0:GetShipProcess({
			arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_0.LAUNCH_ALL, function(arg_4_0, arg_4_1)
		if arg_4_1 then
			var_1_1:setStopBuildSpeedupRemind()
			arg_1_0.viewComponent:setBuildSpeedUpRemind(true)
		end

		arg_1_0.isBatch = true

		for iter_4_0, iter_4_1 in ipairs(var_1_0:getData()) do
			table.insert({}, iter_4_0)
		end

		arg_1_0:GetShipProcess({})

		return
	end)
	arg_1_0.viewComponent:setBuildSpeedUpRemind((getProxy(SettingsProxy):getStopBuildSpeedupRemind()))

	return
end

function var_0_0.GetShipProcess(arg_5_0, arg_5_1)
	local var_5_0 = getProxy(BuildShipProxy)

	table.insert({}, function(arg_6_0)
		arg_5_0:sendNotification(GAME.BUILD_SHIP_IMMEDIATELY, {
			pos_list = arg_5_1,
			callback = arg_6_0
		})

		return
	end)
	seriesAsync({}, function()
		if arg_5_0.isBatch and underscore.any(arg_5_1, function(arg_8_0)
			return var_5_0:getBuildShip(arg_8_0).state ~= BuildShip.FINISH
		end) then
			pg.TipsMgr.GetInstance():ShowTips(i18n("backyard_backyardShipInfoLayer_error_noQuickItem"))
		end

		arg_5_0:sendNotification(GAME.GET_SHIP, {
			pos_list = arg_5_1
		})

		return
	end)

	return
end

function var_0_0.listNotificationInterests(arg_9_0)
	return {
		BagProxy.ITEM_UPDATED,
		GAME.GET_SHIP_DONE,
		BuildShipProxy.REMOVED,
		BuildShipProxy.UPDATED,
		PlayerProxy.UPDATED
	}
end

function var_0_0.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1:getBody()

	if var_10_0 == BagProxy.ITEM_UPDATED then
		arg_10_0.viewComponent:setItems(arg_10_0.bagProxy:getData())
		arg_10_0.viewComponent:updateItem()
	elseif var_10_0 == GAME.GET_SHIP_DONE then
		local var_10_2 = getProxy(BuildShipProxy)

		arg_10_0.viewComponent:setProjectList(getProxy(BuildShipProxy):getData())
		arg_10_0.viewComponent:initProjectList()
		table.insert({}, function(arg_11_0)
			arg_10_0.viewComponent:playGetShipAnimate(arg_11_0, var_10_1.type)

			return
		end)

		for iter_10_0, iter_10_1 in ipairs(var_10_1.ships) do
			table.insert({}, function(arg_12_0)
				local var_12_0 = var_10_2:getSkipBatchBuildFlag()

				if var_12_0 and not iter_10_1.virgin and iter_10_1:getRarity() < 4 then
					arg_12_0()
				else
					arg_10_0:addSubLayers(Context.New({
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

		seriesAsync({}, function()
			arg_10_0:sendNotification(GAME.CONFIRM_GET_SHIP, {
				isBatch = arg_10_0.isBatch,
				ships = var_10_1.ships
			})

			return
		end)
	elseif var_10_0 == BuildShipProxy.UPDATED then
		arg_10_0.viewComponent:updateProject(var_10_1.index, var_10_1.buildShip)
	elseif var_10_0 == PlayerProxy.UPDATED then
		arg_10_0.viewComponent:updatePlayer(var_10_1)
	end

	return
end

return var_0_0
