class = var_0_10000

local var_0_0 = "GuildBossMission"

import = var_0_10002

local var_0_1 = var_0_10000(var_0_0, var_0_10002("...BaseVO"))

var_0_1.MAIN_FLEET_ID = 1
var_0_1.SUB_FLEET_ID = 11

function var_0_1.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.position = arg_1_1
	arg_1_0.dailyCount = arg_1_2 or 0

	local var_1_0 = {}
	local var_1_1 = var_0_1.MAIN_FLEET_ID

	GuildBossMissionFleet = var_1_10006
	var_1_0[var_1_1] = var_1_10006.New({
		fleet_id = var_0_1.MAIN_FLEET_ID
	})

	local var_1_2 = var_0_1.SUB_FLEET_ID

	GuildBossMissionFleet = var_6
	var_1_0[var_1_2] = var_6.New({
		fleet_id = var_0_1.SUB_FLEET_ID
	})
	arg_1_0.fleets = var_1_0
	ipairs = var_1_0

	for iter_1_0, iter_1_1 in var_1_0(arg_1_3) do
		if arg_1_0.fleets[iter_1_1.fleet_id] then
			var_9:Flush(iter_1_1)
		end
	end

	arg_1_0.active = false
	arg_1_0.rankUpdateTime = 0

	return
end

function var_0_1.Flush(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.boss_id
	arg_2_0.configId = arg_2_0.id

	local var_2_0

	if not arg_2_1.damage then
		var_2_0 = 0
	end

	arg_2_0.damage = var_2_0

	local var_2_1

	if not arg_2_1.hp then
		var_2_1 = 1
	end

	arg_2_0.totalHp = var_2_1
	arg_2_0.active = true

	return
end

function var_0_1.GetPosition(arg_3_0)
	return arg_3_0.position
end

function var_0_1.bindConfigTable(arg_4_0)
	pg = var_1_10001

	return var_1_10001.guild_boss_event
end

function var_0_1.GetIcon(arg_5_0)
	local var_5_0

	if not arg_5_0:getConfig("pic") then
		var_5_0 = arg_5_0.configId
	end

	return var_5_0
end

function var_0_1.GetFleetByIndex(arg_6_0, arg_6_1)
	return arg_6_0.fleets[arg_6_1]
end

function var_0_1.GetMainFleet(arg_7_0)
	return arg_7_0.fleets[var_0_1.MAIN_FLEET_ID]
end

function var_0_1.GetSubFleet(arg_8_0)
	return arg_8_0.fleets[var_0_1.SUB_FLEET_ID]
end

function var_0_1.UpdateFleet(arg_9_0, arg_9_1)
	arg_9_0.fleets[arg_9_1.id] = arg_9_1

	return
end

function var_0_1.GetFleets(arg_10_0)
	return arg_10_0.fleets
end

function var_0_1.GetAllShipIds(arg_11_0)
	local var_11_0 = {}

	pairs = var_1_10002

	for iter_11_0, iter_11_1 in var_1_10002(arg_11_0.fleets) do
		local var_11_1 = iter_11_1
		local var_11_2 = iter_11_1.GetShips(var_11_1)

		ipairs = var_11_1

		for iter_11_2, iter_11_3 in var_11_1(var_11_2) do
			GuildAssaultFleet = var_1_10013
			var_1_10013 = var_1_10013.GetRealId(iter_11_3.ship.id)
			table = var_14

			var_14.insert(var_11_0, var_1_10013)
		end
	end

	return var_11_0
end

function var_0_1.GetMyShipIds(arg_12_0)
	local var_12_0 = {}

	pairs = var_1_10002

	for iter_12_0, iter_12_1 in var_1_10002(arg_12_0.fleets) do
		local var_12_1 = iter_12_1
		local var_12_2 = iter_12_1.GetMyShipIds(var_12_1)

		ipairs = var_12_1

		for iter_12_2, iter_12_3 in var_12_1(var_12_2) do
			table = var_1_10013

			var_1_10013.insert(var_12_0, iter_12_3)
		end
	end

	return var_12_0
end

function var_0_1.GetShipsSplitByUserID(arg_13_0)
	local var_13_0 = {}

	getProxy = var_1_10002
	PlayerProxy = var_1_10003

	local var_13_1 = var_1_10002(var_1_10003)
	local var_13_2 = var_2.getRawData(var_13_1).id

	pairs = var_13_1

	for iter_13_0, iter_13_1 in var_13_1(arg_13_0.fleets) do
		local var_13_3 = iter_13_1
		local var_13_4 = iter_13_1.GetShips(var_13_3)

		ipairs = var_13_3

		for iter_13_2, iter_13_3 in var_13_3(var_13_4) do
			if iter_13_3.member.id ~= var_13_2 then
				GuildAssaultFleet = var_1_10015
				var_1_10015 = var_1_10015.GetRealId(iter_13_3.ship.id)
				table = var_16

				var_16.insert(var_13_0, {
					shipID = var_1_10015,
					userID = var_14
				})
			end
		end
	end

	return var_13_0
end

function var_0_1.GetTotalHp(arg_14_0)
	return arg_14_0.totalHp
end

function var_0_1.GetHp(arg_15_0)
	return arg_15_0:GetTotalHp() - arg_15_0.damage
end

function var_0_1.IsDeath(arg_16_0)
	return arg_16_0.damage >= arg_16_0:GetTotalHp()
end

function var_0_1.GetStageID(arg_17_0)
	return arg_17_0:getConfig("expedition_id")[1]
end

function var_0_1.IsMain(arg_18_0)
	return true
end

function var_0_1.IsFinish(arg_19_0)
	return false
end

function var_0_1.GetName(arg_20_0)
	return arg_20_0:getConfig("name")
end

function var_0_1.GetSubType(arg_21_0)
	return 1
end

function var_0_1.IsActive(arg_22_0)
	return arg_22_0.active
end

function var_0_1.IsBoss(arg_23_0)
	return true
end

function var_0_1.GetTag(arg_24_0)
	return 3
end

function var_0_1.GetCanUsageCnt(arg_25_0)
	GuildConst = var_1_10001

	return var_1_10001.MISSION_BOSS_MAX_CNT() - arg_25_0.dailyCount
end

function var_0_1.ReduceDailyCnt(arg_26_0)
	arg_26_0.dailyCount = arg_26_0.dailyCount + 1

	return
end

function var_0_1.ResetDailyCnt(arg_27_0)
	arg_27_0.dailyCount = 0

	return
end

function var_0_1.GetAwards(arg_28_0)
	return arg_28_0:getConfig("award")
end

function var_0_1.CanEnterBattle(arg_29_0)
	local var_29_0 = not arg_29_0:IsReachDailyCnt()
	local var_29_1 = not arg_29_0:IsDeath()

	return var_29_0 and var_29_1
end

function var_0_1.IsReachDailyCnt(arg_30_0)
	local var_30_0 = arg_30_0.dailyCount

	GuildConst = var_1_10002

	return var_30_0 >= var_1_10002.MISSION_BOSS_MAX_CNT()
end

function var_0_1.GetPainting(arg_31_0)
	return arg_31_0:getConfig("painting")
end

function var_0_1.GetPrefab(arg_32_0)
	local var_32_0 = arg_32_0
	local var_32_1 = arg_32_0.getConfig(var_32_0, "expedition_id")[2][1]

	pg = var_32_0

	local var_32_2 = var_32_0.enemy_data_statistics[var_32_1]

	assert = var_3

	var_3(var_32_2)

	return var_32_2.prefab
end

function var_0_1.GetEmenyId(arg_33_0)
	return arg_33_0:getConfig("expedition_id")[2][1]
end

function var_0_1.CanFormation(arg_34_0)
	return false
end

function var_0_1.ExistCommander(arg_35_0, arg_35_1)
	pairs = var_1_10002

	for iter_35_0, iter_35_1 in var_1_10002(arg_35_0.fleets) do
		if iter_35_1:ExistCommander(arg_35_1) then
			return true
		end
	end

	return false
end

function var_0_1.GetFleetUserId(arg_36_0, arg_36_1, arg_36_2)
	pairs = var_1_10003

	for iter_36_0, iter_36_1 in var_1_10003(arg_36_0.fleets) do
		if iter_36_1:ContainShip(arg_36_1, arg_36_2) then
			return iter_36_1
		end
	end

	return false
end

function var_0_1.GetFleetCommanderId(arg_37_0, arg_37_1)
	pairs = var_1_10002

	for iter_37_0, iter_37_1 in var_1_10002(arg_37_0.fleets) do
		if iter_37_1:ExistCommander(arg_37_1) then
			return iter_37_1
		end
	end

	return false
end

return var_0_1
