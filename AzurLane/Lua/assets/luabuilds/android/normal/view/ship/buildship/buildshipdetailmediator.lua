class = var_0_10000

local var_0_0 = "BuildShipDetailMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...base.ContextMediator"))

var_0_1.ON_QUICK = "BuildShipDetailMediator.ON_QUICK"
var_0_1.LAUNCH_ALL = "BuildShipDetailMediator.LAUNCH_ALL"
var_0_1.ON_LAUNCHED = "BuildShipDetailMediator.ON_LAUNCHED"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)
	local var_1_1 = arg_1_0.viewComponent

	var_2.updatePlayer(var_1_1, var_1_0:getData())

	getProxy = var_2
	BagProxy = var_1_1
	arg_1_0.bagProxy = var_2(var_1_1)

	local var_1_2 = arg_1_0.viewComponent
	local var_1_3 = var_2.setItems
	local var_1_4 = arg_1_0.bagProxy

	var_1_3(var_1_2, var_4.getData(var_1_4))

	getProxy = var_1_3
	BuildShipProxy = var_1_2

	local var_1_5 = var_1_3(var_1_2)
	local var_1_6 = arg_1_0.viewComponent

	var_3.setProjectList(var_1_6, var_1_5:getData())

	local var_1_7 = arg_1_0.viewComponent

	var_3.setWorkCount(var_1_7, var_1_5:getMaxWorkCount())

	getProxy = var_3
	SettingsProxy = var_1_7

	local var_1_8 = var_3(var_1_7)

	arg_1_0:bind(var_0_1.ON_QUICK, function(arg_2_0, arg_2_1, arg_2_2)
		if arg_2_2 then
			local var_2_0 = var_1_8

			var_3.setStopBuildSpeedupRemind(var_2_0)

			local var_2_1 = arg_1_0.viewComponent

			var_3.setBuildSpeedUpRemind(var_2_1, true)
		end

		arg_1_0.isBatch = false

		local var_2_2 = arg_1_0

		var_3.GetShipProcess(var_2_2, {
			arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_LAUNCHED, function(arg_3_0, arg_3_1)
		arg_1_0.isBatch = false

		local var_3_0 = arg_1_0

		var_2.GetShipProcess(var_3_0, {
			arg_3_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.LAUNCH_ALL, function(arg_4_0, arg_4_1)
		if arg_4_1 then
			local var_4_0 = var_1_8

			var_2.setStopBuildSpeedupRemind(var_4_0)

			local var_4_1 = arg_1_0.viewComponent

			var_2.setBuildSpeedUpRemind(var_4_1, true)
		end

		arg_1_0.isBatch = true

		local var_4_2 = {}

		ipairs = var_3

		local var_4_3 = var_1_5

		for iter_4_0, iter_4_1 in var_3(var_4.getData(var_4_3)) do
			table = var_2_10008

			var_2_10008.insert(var_4_2, iter_4_0)
		end

		local var_4_4 = arg_1_0

		var_3.GetShipProcess(var_4_4, var_4_2)

		return
	end)

	local var_1_9 = var_1_8:getStopBuildSpeedupRemind()
	local var_1_10 = arg_1_0.viewComponent

	var_5.setBuildSpeedUpRemind(var_1_10, var_1_9)

	return
end

function var_0_1.GetShipProcess(arg_5_0, arg_5_1)
	getProxy = var_1_10002
	BuildShipProxy = var_1_10003

	local var_5_0 = var_1_10002(var_1_10003)
	local var_5_1 = {}

	table = var_1_10004

	var_1_10004.insert(var_5_1, function(arg_6_0)
		local var_6_0 = arg_5_0
		local var_6_1 = var_1.sendNotification

		GAME = var_2_10003

		var_6_1(var_6_0, var_2_10003.BUILD_SHIP_IMMEDIATELY, {
			pos_list = arg_5_1,
			callback = arg_6_0
		})

		return
	end)

	seriesAsync = var_4

	var_4(var_5_1, function()
		if arg_5_0.isBatch then
			underscore = var_0

			if var_0.any(arg_5_1, function(arg_8_0)
				local var_8_0 = var_5_0
				local var_8_1 = var_1.getBuildShip(var_8_0, arg_8_0).state

				BuildShip = var_8_0

				return var_8_1 ~= var_8_0.FINISH
			end) then
				pg = var_0

				local var_7_0 = var_0.TipsMgr.GetInstance()
				local var_7_1 = var_0.ShowTips

				i18n = var_2_10002

				var_7_1(var_7_0, var_2_10002("backyard_backyardShipInfoLayer_error_noQuickItem"))
			end
		end

		local var_7_2 = arg_5_0
		local var_7_3 = var_0.sendNotification

		GAME = var_2_10002

		var_7_3(var_7_2, var_2_10002.GET_SHIP, {
			pos_list = arg_5_1
		})

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_9_0)
	local var_9_0 = {}

	BagProxy = var_1_10002
	var_9_0[1] = var_1_10002.ITEM_UPDATED
	GAME = var_2
	var_9_0[2] = var_2.GET_SHIP_DONE
	BuildShipProxy = var_2
	var_9_0[3] = var_2.REMOVED
	BuildShipProxy = var_2
	var_9_0[4] = var_2.UPDATED
	PlayerProxy = var_2
	var_9_0[5] = var_2.UPDATED

	return var_9_0
end

function var_0_1.handleNotification(arg_10_0, arg_10_1)
	local var_10_0 = arg_10_1:getName()
	local var_10_1 = arg_10_1
	local var_10_2 = arg_10_1.getBody(var_10_1)

	BagProxy = var_10_1

	local var_10_3

	if var_10_0 == var_10_1.ITEM_UPDATED then
		var_1_10005 = arg_10_0.viewComponent
		var_10_3 = var_10_3.setItems

		local var_10_4 = arg_10_0.bagProxy

		var_10_3(var_1_10005, var_6.getData(var_10_4))

		var_1_10005 = arg_10_0.viewComponent

		var_10_3.updateItem(var_1_10005)
	else
		GAME = var_10_3

		local var_10_5

		if var_10_0 == var_10_3.GET_SHIP_DONE then
			getProxy = var_10_5
			BuildShipProxy = var_1_10005
			var_10_5 = var_10_5(var_1_10005)

			local var_10_6 = arg_10_0.viewComponent

			var_5.setProjectList(var_10_6, var_10_5:getData())

			local var_10_7 = arg_10_0.viewComponent

			var_5.initProjectList(var_10_7)

			local var_10_8 = {}

			table = var_10_7

			var_10_7.insert(var_10_8, function(arg_11_0)
				local var_11_0 = arg_10_0.viewComponent

				var_1.playGetShipAnimate(var_11_0, arg_11_0, var_10_2.type)

				return
			end)

			ipairs = var_6

			for iter_10_0, iter_10_1 in var_6(var_10_2.ships) do
				table = var_1_10011

				var_1_10011.insert(var_10_8, function(arg_12_0)
					local var_12_0 = var_10_5

					if var_1.getSkipBatchBuildFlag(var_12_0) and not iter_10_1.virgin then
						local var_12_1 = iter_10_1

						if var_2.getRarity(var_12_1) < 4 then
							arg_12_0()

							goto label_12_0
						end
					end

					do
						local var_12_2 = arg_10_0
						local var_12_3 = var_2.addSubLayers

						Context = var_2_10004

						local var_12_4 = var_2_10004.New
						local var_12_5 = {}

						NewShipMediator = var_2_10006
						var_12_5.mediator = var_2_10006
						NewShipLayer = var_2_10006
						var_12_5.viewComponent = var_2_10006
						var_12_5.data = {
							ship = iter_10_1,
							canSkipBatch = not var_1 and iter_10_0 < #var_10_2.ships
						}
						var_12_5.onRemoved = arg_12_0

						var_12_3(var_12_2, var_12_4(var_12_5))
					end

					::label_12_0::

					return
				end)
			end

			seriesAsync = var_6

			var_6(var_10_8, function()
				local var_13_0 = arg_10_0
				local var_13_1 = var_0.sendNotification

				GAME = var_2_10002

				var_13_1(var_13_0, var_2_10002.CONFIRM_GET_SHIP, {
					isBatch = arg_10_0.isBatch,
					ships = var_10_2.ships
				})

				return
			end)
		else
			BuildShipProxy = var_10_5

			if var_10_0 == var_10_5.UPDATED then
				local var_10_9 = arg_10_0.viewComponent

				var_4.updateProject(var_10_9, var_10_2.index, var_10_2.buildShip)
			else
				PlayerProxy = var_4

				if var_10_0 == var_4.UPDATED then
					local var_10_10 = arg_10_0.viewComponent

					var_4.updatePlayer(var_10_10, var_10_2)
				end
			end
		end
	end

	return
end

return var_0_1
