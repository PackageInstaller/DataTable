local DefenseFormationMedator = class("DefenseFormationMedator", import("..base.ContextMediator"))

DefenseFormationMedator.OPEN_SHIP_INFO = "DefenseFormationMedator:OPEN_SHIP_INFO"
DefenseFormationMedator.ON_CHANGE_FLEET = "DefenseFormationMedator:ON_CHANGE_FLEET"
DefenseFormationMedator.CHANGE_FLEET_NAME = "DefenseFormationMedator:CHANGE_FLEET_NAME"
DefenseFormationMedator.CHANGE_FLEET_SHIP = "DefenseFormationMedator:CHANGE_FLEET_SHIP"
DefenseFormationMedator.REMOVE_SHIP = "DefenseFormationMedator:REMOVE_SHIP"
DefenseFormationMedator.CHANGE_FLEET_FORMATION = "DefenseFormationMedator:CHANGE_FLEET_FORMATION"
DefenseFormationMedator.CHANGE_FLEET_SHIPS_ORDER = "DefenseFormationMedator:CHANGE_FLEET_SHIPS_ORDER"
DefenseFormationMedator.COMMIT_FLEET = "DefenseFormationMedator:COMMIT_FLEET"

function DefenseFormationMedator:register()
	self.ships = getProxy(BayProxy):getRawData()

	self.viewComponent:setShips(self.ships)

	local var_1_0 = getProxy(MilitaryExerciseProxy)
	local var_1_1 = getProxy(FleetProxy):getFleetById(1)

	self.viewComponent:SetFleet((var_1_0:getExerciseFleet()))
	self:bind(DefenseFormationMedator.OPEN_SHIP_INFO, function(arg_2_0, arg_2_1, arg_2_2, arg_2_3)
		self.contextData.number = arg_2_2.id
		self.contextData.toggle = arg_2_3

		local var_2_0 = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_2:getShipIds()) do
			table.insert(var_2_0, self.ships[iter_2_1])
		end

		self:sendNotification(GAME.GO_SCENE, SCENE.SHIPINFO, {
			shipId = arg_2_1,
			shipVOs = var_2_0
		})

		return
	end)
	self:bind(DefenseFormationMedator.COMMIT_FLEET, function(arg_3_0, arg_3_1)
		self:save(nil, arg_3_1)

		return
	end)
	self:bind(DefenseFormationMedator.CHANGE_FLEET_SHIPS_ORDER, function(arg_4_0, arg_4_1)
		self:save(arg_4_1)
		self:refreshView()

		return
	end)
	self:bind(DefenseFormationMedator.REMOVE_SHIP, function(arg_5_0, arg_5_1, arg_5_2)
		arg_5_2:removeShip(arg_5_1)
		self:save(arg_5_2)
		self:refreshView()

		return
	end)
	self:bind(DefenseFormationMedator.CHANGE_FLEET_SHIP, function(arg_6_0, arg_6_1, arg_6_2)
		local var_6_0

		if arg_6_1 then
			var_6_0 = arg_6_1.id or nil
		end

		local var_6_1 = var_1_0:getSeasonInfo()
		local var_6_2 = pg.ShipFlagMgr.GetInstance():FilterShips({
			isActivityNpc = true,
			inExercise = true
		})

		for iter_6_0 = #var_6_2, 1, -1 do
			if var_6_2[iter_6_0] == var_6_0 then
				table.remove(var_6_2, iter_6_0)

				break
			end
		end

		local var_6_3, var_6_4 = self.configDockYardFunc(self.ships, var_6_1:getMainShipIds(), var_6_1:getVanguardShipIds(), var_6_0, arg_6_2, function(arg_7_0, arg_7_1)
			self:sendNotification(GAME.UPDATE_EXERCISE_FLEET, {
				fleet = arg_7_0,
				callback = arg_7_1
			})

			arg_7_0 = nil

			return
		end)

		self:sendNotification(GAME.GO_SCENE, SCENE.DOCKYARD, {
			callbackQuit = true,
			selectedMax = 1,
			quitTeam = arg_6_1 ~= nil,
			teamFilter = arg_6_2,
			ignoredIds = var_6_2,
			hideTagFlags = ShipStatus.TAG_HIDE_DEFENSE,
			leftTopInfo = i18n("word_formation"),
			onShip = var_6_4,
			onSelected = var_6_3
		})

		return
	end)

	return
end

function DefenseFormationMedator:refreshView(arg_8_1)
	self.viewComponent:UpdateFleetView(arg_8_1)

	return
end

function DefenseFormationMedator:save(arg_9_1, arg_9_2)
	if arg_9_1 then
		self:sendNotification(GAME.UPDATE_EXERCISE_FLEET, {
			fleet = arg_9_1,
			callback = arg_9_2
		})
	elseif arg_9_2 then
		arg_9_2()
	end

	return
end

function DefenseFormationMedator:configDockYardFunc(arg_10_1, arg_10_2, arg_10_3, arg_10_4, arg_10_5)
	return function(arg_11_0, arg_11_1)
		local var_11_0 = {}

		local function var_11_1(arg_12_0)
			if not arg_10_3 then
				for iter_12_0, iter_12_1 in ipairs(_.reverse(arg_12_0)) do
					if not table.contains(arg_11_0, iter_12_1) then
						table.insert(arg_11_0, 1, iter_12_1)
					end
				end
			elseif arg_10_3 and table.getCount(arg_11_0) == 0 then
				for iter_12_2, iter_12_3 in ipairs(arg_12_0) do
					if iter_12_3 ~= arg_10_3 and not table.contains(arg_11_0, iter_12_3) then
						table.insert(arg_11_0, iter_12_3)
					end
				end
			elseif arg_10_3 then
				for iter_12_4, iter_12_5 in ipairs(arg_12_0) do
					if iter_12_5 == arg_10_3 then
						arg_12_0[iter_12_4] = arg_11_0[1]
					end
				end

				arg_11_0 = arg_12_0
			end

			return
		end

		local function var_11_2(arg_13_0)
			if arg_10_4 == TeamType.Main then
				if arg_13_0 then
					var_11_0.mainShips = arg_11_0 or arg_10_1
				end

				var_11_0.vanguardShips = arg_10_2
			elseif arg_10_4 == TeamType.Vanguard then
				var_11_0.mainShips = arg_10_1

				if arg_13_0 then
					var_11_0.vanguardShips = arg_11_0 or arg_10_2
				end
			end

			if arg_10_5 then
				arg_10_5(var_11_0, arg_11_1)
			end

			return
		end

		if arg_10_4 == TeamType.Main then
			var_11_1(arg_10_1)
		elseif arg_10_4 == TeamType.Vanguard then
			var_11_1(arg_10_2)
		end

		local function var_11_3()
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("defense_formation_tip_npc"),
				onYes = function()
					var_11_2(false)

					return
				end,
				onNo = function()
					var_11_2(false)

					return
				end
			})

			return
		end

		if #arg_11_0 > 0 then
			var_11_2(true)
		else
			pg.MsgboxMgr.GetInstance():ShowMsgBox({
				content = i18n("exercise_clear_fleet_tip"),
				onYes = function()
					if not getProxy(FleetProxy):getFleetById(1):ExistActNpcShip() then
						var_11_2(true)
					else
						var_11_3()
					end

					return
				end,
				onNo = function()
					var_11_2(false)

					return
				end
			})
		end

		return
	end, function(arg_19_0, arg_19_1, arg_19_2)
		local var_19_0 = pg.ship_data_template[arg_19_0.configId].group_type

		local function var_19_1(arg_20_0)
			for iter_20_0, iter_20_1 in ipairs(arg_20_0) do
				if (not arg_10_3 or arg_10_3 ~= iter_20_1 or pg.ship_data_template[self[iter_20_1].configId].group_type ~= var_19_0) and pg.ship_data_template[self[iter_20_1].configId].group_type == var_19_0 then
					return false
				end
			end

			return true
		end

		if arg_10_4 == TeamType.Main then
			if not var_19_1(arg_10_1) then
				local var_19_3 = i18n("ship_vo_mainFleet_exist_same_ship")

				return
			end
		elseif arg_10_4 == TeamType.Vanguard and not var_19_1(arg_10_2) then
			local var_19_5 = i18n("ship_vo_vanguardFleet_exist_same_ship")

			return
		end

		return true
	end
end

function DefenseFormationMedator:listNotificationInterests()
	return {
		GAME.EXERCISE_FLEET_RESET
	}
end

function DefenseFormationMedator:handleNotification(arg_22_1)
	if GAME.EXERCISE_FLEET_RESET == arg_22_1:getName() then
		self.viewComponent:SetFleet((arg_22_1:getBody()))
		self.viewComponent:UpdateFleetView(true)
	end

	return
end

return DefenseFormationMedator
