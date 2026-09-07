local BayProxy = class("BayProxy", import(".NetProxy"))

BayProxy.SHIP_ADDED = "ship added"
BayProxy.SHIP_REMOVED = "ship removed"
BayProxy.SHIP_UPDATED = "ship updated"
BayProxy.SHIP_EQUIPMENT_ADDED = "ship equipment added"
BayProxy.SHIP_EQUIPMENT_REMOVED = "ship equipment removed"

function BayProxy:register()
	self:on(12001, function(arg_2_0)
		self.data = {}
		self.activityNPCShipIds = {}
		self.metaShipIDList = {}
		self.equipCountDic = {}
		self.equipSkinCountDic = {}

		for iter_2_0, iter_2_1 in ipairs(arg_2_0.shiplist) do
			local var_2_0 = Ship.New(iter_2_1)

			var_2_0:display("loaded")

			self.shipHighestLevel = math.max(self.shipHighestLevel, var_2_0.level)

			if var_2_0:getConfigTable() then
				self.data[var_2_0.id] = var_2_0

				if var_2_0:isActivityNpc() then
					table.insert(self.activityNPCShipIds, var_2_0.id)
				elseif var_2_0:isMetaShip() and not table.contains(self.metaShipIDList, var_2_0.id) then
					table.insert(self.metaShipIDList, var_2_0.id)
				end

				BayProxy.recordShipLevelVertify(var_2_0)
				self:UpdateShipEquipAndSkinCount(var_2_0, true)
			else
				warning("不存在的角色: " .. var_2_0.id)
			end
		end

		self:ClearChangeSkinAsmr()
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")

		return
	end)
	self:on(12031, function(arg_3_0)
		self.energyRecoverTime = arg_3_0.energy_auto_increase_time + Ship.ENERGY_RECOVER_TIME

		self:addEnergyListener(self.energyRecoverTime - pg.TimeMgr.GetInstance():GetServerTime())

		return
	end)
	self:on(12010, function(arg_4_0)
		for iter_4_0, iter_4_1 in ipairs(arg_4_0.ship_list) do
			local var_4_0 = Ship.New(iter_4_1)

			var_4_0:display("loaded")

			self.shipHighestLevel = math.max(self.shipHighestLevel, var_4_0.level)

			if var_4_0:getConfigTable() then
				self.data[var_4_0.id] = var_4_0

				if var_4_0:isActivityNpc() then
					table.insert(self.activityNPCShipIds, var_4_0.id)
				elseif var_4_0:isMetaShip() and not table.contains(self.metaShipIDList, var_4_0.id) then
					table.insert(self.metaShipIDList, var_4_0.id)
				end

				BayProxy.recordShipLevelVertify(var_4_0)
				self:UpdateShipEquipAndSkinCount(var_4_0, true)
			else
				warning("不存在的角色: " .. var_4_0.id)
			end
		end

		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")

		return
	end)
	self:on(12042, function(arg_5_0)
		local var_5_0 = getProxy(PlayerProxy):getInited()
		local var_5_1 = 0

		self.newShipList = {}

		for iter_5_0, iter_5_1 in ipairs(arg_5_0.ship_list) do
			local var_5_2 = Ship.New(iter_5_1)

			if var_5_2:getConfigTable() and var_5_2.id > 0 then
				self:addShip(var_5_2, false)

				if var_5_0 then
					var_5_1 = var_5_1 + 1
				end

				self.newShipList[#self.newShipList + 1] = var_5_2
			else
				warning("不存在的角色: " .. var_5_2.id)
			end
		end

		if var_5_1 > 0 then
			self:countShip(var_5_1)
		end

		self.metaTransItemMap = {}

		return
	end)

	local var_1_0 = getProxy(PlayerProxy)

	self:on(12019, function(arg_6_0)
		local var_6_0 = self:getShipById(var_1_0:getData().character)

		var_6_0:setLikability(arg_6_0.intimacy)
		self:updateShip(var_6_0)

		return
	end)

	self.shipHighestLevel = 0

	return
end

function BayProxy:recoverAllShipEnergy()
	local var_7_0 = pg.energy_template[4].upper_bound
	local var_7_1 = {}
	local var_7_2 = getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING)

	table.insertto(var_7_2, getProxy(ActivityProxy):getActivitiesByType(ActivityConst.ACTIVITY_TYPE_HOTSPRING_2))
	table.Foreach(var_7_2, function(arg_8_0, arg_8_1)
		if arg_8_1 and not arg_8_1:isEnd() then
			local var_8_0 = arg_8_1:GetEnergyRecoverAddition()

			_.each(arg_8_1:getData1List(), function(arg_9_0)
				var_7_1[arg_9_0] = (var_7_1[arg_9_0] or 0) + var_8_0

				return
			end)
		end

		return
	end)

	local var_7_3 = getProxy(DormProxy):getRawData()

	for iter_7_0, iter_7_1 in pairs(self.data) do
		local var_7_4 = iter_7_1:getRecoverEnergyPoint()
		local var_7_5 = 0
		local var_7_6 = pg.energy_template[3].upper_bound - 1
		local var_7_7, var_7_8 = var_7_3:InBackYard(iter_7_1.id)

		if var_7_7 then
			if var_7_8 == DormShip.FLOOR_1 then
				var_7_5 = var_7_5 + Ship.BACKYARD_1F_ENERGY_ADDITION
			elseif var_7_8 == DormShip.FLOOR_2 then
				var_7_5 = var_7_5 + Ship.BACKYARD_2F_ENERGY_ADDITION
			end

			for iter_7_2, iter_7_3 in ipairs(BuffHelper.GetBackYardEnergyBuffs()) do
				var_7_5 = var_7_5 + tonumber(iter_7_3:getConfig("benefit_effect"))
			end

			var_7_6 = var_7_0
		end

		if var_7_1[iter_7_1.id] then
			var_7_5 = var_7_5 + var_7_1[iter_7_1.id]
			var_7_6 = var_7_0
		end

		iter_7_1:setEnergy((math.min(iter_7_1:getEnergy() + math.max(math.min(var_7_4, var_7_6 - iter_7_1:getEnergy()), 0) + var_7_5, var_7_0)))
		self:updateShip(iter_7_1)
	end

	return
end

function BayProxy:addEnergyListener(arg_10_1)
	if arg_10_1 <= 0 then
		self:recoverAllShipEnergy()
		self:addEnergyListener(Ship.ENERGY_RECOVER_TIME)

		return
	end

	if self.energyTimer then
		self.energyTimer:Stop()

		self.energyTimer = nil
	end

	self.energyTimer = Timer.New(function()
		self:recoverAllShipEnergy()
		self:addEnergyListener(Ship.ENERGY_RECOVER_TIME)

		return
	end, arg_10_1, 1)

	self.energyTimer:Start()

	return
end

function BayProxy:remove()
	if self.energyTimer then
		self.energyTimer:Stop()

		self.energyTimer = nil
	end

	return
end

function BayProxy:recordShipLevelVertify()
	if self then
		ys.BattleShipLevelVertify[self.id] = BayProxy.generateLevelVertify(self.level)
	end

	return
end

function BayProxy:checkShiplevelVertify()
	if BayProxy.generateLevelVertify(self.level) == ys.BattleShipLevelVertify[self.id] then
		return true
	else
		return false
	end

	return
end

function BayProxy:generateLevelVertify()
	return (self + 1114) * 824
end

function BayProxy:addShip(arg_16_1, arg_16_2)
	assert(isa(arg_16_1, Ship), "should be an instance of Ship")
	assert(self.data[arg_16_1.id] == nil, "ship already exist, use updateShip() instead")

	self.data[arg_16_1.id] = arg_16_1

	BayProxy.recordShipLevelVertify(arg_16_1)
	self:UpdateShipEquipAndSkinCount(arg_16_1, true)

	arg_16_2 = defaultValue(arg_16_2, true)

	if arg_16_2 then
		self:countShip()
	end

	self.shipHighestLevel = math.max(self.shipHighestLevel, arg_16_1.level)

	if arg_16_1:isActivityNpc() then
		table.insert(self.activityNPCShipIds, arg_16_1.id)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	else
		if arg_16_1:isMetaShip() and not table.contains(self.metaShipIDList, arg_16_1.id) then
			table.insert(self.metaShipIDList, arg_16_1.id)
			getProxy(MetaCharacterProxy):requestMetaTacticsInfo({
				arg_16_1.id
			})
		end

		local var_16_0 = getProxy(CollectionProxy)

		if var_16_0 then
			var_16_0:flushCollection(arg_16_1)
		end
	end

	if getProxy(PlayerProxy):getInited() then
		self:sendNotification(BayProxy.SHIP_ADDED, arg_16_1:clone())
	end

	return
end

function BayProxy:countShip(arg_17_1)
	local var_17_0 = getProxy(PlayerProxy)
	local var_17_1 = var_17_0:getData()

	var_17_1:increaseShipCount(arg_17_1)
	var_17_0:updatePlayer(var_17_1)

	return
end

function BayProxy:getNewShip(arg_18_1)
	if arg_18_1 then
		self.newShipList = nil
	end

	return self.newShipList or {}
end

function BayProxy:getMetaTransItemMap(arg_19_1)
	local var_19_0

	if self.metaTransItemMap and self.metaTransItemMap[arg_19_1] and #self.metaTransItemMap[arg_19_1] > 0 then
		var_19_0 = self.metaTransItemMap[arg_19_1][1]

		table.remove(self.metaTransItemMap[arg_19_1], 1)
	end

	return var_19_0
end

function BayProxy:addMetaTransItemMap(arg_20_1, arg_20_2)
	self.metaTransItemMap = self.metaTransItemMap or {}
	self.metaTransItemMap[arg_20_1] = self.metaTransItemMap[arg_20_1] or {}

	table.insert(self.metaTransItemMap[arg_20_1], arg_20_2)

	return
end

function BayProxy:getShipsByFleet(arg_21_1)
	assert(isa(arg_21_1, Fleet), "should be an instance of Fleet")

	local var_21_0 = {}

	for iter_21_0, iter_21_1 in ipairs(arg_21_1:getShipIds()) do
		table.insert(var_21_0, self.data[iter_21_1])
	end

	return var_21_0
end

function BayProxy:getSortShipsByFleet(arg_22_1)
	assert(isa(arg_22_1, Fleet), "should be an instance of Fleet")

	local var_22_0 = {}

	for iter_22_0, iter_22_1 in ipairs(arg_22_1.mainShips) do
		table.insert(var_22_0, self.data[iter_22_1])
	end

	for iter_22_2, iter_22_3 in ipairs(arg_22_1.vanguardShips) do
		table.insert(var_22_0, self.data[iter_22_3])
	end

	for iter_22_4, iter_22_5 in ipairs(arg_22_1.subShips) do
		table.insert(var_22_0, self.data[iter_22_5])
	end

	return var_22_0
end

function BayProxy:getShipByTeam(arg_23_1, arg_23_2)
	assert(isa(arg_23_1, Fleet), "should be an instance of Fleet")

	local var_23_0 = {}

	if arg_23_2 == TeamType.Vanguard then
		for iter_23_0, iter_23_1 in ipairs(arg_23_1.vanguardShips) do
			table.insert(var_23_0, self.data[iter_23_1])
		end
	elseif arg_23_2 == TeamType.Main then
		for iter_23_2, iter_23_3 in ipairs(arg_23_1.mainShips) do
			table.insert(var_23_0, self.data[iter_23_3])
		end
	elseif arg_23_2 == TeamType.Submarine then
		for iter_23_4, iter_23_5 in ipairs(arg_23_1.subShips) do
			table.insert(var_23_0, self.data[iter_23_5])
		end
	end

	return Clone(var_23_0)
end

function BayProxy:getShipsByTypes(arg_24_1)
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in pairs(self.data) do
		if table.contains(arg_24_1, iter_24_1:getShipType()) then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function BayProxy:getShipsByStatus(arg_25_1)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in pairs(self.data) do
		if iter_25_1.status == arg_25_1 then
			table.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function BayProxy:getShipsByTeamType(arg_26_1)
	local var_26_0 = {}

	for iter_26_0, iter_26_1 in pairs(self.data) do
		if iter_26_1:getTeamType() == arg_26_1 then
			table.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function BayProxy:getConfigShipCount(arg_27_1)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(self.data) do
		if iter_27_1.configId == arg_27_1 then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0
end

function BayProxy:getShips()
	local var_28_0 = {}

	for iter_28_0, iter_28_1 in pairs(self.data) do
		table.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function BayProxy:getShipList(arg_29_1)
	return underscore.map(arg_29_1, function(arg_30_0)
		return self.data[arg_30_0] or false
	end)
end

function BayProxy:getRawShipCount()
	local var_31_0 = 0

	for iter_31_0, iter_31_1 in pairs(self.data) do
		var_31_0 = var_31_0 + 1
	end

	return var_31_0
end

function BayProxy:getShipCount()
	local var_32_0 = {}

	for iter_32_0, iter_32_1 in ipairs(getGameset("unoccupied_ship_nationality")[2]) do
		var_32_0[iter_32_1] = true
	end

	local var_32_1 = 0
	local var_32_2 = 0

	for iter_32_2, iter_32_3 in pairs(self.data) do
		if var_32_0[iter_32_3:getNation()] then
			var_32_2 = var_32_2 + 1
		else
			var_32_1 = var_32_1 + 1
		end
	end

	return var_32_1, var_32_2
end

function BayProxy:getShipById(arg_33_1)
	if self.data[arg_33_1] ~= nil then
		return self.data[arg_33_1]:clone()
	end

	return
end

function BayProxy:RawGetShipById(arg_34_1)
	return self.data[arg_34_1]
end

function BayProxy:getActivityNPCShipByActId(arg_35_1)
	for iter_35_0, iter_35_1 in ipairs(self.activityNPCShipIds) do
		if self.data[iter_35_1].activityNpc == arg_35_1 then
			return iter_35_1
		end
	end

	return
end

function BayProxy:getMetaShipByGroupId(arg_36_1)
	for iter_36_0, iter_36_1 in pairs(self.data) do
		if iter_36_1:isMetaShip() and iter_36_1.metaCharacter.id == arg_36_1 then
			return iter_36_1
		end
	end

	return
end

function BayProxy:getMetaShipIDList()
	return self.metaShipIDList
end

function BayProxy:updateShip(arg_38_1)
	if arg_38_1.isNpc then
		return
	end

	assert(isa(arg_38_1, Ship), "should be an instance of Ship")
	assert(self.data[arg_38_1.id] ~= nil, "ship should exist")

	if arg_38_1.level > self.shipHighestLevel then
		self.shipHighestLevel = arg_38_1.level

		pg.TrackerMgr.GetInstance():Tracking(TRACKING_SHIP_HIGHEST_LEVEL, self.shipHighestLevel)
	end

	local var_38_0 = self.data[arg_38_1.id]

	self:UpdateShipEquipAndSkinCount(self.data[arg_38_1.id], false)

	self.data[arg_38_1.id] = arg_38_1

	BayProxy.recordShipLevelVertify(arg_38_1)
	self:UpdateShipEquipAndSkinCount(arg_38_1, true)

	if var_38_0:isActivityNpc() and not arg_38_1:isActivityNpc() then
		table.removebyvalue(self.activityNPCShipIds, arg_38_1.id)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	end

	if var_38_0.level < arg_38_1.level then
		pg.TrackerMgr.GetInstance():Tracking(TRACKING_SHIP_LEVEL_UP, arg_38_1.level - var_38_0.level)
	end

	if var_38_0:getStar() < arg_38_1:getStar() or var_38_0.intimacy < arg_38_1.intimacy or var_38_0.level < arg_38_1.level or not var_38_0.propose and arg_38_1.propose then
		local var_38_1 = getProxy(CollectionProxy)

		if var_38_1 and not arg_38_1:isActivityNpc() then
			var_38_1:flushCollection(arg_38_1)
		end
	end

	self:sendNotification(BayProxy.SHIP_UPDATED, arg_38_1:clone())

	return
end

function BayProxy:removeShip(arg_39_1)
	assert(isa(arg_39_1, Ship), "should be an instance of Ship")
	self:removeShipById(arg_39_1.id)

	return
end

function BayProxy:getEquipment2ByflagShip()
	local var_40_0 = self:getShipById(getProxy(PlayerProxy):getData().character)

	assert(var_40_0, "ship is nil")

	return var_40_0:getEquip(2)
end

function BayProxy:removeShipById(arg_41_1)
	local var_41_0 = self.data[arg_41_1]

	assert(self.data[arg_41_1] ~= nil, "ship should exist")

	if var_41_0:isActivityNpc() then
		table.removebyvalue(self.activityNPCShipIds, var_41_0.id)
		pg.ShipFlagMgr.GetInstance():UpdateFlagShips("isActivityNpc")
	end

	self.data[var_41_0.id] = nil

	var_41_0:display("removed")
	self:UpdateShipEquipAndSkinCount(var_41_0, false)
	self:sendNotification(BayProxy.SHIP_REMOVED, var_41_0)

	return
end

function BayProxy:findShipByGroup(arg_42_1)
	for iter_42_0, iter_42_1 in pairs(self.data) do
		if iter_42_1.groupId == arg_42_1 then
			return iter_42_1
		end
	end

	return nil
end

function BayProxy:findShipsByGroup(arg_43_1)
	local var_43_0 = {}

	for iter_43_0, iter_43_1 in pairs(self.data) do
		if iter_43_1.groupId == arg_43_1 then
			table.insert(var_43_0, iter_43_1)
		end
	end

	return var_43_0
end

function BayProxy:ExistGroupShip(arg_44_1)
	for iter_44_0, iter_44_1 in pairs(self.data) do
		if iter_44_1.groupId == arg_44_1 then
			return true
		end
	end

	return false
end

function BayProxy:_ExistGroupShip(arg_45_1, arg_45_2, arg_45_3)
	local function var_45_0(arg_46_0)
		if arg_45_2 then
			return arg_46_0:isRemoulded()
		else
			return true
		end

		return
	end

	local function var_45_1(arg_47_0)
		if arg_45_3 then
			return arg_47_0.propose
		else
			return true
		end

		return
	end

	for iter_45_0, iter_45_1 in pairs(self.data) do
		if iter_45_1.groupId == arg_45_1 and var_45_0(iter_45_1) and var_45_1(iter_45_1) then
			return true
		end
	end

	return false
end

function BayProxy:getSameGroupShipCount(arg_48_1)
	local var_48_0 = 0

	for iter_48_0, iter_48_1 in pairs(self.data) do
		if iter_48_1.groupId == arg_48_1 then
			var_48_0 = var_48_0 + 1
		end
	end

	return var_48_0
end

function BayProxy:getUpgradeShips(arg_49_1)
	local var_49_0 = arg_49_1:getConfig("rarity")
	local var_49_1 = {}

	for iter_49_0, iter_49_1 in pairs(self.data) do
		if iter_49_1.groupId == arg_49_1.groupId or iter_49_1:isTestShip() and iter_49_1:canUseTestShip(var_49_0) then
			table.insert(var_49_1, iter_49_1)
		end
	end

	return var_49_1
end

function BayProxy:getBayPower()
	local var_50_0 = {}
	local var_50_1 = 0

	for iter_50_0, iter_50_1 in pairs(self.data) do
		local var_50_2 = iter_50_1:getShipCombatPower()

		if ShipGroup.GetGroupConfig(iter_50_1:getGroupId()).handbook_type ~= 1 and (not var_50_0[iter_50_1.configId] or var_50_2 > var_50_0[iter_50_1.configId]) then
			var_50_1 = var_50_1 - defaultValue(var_50_0[iter_50_1.configId], 0)
			var_50_0[iter_50_1.configId] = var_50_2
			var_50_1 = var_50_1 + var_50_2
		end
	end

	return var_50_1
end

function BayProxy:GetBayPowerRootedAsyn(arg_51_1)
	local var_51_0

	var_51_0 = coroutine.wrap(function()
		local var_52_0 = {}
		local var_52_1 = 0
		local var_52_2 = 0

		for iter_52_0, iter_52_1 in pairs(self.data) do
			local var_52_3 = iter_52_1:getShipCombatPower()

			if ShipGroup.GetGroupConfig(iter_52_1:getGroupId()).handbook_type ~= 1 and (not var_52_0[iter_52_1.configId] or var_52_3 > var_52_0[iter_52_1.configId]) then
				var_52_1 = var_52_1 - defaultValue(var_52_0[iter_52_1.configId], 0)
				var_52_0[iter_52_1.configId] = var_52_3
				var_52_1 = var_52_1 + var_52_3
			end

			var_52_2 = var_52_2 + 1

			if var_52_2 == 1 or var_52_2 % 50 == 0 then
				onNextTick(var_51_0)
				coroutine.yield()
			end
		end

		arg_51_1(var_52_1^0.667)

		return
	end)

	;(nil)()

	return
end

function BayProxy:getBayPowerRooted()
	return self:getBayPower()^0.667
end

function BayProxy:getEquipsInShips(arg_54_1)
	local var_54_0 = {}

	for iter_54_0, iter_54_1 in pairs(self.data) do
		for iter_54_2, iter_54_3 in pairs(iter_54_1.equipments) do
			if iter_54_3 and (not arg_54_1 or arg_54_1(iter_54_3, iter_54_1.id)) then
				table.insert(var_54_0, setmetatable({
					shipId = iter_54_1.id,
					shipPos = iter_54_2
				}, {
					__index = iter_54_3
				}))
			end
		end
	end

	return var_54_0
end

function BayProxy:UpdateShipEquipAndSkinCount(arg_55_1, arg_55_2)
	if not arg_55_1 then
		return
	end

	local var_55_0 = arg_55_2 and 1 or -1

	for iter_55_0, iter_55_1 in pairs(arg_55_1.equipments) do
		if iter_55_1 then
			self.equipCountDic[iter_55_1.id] = defaultValue(self.equipCountDic[iter_55_1.id], 0) + var_55_0

			assert(self.equipCountDic[iter_55_1.id] >= 0)
		end
	end

	for iter_55_2, iter_55_3 in pairs(arg_55_1.equipmentSkins) do
		if iter_55_3 > 0 then
			self.equipSkinCountDic[iter_55_3] = defaultValue(self.equipSkinCountDic[iter_55_3], 0) + var_55_0

			assert(self.equipSkinCountDic[iter_55_3] >= 0)
		end
	end

	return
end

function BayProxy:GetEquipCountInShips(arg_56_1)
	return self.equipCountDic[arg_56_1] or 0
end

function BayProxy:GetEquipSkinCountInShips(arg_57_1)
	return self.equipSkinCountDic[arg_57_1] or 0
end

function BayProxy:GetEquipsInShipsRaw()
	local function var_58_0(arg_59_0, arg_59_1, arg_59_2)
		local var_59_0 = CreateShell(arg_59_0)

		var_59_0.shipId = arg_59_1
		var_59_0.shipPos = arg_59_2

		return var_59_0
	end

	local var_58_1 = {}

	for iter_58_0, iter_58_1 in pairs(self.data) do
		for iter_58_2, iter_58_3 in pairs(iter_58_1.equipments) do
			if iter_58_3 then
				table.insert(var_58_1, var_58_0(iter_58_3, iter_58_1.id, iter_58_2))
			end
		end
	end

	return var_58_1
end

function BayProxy:getEquipmentSkinInShips(arg_60_1, arg_60_2)
	local function var_60_0(arg_61_0)
		return (arg_61_0 and arg_61_0 > 0 or nil) and _.any(pg.equip_skin_template[arg_61_0].equip_type, function(arg_62_0)
			return not arg_60_2 or table.contains(arg_60_2, arg_62_0)
		end)
	end

	local var_60_1 = {}

	for iter_60_0, iter_60_1 in pairs(self.data) do
		if not arg_60_1 or arg_60_1.id ~= iter_60_1.id then
			for iter_60_2, iter_60_3 in pairs(iter_60_1:getEquipSkins()) do
				if iter_60_3 and var_60_0(iter_60_3) then
					table.insert(var_60_1, {
						id = iter_60_3,
						shipId = iter_60_1.id,
						shipPos = iter_60_2
					})
				end
			end
		end
	end

	return var_60_1
end

function BayProxy:GetSpWeaponsInShips(arg_63_1)
	local var_63_0 = {}

	for iter_63_0, iter_63_1 in pairs(self.data) do
		if not arg_63_1 or arg_63_1.id ~= iter_63_1.id then
			local var_63_1 = iter_63_1:GetSpWeapon()

			if var_63_1 and (not arg_63_1 or not arg_63_1:IsSpWeaponForbidden(var_63_1)) then
				table.insert(var_63_0, var_63_1)
			end
		end
	end

	return var_63_0
end

function BayProxy:getProposeGroupList()
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in pairs(self.data) do
		if iter_64_1:ShowPropose() then
			var_64_0[iter_64_1.groupId] = true
		end
	end

	return var_64_0
end

function BayProxy:GetRecommendShip(arg_65_1, arg_65_2, arg_65_3)
	assert(arg_65_3)

	local var_65_0 = self:getShipsByTypes(arg_65_1)
	local var_65_1 = {}

	for iter_65_0, iter_65_1 in ipairs(var_65_0) do
		var_65_1[iter_65_1] = iter_65_1:getShipCombatPower()
	end

	table.sort(var_65_0, function(arg_66_0, arg_66_1)
		return var_65_1[arg_66_0] < var_65_1[arg_66_1]
	end)

	if getProxy(SettingsProxy):GetRecommendLowEnerySkipEnable() then
		var_65_0 = underscore.filter(var_65_0, function(arg_67_0)
			return not arg_67_0:isLowEnergy()
		end)
	end

	local var_65_2 = {}

	for iter_65_2, iter_65_3 in ipairs(arg_65_2) do
		var_65_2[#var_65_2 + 1] = self.data[iter_65_3]:getGroupId()
	end

	local var_65_3

	while #var_65_0 > 0 do
		local var_65_4

		if not table.contains(arg_65_2, var_65_0[#var_65_0].id) and not table.contains(var_65_2, (var_65_0[#var_65_0]:getGroupId())) and arg_65_3(var_65_0[#var_65_0]) then
			var_65_3 = var_65_0[#var_65_0]

			break
		else
			var_65_4 = #var_65_0 - 1
		end
	end

	return var_65_3
end

function BayProxy:getActivityRecommendShips(arg_68_1, arg_68_2, arg_68_3, arg_68_4)
	local var_68_0 = self:getShipsByTypes(arg_68_1)
	local var_68_1 = {}

	for iter_68_0, iter_68_1 in ipairs(var_68_0) do
		var_68_1[iter_68_1] = iter_68_1:getShipCombatPower()
	end

	table.sort(var_68_0, CompareFuncs({
		function(arg_69_0)
			return var_68_1[arg_69_0]
		end
	}))

	local var_68_2 = {}

	for iter_68_2, iter_68_3 in ipairs(arg_68_2) do
		var_68_2[#var_68_2 + 1] = self.data[iter_68_3]:getGroupId()
	end

	local var_68_3 = {}

	while #var_68_0 > 0 and arg_68_3 > 0 do
		local var_68_4 = var_68_0[#var_68_0]:getGroupId()

		if not table.contains(arg_68_2, var_68_0[#var_68_0].id) and not table.contains(var_68_2, var_68_4) and ShipStatus.ShipStatusCheck("inActivity", var_68_0[#var_68_0], nil, {
			inActivity = arg_68_4
		}) then
			table.insert(var_68_3, var_68_0[#var_68_0])
			table.insert(var_68_2, var_68_4)

			arg_68_3 = arg_68_3 - 1
		end
	end

	return var_68_3
end

function BayProxy:getDelegationRecommendShips(arg_70_1)
	local var_70_0 = math.max(arg_70_1.template.ship_lv, 2)
	local var_70_1 = Clone(arg_70_1.shipIds)
	local var_70_2 = self:getShipsByTypes(arg_70_1.template.ship_type)

	table.sort(var_70_2, function(arg_71_0, arg_71_1)
		if arg_71_0.maxLevel == arg_71_0.level ~= (arg_71_1.maxLevel == arg_71_1.level) then
			return arg_71_0.maxLevel == arg_71_0.level
		end

		return arg_71_0.level > arg_71_1.level
	end)

	local var_70_3 = {}
	local var_70_4 = false

	for iter_70_0, iter_70_1 in ipairs(var_70_1) do
		if var_70_0 <= self.data[iter_70_1].level then
			var_70_4 = true
		end

		var_70_3[#var_70_3 + 1] = self.data[iter_70_1]:getGroupId()
	end

	if var_70_4 then
		var_70_0 = 2
	end

	local var_70_5 = {}
	local var_70_6 = #var_70_2

	while var_70_6 > 0 do
		if 6 - #arg_70_1.shipIds <= 0 then
			break
		end

		local var_70_7 = var_70_2[var_70_6]
		local var_70_8 = var_70_2[var_70_6]:getGroupId()
		local var_70_9

		if var_70_0 <= var_70_2[var_70_6].level and var_70_7.lockState ~= Ship.LOCK_STATE_UNLOCK and not table.contains(var_70_1, var_70_2[var_70_6].id) and not table.contains(var_70_3, var_70_8) and not table.contains(var_70_5, var_70_2[var_70_6].id) and not var_70_7:getFlag("inElite") and not var_70_7:getFlag("inActivity") and ShipStatus.ShipStatusCheck("inEvent", var_70_7) then
			table.insert(var_70_3, var_70_8)
			table.insert(var_70_5, var_70_2[var_70_6].id)

			var_70_9 = 6 - #arg_70_1.shipIds - 1

			if var_70_4 == false then
				var_70_4 = true
				var_70_0 = 2
				var_70_6 = #var_70_2
			end
		else
			var_70_6 = var_70_6 - 1
		end
	end

	return var_70_5
end

function BayProxy:getDelegationRecommendShipsLV1(arg_72_1)
	local var_72_0 = Clone(arg_72_1.shipIds)
	local var_72_1 = _.select(self:getShipsByTypes(arg_72_1.template.ship_type), function(arg_73_0)
		return arg_73_0.level == 1
	end)

	table.sort(var_72_1, CompareFuncs({
		function(arg_74_0)
			return arg_74_0.lockState == arg_74_0.LOCK_STATE_UNLOCK and 0 or 1
		end
	}))

	local var_72_2 = {}

	for iter_72_0, iter_72_1 in ipairs(var_72_0) do
		var_72_2[#var_72_2 + 1] = self.data[iter_72_1]:getGroupId()
	end

	local var_72_3 = {}

	while #var_72_1 > 0 do
		if 6 - #arg_72_1.shipIds <= 0 then
			break
		end

		local var_72_4 = var_72_1[#var_72_1]
		local var_72_5 = var_72_1[#var_72_1]:getGroupId()
		local var_72_6, var_72_7

		if not table.contains(var_72_0, var_72_1[#var_72_1].id) and not table.contains(var_72_2, var_72_5) and not table.contains(var_72_3, var_72_1[#var_72_1].id) and not var_72_4:getFlag("inElite") and not var_72_4:getFlag("inActivity") and ShipStatus.ShipStatusCheck("inEvent", var_72_4) then
			table.insert(var_72_2, var_72_5)
			table.insert(var_72_3, var_72_1[#var_72_1].id)

			var_72_6 = 6 - #arg_72_1.shipIds - 1
		else
			var_72_7 = #var_72_1 - 1
		end
	end

	return var_72_3
end

function BayProxy:getWorldRecommendShip(arg_75_1, arg_75_2)
	local var_75_0 = self:getShipsByTeamType(arg_75_1)
	local var_75_1 = {}

	for iter_75_0, iter_75_1 in ipairs(var_75_0) do
		var_75_1[iter_75_1] = iter_75_1:getShipCombatPower()
	end

	table.sort(var_75_0, function(arg_76_0, arg_76_1)
		return var_75_1[arg_76_0] < var_75_1[arg_76_1]
	end)

	local var_75_2 = {}

	for iter_75_2, iter_75_3 in ipairs(arg_75_2) do
		var_75_2[#var_75_2 + 1] = self.data[iter_75_3]:getGroupId()
	end

	local var_75_3

	while #var_75_0 > 0 do
		local var_75_4

		if not table.contains(arg_75_2, var_75_0[#var_75_0].id) and not table.contains(var_75_2, (var_75_0[#var_75_0]:getGroupId())) and ShipStatus.ShipStatusCheck("inWorld", var_75_0[#var_75_0]) then
			var_75_3 = var_75_0[#var_75_0]

			break
		else
			var_75_4 = #var_75_0 - 1
		end
	end

	return var_75_3
end

function BayProxy:getModRecommendShip(arg_77_1, arg_77_2)
	local var_77_0 = underscore.map(arg_77_2, function(arg_78_0)
		return self.data[arg_78_0]
	end)
	local var_77_1 = Clone(arg_77_1)

	for iter_77_0, iter_77_1 in pairs(ShipModLayer.getModExpAdditions(var_77_1, var_77_0)) do
		var_77_1:addModAttrExp(iter_77_0, iter_77_1)
	end

	local var_77_2 = var_77_1:getNeedModExp()
	local var_77_3 = 0

	for iter_77_2, iter_77_3 in pairs(var_77_2) do
		var_77_3 = var_77_3 + iter_77_3
	end

	local var_77_4 = {}

	for iter_77_4, iter_77_5 in pairs(self.data) do
		if iter_77_5:isSameKind(arg_77_1) then
			var_77_4.sameKind = var_77_4.sameKind or {}

			table.insert(var_77_4.sameKind, iter_77_5)
		else
			local var_77_5 = iter_77_5:getShipType()

			var_77_4[var_77_5] = var_77_4[var_77_5] or {}

			table.insert(var_77_4[var_77_5], iter_77_5)
		end
	end

	for iter_77_6, iter_77_7 in ipairs(table.mergeArray({
		"sameKind"
	}, pg.ship_data_by_type[arg_77_1:getConfig("type")].strengthen_choose_type)) do
		if #var_77_0 == 12 or var_77_3 == 0 then
			break
		end

		local var_77_6 = var_77_4[iter_77_7] or {}
		local var_77_7 = {}

		for iter_77_8, iter_77_9 in ipairs(pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_2, underscore.map(var_77_6, function(arg_79_0)
			return arg_79_0.id
		end))) do
			var_77_7[iter_77_9] = true
		end

		for iter_77_10, iter_77_11 in ipairs((underscore.filter(var_77_6, function(arg_80_0)
			return arg_80_0.level == 1 and arg_80_0:getRarity() <= ShipRarity.Gray and arg_80_0:GetLockState() ~= Ship.LOCK_STATE_LOCK and not table.contains(arg_77_2, arg_80_0.id) and arg_77_1.id ~= arg_80_0.id and not var_77_7[arg_80_0.id]
		end))) do
			local var_77_8

			if #var_77_0 == 12 or var_77_3 == 0 then
				do break end

				var_77_8 = false
			end

			for iter_77_12, iter_77_13 in pairs((ShipModLayer.getModExpAdditions(var_77_1, {
				iter_77_11
			}))) do
				if iter_77_13 > 0 and var_77_2[iter_77_12] > 0 then
					var_77_8 = true
					var_77_3 = var_77_3 - math.min(var_77_2[iter_77_12], iter_77_13)
					var_77_2[iter_77_12] = math.max(var_77_2[iter_77_12] - iter_77_13, 0)
				end
			end

			if var_77_8 then
				table.insert(var_77_0, iter_77_11)
			end
		end
	end

	return underscore.map(var_77_0, function(arg_81_0)
		return arg_81_0.id
	end)
end

function BayProxy:getUpgradeRecommendShip(arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = pg.ShipFlagMgr.GetInstance():FilterShips(ShipStatus.FILTER_SHIPS_FLAGS_4, underscore.keys(self.data))

	local function var_82_1(arg_83_0)
		return arg_83_0.level == 1 and arg_83_0:GetLockState() ~= Ship.LOCK_STATE_LOCK and not table.contains(arg_82_2, arg_83_0.id) and arg_82_1.id ~= arg_83_0.id and not table.contains(var_82_0, arg_83_0.id)
	end

	local var_82_2 = {}

	for iter_82_0, iter_82_1 in ipairs((self:getUpgradeShips(arg_82_1))) do
		if var_82_1(iter_82_1) then
			table.insert(var_82_2, iter_82_1)
		end
	end

	table.sort(var_82_2, CompareFuncs({
		function(arg_84_0)
			return arg_84_0:isSameKind(arg_82_1) and 0 or 1
		end
	}))

	local var_82_3 = {}

	for iter_82_2, iter_82_3 in pairs(arg_82_2) do
		table.insert(var_82_3, self.data[iter_82_3])
	end

	for iter_82_4, iter_82_5 in ipairs(var_82_2) do
		if #var_82_3 == arg_82_3 then
			break
		end

		table.insert(var_82_3, iter_82_5)
	end

	return underscore.map(var_82_3, function(arg_85_0)
		return arg_85_0.id
	end)
end

function BayProxy:getGroupPropose(arg_86_1)
	if self.data then
		for iter_86_0, iter_86_1 in ipairs(self.data) do
			if pg.ship_data_template[iter_86_1.configId].group_type == arg_86_1 and iter_86_1.propose then
				return true
			end
		end
	end

	return false
end

function BayProxy:updateRandomFlagShips(arg_87_1)
	for iter_87_0, iter_87_1 in ipairs(arg_87_1) do
		self.data[iter_87_1.ship_id]:updateRandomFlag(iter_87_1.flag, iter_87_1.shadow)
	end

	return
end

function BayProxy:getRandomFlagShipPhantomMarks()
	local var_88_0 = {}

	for iter_88_0, iter_88_1 in pairs(self.data) do
		table.insertto(var_88_0, iter_88_1:getRandomFlagShipPhantomMarks())
	end

	return var_88_0
end

function BayProxy:getAllShipPhantomMarks()
	local var_89_0 = {}

	for iter_89_0, iter_89_1 in pairs(self.data) do
		table.insertto(var_89_0, iter_89_1:getAllShipPhantomMarks())
	end

	return var_89_0
end

function BayProxy:GetShipPhantom(arg_90_1)
	local var_90_0, var_90_1 = ShipPhantom.UnpackMark(arg_90_1)

	return self.data[var_90_0] and ShipPhantom.Create(self.data[var_90_0], var_90_1) or nil
end

function BayProxy:getShipPhantomList(arg_91_1)
	return underscore.map(arg_91_1, function(arg_92_0)
		return self:GetShipPhantom(arg_92_0)
	end)
end

function BayProxy:ClearChangeSkinAsmr()
	for iter_93_0, iter_93_1 in pairs(self.data) do
		iter_93_1:RevertAsmrSkin()
	end

	return
end

function BayProxy:updateShipSkin(arg_94_1, arg_94_2, arg_94_3)
	assert(self.data[arg_94_1])
	self.data[arg_94_1]:updateSkinId(arg_94_3, arg_94_2)
	self:sendNotification(BayProxy.SHIP_UPDATED, self.data[arg_94_1]:clone())

	return
end

function BayProxy:CanUseShareSkinPhantoms(arg_95_1)
	local var_95_0 = ShipSkin.New({
		id = arg_95_1
	})
	local var_95_1 = var_95_0:IsTransSkin()
	local var_95_2 = var_95_0:IsProposeSkin()
	local var_95_3, var_95_4 = var_95_0:GetShareGroupIds()
	local var_95_5 = {}

	for iter_95_0, iter_95_1 in ipairs(var_95_4) do
		var_95_5[iter_95_1] = true
	end

	local var_95_6 = {}

	for iter_95_2, iter_95_3 in ipairs(underscore.filter(underscore.values(self:getRawData()), function(arg_96_0)
		if not arg_96_0 then
			return false
		end

		if var_95_1 then
			return arg_96_0.groupId == var_95_3 and arg_96_0:isRemoulded()
		elseif arg_96_0.groupId == var_95_3 or var_95_5[arg_96_0.groupId] and math.floor(arg_96_0:getIntimacy() / 100) >= arg_96_0:GetNoProposeIntimacyMax() then
			return not var_95_2 or tobool(arg_96_0.propose)
		else
			return false
		end

		return
	end)) do
		table.insertto(var_95_6, iter_95_3:getAllShipPhantom())
	end

	return var_95_6
end

return BayProxy
