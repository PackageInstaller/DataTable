class = var_0_10000

local var_0_0 = "DockyardMediator"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("..base.ContextMediator"))

var_0_1.ON_DESTROY_SHIPS = "DockyardMediator:ON_DESTROY_SHIPS"
var_0_1.ON_SHIP_DETAIL = "DockyardMediator:ON_SHIP_DETAIL"
var_0_1.ON_SHIP_REPAIR = "DockyardMediator:ON_SHIP_REPAIR"
var_0_1.OPEN_DOCKYARD_INDEX = "DockyardMediator:OPEN_DOCKYARD_INDEX"
var_0_1.CHANGE_SKIN = "DockyardMediator.CHANGE_SKIN"
var_0_1.CHANGE_RANDOM_FLAG = "DockyardMediator.CHANGE_RANDOM_FLAG"

function var_0_1.register(arg_1_0)
	getProxy = var_1_10001
	BayProxy = var_1_10002

	local var_1_0 = var_1_10001(var_1_10002)

	if arg_1_0.contextData.shipVOs then
		arg_1_0.shipsById = {}
		ipairs = var_2

		for iter_1_0, iter_1_1 in var_2(arg_1_0.contextData.shipVOs) do
			arg_1_0.shipsById[iter_1_1.id] = iter_1_1
		end
	else
		local var_1_1 = arg_1_0.contextData.mode

		DockyardScene = var_1_10003

		if var_1_1 == var_1_10003.MODE_WORLD then
			arg_1_0.shipsById = {}
			ipairs = var_2
			nowWorld = var_1_10003

			local var_1_2 = var_1_10003()

			for iter_1_2, iter_1_3 in var_2(var_1_10003.GetShipVOs(var_1_2)) do
				arg_1_0.shipsById[iter_1_3.id] = iter_1_3
			end
		else
			arg_1_0.shipsById = {}
			pairs = var_2

			for iter_1_4, iter_1_5 in var_2(var_1_0.data) do
				arg_1_0.shipsById[iter_1_4] = iter_1_5
			end
		end
	end

	local var_1_3 = arg_1_0.contextData.mode

	DockyardScene = var_1_10003

	local var_1_5

	if var_1_3 == var_1_10003.MODE_MOD then
		var_1_3 = arg_1_0.contextData.ignoredIds[1]

		local var_1_4 = arg_1_0.viewComponent

		var_1_5 = var_1_5.setModShip

		local var_1_6 = arg_1_0.shipsById[var_1_3]

		var_1_5(var_1_4, var_5.clone(var_1_6))
	end

	getProxy = var_1_3
	FleetProxy = var_1_5
	arg_1_0.fleetProxy = var_1_3(var_1_5)

	local var_1_7 = arg_1_0.fleetProxy

	arg_1_0.fleetShipIds = var_2.getAllShipIds(var_1_7)

	if arg_1_0.contextData.ignoredIds then
		ipairs = var_2

		for iter_1_6, iter_1_7 in var_2(arg_1_0.contextData.ignoredIds) do
			arg_1_0.shipsById[iter_1_7] = nil
		end
	end

	local var_1_8 = arg_1_0.viewComponent

	var_2.setShips(var_1_8, arg_1_0.shipsById)

	local var_1_9 = arg_1_0.viewComponent

	var_2.setShipsCount(var_1_9, var_1_0:getShipCount())

	getProxy = var_2
	PlayerProxy = var_1_9

	local var_1_10 = var_2(var_1_9)
	local var_1_11 = var_2.getData(var_1_10)
	local var_1_12 = arg_1_0.viewComponent

	var_4.setPlayer(var_1_12, var_1_11)
	arg_1_0:bind(var_0_1.ON_DESTROY_SHIPS, function(arg_2_0, arg_2_1, arg_2_2)
		local var_2_0 = arg_1_0
		local var_2_1 = var_3.sendNotification

		GAME = var_2_10005

		var_2_1(var_2_0, var_2_10005.DESTROY_SHIPS, {
			destroyEquipment = arg_2_2,
			shipIds = arg_2_1
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHIP_DETAIL, function(arg_3_0, arg_3_1, arg_3_2, arg_3_3)
		local var_3_0 = arg_1_0
		local var_3_1 = var_4.sendNotification

		GAME = var_2_10006

		local var_3_2 = var_2_10006.GO_SCENE

		SCENE = var_2_10007

		var_3_1(var_3_0, var_3_2, var_2_10007.SHIPINFO, {
			shipId = arg_3_1.id,
			shipVOs = arg_3_2,
			selectContextData = arg_3_3
		})

		return
	end)
	arg_1_0:bind(var_0_1.ON_SHIP_REPAIR, function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = arg_1_0
		local var_4_1 = var_3.sendNotification

		GAME = var_2_10005

		var_4_1(var_4_0, var_2_10005.WORLD_SHIP_REPAIR, {
			shipIds = arg_4_1,
			totalCost = arg_4_2
		})

		return
	end)
	arg_1_0:bind(var_0_1.OPEN_DOCKYARD_INDEX, function(arg_5_0, arg_5_1)
		local var_5_0 = arg_1_0
		local var_5_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_5_2 = var_2_10004.New
		local var_5_3 = {}

		CustomIndexLayer = var_2_10006
		var_5_3.viewComponent = var_2_10006
		CustomIndexMediator = var_2_10006
		var_5_3.mediator = var_2_10006
		var_5_3.data = arg_5_1

		var_5_1(var_5_0, var_5_2(var_5_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_SKIN, function(arg_6_0, arg_6_1)
		local var_6_0 = arg_1_0
		local var_6_1 = var_2.addSubLayers

		Context = var_2_10004

		local var_6_2 = var_2_10004.New
		local var_6_3 = {}

		SwitchSkinMediator = var_2_10006
		var_6_3.mediator = var_2_10006
		SwitchSkinLayer = var_2_10006
		var_6_3.viewComponent = var_2_10006
		var_6_3.data = {
			shipVO = arg_6_1
		}

		var_6_1(var_6_0, var_6_2(var_6_3))

		return
	end)
	arg_1_0:bind(var_0_1.CHANGE_RANDOM_FLAG, function(arg_7_0, arg_7_1, arg_7_2)
		local var_7_0 = arg_1_0
		local var_7_1 = var_3.sendNotification

		GAME = var_2_10005

		local var_7_2 = var_2_10005.CHANGE_RANDOM_SHIPS
		local var_7_3 = {}
		local var_7_4

		if not arg_7_2 or not {
			arg_7_1
		} then
			var_7_4 = {}
		end

		var_7_3.addList = var_7_4

		local var_7_5

		if arg_7_2 or not {
			arg_7_1
		} then
			var_7_5 = {}
		end

		var_7_3.deleteList = var_7_5

		var_7_1(var_7_0, var_7_2, var_7_3)

		return
	end)

	return
end

function var_0_1.listNotificationInterests(arg_8_0)
	local var_8_0 = {}

	GAME = var_1_10002
	var_8_0[1] = var_1_10002.DESTROY_SHIP_DONE
	FleetProxy = var_2
	var_8_0[2] = var_2.FLEET_UPDATED
	GAME = var_2
	var_8_0[3] = var_2.EXIT_SHIP_DONE
	GAME = var_2
	var_8_0[4] = var_2.UPDATE_EXERCISE_FLEET_DONE
	GAME = var_2
	var_8_0[5] = var_2.CANCEL_LEARN_TACTICS_DONE
	PlayerProxy = var_2
	var_8_0[6] = var_2.UPDATED
	GAME = var_2
	var_8_0[7] = var_2.WORLD_SHIP_REPAIR_DONE
	GAME = var_2
	var_8_0[8] = var_2.UPDATE_LOCK_DONE
	GAME = var_2
	var_8_0[9] = var_2.WORLD_FLEET_REDEPLOY_DONE
	SetShipSkinCommand = var_2
	var_8_0[10] = var_2.SKIN_UPDATED
	GAME = var_2
	var_8_0[11] = var_2.CHANGE_SKIN_UPDATE

	return var_8_0
end

function var_0_1.handleNotification(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1:getName()
	local var_9_1 = arg_9_1
	local var_9_2 = arg_9_1.getBody(var_9_1)

	GAME = var_9_1

	local var_9_3

	if var_9_0 == var_9_1.DESTROY_SHIP_DONE then
		pg = var_9_3
		var_1_10005 = var_9_3.m02
		var_9_3 = var_9_3.hasMediator
		ShipMainMediator = var_1_10006

		if not var_9_3(var_1_10005, var_1_10006.__cname) then
			pg = var_9_3
			var_1_10005 = var_9_3.TipsMgr.GetInstance()
			var_9_3 = var_9_3.ShowTips
			i18n = var_1_10006

			var_9_3(var_1_10005, var_1_10006("ship_dockyardMediator_destroy"))
		end

		ipairs = var_9_3

		for iter_9_0, iter_9_1 in var_9_3(var_9_2.destroiedShipIds) do
			local var_9_4 = arg_9_0.viewComponent

			iter_9_12.removeShip(var_9_4, iter_9_1)
		end

		var_1_10005 = arg_9_0.viewComponent

		var_9_3.updateShipCount(var_1_10005)

		var_1_10005 = arg_9_0.viewComponent
		var_9_3 = var_9_3.setShipsCount
		getProxy = var_1_10006
		BayProxy = iter_9_0
		iter_9_0 = var_1_10006(iter_9_0)

		var_9_3(var_1_10005, var_1_10006.getShipCount(iter_9_0))

		var_1_10005 = arg_9_0.viewComponent

		var_9_3.updateBarInfo(var_1_10005)

		var_1_10005 = arg_9_0.viewComponent

		var_9_3.updateSelected(var_1_10005)

		var_1_10005 = arg_9_0.viewComponent

		var_9_3.updateDestroyRes(var_1_10005)

		function var_9_3()
			table = var_2_10000

			local var_10_0 = var_2_10000.getCount(var_9_2.equipments)

			if 0 < var_10_0 then
				local var_10_1 = {}

				pairs = var_1

				for iter_10_0, iter_10_1 in var_1(var_9_2.equipments) do
					table = var_2_10006

					var_2_10006.insert(var_10_1, iter_10_1)
				end

				local var_10_2 = arg_9_0
				local var_10_3 = var_1.addSubLayers

				Context = var_3

				local var_10_4 = var_3.New
				local var_10_5 = {}

				ResolveEquipmentLayer = iter_10_1
				var_10_5.viewComponent = iter_10_1
				ResolveEquipmentMediator = iter_10_1
				var_10_5.mediator = iter_10_1
				var_10_5.data = {
					Equipments = var_10_1
				}

				var_10_3(var_10_2, var_10_4(var_10_5))
			end

			return
		end

		var_1_10006 = arg_9_0.viewComponent
		var_1_10005 = var_1_10005.emit
		BaseUI = iter_9_0
		iter_9_0 = iter_9_0.ON_AWARD
		iter_9_1 = {
			items = var_9_2.bonus
		}
		AwardInfoLayer = iter_9_12
		iter_9_1.title = iter_9_12.TITLE.ITEM
		iter_9_1.removeFunc = var_9_3

		var_1_10005(var_1_10006, iter_9_0, iter_9_1)

		var_1_10006 = arg_9_0.viewComponent

		var_1_10005.closeDestroyPanel(var_1_10006)
	else
		FleetProxy = var_9_3

		local var_9_5

		if var_9_0 == var_9_3.FLEET_UPDATED then
			var_9_5 = arg_9_0.fleetShipIds
			var_1_10006 = arg_9_0.fleetProxy
			arg_9_0.fleetShipIds = var_1_10005.getAllShipIds(var_1_10006)
			var_1_10005 = {}
			ipairs = var_1_10006

			for iter_9_12, iter_9_3 in var_1_10006(var_9_5) do
				var_1_10005[iter_9_3] = 1
			end

			ipairs = var_1_10006

			for iter_9_12, iter_9_5 in var_1_10006(arg_9_0.fleetShipIds) do
				if var_1_10005[iter_9_5] == 1 then
					var_1_10005[iter_9_5] = 2
				else
					var_1_10005[iter_9_5] = 3
				end
			end

			ipairs = var_1_10006

			for iter_9_12, iter_9_7 in var_1_10006(var_9_5) do
				if var_1_10005[iter_9_7] == 1 then
					var_1_10005[iter_9_7] = 0
				end
			end

			pairs = var_1_10006

			for iter_9_12, iter_9_9 in var_1_10006(var_1_10005) do
				if iter_9_9 == 0 then
					arg_9_0:setShipFlag(iter_9_12, "inFleet", false)
				elseif iter_9_9 == 3 then
					arg_9_0:setShipFlag(iter_9_12, "inFleet", true)
				end

				local var_9_6 = arg_9_0.viewComponent

				var_11.updateShipStatusById(var_9_6, iter_9_12)
			end
		else
			GAME = var_9_5

			if var_9_0 == var_9_5.EXIT_SHIP_DONE then
				var_1_10005 = arg_9_0

				arg_9_0.setShipFlag(var_1_10005, var_9_2.id, "inBackyard", false)

				var_1_10005 = arg_9_0.viewComponent

				var_4.updateShipStatusById(var_1_10005, var_9_2.id)
			else
				GAME = var_4

				local var_9_7

				if var_9_0 == var_4.UPDATE_LOCK_DONE then
					var_9_7 = arg_9_0.shipsById[var_9_2.id]
					var_9_7.lockState = var_9_2.lockState
					var_1_10005 = arg_9_0.viewComponent

					var_9_7.updateShipStatusById(var_1_10005, var_9_2.id)
				else
					GAME = var_9_7

					if var_9_0 == var_9_7.CANCEL_LEARN_TACTICS_DONE then
						var_1_10005 = arg_9_0

						arg_9_0.setShipFlag(var_1_10005, var_9_2.shipId, "inTactics", false)

						var_1_10005 = arg_9_0.viewComponent

						var_4.updateShipStatusById(var_1_10005, var_9_2.shipId)
					else
						GAME = var_4

						local var_9_8

						if var_9_0 == var_4.UPDATE_EXERCISE_FLEET_DONE then
							var_9_8 = var_9_2.oldFleet
							var_1_10005 = var_9_2.newFleet
							ipairs = var_1_10006

							for iter_9_12, iter_9_11 in var_1_10006(var_9_8.ships) do
								arg_9_0:setShipFlag(iter_9_11, "inExercise", false)

								local var_9_9 = arg_9_0.viewComponent

								var_11.updateShipStatusById(var_9_9, iter_9_11)
							end

							ipairs = var_1_10006

							for iter_9_12, iter_9_13 in var_1_10006(var_1_10005.ships) do
								arg_9_0:setShipFlag(iter_9_13, "inExercise", true)

								local var_9_10 = arg_9_0.viewComponent

								var_11.updateShipStatusById(var_9_10, iter_9_13)
							end
						else
							PlayerProxy = var_9_8

							if var_9_0 == var_9_8.UPDATED then
								var_1_10005 = arg_9_0.viewComponent

								var_4.setPlayer(var_1_10005, var_9_2)
							else
								GAME = var_4

								if var_9_0 == var_4.WORLD_SHIP_REPAIR_DONE then
									_ = var_4

									var_4.each(var_9_2.shipIds, function(arg_11_0)
										local var_11_0 = arg_9_0.viewComponent

										var_1.updateShipStatusById(var_11_0, arg_11_0)

										return
									end)
								else
									GAME = var_4

									local var_9_11

									if var_9_0 == var_4.WORLD_FLEET_REDEPLOY_DONE then
										var_1_10005 = arg_9_0.viewComponent
										var_9_11 = var_9_11.emit
										BaseUI = var_1_10006

										var_9_11(var_1_10005, var_1_10006.ON_BACK)
									else
										SetShipSkinCommand = var_9_11

										local var_9_12

										if var_9_0 == var_9_11.SKIN_UPDATED then
											if arg_9_0.shipsById[var_9_2.ship.id] then
												var_9_12 = arg_9_0.shipsById
												var_1_10005 = var_9_2.ship.id
												getProxy = var_1_10006
												BayProxy = iter_9_0

												local var_9_13 = var_1_10006(iter_9_0)

												var_9_12[var_1_10005] = var_6.RawGetShipById(var_9_13, var_9_2.ship.id)
											end

											var_1_10005 = arg_9_0.viewComponent
											var_9_12 = var_9_12.OnShipSkinChanged

											local var_9_14 = var_9_2.ship

											var_9_12(var_1_10005, var_6.GetShipPhantomMark(var_9_14))
										else
											GAME = var_9_12

											if var_9_0 == var_9_12.CHANGE_SKIN_UPDATE then
												local var_9_15 = var_9_2

												ShipPhantom = var_1_10005

												local var_9_16, var_9_17 = var_1_10005.UnpackMark(var_9_15)

												if arg_9_0.shipsById[var_9_16] then
													local var_9_18 = arg_9_0.shipsById

													getProxy = iter_9_1
													BayProxy = iter_9_12

													local var_9_19 = iter_9_1(iter_9_12)

													var_9_18[var_9_16] = var_8.RawGetShipById(var_9_19, var_9_16)
												end

												local var_9_20 = arg_9_0.viewComponent

												var_7.OnShipSkinChanged(var_9_20, var_9_15)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
	end

	return
end

function var_0_1.setShipFlag(arg_12_0, arg_12_1, arg_12_2, arg_12_3)
	if arg_12_0.shipsById[arg_12_1] then
		var_4[arg_12_2] = arg_12_3
	end

	return
end

return var_0_1
