local var_0_0 = class("GuildBossMission", import("...BaseVO"))

var_0_0.MAIN_FLEET_ID = 1
var_0_0.SUB_FLEET_ID = 11

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2, arg_1_3)
	arg_1_0.position = arg_1_1
	arg_1_0.dailyCount = arg_1_2 or 0
	arg_1_0.fleets = {
		[var_0_0.MAIN_FLEET_ID] = GuildBossMissionFleet.New({
			fleet_id = var_0_0.MAIN_FLEET_ID
		}),
		[var_0_0.SUB_FLEET_ID] = GuildBossMissionFleet.New({
			fleet_id = var_0_0.SUB_FLEET_ID
		})
	}

	for iter_1_0, iter_1_1 in ipairs(arg_1_3) do
		if arg_1_0.fleets[iter_1_1.fleet_id] then
			arg_1_0.fleets[iter_1_1.fleet_id]:Flush(iter_1_1)
		end
	end

	arg_1_0.active = false
	arg_1_0.rankUpdateTime = 0

	return
end

function var_0_0.Flush(arg_2_0, arg_2_1)
	arg_2_0.id = arg_2_1.boss_id
	arg_2_0.configId = arg_2_0.id
	arg_2_0.damage = arg_2_1.damage or 0
	arg_2_0.totalHp = arg_2_1.hp or 1
	arg_2_0.active = true

	return
end

function var_0_0.GetPosition(arg_3_0)
	return arg_3_0.position
end

function var_0_0.bindConfigTable(arg_4_0)
	return pg.guild_boss_event
end

function var_0_0.GetIcon(arg_5_0)
	return arg_5_0:getConfig("pic") or arg_5_0.configId
end

function var_0_0.GetFleetByIndex(arg_6_0, arg_6_1)
	return arg_6_0.fleets[arg_6_1]
end

function var_0_0.GetMainFleet(arg_7_0)
	return arg_7_0.fleets[var_0_0.MAIN_FLEET_ID]
end

function var_0_0.GetSubFleet(arg_8_0)
	return arg_8_0.fleets[var_0_0.SUB_FLEET_ID]
end

function var_0_0.UpdateFleet(arg_9_0, arg_9_1)
	arg_9_0.fleets[arg_9_1.id] = arg_9_1

	return
end

function var_0_0.GetFleets(arg_10_0)
	return arg_10_0.fleets
end

function var_0_0.GetAllShipIds(arg_11_0)
	for iter_11_0, iter_11_1 in pairs(arg_11_0.fleets) do
		for iter_11_2, iter_11_3 in ipairs((iter_11_1:GetShips())) do
			table.insert({}, (GuildAssaultFleet.GetRealId(iter_11_3.ship.id)))
		end
	end

	return {}
end

function var_0_0.GetMyShipIds(arg_12_0)
	for iter_12_0, iter_12_1 in pairs(arg_12_0.fleets) do
		for iter_12_2, iter_12_3 in ipairs((iter_12_1:GetMyShipIds())) do
			table.insert({}, iter_12_3)
		end
	end

	return {}
end

function var_0_0.GetShipsSplitByUserID(arg_13_0)
	local var_13_0 = getProxy(PlayerProxy):getRawData().id

	for iter_13_0, iter_13_1 in pairs(arg_13_0.fleets) do
		for iter_13_2, iter_13_3 in ipairs((iter_13_1:GetShips())) do
			if iter_13_3.member.id ~= var_13_0 then
				table.insert({}, {
					shipID = GuildAssaultFleet.GetRealId(iter_13_3.ship.id),
					userID = iter_13_3.member.id
				})
			end
		end
	end

	return {}
end

function var_0_0.GetTotalHp(arg_14_0)
	return arg_14_0.totalHp
end

function var_0_0.GetHp(arg_15_0)
	return arg_15_0:GetTotalHp() - arg_15_0.damage
end

function var_0_0.IsDeath(arg_16_0)
	return arg_16_0.damage >= arg_16_0:GetTotalHp()
end

function var_0_0.GetStageID(arg_17_0)
	return arg_17_0:getConfig("expedition_id")[1]
end

function var_0_0.IsMain(arg_18_0)
	return true
end

function var_0_0.IsFinish(arg_19_0)
	return false
end

function var_0_0.GetName(arg_20_0)
	return arg_20_0:getConfig("name")
end

function var_0_0.GetSubType(arg_21_0)
	return 1
end

function var_0_0.IsActive(arg_22_0)
	return arg_22_0.active
end

function var_0_0.IsBoss(arg_23_0)
	return true
end

function var_0_0.GetTag(arg_24_0)
	return 3
end

function var_0_0.GetCanUsageCnt(arg_25_0)
	return GuildConst.MISSION_BOSS_MAX_CNT() - arg_25_0.dailyCount
end

function var_0_0.ReduceDailyCnt(arg_26_0)
	arg_26_0.dailyCount = arg_26_0.dailyCount + 1

	return
end

function var_0_0.ResetDailyCnt(arg_27_0)
	arg_27_0.dailyCount = 0

	return
end

function var_0_0.GetAwards(arg_28_0)
	return arg_28_0:getConfig("award")
end

function var_0_0.CanEnterBattle(arg_29_0)
	return not arg_29_0:IsReachDailyCnt() and not arg_29_0:IsDeath()
end

function var_0_0.IsReachDailyCnt(arg_30_0)
	return arg_30_0.dailyCount >= GuildConst.MISSION_BOSS_MAX_CNT()
end

function var_0_0.GetPainting(arg_31_0)
	return arg_31_0:getConfig("painting")
end

function var_0_0.GetPrefab(arg_32_0)
	local var_32_0 = pg.enemy_data_statistics[arg_32_0:getConfig("expedition_id")[2][1]]

	assert(var_32_0)

	return var_32_0.prefab
end

function var_0_0.GetEmenyId(arg_33_0)
	return arg_33_0:getConfig("expedition_id")[2][1]
end

function var_0_0.CanFormation(arg_34_0)
	return false
end

function var_0_0.ExistCommander(arg_35_0, arg_35_1)
	for iter_35_0, iter_35_1 in pairs(arg_35_0.fleets) do
		if iter_35_1:ExistCommander(arg_35_1) then
			return true
		end
	end

	return false
end

function var_0_0.GetFleetUserId(arg_36_0, arg_36_1, arg_36_2)
	for iter_36_0, iter_36_1 in pairs(arg_36_0.fleets) do
		if iter_36_1:ContainShip(arg_36_1, arg_36_2) then
			return iter_36_1
		end
	end

	return false
end

function var_0_0.GetFleetCommanderId(arg_37_0, arg_37_1)
	for iter_37_0, iter_37_1 in pairs(arg_37_0.fleets) do
		if iter_37_1:ExistCommander(arg_37_1) then
			return iter_37_1
		end
	end

	return false
end

return var_0_0
