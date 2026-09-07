local FleetProxy = class("FleetProxy", import(".NetProxy"))

FleetProxy.FLEET_ADDED = "fleet added"
FleetProxy.FLEET_UPDATED = "fleet updated"
FleetProxy.FLEET_RENAMED = "fleet renamed"
FleetProxy.PVP_FLEET_ID = 101
FleetProxy.CHALLENGE_FLEET_ID = 102
FleetProxy.CHALLENGE_SUB_FLEET_ID = 103

function FleetProxy:register()
	self.extraFleets = {}
	self.activityFleetData = {}

	self:on(12101, function(arg_2_0)
		self.data = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.group_list) do
			local var_2_0 = FleetProxy.CreateFleet(iter_2_1)

			var_2_0:display("loaded")

			self.data[var_2_0.id] = var_2_0

			self:CommanderManualTaskProgressAdd(var_2_0)
		end

		for iter_2_2 = 1, FormationUI.MAX_FLEET_NUM do
			self.data[iter_2_2] = self.data[iter_2_2] or FleetProxy.CreateFleet({
				name = "",
				id = iter_2_2,
				ship_list = {},
				commanders = {}
			})
		end

		for iter_2_3, iter_2_4 in pairs({
			[FleetProxy.PVP_FLEET_ID] = "",
			[FleetProxy.CHALLENGE_FLEET_ID] = "",
			[FleetProxy.CHALLENGE_SUB_FLEET_ID] = ""
		}) do
			self.data[iter_2_3] = self.data[iter_2_3] or FleetProxy.CreateFleet({
				id = iter_2_3,
				name = iter_2_4,
				ship_list = {},
				commanders = {}
			})
		end

		for iter_2_5, iter_2_6 in ipairs({
			FleetProxy.CHALLENGE_FLEET_ID,
			FleetProxy.CHALLENGE_SUB_FLEET_ID
		}) do
			self.extraFleets[iter_2_6] = self.data[iter_2_6]
			self.data[iter_2_6] = nil
		end

		if LOCK_SUBMARINE then
			for iter_2_7, iter_2_8 in pairs(self.data) do
				if iter_2_8.id == 11 or iter_2_8.id == 12 then
					self.data[iter_2_7] = nil
				end
			end
		end

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inFleet")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inPvP")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inChallenge")

		return
	end)
	self:on(12106, function(arg_3_0)
		local var_3_0 = FleetProxy.CreateFleet(arg_3_0.group)

		if self.data[var_3_0.id] then
			self:updateFleet(var_3_0)
		else
			self:addFleet(var_3_0)
		end

		return
	end)

	return
end

function FleetProxy:CreateFleet()
	local var_4_0 = CreateShell(self)

	var_4_0.fleetType = FleetType.Normal

	if self.id >= Fleet.REGULAR_FLEET_ID and self.id < Fleet.REGULAR_FLEET_ID + Fleet.REGULAR_FLEET_NUMS then
		if self.id == Fleet.REGULAR_FLEET_ID then
			var_4_0.saveLastShipFlag = true
		end
	elseif self.id >= Fleet.SUBMARINE_FLEET_ID and self.id < Fleet.SUBMARINE_FLEET_ID + Fleet.SUBMARINE_FLEET_NUMS then
		var_4_0.fleetType = FleetType.Submarine
	elseif self.id == FleetProxy.PVP_FLEET_ID then
		var_4_0.saveLastShipFlag = true
	elseif self.id == FleetProxy.CHALLENGE_FLEET_ID then
		-- block empty
	elseif self.id == FleetProxy.CHALLENGE_SUB_FLEET_ID then
		var_4_0.fleetType = FleetType.Submarine
	end

	return (TypedFleet.New(var_4_0))
end

function FleetProxy:addFleet(arg_5_1)
	assert(isa(arg_5_1, Fleet), "should be an instance of Fleet")
	assert(self.data[arg_5_1.id] == nil, "fleet already exist, use updateFleet() instead")

	self.data[arg_5_1.id] = arg_5_1:clone()

	self.data[arg_5_1.id]:display("added")
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inFleet")
	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inPvP")
	self.facade:sendNotification(FleetProxy.FLEET_ADDED, arg_5_1:clone())

	return
end

function FleetProxy:updateFleet(arg_6_1)
	assert(isa(arg_6_1, Fleet), "should be an instance of Fleet")

	if self.data[arg_6_1.id] ~= nil then
		self.data[arg_6_1.id] = arg_6_1:clone()

		self.data[arg_6_1.id]:display("updated")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inFleet")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inPvP")
		self:CommanderManualTaskProgressAdd(arg_6_1)
	elseif self.extraFleets[arg_6_1.id] ~= nil then
		self.extraFleets[arg_6_1.id] = arg_6_1

		self.extraFleets[arg_6_1.id]:display("updated")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inChallenge")
	else
		assert(false, "fleet should exist")
	end

	self.facade:sendNotification(FleetProxy.FLEET_UPDATED, arg_6_1.id)

	return
end

function FleetProxy:saveEdittingFleet()
	if self.editSrcCache == nil then
		self.editSrcCache = Clone(self.data)
	end

	if self.EdittingFleet ~= nil then
		self.data[self.EdittingFleet.id] = self.EdittingFleet

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inFleet")
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inPvP")
	end

	return
end

function FleetProxy:commitEdittingFleet(arg_8_1)
	local var_8_0 = {}

	if self.EdittingFleet ~= nil then
		table.insert(var_8_0, function(arg_9_0)
			self.facade:sendNotification(GAME.UPDATE_FLEET, {
				fleet = self.EdittingFleet,
				callback = function()
					self.editSrcCache = nil
					self.EdittingFleet = nil

					arg_9_0()

					return
				end
			})

			return
		end)
	end

	seriesAsync(var_8_0, function()
		if arg_8_1 then
			arg_8_1()
		end

		return
	end)

	return
end

function FleetProxy:abortEditting()
	if self.editSrcCache then
		self.data = self.editSrcCache
		self.editSrcCache = nil
	end

	self.EdittingFleet = nil

	return
end

function FleetProxy:syncFleet()
	for iter_13_0, iter_13_1 in ipairs(self.data) do
		self.facade:sendNotification(GAME.UPDATE_FLEET, {
			fleet = iter_13_1
		})
	end

	return
end

function FleetProxy:getCount()
	return table.getCount(self.data)
end

function FleetProxy:getFleetById(arg_15_1)
	if self.data[arg_15_1] ~= nil then
		return self.data[arg_15_1]:clone()
	end

	if self.extraFleets[arg_15_1] then
		return self.extraFleets[arg_15_1]
	end

	return nil
end

function FleetProxy:getAllShipIds(arg_16_1)
	local var_16_0 = {}

	for iter_16_0, iter_16_1 in pairs(self.data) do
		if arg_16_1 and not iter_16_1:isRegularFleet() then
			-- block empty
		else
			for iter_16_2, iter_16_3 in ipairs(iter_16_1.ships) do
				table.insert(var_16_0, iter_16_3)
			end
		end
	end

	return var_16_0
end

function FleetProxy:getFirstFleetShipCount()
	local var_17_0 = 0

	for iter_17_0, iter_17_1 in ipairs(self.data[1].ships) do
		var_17_0 = var_17_0 + 1
	end

	return var_17_0
end

function FleetProxy:GetRegularFleets()
	local var_18_0 = {}

	for iter_18_0, iter_18_1 in pairs(self.data) do
		if iter_18_1:isRegularFleet() then
			var_18_0[iter_18_0] = Clone(iter_18_1)
		end
	end

	return var_18_0
end

function FleetProxy:inPvPFleet(arg_19_1)
	if self.data[FleetProxy.PVP_FLEET_ID]:containShip(arg_19_1) then
		return true
	end

	return false
end

function FleetProxy:GetRegularFleetByShip(arg_20_1)
	assert(isa(arg_20_1, Ship), "should be an instance of Ship")

	for iter_20_0, iter_20_1 in pairs(self.data) do
		if iter_20_1:isRegularFleet() and iter_20_1:containShip(arg_20_1) then
			return iter_20_1:clone()
		end
	end

	return nil
end

function FleetProxy:renameFleet(arg_21_1, arg_21_2)
	local var_21_0 = self:getFleetById(arg_21_1)

	assert(var_21_0 ~= nil, "fleet should exist")

	var_21_0.name = arg_21_2

	self:updateFleet(var_21_0)
	self.facade:sendNotification(FleetProxy.FLEET_RENAMED, var_21_0:clone())

	return
end

function FleetProxy:getCommandersInFleet()
	local var_22_0 = {}

	for iter_22_0, iter_22_1 in pairs(self.data) do
		if iter_22_1:isRegularFleet() then
			for iter_22_2, iter_22_3 in pairs(iter_22_1:getCommanders()) do
				table.insert(var_22_0, iter_22_3.id)
			end
		end
	end

	return var_22_0
end

function FleetProxy:getCommanders()
	local var_23_0 = {}

	for iter_23_0, iter_23_1 in pairs(self.data) do
		if iter_23_1:isRegularFleet() then
			for iter_23_2, iter_23_3 in pairs(iter_23_1:getCommanders()) do
				table.insert(var_23_0, {
					fleetId = iter_23_1.id,
					pos = iter_23_2,
					commanderId = iter_23_3.id
				})
			end
		end
	end

	return var_23_0
end

function FleetProxy:GetExtraCommanders()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self.extraFleets) do
		for iter_24_2, iter_24_3 in pairs(iter_24_1:getCommanders()) do
			table.insert(var_24_0, {
				fleetId = iter_24_1.id,
				pos = iter_24_2,
				commanderId = iter_24_3.id
			})
		end
	end

	return var_24_0
end

function FleetProxy:getActivityFleets()
	return self.activityFleetData
end

function FleetProxy:addActivityFleet(arg_26_1, arg_26_2)
	self.activityFleetData[arg_26_1.id] = self.activityFleetData[arg_26_1.id] or {}

	local var_26_0 = self.activityFleetData[arg_26_1.id]
	local var_26_1 = getProxy(BayProxy)
	local var_26_2
	local var_26_3
	local var_26_4 = pg.activity_template[arg_26_1.id]

	local function var_26_5()
		if var_26_3 then
			return var_26_3
		end

		if var_26_4.type == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
			local var_27_0 = CollabrateBossRushSeriesData or BossRushSeriesData
		end

		var_26_3 = _.map(arg_26_1:GetActiveSeriesIds(), function(arg_28_0)
			return table.lastof(var_27_0.New({
				id = arg_28_0,
				actId = arg_26_1.id
			}):GetFleetIds())
		end)

		return var_26_3
	end

	for iter_26_0, iter_26_1 in ipairs(arg_26_2) do
		local var_26_6 = CreateShell(iter_26_1)

		if pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
			if table.contains(var_26_5(), iter_26_1.id) then
				var_26_6.fleetType = FleetType.Submarine or FleetType.Normal
			end
		elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
			if iter_26_1.id >= Fleet.SUBMARINE_FLEET_ID then
				var_26_6.fleetType = FleetType.Submarine or FleetType.Normal
			end
		elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE then
			if iter_26_1.id >= Fleet.SUBMARINE_FLEET_ID then
				var_26_6.fleetType = FleetType.Submarine or FleetType.Normal
			end
		elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
			if iter_26_1.id >= Fleet.MEGA_SUBMARINE_FLEET_OFFSET then
				var_26_6.fleetType = FleetType.Submarine or FleetType.Normal
			end
		elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
			if table.contains(var_26_5(), iter_26_1.id) then
				var_26_6.fleetType = FleetType.Submarine or FleetType.Normal
			end
		elseif Fleet.isSubmarineFleet({
			id = iter_26_1.id
		}) then
			var_26_6.fleetType = FleetType.Submarine or FleetType.Normal
		end

		local var_26_7 = TypedFleet.New(var_26_6)

		var_26_0[var_26_7.id] = var_26_7

		for iter_26_2, iter_26_3 in ipairs(iter_26_1.ship_list) do
			if not var_26_1:RawGetShipById(iter_26_3) then
				var_26_2 = true

				break
			end
		end
	end

	if pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
		for iter_26_4, iter_26_5 in ipairs(arg_26_1:getConfig("config_data")) do
			local var_26_8 = BossRushSeriesData.New({
				id = iter_26_5,
				actId = arg_26_1.id
			})
			local var_26_9 = var_26_8:GetFleetIds()[1]

			if not var_26_8:IsSingleFight() and var_26_0[var_26_9] and not var_26_0[var_26_9]:isAllEmpty() then
				var_26_0[var_26_9]:allClear()

				var_26_2 = true
			end
		end
	end

	if var_26_2 then
		self:commitActivityFleet(arg_26_1.id)
	end

	local var_26_10
	local var_26_11

	if pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_CHALLENGE then
		var_26_10 = 2
		var_26_11 = 2
	elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSS_BATTLE_MARK_2 then
		var_26_10 = 0
		var_26_11 = 0
	elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSRUSH then
		var_26_10 = 0
		var_26_11 = 0
	elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE then
		var_26_10 = 0
		var_26_11 = 0
	elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		var_26_10 = 0
		var_26_11 = 0
	elseif pg.activity_template[arg_26_1.id].type == ActivityConst.ACTIVITY_TYPE_BOSS_RUSH_DAL_COLLAB then
		var_26_10 = 0
		var_26_11 = 0
	end

	local var_26_12 = 0

	while var_26_12 < var_26_10 do
		var_26_12 = var_26_12 + 1

		if var_26_0[var_26_12] == nil then
			var_26_0[var_26_12] = TypedFleet.New({
				id = var_26_12,
				ship_list = {},
				fleetType = FleetType.Normal
			})
		end
	end

	local var_26_13 = 0

	while var_26_13 < var_26_11 do
		if var_26_0[Fleet.SUBMARINE_FLEET_ID + var_26_13] == nil then
			var_26_0[Fleet.SUBMARINE_FLEET_ID + var_26_13] = TypedFleet.New({
				id = Fleet.SUBMARINE_FLEET_ID + var_26_13,
				ship_list = {},
				fleetType = FleetType.Submarine
			})
		end

		var_26_13 = var_26_13 + 1
	end

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inActivity")

	return
end

function FleetProxy:updateActivityFleet(arg_29_1, arg_29_2, arg_29_3)
	self.activityFleetData[arg_29_1][arg_29_2] = arg_29_3

	pg.ShipFlagMgr.GetInstance():UpdateFlagShips("inActivity")

	return
end

function FleetProxy:commitActivityFleet(arg_30_1)
	self.editSrcCache = nil
	self.EdittingFleet = nil

	self.facade:sendNotification(GAME.EDIT_ACTIVITY_FLEET, {
		actID = arg_30_1,
		fleets = self.activityFleetData[arg_30_1]
	})

	return
end

function FleetProxy:checkActivityFleet(arg_31_1)
	for iter_31_0, iter_31_1 in pairs(self.activityFleetData[arg_31_1]) do
		if iter_31_0 < Fleet.SUBMARINE_FLEET_ID and iter_31_1:isLegalToFight() == true then
			return true
		end
	end

	return false
end

function FleetProxy:removeActivityFleetCommander(arg_32_1)
	for iter_32_0, iter_32_1 in pairs(self.activityFleetData) do
		for iter_32_2, iter_32_3 in pairs(iter_32_1) do
			local var_32_0 = false

			for iter_32_4, iter_32_5 in pairs((iter_32_3:GetRawCommanderIds())) do
				if arg_32_1 == iter_32_5 then
					iter_32_3:updateCommanderByPos(iter_32_4, nil)
					iter_32_3:updateCommanderSkills()
					self:updateActivityFleet(iter_32_0, iter_32_2, iter_32_3)
					self:commitActivityFleet(iter_32_0)

					var_32_0 = true

					break
				end
			end

			if var_32_0 then
				break
			end
		end
	end

	return
end

function FleetProxy:recommendActivityFleet(arg_33_1, arg_33_2)
	local var_33_0 = self:getActivityFleets()[arg_33_1][arg_33_2]
	local var_33_1 = getProxy(BayProxy)

	local function var_33_2(arg_34_0, arg_34_1)
		for iter_34_0, iter_34_1 in ipairs((var_33_1:getActivityRecommendShips(arg_34_0, var_33_0.ships, arg_34_1, arg_33_1))) do
			var_33_0:insertShip(iter_34_1, nil, iter_34_1:getTeamType())
		end

		return
	end

	local function var_33_3(arg_35_0)
		if TeamType.VanguardMax - #arg_35_0.vanguardShips > 0 then
			var_33_2(ShipType.VanguardShipType, TeamType.VanguardMax - #arg_35_0.vanguardShips)
		end

		if TeamType.MainMax - #arg_35_0.mainShips > 0 then
			var_33_2(ShipType.MainShipType, TeamType.MainMax - #arg_35_0.mainShips)
		end

		return
	end

	local function var_33_4(arg_36_0)
		if not arg_36_0:isFull() then
			var_33_2(ShipType.SubShipType, TeamType.SubmarineMax - #arg_36_0.subShips)
		end

		return
	end

	if getProxy(ActivityProxy):getActivityById(arg_33_1):getConfig("type") == ActivityConst.ACTIVITY_TYPE_BOSSSINGLE_VARIABLE then
		if arg_33_2 >= Fleet.MEGA_SUBMARINE_FLEET_OFFSET then
			var_33_4(var_33_0)
		else
			var_33_3(var_33_0)
		end
	elseif arg_33_2 >= Fleet.SUBMARINE_FLEET_ID then
		var_33_4(var_33_0)
	else
		var_33_3(var_33_0)
	end

	self:updateActivityFleet(arg_33_1, arg_33_2, var_33_0)

	return
end

function FleetProxy:GetBossRushFleets(arg_37_1, arg_37_2)
	local var_37_0 = {}
	local var_37_1 = self:getActivityFleets()[arg_37_1]

	table.Foreach(arg_37_2, function(arg_38_0, arg_38_1)
		local var_38_0 = arg_38_0 == #arg_37_2

		var_37_1[arg_38_1] = var_37_1[arg_38_1] or TypedFleet.New({
			id = arg_38_1,
			ship_list = {},
			fleetType = (var_38_0 or nil) and (FleetType.Submarine or FleetType.Normal)
		})

		local var_38_1 = var_37_1[arg_38_1]

		var_37_1[arg_38_1]:RemoveUnusedItems()

		var_37_0[arg_38_0] = var_38_1

		return
	end)

	return var_37_0
end

function FleetProxy:IsBossRushFleetsEmpty(arg_39_1, arg_39_2)
	local var_39_0 = self:getActivityFleets()[arg_39_1]

	return underscore.all(arg_39_2, function(arg_40_0)
		return not var_39_0[arg_40_0]
	end)
end

function FleetProxy:CommanderManualTaskProgressAdd(arg_41_1)
	local var_41_0 = getProxy(CommanderManualProxy)
	local var_41_1 = arg_41_1:isLegalToFight()

	if var_41_1 == true and #arg_41_1.vanguardShips >= TeamType.VanguardMax then
		var_41_0:TaskProgressAdd(2013, 1)

		local var_41_2 = {
			ShipType.QuZhu,
			ShipType.QingXun,
			ShipType.ZhongXun
		}

		for iter_41_0, iter_41_1 in ipairs(arg_41_1.vanguardShips) do
			local var_41_3 = getProxy(BayProxy):getShipById(iter_41_1):getConfig("type")

			if table.contains(var_41_2, var_41_3) then
				table.removebyvalue(var_41_2, var_41_3)
			end
		end

		if #var_41_2 == 0 then
			var_41_0:TaskProgressAdd(2014, 1)
		end
	end

	if var_41_1 == true and #arg_41_1.mainShips >= TeamType.MainMax then
		var_41_0:TaskProgressAdd(2015, 1)

		local var_41_4 = {
			ShipType.ZhengHang,
			ShipType.ZhanLie,
			ShipType.ZhanLie
		}

		for iter_41_2, iter_41_3 in ipairs(arg_41_1.mainShips) do
			local var_41_5 = getProxy(BayProxy):getShipById(iter_41_3):getConfig("type")

			if table.contains(var_41_4, var_41_5) then
				table.removebyvalue(var_41_4, var_41_5)
			end
		end

		if #var_41_4 == 0 then
			var_41_0:TaskProgressAdd(2016, 1)
		end
	end

	if var_41_1 == true and arg_41_1:GetGearScoreSum() > 1000 then
		var_41_0:TaskProgressAdd(2017, 1)
	end

	if var_41_1 == true and arg_41_1:getFleetType() == FleetType.Submarine then
		var_41_0:TaskProgressAdd(2018, 1)
	end

	if var_41_1 == true and not arg_41_1:isFirstFleet() and not arg_41_1:isSubmarineFleet() then
		var_41_0:TaskProgressAdd(2019, 1)
	end

	return
end

return FleetProxy
