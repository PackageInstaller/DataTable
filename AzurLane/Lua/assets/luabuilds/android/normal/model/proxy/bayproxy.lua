class = var_0_10000

local var_0_0 = "BayProxy"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002(".NetProxy"))

var_0_1.SHIP_ADDED = "ship added"
var_0_1.SHIP_REMOVED = "ship removed"
var_0_1.SHIP_UPDATED = "ship updated"
var_0_1.SHIP_EQUIPMENT_ADDED = "ship equipment added"
var_0_1.SHIP_EQUIPMENT_REMOVED = "ship equipment removed"

function var_0_1.register(arg_1_0)
	arg_1_0:on(12001, function(arg_2_0)
		arg_1_0.data = {}
		arg_1_0.activityNPCShipIds = {}
		arg_1_0.metaShipIDList = {}
		arg_1_0.equipCountDic = {}

		local var_2_0 = arg_1_0

		var_2_0.equipSkinCountDic = {}
		ipairs = var_2_0

		for iter_2_0, iter_2_1 in var_2_0(arg_2_0.shiplist) do
			Ship = var_2_10006

			local var_2_1 = var_2_10006.New(iter_2_1)

			var_2_10006.display(var_2_1, "loaded")

			local var_2_2 = arg_1_0

			math = var_2_1
			var_2_2.shipHighestLevel = var_2_1.max(arg_1_0.shipHighestLevel, var_2_10006.level)

			local var_2_3

			if var_2_10006:getConfigTable() then
				var_2_3 = arg_1_0.data
				var_2_3[var_2_10006.id] = var_2_10006

				if var_2_10006:isActivityNpc() then
					table = var_2_3

					var_2_3.insert(arg_1_0.activityNPCShipIds, var_2_10006.id)
				elseif var_2_10006:isMetaShip() then
					table = var_2_3

					if not var_2_3.contains(arg_1_0.metaShipIDList, var_2_10006.id) then
						table = var_2_3

						var_2_3.insert(arg_1_0.metaShipIDList, var_2_10006.id)
					end
				end

				var_0_1.recordShipLevelVertify(var_2_10006)

				local var_2_4 = arg_1_0

				var_2_3.UpdateShipEquipAndSkinCount(var_2_4, var_2_10006, true)
			else
				warning = var_2_3

				var_2_3("不存在的角色: " .. var_2_10006.id)
			end
		end

		local var_2_5 = arg_1_0

		var_1.ClearChangeSkinAsmr(var_2_5)

		pg = var_1

		local var_2_6 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_2_6, "isActivityNpc")

		return
	end)
	arg_1_0:on(12031, function(arg_3_0)
		local var_3_0 = arg_1_0
		local var_3_1 = arg_3_0.energy_auto_increase_time

		Ship = var_2_10003
		var_3_0.energyRecoverTime = var_3_1 + var_2_10003.ENERGY_RECOVER_TIME

		local var_3_2 = arg_1_0.energyRecoverTime

		pg = var_2

		local var_3_3 = var_2.TimeMgr.GetInstance()
		local var_3_4 = var_3_2 - var_2.GetServerTime(var_3_3)
		local var_3_5 = arg_1_0

		var_2.addEnergyListener(var_3_5, var_3_4)

		return
	end)
	arg_1_0:on(12010, function(arg_4_0)
		ipairs = var_2_10001

		for iter_4_0, iter_4_1 in var_2_10001(arg_4_0.ship_list) do
			Ship = var_2_10006

			local var_4_0 = var_2_10006.New(iter_4_1)

			var_2_10006.display(var_4_0, "loaded")

			local var_4_1 = arg_1_0

			math = var_4_0
			var_4_1.shipHighestLevel = var_4_0.max(arg_1_0.shipHighestLevel, var_2_10006.level)

			local var_4_2

			if var_2_10006:getConfigTable() then
				var_4_2 = arg_1_0.data
				var_4_2[var_2_10006.id] = var_2_10006

				if var_2_10006:isActivityNpc() then
					table = var_4_2

					var_4_2.insert(arg_1_0.activityNPCShipIds, var_2_10006.id)
				elseif var_2_10006:isMetaShip() then
					table = var_4_2

					if not var_4_2.contains(arg_1_0.metaShipIDList, var_2_10006.id) then
						table = var_4_2

						var_4_2.insert(arg_1_0.metaShipIDList, var_2_10006.id)
					end
				end

				var_0_1.recordShipLevelVertify(var_2_10006)

				local var_4_3 = arg_1_0

				var_4_2.UpdateShipEquipAndSkinCount(var_4_3, var_2_10006, true)
			else
				warning = var_4_2

				var_4_2("不存在的角色: " .. var_2_10006.id)
			end
		end

		pg = var_1

		local var_4_4 = var_1.ShipFlagMgr.GetInstance()

		var_1.UpdateFlagShips(var_4_4, "isActivityNpc")

		return
	end)

	local var_1_0 = arg_1_0

	arg_1_0.on(var_1_0, 12042, function(arg_5_0)
		getProxy = var_2_10001
		PlayerProxy = var_2_10002

		local var_5_0 = var_2_10001(var_2_10002)
		local var_5_1 = var_1.getInited(var_5_0)
		local var_5_2 = 0
		local var_5_3 = arg_1_0

		var_5_3.newShipList = {}
		ipairs = var_5_3

		for iter_5_0, iter_5_1 in var_5_3(arg_5_0.ship_list) do
			Ship = var_2_10009

			local var_5_4 = var_2_10009.New(iter_5_1)
			local var_5_6

			if var_2_10009.getConfigTable(var_5_4) and var_2_10009.id > 0 then
				local var_5_5 = arg_1_0

				var_5_6.addShip(var_5_5, var_2_10009, false)

				if var_5_1 then
					var_5_2 = var_5_2 + 1
				end

				var_5_6 = arg_1_0.newShipList
				var_5_6[#arg_1_0.newShipList + 1] = var_2_10009
			else
				warning = var_5_6

				var_5_6("不存在的角色: " .. var_2_10009.id)
			end
		end

		if var_5_2 > 0 then
			local var_5_7 = arg_1_0

			var_4.countShip(var_5_7, var_5_2)
		end

		arg_1_0.metaTransItemMap = {}

		return
	end)

	getProxy = var_1
	PlayerProxy = var_1_0

	local var_1_1 = var_1(var_1_0)

	arg_1_0:on(12019, function(arg_6_0)
		local var_6_0 = var_1_1
		local var_6_1 = var_1.getData(var_6_0)
		local var_6_2 = arg_1_0
		local var_6_3 = var_2.getShipById(var_6_2, var_6_1.character)

		var_2.setLikability(var_6_3, arg_6_0.intimacy)

		local var_6_4 = arg_1_0

		var_3.updateShip(var_6_4, var_2)

		return
	end)

	arg_1_0.shipHighestLevel = 0

	return
end

function var_0_1.recoverAllShipEnergy(arg_7_0)
	pg = var_1_10001

	local var_7_0 = var_1_10001.energy_template[3].upper_bound - 1

	pg = var_1_10002

	local var_7_1 = var_1_10002.energy_template[4].upper_bound
	local var_7_2 = {}

	getProxy = var_1_10004
	ActivityProxy = var_1_10005

	local var_7_3 = var_1_10004(var_1_10005)
	local var_7_4 = var_4.getActivitiesByType

	ActivityConst = var_1_10006

	local var_7_5 = var_7_4(var_7_3, var_1_10006.ACTIVITY_TYPE_HOTSPRING)

	table = var_7_3

	local var_7_6 = var_7_3.insertto
	local var_7_7 = var_7_5

	getProxy = var_1_10007
	ActivityProxy = var_1_10008

	local var_7_8 = var_1_10007(var_1_10008)
	local var_7_9 = var_7.getActivitiesByType

	ActivityConst = var_1_10009

	var_7_6(var_7_7, var_7_9(var_7_8, var_1_10009.ACTIVITY_TYPE_HOTSPRING_2))

	table = var_7_6

	var_7_6.Foreach(var_7_5, function(arg_8_0, arg_8_1)
		if arg_8_1 and not arg_8_1:isEnd() then
			local var_8_0 = arg_8_1
			local var_8_1 = arg_8_1.GetEnergyRecoverAddition(var_8_0)

			_ = var_8_0

			var_8_0.each(arg_8_1:getData1List(), function(arg_9_0)
				local var_9_0 = var_7_2
				local var_9_1

				if not var_7_2[arg_9_0] then
					var_9_1 = 0
				end

				var_9_0[arg_9_0] = var_9_1 + var_8_1

				return
			end)
		end

		return
	end)

	getProxy = var_5
	DormProxy = var_6

	local var_7_10 = var_5(var_6)
	local var_7_11 = var_5.getRawData(var_7_10)

	pairs = var_7_10

	for iter_7_0, iter_7_1 in var_7_10(arg_7_0.data) do
		local var_7_12 = iter_7_1:getRecoverEnergyPoint()
		local var_7_13 = 0
		local var_7_14 = var_7_0
		local var_7_15, var_7_16 = var_7_11:InBackYard(iter_7_1.id)

		if var_7_15 then
			DormShip = var_16

			if var_7_16 == var_16.FLOOR_1 then
				Ship = var_16
				var_7_13 = var_7_13 + var_16.BACKYARD_1F_ENERGY_ADDITION
			else
				DormShip = var_16

				if var_7_16 == var_16.FLOOR_2 then
					Ship = var_16
					var_7_13 = var_7_13 + var_16.BACKYARD_2F_ENERGY_ADDITION
				end
			end

			ipairs = var_16
			BuffHelper = var_1_10017

			for iter_7_2, iter_7_3 in var_16(var_1_10017.GetBackYardEnergyBuffs()) do
				tonumber = var_1_10021
				var_7_13 = var_7_13 + var_1_10021(iter_7_3:getConfig("benefit_effect"))
			end

			var_7_14 = var_7_1
		end

		if var_7_2[iter_7_1.id] then
			var_7_13 = var_7_13 + var_7_2[iter_7_1.id]
			var_7_14 = var_7_1
		end

		math = var_16

		local var_7_17 = var_16.max

		math = var_1_10017

		local var_7_18 = var_7_17(var_1_10017.min(var_7_12, var_7_14 - iter_7_1:getEnergy()), 0)

		math = var_16

		local var_7_19 = var_16.min(iter_7_1:getEnergy() + var_7_18 + var_7_13, var_7_1)

		iter_7_1:setEnergy(var_7_19)
		arg_7_0:updateShip(iter_7_1)
	end

	return
end

function var_0_1.addEnergyListener(arg_10_0, arg_10_1)
	if arg_10_1 <= 0 then
		arg_10_0:recoverAllShipEnergy()

		local var_10_0 = arg_10_0
		local var_10_1 = arg_10_0.addEnergyListener

		Ship = var_1_10004

		var_10_1(var_10_0, var_1_10004.ENERGY_RECOVER_TIME)

		return
	end

	if arg_10_0.energyTimer then
		local var_10_2 = arg_10_0.energyTimer

		var_2.Stop(var_10_2)

		arg_10_0.energyTimer = nil
	end

	Timer = var_2
	arg_10_0.energyTimer = var_2.New(function()
		local var_11_0 = arg_10_0

		var_0.recoverAllShipEnergy(var_11_0)

		local var_11_1 = arg_10_0
		local var_11_2 = var_0.addEnergyListener

		Ship = var_2_10002

		var_11_2(var_11_1, var_2_10002.ENERGY_RECOVER_TIME)

		return
	end, arg_10_1, 1)

	local var_10_3 = arg_10_0.energyTimer

	var_2.Start(var_10_3)

	return
end

function var_0_1.remove(arg_12_0)
	if arg_12_0.energyTimer then
		local var_12_0 = arg_12_0.energyTimer

		var_1.Stop(var_12_0)

		arg_12_0.energyTimer = nil
	end

	return
end

function var_0_1.recordShipLevelVertify(arg_13_0)
	if arg_13_0 then
		ys = var_1_10001
		var_1_10001.BattleShipLevelVertify[arg_13_0.id] = var_0_1.generateLevelVertify(arg_13_0.level)
	end

	return
end

function var_0_1.checkShiplevelVertify(arg_14_0)
	local var_14_0 = var_0_1.generateLevelVertify(arg_14_0.level)

	ys = var_2

	if var_14_0 == var_2.BattleShipLevelVertify[arg_14_0.id] then
		return true
	else
		return false
	end

	return
end

function var_0_1.generateLevelVertify(arg_15_0)
	return (arg_15_0 + 1114) * 824
end

function var_0_1.addShip(arg_16_0, arg_16_1, arg_16_2)
	assert = var_1_10003
	isa = var_1_10004

	local var_16_0 = arg_16_1

	Ship = var_1_10006

	var_1_10003(var_1_10004(var_16_0, var_1_10006), "should be an instance of Ship")

	assert = var_1_10003

	var_1_10003(arg_16_0.data[arg_16_1.id] == nil, "ship already exist, use updateShip() instead")

	arg_16_0.data[arg_16_1.id] = arg_16_1

	var_0_1.recordShipLevelVertify(arg_16_1)
	arg_16_0:UpdateShipEquipAndSkinCount(arg_16_1, true)

	defaultValue = var_3

	if var_3(arg_16_2, true) then
		arg_16_0:countShip()
	end

	math = var_3
	arg_16_0.shipHighestLevel = var_3.max(arg_16_0.shipHighestLevel, arg_16_1.level)

	local var_16_1 = arg_16_1

	if arg_16_1.isActivityNpc(var_16_1) then
		table = var_3

		var_3.insert(arg_16_0.activityNPCShipIds, arg_16_1.id)

		pg = var_3
		var_16_1 = var_3.ShipFlagMgr.GetInstance()

		var_3.UpdateFlagShips(var_16_1, "isActivityNpc")
	else
		var_16_1 = arg_16_1

		if arg_16_1.isMetaShip(var_16_1) then
			table = var_3

			if not var_3.contains(arg_16_0.metaShipIDList, arg_16_1.id) then
				table = var_3

				var_3.insert(arg_16_0.metaShipIDList, arg_16_1.id)

				getProxy = var_3
				MetaCharacterProxy = var_16_1
				var_16_1 = var_3(var_16_1)

				var_3.requestMetaTacticsInfo(var_16_1, {
					arg_16_1.id
				})
			end
		end

		getProxy = var_3
		CollectionProxy = var_16_1

		if var_3(var_16_1) then
			var_3:flushCollection(arg_16_1)
		end
	end

	getProxy = var_3
	PlayerProxy = var_16_1

	local var_16_2 = var_3(var_16_1)

	if var_3.getInited(var_16_2) then
		arg_16_0:sendNotification(var_0_1.SHIP_ADDED, arg_16_1:clone())
	end

	return
end

function var_0_1.countShip(arg_17_0, arg_17_1)
	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_17_0 = var_1_10002(var_1_10003)
	local var_17_1 = var_2.getData(var_17_0)

	var_3.increaseShipCount(var_17_1, arg_17_1)
	var_2:updatePlayer(var_3)

	return
end

function var_0_1.getNewShip(arg_18_0, arg_18_1)
	local var_18_0

	if not arg_18_0.newShipList then
		var_18_0 = {}
	end

	if arg_18_1 then
		arg_18_0.newShipList = nil
	end

	return var_18_0
end

function var_0_1.getMetaTransItemMap(arg_19_0, arg_19_1)
	local var_19_0

	if arg_19_0.metaTransItemMap and arg_19_0.metaTransItemMap[arg_19_1] and #arg_19_0.metaTransItemMap[arg_19_1] > 0 then
		var_19_0 = arg_19_0.metaTransItemMap[arg_19_1][1]
		table = var_3

		var_3.remove(arg_19_0.metaTransItemMap[arg_19_1], 1)
	end

	return var_19_0
end

function var_0_1.addMetaTransItemMap(arg_20_0, arg_20_1, arg_20_2)
	if not arg_20_0.metaTransItemMap then
		arg_20_0.metaTransItemMap = {}
	end

	local var_20_0

	if not arg_20_0.metaTransItemMap[arg_20_1] then
		var_20_0 = arg_20_0.metaTransItemMap
		var_20_0[arg_20_1] = {}
	end

	table = var_20_0

	var_20_0.insert(arg_20_0.metaTransItemMap[arg_20_1], arg_20_2)

	return
end

function var_0_1.getShipsByFleet(arg_21_0, arg_21_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_21_0 = arg_21_1

	Fleet = var_1_10005

	var_1_10002(var_1_10003(var_21_0, var_1_10005), "should be an instance of Fleet")

	local var_21_1 = {}

	ipairs = var_3

	for iter_21_0, iter_21_1 in var_3(arg_21_1:getShipIds()) do
		table = var_1_10008

		var_1_10008.insert(var_21_1, arg_21_0.data[iter_21_1])
	end

	return var_21_1
end

function var_0_1.getSortShipsByFleet(arg_22_0, arg_22_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_22_0 = arg_22_1

	Fleet = var_1_10005

	var_1_10002(var_1_10003(var_22_0, var_1_10005), "should be an instance of Fleet")

	local var_22_1 = {}

	ipairs = var_3

	for iter_22_0, iter_22_1 in var_3(arg_22_1.mainShips) do
		table = var_1_10008

		var_1_10008.insert(var_22_1, arg_22_0.data[iter_22_1])
	end

	ipairs = var_3

	for iter_22_2, iter_22_3 in var_3(arg_22_1.vanguardShips) do
		table = var_1_10008

		var_1_10008.insert(var_22_1, arg_22_0.data[iter_22_3])
	end

	ipairs = var_3

	for iter_22_4, iter_22_5 in var_3(arg_22_1.subShips) do
		table = var_1_10008

		var_1_10008.insert(var_22_1, arg_22_0.data[iter_22_5])
	end

	return var_22_1
end

function var_0_1.getShipByTeam(arg_23_0, arg_23_1, arg_23_2)
	assert = var_1_10003
	isa = var_1_10004

	local var_23_0 = arg_23_1

	Fleet = var_1_10006

	var_1_10003(var_1_10004(var_23_0, var_1_10006), "should be an instance of Fleet")

	local var_23_1 = {}

	TeamType = var_4

	if arg_23_2 == var_4.Vanguard then
		ipairs = var_4

		for iter_23_0, iter_23_1 in var_4(arg_23_1.vanguardShips) do
			table = var_1_10009

			var_1_10009.insert(var_23_1, arg_23_0.data[iter_23_1])
		end
	else
		TeamType = var_4

		if arg_23_2 == var_4.Main then
			ipairs = var_4

			for iter_23_2, iter_23_3 in var_4(arg_23_1.mainShips) do
				table = var_1_10009

				var_1_10009.insert(var_23_1, arg_23_0.data[iter_23_3])
			end
		else
			TeamType = var_4

			if arg_23_2 == var_4.Submarine then
				ipairs = var_4

				for iter_23_4, iter_23_5 in var_4(arg_23_1.subShips) do
					table = var_1_10009

					var_1_10009.insert(var_23_1, arg_23_0.data[iter_23_5])
				end
			end
		end
	end

	Clone = var_4

	return var_4(var_23_1)
end

function var_0_1.getShipsByTypes(arg_24_0, arg_24_1)
	local var_24_0 = {}

	pairs = var_1_10003

	for iter_24_0, iter_24_1 in var_1_10003(arg_24_0.data) do
		table = var_1_10008

		if var_1_10008.contains(arg_24_1, iter_24_1:getShipType()) then
			table = var_1_10008

			var_1_10008.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_1.getShipsByStatus(arg_25_0, arg_25_1)
	local var_25_0 = {}

	pairs = var_1_10003

	for iter_25_0, iter_25_1 in var_1_10003(arg_25_0.data) do
		if iter_25_1.status == arg_25_1 then
			table = var_8

			var_8.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function var_0_1.getShipsByTeamType(arg_26_0, arg_26_1)
	local var_26_0 = {}

	pairs = var_1_10003

	for iter_26_0, iter_26_1 in var_1_10003(arg_26_0.data) do
		if iter_26_1:getTeamType() == arg_26_1 then
			table = var_8

			var_8.insert(var_26_0, iter_26_1)
		end
	end

	return var_26_0
end

function var_0_1.getConfigShipCount(arg_27_0, arg_27_1)
	local var_27_0 = 0

	pairs = var_1_10003

	for iter_27_0, iter_27_1 in var_1_10003(arg_27_0.data) do
		if iter_27_1.configId == arg_27_1 then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0
end

function var_0_1.getShips(arg_28_0)
	local var_28_0 = {}

	pairs = var_1_10002

	for iter_28_0, iter_28_1 in var_1_10002(arg_28_0.data) do
		table = var_1_10007

		var_1_10007.insert(var_28_0, iter_28_1)
	end

	return var_28_0
end

function var_0_1.getShipList(arg_29_0, arg_29_1)
	underscore = var_1_10002

	return var_1_10002.map(arg_29_1, function(arg_30_0)
		local var_30_0

		if not arg_29_0.data[arg_30_0] then
			var_30_0 = false
		end

		return var_30_0
	end)
end

function var_0_1.getRawShipCount(arg_31_0)
	local var_31_0 = 0

	pairs = var_1_10002

	for iter_31_0, iter_31_1 in var_1_10002(arg_31_0.data) do
		var_31_0 = var_31_0 + 1
	end

	return var_31_0
end

function var_0_1.getShipCount(arg_32_0)
	local var_32_0 = {}

	ipairs = var_1_10002
	getGameset = var_1_10003

	for iter_32_0, iter_32_1 in var_1_10002(var_1_10003("unoccupied_ship_nationality")[2]) do
		var_32_0[iter_32_1] = true
	end

	local var_32_1 = 0
	local var_32_2 = 0

	pairs = var_4

	for iter_32_2, iter_32_3 in var_4(arg_32_0.data) do
		if var_32_0[iter_32_3:getNation()] then
			var_32_2 = var_32_2 + 1
		else
			var_32_1 = var_32_1 + 1
		end
	end

	return var_32_1, var_32_2
end

function var_0_1.getShipById(arg_33_0, arg_33_1)
	if arg_33_0.data[arg_33_1] ~= nil then
		local var_33_0 = arg_33_0.data[arg_33_1]

		return var_2.clone(var_33_0)
	end

	return
end

function var_0_1.RawGetShipById(arg_34_0, arg_34_1)
	return arg_34_0.data[arg_34_1]
end

function var_0_1.getActivityNPCShipByActId(arg_35_0, arg_35_1)
	ipairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_0.activityNPCShipIds) do
		if arg_35_0.data[iter_35_1].activityNpc == arg_35_1 then
			return iter_35_1
		end
	end

	return
end

function var_0_1.getMetaShipByGroupId(arg_36_0, arg_36_1)
	pairs = var_1_10002

	for iter_36_0, iter_36_1 in var_1_10002(arg_36_0.data) do
		if iter_36_1:isMetaShip() and iter_36_1.metaCharacter.id == arg_36_1 then
			return iter_36_1
		end
	end

	return
end

function var_0_1.getMetaShipIDList(arg_37_0)
	return arg_37_0.metaShipIDList
end

function var_0_1.updateShip(arg_38_0, arg_38_1)
	if arg_38_1.isNpc then
		return
	end

	assert = var_2
	isa = var_1_10003

	local var_38_0 = arg_38_1

	Ship = var_1_10005

	var_2(var_1_10003(var_38_0, var_1_10005), "should be an instance of Ship")

	assert = var_2

	var_2(arg_38_0.data[arg_38_1.id] ~= nil, "ship should exist")

	if arg_38_1.level > arg_38_0.shipHighestLevel then
		arg_38_0.shipHighestLevel = arg_38_1.level
		pg = var_2

		local var_38_1 = var_2.TrackerMgr.GetInstance()
		local var_38_2 = var_2.Tracking

		TRACKING_SHIP_HIGHEST_LEVEL = var_4

		var_38_2(var_38_1, var_4, arg_38_0.shipHighestLevel)
	end

	local var_38_3 = arg_38_0.data[arg_38_1.id]

	arg_38_0:UpdateShipEquipAndSkinCount(var_38_3, false)

	arg_38_0.data[arg_38_1.id] = arg_38_1

	var_0_1.recordShipLevelVertify(arg_38_1)
	arg_38_0:UpdateShipEquipAndSkinCount(arg_38_1, true)

	if var_38_3:isActivityNpc() and not arg_38_1:isActivityNpc() then
		table = var_3

		var_3.removebyvalue(arg_38_0.activityNPCShipIds, arg_38_1.id)

		pg = var_3

		local var_38_4 = var_3.ShipFlagMgr.GetInstance()

		var_3.UpdateFlagShips(var_38_4, "isActivityNpc")
	end

	if var_38_3.level < arg_38_1.level then
		pg = var_3

		local var_38_5 = var_3.TrackerMgr.GetInstance()
		local var_38_6 = var_3.Tracking

		TRACKING_SHIP_LEVEL_UP = var_5

		var_38_6(var_38_5, var_5, arg_38_1.level - var_38_3.level)
	end

	if var_38_3:getStar() < arg_38_1:getStar() or var_38_3.intimacy < arg_38_1.intimacy or var_38_3.level < arg_38_1.level or not var_38_3.propose and arg_38_1.propose then
		getProxy = var_3
		CollectionProxy = var_4

		if var_3(var_4) and not arg_38_1:isActivityNpc() then
			var_3:flushCollection(arg_38_1)
		end
	end

	arg_38_0:sendNotification(var_0_1.SHIP_UPDATED, arg_38_1:clone())

	return
end

function var_0_1.removeShip(arg_39_0, arg_39_1)
	assert = var_1_10002
	isa = var_1_10003

	local var_39_0 = arg_39_1

	Ship = var_1_10005

	var_1_10002(var_1_10003(var_39_0, var_1_10005), "should be an instance of Ship")
	arg_39_0:removeShipById(arg_39_1.id)

	return
end

function var_0_1.getEquipment2ByflagShip(arg_40_0)
	getProxy = var_1_10001
	PlayerProxy = var_1_10002

	local var_40_0 = var_1_10001(var_1_10002)
	local var_40_1 = var_1.getData(var_40_0)
	local var_40_2 = arg_40_0
	local var_40_3 = arg_40_0.getShipById(var_40_2, var_40_1.character)

	assert = var_40_2

	var_40_2(var_40_3, "ship is nil")

	return var_40_3:getEquip(2)
end

function var_0_1.removeShipById(arg_41_0, arg_41_1)
	local var_41_0 = arg_41_0.data[arg_41_1]

	assert = var_1_10003

	var_1_10003(var_41_0 ~= nil, "ship should exist")

	if var_41_0:isActivityNpc() then
		table = var_3

		var_3.removebyvalue(arg_41_0.activityNPCShipIds, var_41_0.id)

		pg = var_3

		local var_41_1 = var_3.ShipFlagMgr.GetInstance()

		var_3.UpdateFlagShips(var_41_1, "isActivityNpc")
	end

	arg_41_0.data[var_41_0.id] = nil

	var_41_0:display("removed")
	arg_41_0:UpdateShipEquipAndSkinCount(var_41_0, false)
	arg_41_0:sendNotification(var_0_1.SHIP_REMOVED, var_41_0)

	return
end

function var_0_1.findShipByGroup(arg_42_0, arg_42_1)
	pairs = var_1_10002

	for iter_42_0, iter_42_1 in var_1_10002(arg_42_0.data) do
		if iter_42_1.groupId == arg_42_1 then
			return iter_42_1
		end
	end

	return nil
end

function var_0_1.findShipsByGroup(arg_43_0, arg_43_1)
	local var_43_0 = {}

	pairs = var_1_10003

	for iter_43_0, iter_43_1 in var_1_10003(arg_43_0.data) do
		if iter_43_1.groupId == arg_43_1 then
			table = var_8

			var_8.insert(var_43_0, iter_43_1)
		end
	end

	return var_43_0
end

function var_0_1.ExistGroupShip(arg_44_0, arg_44_1)
	pairs = var_1_10002

	for iter_44_0, iter_44_1 in var_1_10002(arg_44_0.data) do
		if iter_44_1.groupId == arg_44_1 then
			return true
		end
	end

	return false
end

function var_0_1._ExistGroupShip(arg_45_0, arg_45_1, arg_45_2, arg_45_3)
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

	pairs = var_1_10006

	for iter_45_0, iter_45_1 in var_1_10006(arg_45_0.data) do
		if iter_45_1.groupId == arg_45_1 and var_45_0(iter_45_1) and var_45_1(iter_45_1) then
			return true
		end
	end

	return false
end

function var_0_1.getSameGroupShipCount(arg_48_0, arg_48_1)
	local var_48_0 = 0

	pairs = var_1_10003

	for iter_48_0, iter_48_1 in var_1_10003(arg_48_0.data) do
		if iter_48_1.groupId == arg_48_1 then
			var_48_0 = var_48_0 + 1
		end
	end

	return var_48_0
end

function var_0_1.getUpgradeShips(arg_49_0, arg_49_1)
	local var_49_0 = arg_49_1:getConfig("rarity")
	local var_49_1 = arg_49_1.groupId
	local var_49_2 = {}

	pairs = var_1_10005

	for iter_49_0, iter_49_1 in var_1_10005(arg_49_0.data) do
		if iter_49_1.groupId == var_49_1 or iter_49_1:isTestShip() and iter_49_1:canUseTestShip(var_49_0) then
			table = var_10

			var_10.insert(var_49_2, iter_49_1)
		end
	end

	return var_49_2
end

function var_0_1.getBayPower(arg_50_0)
	local var_50_0 = {}
	local var_50_1 = 0

	pairs = var_1_10003

	for iter_50_0, iter_50_1 in var_1_10003(arg_50_0.data) do
		local var_50_2 = iter_50_1.configId
		local var_50_3 = iter_50_1
		local var_50_4 = iter_50_1.getShipCombatPower(var_50_3)

		ShipGroup = var_50_3

		if var_50_3.GetGroupConfig(iter_50_1:getGroupId()).handbook_type ~= 1 and (not var_50_0[var_50_2] or var_50_0[var_50_2] < var_50_4) then
			defaultValue = var_10
			var_50_1 = var_50_1 - var_10(var_50_0[var_50_2], 0)
			var_50_0[var_50_2] = var_50_4
			var_50_1 = var_50_1 + var_50_4
		end
	end

	return var_50_1
end

function var_0_1.GetBayPowerRootedAsyn(arg_51_0, arg_51_1)
	local var_51_0

	coroutine = var_1_10003

	var_1_10003.wrap(function()
		local var_52_0 = {}
		local var_52_1 = 0
		local var_52_2 = 0

		pairs = var_2_10003

		for iter_52_0, iter_52_1 in var_2_10003(arg_51_0.data) do
			local var_52_3 = iter_52_1.configId
			local var_52_4 = iter_52_1
			local var_52_5 = iter_52_1.getShipCombatPower(var_52_4)

			ShipGroup = var_52_4

			if var_52_4.GetGroupConfig(iter_52_1:getGroupId()).handbook_type ~= 1 and (not var_52_0[var_52_3] or var_52_0[var_52_3] < var_52_5) then
				defaultValue = var_10
				var_52_1 = var_52_1 - var_10(var_52_0[var_52_3], 0)
				var_52_0[var_52_3] = var_52_5
				var_52_1 = var_52_1 + var_52_5
			end

			if var_52_2 + 1 == 1 or var_52_2 % 50 == 0 then
				onNextTick = var_10

				var_10(var_51_0)

				coroutine = var_10

				var_10.yield()
			end
		end

		arg_51_1(var_52_1^0.667)

		return
	end)()

	return
end

function var_0_1.getBayPowerRooted(arg_53_0)
	return arg_53_0:getBayPower()^0.667
end

function var_0_1.getEquipsInShips(arg_54_0, arg_54_1)
	local var_54_0 = {}

	pairs = var_1_10003

	for iter_54_0, iter_54_1 in var_1_10003(arg_54_0.data) do
		pairs = var_1_10008

		for iter_54_2, iter_54_3 in var_1_10008(iter_54_1.equipments) do
			if iter_54_3 and (not arg_54_1 or arg_54_1(iter_54_3, iter_54_1.id)) then
				table = var_1_10013
				var_1_10013 = var_1_10013.insert

				local var_54_1 = var_54_0

				setmetatable = var_1_10015

				var_1_10013(var_54_1, var_1_10015({
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

function var_0_1.UpdateShipEquipAndSkinCount(arg_55_0, arg_55_1, arg_55_2)
	if not arg_55_1 then
		return
	end

	local var_55_0 = arg_55_2 and 1 or -1

	pairs = var_1_10004

	for iter_55_0, iter_55_1 in var_1_10004(arg_55_1.equipments) do
		if iter_55_1 then
			local var_55_1 = arg_55_0.equipCountDic

			var_1_10010 = iter_55_1.id
			defaultValue = var_1_10011
			var_55_1[var_1_10010] = var_1_10011(arg_55_0.equipCountDic[iter_55_1.id], 0) + var_55_0
			assert = var_55_1
			var_1_10010 = arg_55_0.equipCountDic[iter_55_1.id]
			var_1_10010 = 0 <= var_1_10010

			var_55_1(var_1_10010)
		end
	end

	pairs = var_4

	for iter_55_2, iter_55_3 in var_4(arg_55_1.equipmentSkins) do
		if iter_55_3 > 0 then
			local var_55_2 = arg_55_0.equipSkinCountDic

			defaultValue = var_1_10010
			var_55_2[iter_55_3] = var_1_10010(arg_55_0.equipSkinCountDic[iter_55_3], 0) + var_55_0
			assert = var_55_2
			var_1_10010 = arg_55_0.equipSkinCountDic[iter_55_3] >= 0

			var_55_2(var_1_10010)
		end
	end

	return
end

function var_0_1.GetEquipCountInShips(arg_56_0, arg_56_1)
	local var_56_0

	if not arg_56_0.equipCountDic[arg_56_1] then
		var_56_0 = 0
	end

	return var_56_0
end

function var_0_1.GetEquipSkinCountInShips(arg_57_0, arg_57_1)
	local var_57_0

	if not arg_57_0.equipSkinCountDic[arg_57_1] then
		var_57_0 = 0
	end

	return var_57_0
end

function var_0_1.GetEquipsInShipsRaw(arg_58_0)
	local function var_58_0(arg_59_0, arg_59_1, arg_59_2)
		CreateShell = var_2_10003

		local var_59_0 = var_2_10003(arg_59_0)

		var_59_0.shipId = arg_59_1
		var_59_0.shipPos = arg_59_2

		return var_59_0
	end

	local var_58_1 = {}

	pairs = var_1_10003

	for iter_58_0, iter_58_1 in var_1_10003(arg_58_0.data) do
		pairs = var_1_10008

		for iter_58_2, iter_58_3 in var_1_10008(iter_58_1.equipments) do
			if iter_58_3 then
				table = var_1_10013

				var_1_10013.insert(var_58_1, var_58_0(iter_58_3, iter_58_1.id, iter_58_2))
			end
		end
	end

	return var_58_1
end

function var_0_1.getEquipmentSkinInShips(arg_60_0, arg_60_1, arg_60_2)
	local function var_60_0(arg_61_0)
		local var_61_0 = false

		if arg_61_0 and 0 < arg_61_0 then
			pg = var_2

			local var_61_1 = var_2.equip_skin_template[arg_61_0]

			_ = var_2_10003
			var_61_0 = var_2_10003.any(var_61_1.equip_type, function(arg_62_0)
				local var_62_0

				if arg_60_2 then
					table = var_1
					var_62_0 = var_1.contains(arg_60_2, arg_62_0)

					if false then
						var_62_0 = false
					end
				else
					var_62_0 = true
				end

				return var_62_0
			end)
		end

		return var_61_0
	end

	local var_60_1 = {}

	pairs = var_1_10005

	for iter_60_0, iter_60_1 in var_1_10005(arg_60_0.data) do
		if not arg_60_1 or arg_60_1.id ~= iter_60_1.id then
			pairs = var_1_10010

			for iter_60_2, iter_60_3 in var_1_10010(iter_60_1:getEquipSkins()) do
				local var_60_2 = var_60_0(iter_60_3)

				if iter_60_3 and var_60_2 then
					table = var_16

					var_16.insert(var_60_1, {
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

function var_0_1.GetSpWeaponsInShips(arg_63_0, arg_63_1)
	local var_63_0 = {}

	pairs = var_1_10003

	for iter_63_0, iter_63_1 in var_1_10003(arg_63_0.data) do
		if not arg_63_1 or arg_63_1.id ~= iter_63_1.id then
			local var_63_1 = iter_63_1

			if iter_63_1.GetSpWeapon(var_63_1) and (not arg_63_1 or not arg_63_1:IsSpWeaponForbidden(var_8)) then
				table = var_63_1

				var_63_1.insert(var_63_0, var_8)
			end
		end
	end

	return var_63_0
end

function var_0_1.getProposeGroupList(arg_64_0)
	local var_64_0 = {}

	pairs = var_1_10002

	for iter_64_0, iter_64_1 in var_1_10002(arg_64_0.data) do
		if iter_64_1:ShowPropose() then
			var_64_0[iter_64_1.groupId] = true
		end
	end

	return var_64_0
end

function var_0_1.GetRecommendShip(arg_65_0, arg_65_1, arg_65_2, arg_65_3)
	assert = var_1_10004

	var_1_10004(arg_65_3)

	local var_65_0 = arg_65_0:getShipsByTypes(arg_65_1)
	local var_65_1 = {}

	ipairs = var_6

	for iter_65_0, iter_65_1 in var_6(var_65_0) do
		var_65_1[iter_65_1] = iter_65_1:getShipCombatPower()
	end

	table = var_6

	var_6.sort(var_65_0, function(arg_66_0, arg_66_1)
		return var_65_1[arg_66_0] < var_65_1[arg_66_1]
	end)

	getProxy = var_6
	SettingsProxy = var_7

	local var_65_2 = var_6(var_7)

	if var_6.GetRecommendLowEnerySkipEnable(var_65_2) then
		underscore = var_6
		var_65_0 = var_6.filter(var_65_0, function(arg_67_0)
			return not arg_67_0:isLowEnergy()
		end)
	end

	local var_65_3 = {}

	ipairs = var_65_2

	for iter_65_2, iter_65_3 in var_65_2(arg_65_2) do
		local var_65_4 = #var_65_3 + 1
		local var_65_5 = arg_65_0.data[iter_65_3]

		var_65_3[var_65_4] = var_13.getGroupId(var_65_5)
	end

	local var_65_6 = #var_65_0
	local var_65_7

	::label_65_0::

	while var_65_6 > 0 do
		local var_65_8 = var_65_0[var_65_6].id
		local var_65_9 = var_9
		local var_65_10 = var_9.getGroupId(var_65_9)

		table = var_65_9

		if not var_65_9.contains(arg_65_2, var_65_8) then
			table = var_12

			if not var_12.contains(var_65_3, var_65_10) and arg_65_3(var_9) then
				var_65_7 = var_9

				do break end
				goto label_65_0
			end
		end

		var_65_6 = var_65_6 - 1
	end

	return var_65_7
end

function var_0_1.getActivityRecommendShips(arg_68_0, arg_68_1, arg_68_2, arg_68_3, arg_68_4)
	local var_68_0 = arg_68_0:getShipsByTypes(arg_68_1)
	local var_68_1 = {}

	ipairs = var_7

	for iter_68_0, iter_68_1 in var_7(var_68_0) do
		var_68_1[iter_68_1] = iter_68_1:getShipCombatPower()
	end

	table = var_7

	local var_68_2 = var_7.sort
	local var_68_3 = var_68_0

	CompareFuncs = var_9

	var_68_2(var_68_3, var_9({
		function(arg_69_0)
			return var_68_1[arg_69_0]
		end
	}))

	local var_68_4 = {}

	ipairs = var_68_3

	for iter_68_2, iter_68_3 in var_68_3(arg_68_2) do
		local var_68_5 = arg_68_0.data[iter_68_3]

		var_68_4[#var_68_4 + 1] = var_68_5:getGroupId()
	end

	local var_68_6 = #var_68_0
	local var_68_7 = {}

	while var_68_6 > 0 and arg_68_3 > 0 do
		local var_68_8 = var_68_0[var_68_6].id
		local var_68_9 = var_10
		local var_68_10 = var_10.getGroupId(var_68_9)

		table = var_68_9

		if not var_68_9.contains(arg_68_2, var_68_8) then
			table = var_13

			if not var_13.contains(var_68_4, var_68_10) then
				ShipStatus = var_13

				if var_13.ShipStatusCheck("inActivity", var_10, nil, {
					inActivity = arg_68_4
				}) then
					table = var_13

					var_13.insert(var_68_7, var_10)

					table = var_13

					var_13.insert(var_68_4, var_68_10)

					arg_68_3 = arg_68_3 - 1
				end
			end
		end

		var_68_6 = var_68_6 - 1
	end

	return var_68_7
end

function var_0_1.getDelegationRecommendShips(arg_70_0, arg_70_1)
	local var_70_0 = 6 - #arg_70_1.shipIds
	local var_70_1 = arg_70_1.template.ship_type
	local var_70_2 = arg_70_1.template.ship_lv

	math = var_1_10005

	local var_70_3 = var_1_10005.max(var_70_2, 2)

	Clone = var_5

	local var_70_4 = var_5(arg_70_1.shipIds)
	local var_70_5 = arg_70_0
	local var_70_6 = arg_70_0.getShipsByTypes(var_70_5, var_70_1)

	table = var_70_5

	var_70_5.sort(var_70_6, function(arg_71_0, arg_71_1)
		if arg_71_0.maxLevel == arg_71_0.level ~= (arg_71_1.maxLevel == arg_71_1.level) then
			return var_2
		end

		return arg_71_0.level > arg_71_1.level
	end)

	local var_70_7 = {}
	local var_70_8 = false

	ipairs = var_9

	for iter_70_0, iter_70_1 in var_9(var_70_4) do
		if var_70_3 <= arg_70_0.data[iter_70_1].level then
			var_70_8 = true
		end

		var_70_7[#var_70_7 + 1] = var_14:getGroupId()
	end

	if var_70_8 then
		var_70_3 = 2
	end

	local var_70_9 = {}
	local var_70_10 = #var_70_6

	::label_70_0::

	while var_70_10 > 0 do
		if var_70_0 <= 0 then
			break
		end

		local var_70_11 = var_70_6[var_70_10].id
		local var_70_12 = var_11:getGroupId()

		if var_70_3 <= var_11.level then
			local var_70_13 = var_11.lockState

			Ship = var_1_10015

			if var_70_13 ~= var_1_10015.LOCK_STATE_UNLOCK then
				table = var_70_13

				if not var_70_13.contains(var_70_4, var_70_11) then
					table = var_14

					if not var_14.contains(var_70_7, var_70_12) then
						table = var_14

						if not var_14.contains(var_70_9, var_70_11) then
							var_1_10015 = var_11

							if not var_11.getFlag(var_1_10015, "inElite") then
								var_1_10015 = var_11

								if not var_11.getFlag(var_1_10015, "inActivity") then
									ShipStatus = var_14

									if var_14.ShipStatusCheck("inEvent", var_11) then
										table = var_14

										var_14.insert(var_70_7, var_70_12)

										table = var_14

										var_14.insert(var_70_9, var_70_11)

										var_70_0 = var_70_0 - 1

										if var_70_8 == false then
											var_70_8 = true
											var_70_3 = 2
											var_70_10 = #var_70_6
										end

										goto label_70_0
									end
								end
							end
						end
					end
				end
			end
		end

		var_70_10 = var_70_10 - 1
	end

	return var_70_9
end

function var_0_1.getDelegationRecommendShipsLV1(arg_72_0, arg_72_1)
	local var_72_0 = 6 - #arg_72_1.shipIds
	local var_72_1 = arg_72_1.template.ship_type

	Clone = var_1_10004

	local var_72_2 = var_1_10004(arg_72_1.shipIds)
	local var_72_3 = arg_72_0
	local var_72_4 = arg_72_0.getShipsByTypes(var_72_3, var_72_1)

	_ = var_72_3

	local var_72_5 = var_72_3.select(var_72_4, function(arg_73_0)
		return arg_73_0.level == 1
	end)

	table = var_7

	local var_72_6 = var_7.sort
	local var_72_7 = var_72_5

	CompareFuncs = var_1_10009

	var_72_6(var_72_7, var_1_10009({
		function(arg_74_0)
			return arg_74_0.lockState == arg_74_0.LOCK_STATE_UNLOCK and 0 or 1
		end
	}))

	local var_72_8 = {}

	ipairs = var_72_7

	for iter_72_0, iter_72_1 in var_72_7(var_72_2) do
		local var_72_9 = arg_72_0.data[iter_72_1]

		var_72_8[#var_72_8 + 1] = var_72_9:getGroupId()
	end

	local var_72_10 = {}
	local var_72_11 = #var_72_5

	::label_72_0::

	while var_72_11 > 0 do
		if var_72_0 <= 0 then
			break
		end

		local var_72_12 = var_72_5[var_72_11].id
		local var_72_13 = var_10
		local var_72_14 = var_10.getGroupId(var_72_13)

		table = var_72_13

		if not var_72_13.contains(var_72_2, var_72_12) then
			table = var_13

			if not var_13.contains(var_72_8, var_72_14) then
				table = var_13

				if not var_13.contains(var_72_10, var_72_12) and not var_10:getFlag("inElite") and not var_10:getFlag("inActivity") then
					ShipStatus = var_13

					if var_13.ShipStatusCheck("inEvent", var_10) then
						table = var_13

						var_13.insert(var_72_8, var_72_14)

						table = var_13

						var_13.insert(var_72_10, var_72_12)

						var_72_0 = var_72_0 - 1

						goto label_72_0
					end
				end
			end
		end

		var_72_11 = var_72_11 - 1
	end

	return var_72_10
end

function var_0_1.getWorldRecommendShip(arg_75_0, arg_75_1, arg_75_2)
	local var_75_0 = arg_75_0:getShipsByTeamType(arg_75_1)
	local var_75_1 = {}

	ipairs = var_5

	for iter_75_0, iter_75_1 in var_5(var_75_0) do
		var_75_1[iter_75_1] = iter_75_1:getShipCombatPower()
	end

	table = var_5

	var_5.sort(var_75_0, function(arg_76_0, arg_76_1)
		return var_75_1[arg_76_0] < var_75_1[arg_76_1]
	end)

	local var_75_2 = {}

	ipairs = var_6

	for iter_75_2, iter_75_3 in var_6(arg_75_2) do
		local var_75_3 = #var_75_2 + 1
		local var_75_4 = arg_75_0.data[iter_75_3]

		var_75_2[var_75_3] = var_12.getGroupId(var_75_4)
	end

	local var_75_5 = #var_75_0
	local var_75_6

	::label_75_0::

	while var_75_5 > 0 do
		local var_75_7 = var_75_0[var_75_5].id
		local var_75_8 = var_8
		local var_75_9 = var_8.getGroupId(var_75_8)

		table = var_75_8

		if not var_75_8.contains(arg_75_2, var_75_7) then
			table = var_11

			if not var_11.contains(var_75_2, var_75_9) then
				ShipStatus = var_11

				if var_11.ShipStatusCheck("inWorld", var_8) then
					var_75_6 = var_8

					do break end
					goto label_75_0
				end
			end
		end

		var_75_5 = var_75_5 - 1
	end

	return var_75_6
end

function var_0_1.getModRecommendShip(arg_77_0, arg_77_1, arg_77_2)
	underscore = var_1_10003

	local var_77_0 = var_1_10003.map(arg_77_2, function(arg_78_0)
		return arg_77_0.data[arg_78_0]
	end)

	Clone = var_4

	local var_77_1 = var_4(arg_77_1)

	pairs = var_5
	ShipModLayer = var_1_10006

	for iter_77_0, iter_77_1 in var_5(var_1_10006.getModExpAdditions(var_77_1, var_77_0)) do
		var_77_1:addModAttrExp(iter_77_0, iter_77_1)
	end

	local var_77_2 = var_77_1:getNeedModExp()
	local var_77_3 = 0

	pairs = var_7

	for iter_77_2, iter_77_3 in var_7(var_77_2) do
		var_77_3 = var_77_3 + iter_77_3
	end

	local var_77_4 = {}

	pairs = var_8

	for iter_77_4, iter_77_5 in var_8(arg_77_0.data) do
		if iter_77_5:isSameKind(arg_77_1) then
			local var_77_5

			if not var_77_4.sameKind then
				var_77_5 = {}
			end

			var_77_4.sameKind = var_77_5
			table = var_77_5

			var_77_5.insert(var_77_4.sameKind, iter_77_5)
		else
			local var_77_6

			if not var_77_4[iter_77_5:getShipType()] then
				var_77_6 = {}
			end

			var_77_4[var_13] = var_77_6
			table = var_77_6

			var_77_6.insert(var_77_4[var_13], iter_77_5)
		end
	end

	local var_77_7 = arg_77_1
	local var_77_8 = arg_77_1.getConfig(var_77_7, "type")

	ipairs = var_77_7
	table = var_10

	local var_77_9 = var_10.mergeArray
	local var_77_10 = {
		"sameKind"
	}

	pg = iter_77_5

	for iter_77_6, iter_77_7 in var_77_7(var_77_9(var_77_10, iter_77_5.ship_data_by_type[var_77_8].strengthen_choose_type)) do
		if #var_77_0 == 12 or var_77_3 == 0 then
			break
		end

		local var_77_11

		if not var_77_4[iter_77_7] then
			var_77_11 = {}
		end

		local var_77_12 = {}

		ipairs = var_1_10016
		pg = var_1_10017

		local var_77_13 = var_1_10017.ShipFlagMgr.GetInstance()

		var_1_10017 = var_1_10017.FilterShips
		ShipStatus = iter_77_10
		iter_77_10 = iter_77_10.FILTER_SHIPS_FLAGS_2
		underscore = iter_77_11

		for iter_77_10, iter_77_11 in var_1_10016(var_1_10017(var_77_13, iter_77_10, iter_77_11.map(var_77_11, function(arg_79_0)
			return arg_79_0.id
		end))) do
			var_77_12[iter_77_11] = true
		end

		underscore = var_1_10016

		local var_77_14 = var_1_10016.filter(var_77_11, function(arg_80_0)
			local var_80_4

			if arg_80_0.level == 1 then
				local var_80_0 = arg_80_0
				local var_80_1 = arg_80_0.getRarity(var_80_0)

				ShipRarity = var_80_0

				if var_80_1 <= var_80_0.Gray then
					local var_80_2 = arg_80_0
					local var_80_3 = arg_80_0.GetLockState(var_80_2)

					Ship = var_80_2

					if var_80_3 ~= var_80_2.LOCK_STATE_LOCK then
						table = var_80_3

						if not var_80_3.contains(arg_77_2, arg_80_0.id) and arg_77_1.id ~= arg_80_0.id then
							var_80_4 = not var_77_12[arg_80_0.id]

							goto label_80_0
						end
					end
				end
			end

			var_80_4 = false

			if false then
				var_80_4 = true
			end

			::label_80_0::

			return var_80_4
		end)

		ipairs = var_1_10016

		for iter_77_10, iter_77_11 in var_1_10016(var_77_14) do
			if #var_77_0 == 12 or var_77_3 == 0 then
				break
			end

			ShipModLayer = var_21

			local var_77_15 = var_21.getModExpAdditions(var_77_1, {
				iter_77_11
			})
			local var_77_16 = false

			pairs = var_23

			for iter_77_12, iter_77_13 in var_23(var_77_15) do
				if iter_77_13 > 0 and var_77_2[iter_77_12] > 0 then
					var_77_16 = true
					math = var_28
					var_77_3 = var_77_3 - var_28.min(var_77_2[iter_77_12], iter_77_13)
					math = var_28
					var_77_2[iter_77_12] = var_28.max(var_77_2[iter_77_12] - iter_77_13, 0)
				end
			end

			if var_77_16 then
				table = var_23

				var_23.insert(var_77_0, iter_77_11)
			end
		end
	end

	underscore = var_9

	return var_9.map(var_77_0, function(arg_81_0)
		return arg_81_0.id
	end)
end

function var_0_1.getUpgradeRecommendShip(arg_82_0, arg_82_1, arg_82_2, arg_82_3)
	local var_82_0 = arg_82_0
	local var_82_1 = arg_82_0.getUpgradeShips(var_82_0, arg_82_1)

	pg = var_82_0

	local var_82_2 = var_82_0.ShipFlagMgr.GetInstance()
	local var_82_3 = var_5.FilterShips

	ShipStatus = var_1_10007

	local var_82_4 = var_1_10007.FILTER_SHIPS_FLAGS_4

	underscore = var_1_10008

	local var_82_5 = var_82_3(var_82_2, var_82_4, var_1_10008.keys(arg_82_0.data))

	local function var_82_6(arg_83_0)
		local var_83_2

		if arg_83_0.level == 1 then
			local var_83_0 = arg_83_0
			local var_83_1 = arg_83_0.GetLockState(var_83_0)

			Ship = var_83_0

			if var_83_1 ~= var_83_0.LOCK_STATE_LOCK then
				table = var_83_1

				if not var_83_1.contains(arg_82_2, arg_83_0.id) and arg_82_1.id ~= arg_83_0.id then
					table = var_1
					var_83_2 = not var_1.contains(var_82_5, arg_83_0.id)

					goto label_83_0
				end
			end
		end

		var_83_2 = false

		if false then
			var_83_2 = true
		end

		::label_83_0::

		return var_83_2
	end

	local var_82_7 = {}

	ipairs = var_8

	for iter_82_0, iter_82_1 in var_8(var_82_1) do
		if var_82_6(iter_82_1) then
			table = var_13

			var_13.insert(var_82_7, iter_82_1)
		end
	end

	local var_82_8 = {
		function(arg_84_0)
			return arg_84_0:isSameKind(arg_82_1) and 0 or 1
		end
	}

	table = var_9

	local var_82_9 = var_9.sort
	local var_82_10 = var_82_7

	CompareFuncs = iter_82_0

	var_82_9(var_82_10, iter_82_0(var_82_8))

	local var_82_11 = {}

	pairs = var_82_10

	for iter_82_2, iter_82_3 in var_82_10(arg_82_2) do
		table = var_1_10015

		var_1_10015.insert(var_82_11, arg_82_0.data[iter_82_3])
	end

	ipairs = var_10

	for iter_82_4, iter_82_5 in var_10(var_82_7) do
		if #var_82_11 == arg_82_3 then
			break
		end

		table = var_15

		var_15.insert(var_82_11, iter_82_5)
	end

	underscore = var_10

	return var_10.map(var_82_11, function(arg_85_0)
		return arg_85_0.id
	end)
end

function var_0_1.getGroupPropose(arg_86_0, arg_86_1)
	local var_86_0 = false

	if arg_86_0.data then
		ipairs = var_3

		for iter_86_0, iter_86_1 in var_3(arg_86_0.data) do
			pg = var_1_10008

			if var_1_10008.ship_data_template[iter_86_1.configId].group_type == arg_86_1 and iter_86_1.propose then
				return true
			end
		end
	end

	return var_86_0
end

function var_0_1.updateRandomFlagShips(arg_87_0, arg_87_1)
	ipairs = var_1_10002

	for iter_87_0, iter_87_1 in var_1_10002(arg_87_1) do
		local var_87_0 = arg_87_0.data[iter_87_1.ship_id]

		var_7.updateRandomFlag(var_87_0, iter_87_1.flag, iter_87_1.shadow)
	end

	return
end

function var_0_1.getRandomFlagShipPhantomMarks(arg_88_0)
	local var_88_0 = {}

	pairs = var_1_10002

	for iter_88_0, iter_88_1 in var_1_10002(arg_88_0.data) do
		table = var_1_10007

		var_1_10007.insertto(var_88_0, iter_88_1:getRandomFlagShipPhantomMarks())
	end

	return var_88_0
end

function var_0_1.getAllShipPhantomMarks(arg_89_0)
	local var_89_0 = {}

	pairs = var_1_10002

	for iter_89_0, iter_89_1 in var_1_10002(arg_89_0.data) do
		table = var_1_10007

		var_1_10007.insertto(var_89_0, iter_89_1:getAllShipPhantomMarks())
	end

	return var_89_0
end

function var_0_1.GetShipPhantom(arg_90_0, arg_90_1)
	ShipPhantom = var_1_10002

	local var_90_0, var_90_1 = var_1_10002.UnpackMark(arg_90_1)

	if arg_90_0.data[var_90_0] then
		ShipPhantom = var_4

		local var_90_2

		if not var_4.Create(arg_90_0.data[var_90_0], var_90_1) then
			var_90_2 = nil
		end

		return var_90_2
	end
end

function var_0_1.getShipPhantomList(arg_91_0, arg_91_1)
	underscore = var_1_10002

	return var_1_10002.map(arg_91_1, function(arg_92_0)
		local var_92_0 = arg_91_0

		return var_1.GetShipPhantom(var_92_0, arg_92_0)
	end)
end

function var_0_1.ClearChangeSkinAsmr(arg_93_0)
	pairs = var_1_10001

	for iter_93_0, iter_93_1 in var_1_10001(arg_93_0.data) do
		iter_93_1:RevertAsmrSkin()
	end

	return
end

function var_0_1.updateShipSkin(arg_94_0, arg_94_1, arg_94_2, arg_94_3)
	local var_94_0 = arg_94_0.data[arg_94_1]

	assert = var_1_10005

	var_1_10005(var_94_0)
	var_94_0:updateSkinId(arg_94_3, arg_94_2)
	arg_94_0:sendNotification(var_0_1.SHIP_UPDATED, var_94_0:clone())

	return
end

function var_0_1.CanUseShareSkinPhantoms(arg_95_0, arg_95_1)
	ShipSkin = var_1_10002

	local var_95_0 = var_1_10002.New({
		id = arg_95_1
	})
	local var_95_1 = var_2.IsTransSkin(var_95_0)
	local var_95_2 = var_2:IsProposeSkin()
	local var_95_3, var_95_4 = var_2:GetShareGroupIds()
	local var_95_5 = {}

	ipairs = var_1_10008

	for iter_95_0, iter_95_1 in var_1_10008(var_95_4) do
		var_95_5[iter_95_1] = true
	end

	local var_95_6 = {}

	ipairs = var_9
	underscore = var_10

	local var_95_7 = var_10.filter

	underscore = iter_95_0

	for iter_95_2, iter_95_3 in var_9(var_95_7(iter_95_0.values(arg_95_0:getRawData()), function(arg_96_0)
		if not arg_96_0 then
			return false
		end

		if var_95_1 then
			do return arg_96_0.groupId == var_95_3 and arg_96_0:isRemoulded() end

			goto label_96_0
		end

		if arg_96_0.groupId ~= var_95_3 then
			if var_95_5[arg_96_0.groupId] then
				math = var_1

				if var_1.floor(arg_96_0:getIntimacy() / 100) >= arg_96_0:GetNoProposeIntimacyMax() then
					local var_96_0

					if var_95_2 then
						tobool = var_1
						var_96_0 = var_1(arg_96_0.propose)

						if false then
							var_96_0 = false
						end
					else
						var_96_0 = true
					end

					do return var_96_0 end

					goto label_96_0
				end
			end

			do return false end

			::label_96_0::

			return
		end
	end)) do
		table = var_1_10014

		var_1_10014.insertto(var_95_6, iter_95_3:getAllShipPhantom())
	end

	return var_95_6
end

return var_0_1
