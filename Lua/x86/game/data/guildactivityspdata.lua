GuildActivityRankStruct = class("GuildActivityRankStruct")

function GuildActivityRankStruct.Ctor(arg_1_0, arg_1_1)
	arg_1_0.score = arg_1_1.damage
	arg_1_0.user_id = arg_1_1.uid
	arg_1_0.nick = arg_1_1.base_info.nick
	arg_1_0.icon = arg_1_1.base_info.icon
	arg_1_0.icon_frame = arg_1_1.base_info.icon_frame
	arg_1_0.time_stamp = arg_1_1.timestamp
	arg_1_0.select_hero_id_list = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hero_list or {}) do
		table.insert(arg_1_0.select_hero_id_list, iter_1_1)
	end
end

local var_0_0 = singletonClass("GuildActivitySPData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = 0
local var_0_6

function var_0_0.Init(arg_2_0)
	var_0_5 = 0
	var_0_4 = {}
	var_0_2 = {
		benchmark_time = 0,
		last_receive_time = 0,
		current_grid = 0,
		is_init_hero_list = 0,
		spawn_id_list = {},
		grid_list = {},
		talent_list = {},
		grid_dic = {},
		hero_list = {},
		max_node_id = GuildActivitySPData:GetMaxNodeId()
	}
end

function var_0_0.InitActivityID(arg_3_0, arg_3_1)
	var_0_6 = arg_3_1

	if not var_0_6 or var_0_6 == 0 then
		var_0_6 = ActivityConst.GUILD_ACTIVITY_SP_2_8
	end
end

function var_0_0.InitMainDataFromServer(arg_4_0, arg_4_1)
	var_0_2 = {
		current_grid = arg_4_1.stay_id,
		last_receive_time = arg_4_1.last_receive_time,
		is_init_hero_list = arg_4_1.is_init_hero_list,
		benchmark_time = arg_4_1.benchmark_time
	}
	var_0_2.hero_list = {}
	var_0_2.hero_dic = {}

	for iter_4_0, iter_4_1 in ipairs(arg_4_1.hero_list) do
		local var_4_0 = {
			id = iter_4_1.id,
			fatigue = iter_4_1.fatigue,
			last_update_time = iter_4_1.last_update_time
		}

		var_0_2.hero_dic[iter_4_1.id] = var_4_0

		table.insert(var_0_2.hero_list, var_4_0)
	end

	var_0_2.spawn_id_list = {}

	for iter_4_2, iter_4_3 in ipairs(arg_4_1.spawn_id_list) do
		if not table.indexof(var_0_2.spawn_id_list, iter_4_3) then
			table.insert(var_0_2.spawn_id_list, iter_4_3)
		end
	end

	table.sort(var_0_2.spawn_id_list, function(arg_5_0, arg_5_1)
		return arg_5_0 < arg_5_1
	end)

	var_0_2.grid_dic = {}

	for iter_4_4, iter_4_5 in ipairs(arg_4_1.grid_list) do
		local var_4_1 = {
			id = iter_4_5.id,
			is_occupied = iter_4_5.is_occupied,
			dispatch_cat_id = iter_4_5.dispatch_cat_id or 0,
			dispatch_time = iter_4_5.dispatch_time or 0,
			elite_health_rate = iter_4_5.elite_health_rate
		}

		var_0_2.grid_dic[var_4_1.id] = var_4_1
	end

	var_0_2.talent_list = {}

	for iter_4_6, iter_4_7 in ipairs(arg_4_1.talent_list) do
		var_0_2.talent_list[iter_4_7.id] = {}
		var_0_2.talent_list[iter_4_7.id] = {
			id = iter_4_7.id,
			level = iter_4_7.level
		}
	end

	arg_4_0:RefreshAffixRedPoint()

	var_0_2.receive_list = {}

	for iter_4_8, iter_4_9 in ipairs(arg_4_1.receive_list) do
		table.insert(var_0_2.receive_list, iter_4_9)
	end
end

function var_0_0.InitGridsDataFromServer(arg_6_0, arg_6_1)
	var_0_3 = {}

	local var_6_0 = arg_6_0:CreateDefaultDataList()
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		var_6_1[iter_6_1.id] = iter_6_1
	end

	local var_6_2 = arg_6_0:GetCurRunActivityID()
	local var_6_3 = ActivityClubSPCfg.get_id_list_by_activity[var_6_2]

	if var_6_3 then
		for iter_6_2, iter_6_3 in ipairs(var_6_3) do
			local var_6_4 = ActivityClubSPCfg[iter_6_3]

			if var_6_4.type ~= 0 then
				local var_6_5 = var_6_1[iter_6_3]
				local var_6_6

				if var_6_5 then
					var_6_6 = {
						id = iter_6_3,
						occupied_num = var_6_5.occupied_num,
						health = var_6_5.health or var_6_4.boss_score,
						dispatch_num = var_6_5.dispatch_num
					}
				else
					var_6_6 = {
						dispatch_num = 0,
						occupied_num = 0,
						id = iter_6_3,
						health = var_6_4.boss_score
					}
				end

				var_0_3[var_6_6.id] = var_6_6

				local var_6_7 = arg_6_0:CreateNodeData(var_6_6.id)

				var_6_7.occupied_num = var_6_6.occupied_num
				var_6_7.health = math.floor(var_6_6.health / 100)

				if var_6_7.health == 0 and var_6_6.health > 0 then
					var_6_7.health = 1
				end

				if var_0_2.grid_dic[var_6_6.id] and var_0_2.grid_dic[var_6_6.id].is_occupied > 0 then
					var_6_7.is_occupied = var_0_2.grid_dic[var_6_6.id].is_occupied
				else
					var_6_7.is_occupied = 0
				end

				if var_0_2.grid_dic[var_6_6.id] and var_0_2.grid_dic[var_6_6.id].elite_health_rate > 0 then
					var_6_7.eliteHealthRate = var_0_2.grid_dic[var_6_6.id].elite_health_rate
				else
					var_6_7.eliteHealthRate = 0
				end

				if var_0_2.grid_dic[var_6_6.id] and var_0_2.grid_dic[var_6_6.id].dispatch_cat_id > 0 then
					var_6_7.myDispatchCatId = var_0_2.grid_dic[var_6_6.id].dispatch_cat_id
				else
					var_6_7.myDispatchCatId = 0
				end

				if var_0_2.grid_dic[var_6_6.id] and var_0_2.grid_dic[var_6_6.id].dispatch_time > 0 then
					var_6_7.myDispatchTime = var_0_2.grid_dic[var_6_6.id].dispatch_time
				else
					var_6_7.myDispatchTime = 0
				end

				var_6_7.dispatch_num = var_6_6.dispatch_num

				var_6_0.dataList:Add(var_6_7)
			end
		end

		manager.notify:Invoke(INIT_GUILD_ACTIVITY_SP_MAIN_DATA, {})
		arg_6_0:UpdateBigBossStatus(var_6_0)

		if GuildActivitySPLuaBridge.GetManager() then
			GuildActivitySPLuaBridge.GetManager():UpdateNodeData(var_6_0, true)
		end
	end
end

function var_0_0.InitFightRecordFromServer(arg_7_0, arg_7_1)
	var_0_4 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		local var_7_0 = {
			uid = iter_7_1.uid,
			icon = iter_7_1.icon,
			icon_frame = iter_7_1.icon_frame,
			name = iter_7_1.name,
			damage = iter_7_1.damage,
			hero_list = iter_7_1.hero_list,
			timestamp = iter_7_1.timestamp
		}

		table.insert(var_0_4, var_7_0)
	end

	table.sort(var_0_4, function(arg_8_0, arg_8_1)
		return arg_8_0.damage > arg_8_1.damage
	end)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_FIGHT_RECORD_GET, {})
end

function var_0_0.UpdateSelfGridDataFromServer(arg_9_0, arg_9_1)
	if arg_9_1.spawn_id_list ~= nil and #arg_9_1.spawn_id_list > 0 then
		for iter_9_0, iter_9_1 in ipairs(arg_9_1.spawn_id_list) do
			if table.indexof(var_0_2.spawn_id_list, iter_9_1) then
				-- block empty
			else
				table.insert(var_0_2.spawn_id_list, iter_9_1)
			end
		end

		table.sort(var_0_2.spawn_id_list, function(arg_10_0, arg_10_1)
			return arg_10_0 < arg_10_1
		end)
		manager.notify:Invoke(GUILD_ACTIVITY_SP_SPAWN_ID_UPDATE, {})
	end

	local var_9_0 = arg_9_0:CreateDefaultDataList()
	local var_9_1 = arg_9_1.type
	local var_9_2 = {}

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.grid_list) do
		table.insert(var_9_2, iter_9_3.id)

		if var_9_1 == 1 then
			local var_9_3 = {
				id = iter_9_3.id,
				is_occupied = iter_9_3.is_occupied,
				dispatch_cat_id = iter_9_3.dispatch_cat_id or 0,
				dispatch_time = iter_9_3.dispatch_time or 0,
				elite_health_rate = iter_9_3.elite_health_rate
			}

			if var_9_3.id == 21128 then
				CustomLog.Log(debug.traceback(string.format("21128 is occupied = %d", var_9_3.is_occupied)))
			end

			var_0_2.grid_dic[iter_9_3.id] = var_9_3

			local var_9_4 = var_0_3[iter_9_3.id]

			if var_9_4 then
				local var_9_5 = arg_9_0:CreateNodeData(iter_9_3.id)

				var_9_5.occupied_num = var_9_4.occupied_num
				var_9_5.health = math.floor(var_9_4.health / 100)

				if var_9_5.health == 0 and var_9_4.health > 0 then
					var_9_5.health = 1
				end

				if var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].is_occupied > 0 then
					var_9_5.is_occupied = var_0_2.grid_dic[iter_9_3.id].is_occupied
				else
					var_9_5.is_occupied = 0
				end

				if var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].elite_health_rate > 0 then
					var_9_5.eliteHealthRate = var_0_2.grid_dic[iter_9_3.id].elite_health_rate
				else
					var_9_5.eliteHealthRate = 0
				end

				if var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].dispatch_cat_id > 0 then
					var_9_5.myDispatchCatId = var_0_2.grid_dic[iter_9_3.id].dispatch_cat_id
				else
					var_9_5.myDispatchCatId = 0
				end

				if var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].dispatch_time > 0 then
					var_9_5.myDispatchTime = var_0_2.grid_dic[iter_9_3.id].dispatch_time
				else
					var_9_5.myDispatchTime = 0
				end

				var_9_5.dispatch_num = var_9_4.dispatch_num

				var_9_0.dataList:Add(var_9_5)
			end
		else
			var_0_2.grid_dic[iter_9_3.id] = nil

			local var_9_6 = var_0_3[iter_9_3.id]

			if var_9_6 then
				local var_9_7 = arg_9_0:CreateNodeData(iter_9_3.id)

				var_9_7.is_occupied = 0
				var_9_7.eliteHealthRate = 0
				var_9_7.occupied_num = var_9_6.occupied_num
				var_9_7.health = var_9_6.health
				var_9_7.myOccupiedTimestamp = 0
				var_9_7.processingType = 0
				var_9_7.myProcessingTimestamp = 0
				var_9_7.dispatch_num = 0
				var_9_7.myDispatchCatId = 0
				var_9_7.myDispatchTime = 0

				var_9_0.dataList:Add(var_9_7)
			end
		end
	end

	arg_9_0:UpdateBigBossStatus(var_9_0)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, var_9_2)

	if GuildActivitySPLuaBridge.GetManager() then
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(var_9_0)
	end
end

function var_0_0.UpdateGridsDataFromServer(arg_11_0, arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = {
			id = iter_11_1.id,
			occupied_num = iter_11_1.occupied_num,
			health = iter_11_1.health or ActivityClubSPCfg[iter_11_1.id].boss_score,
			dispatch_num = iter_11_1.dispatch_num
		}

		table.insert(var_11_0, var_11_1.id)

		var_0_3[var_11_1.id] = var_11_1
	end

	manager.notify:Invoke(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, var_11_0)

	if GuildActivitySPLuaBridge.GetManager() then
		local var_11_2 = arg_11_0:CreateDefaultDataList()

		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			local var_11_3 = arg_11_0:CreateNodeData(iter_11_3.id)

			var_11_3.occupied_num = iter_11_3.occupied_num
			var_11_3.health = math.floor(iter_11_3.health / 100)

			if var_11_3.health == 0 and iter_11_3.health > 0 then
				var_11_3.health = 1
			end

			if var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].is_occupied > 0 then
				var_11_3.is_occupied = var_0_2.grid_dic[iter_11_3.id].is_occupied
			else
				var_11_3.is_occupied = 0
			end

			if var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].elite_health_rate > 0 then
				var_11_3.eliteHealthRate = var_0_2.grid_dic[iter_11_3.id].elite_health_rate
			else
				var_11_3.eliteHealthRate = 0
			end

			if var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].dispatch_cat_id > 0 then
				var_11_3.myDispatchCatId = var_0_2.grid_dic[iter_11_3.id].dispatch_cat_id
			else
				var_11_3.myDispatchCatId = 0
			end

			if var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].dispatch_time > 0 then
				var_11_3.myDispatchTime = var_0_2.grid_dic[iter_11_3.id].dispatch_time
			else
				var_11_3.myDispatchTime = 0
			end

			var_11_3.dispatch_num = iter_11_3.dispatch_num

			var_11_2.dataList:Add(var_11_3)
		end

		arg_11_0:UpdateBigBossStatus(var_11_2)
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(var_11_2)
	end
end

function var_0_0.GetSpawnIdList(arg_12_0)
	return var_0_2.spawn_id_list
end

function var_0_0.GetFightRecords(arg_13_0)
	return var_0_4
end

function var_0_0.CreateNodeData(arg_14_0, arg_14_1)
	local var_14_0 = GuildActivitySPNodeData.New()
	local var_14_1 = ActivityClubSPCfg[arg_14_1]

	var_14_0.id = arg_14_1
	var_14_0.map_id = var_14_1.map_id
	var_14_0.type = var_14_1.type
	var_14_0.level = var_14_1.level
	var_14_0.stage_id = var_14_1.stage_id
	var_14_0.vitality_cost = var_14_1.vitality_cost
	var_14_0.token_get = var_14_1.token_get
	var_14_0.boss_score = math.floor(var_14_1.boss_score / 100)
	var_14_0.boss_stage_hp = var_14_1.boss_stage_hp
	var_14_0.boss_name = var_14_1.boss_name

	return var_14_0
end

function var_0_0.UpdateBigBossStatus(arg_15_0, arg_15_1)
	for iter_15_0, iter_15_1 in pairs(ActivityClubSPCfg.get_id_list_by_map_id) do
		if arg_15_0:IsAllLittleBossPass(iter_15_0) > 0 then
			arg_15_1.selfData.bigBossUnlockMapList:Add(iter_15_0)
		end
	end
end

function var_0_0.CreateDefaultDataList(arg_16_0)
	local var_16_0 = GuildActivitySPNodeDataList.New()

	var_16_0.selfData.benchmark_time = var_0_2.benchmark_time
	var_16_0.selfData.coinRefreshMinutes = GameSetting.activity_club_sp_coin_calculate_time.value[1]
	var_16_0.selfData.curNode = var_0_2.current_grid

	local var_16_1 = GuildActivitySPData:GetCurRunActivityID()
	local var_16_2 = ActivityClubSPMapCfg.get_id_list_by_activity[var_16_1]

	var_16_0.selfData.mapCount = #var_16_2
	var_16_0.selfData.myLastReceiveTimestamp = var_0_2.last_receive_time
	var_16_0.selfData.maxNodeId = GuildActivitySPData:GetMaxNodeId()

	for iter_16_0, iter_16_1 in ipairs(var_0_2.spawn_id_list) do
		var_16_0.selfData.spawnNodeIdList:Add(iter_16_1)
	end

	local var_16_3 = {}

	for iter_16_2, iter_16_3 in pairs(ActivityClubSPCfg.get_id_list_by_map_id) do
		local var_16_4 = GuildActivitySPData:GetCurRunActivityID()
		local var_16_5 = ActivityClubSPMapCfg.get_id_list_by_activity[var_16_4]
		local var_16_6 = table.indexof(var_16_5, iter_16_2)
		local var_16_7 = ActivityClubSPCfg.get_id_list_by_map_id[iter_16_2]

		var_16_3[var_16_6] = var_16_7[#var_16_7]
	end

	for iter_16_4, iter_16_5 in ipairs(var_16_3) do
		var_16_0.selfData.bossIdList:Add(iter_16_5)
	end

	return var_16_0
end

function var_0_0.OnGetCoin(arg_17_0, arg_17_1)
	var_0_2.last_receive_time = arg_17_1

	local var_17_0 = arg_17_0:CreateDefaultDataList()

	arg_17_0:UpdateBigBossStatus(var_17_0)

	if GuildActivitySPLuaBridge.GetManager() then
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(var_17_0)
	end
end

function var_0_0.GetCurMainActivityID(arg_18_0)
	return var_0_6
end

function var_0_0.GetCurRunActivityID(arg_19_0)
	local var_19_0 = GuildActivitySPTools.GetCurActivityIDInfo(var_0_6)

	if var_19_0 then
		return var_19_0.start
	end
end

function var_0_0.OnSetFightMember(arg_20_0)
	var_0_2.is_init_hero_list = 1
end

function var_0_0.GetCurrentGrid(arg_21_0)
	return var_0_2.current_grid
end

function var_0_0.SetCurrentGrid(arg_22_0, arg_22_1)
	var_0_2.current_grid = arg_22_1
end

function var_0_0.SetIsSignFromServer(arg_23_0, arg_23_1)
	var_0_5 = arg_23_1
end

function var_0_0.SignUpSuccess(arg_24_0)
	var_0_5 = 1
end

function var_0_0.UpdateGuildActivityHeroes(arg_25_0, arg_25_1)
	var_0_2.hero_dic = {}
	var_0_2.hero_list = {}

	for iter_25_0, iter_25_1 in ipairs(arg_25_1) do
		local var_25_0 = {
			id = iter_25_1.id,
			fatigue = iter_25_1.fatigue,
			last_update_time = iter_25_1.last_update_time
		}

		var_0_2.hero_dic[iter_25_1.id] = var_25_0

		table.insert(var_0_2.hero_list, var_25_0)
	end

	manager.notify:Invoke(GUILD_ACTIVITY_SP_HERO_LIST_UPDATE, {})
end

function var_0_0.IsFirstConfigFightRole(arg_26_0)
	return var_0_2.is_init_hero_list == 0
end

function var_0_0.GetMyOccupiedNum(arg_27_0)
	local var_27_0 = 0

	for iter_27_0, iter_27_1 in pairs(var_0_2.grid_dic) do
		if iter_27_1.is_occupied > 0 then
			var_27_0 = var_27_0 + 1
		end
	end

	return var_27_0
end

function var_0_0.GetMaxFightHeroCount(arg_28_0)
	local var_28_0 = GuildActivitySPData:GetCurRunActivityID()

	return ActivityClubSPLevelSettingCfg[arg_28_0:GetCurRateID(var_28_0)].max_hero
end

function var_0_0.GetMaxOccupyCount(arg_29_0)
	return 99999
end

function var_0_0.GetFightHeroById(arg_30_0, arg_30_1)
	return var_0_2.hero_dic[arg_30_1]
end

function var_0_0.GetHeroFatigue(arg_31_0, arg_31_1)
	if arg_31_0:IsFirstConfigFightRole() then
		return GameSetting.activity_club_sp_hero_fatigue_max.value[1]
	end

	local var_31_0 = manager.time:GetServerTime()
	local var_31_1 = var_0_2.benchmark_time

	if var_0_2.hero_dic[arg_31_1] then
		local var_31_2 = var_0_2.hero_dic[arg_31_1].last_update_time
		local var_31_3 = GameSetting.activity_club_sp_hero_fatigue_max.value[1]
		local var_31_4 = GameSetting.activity_club_sp_hero_fatigue_recovery.value[1] * 60
		local var_31_5 = math.floor((var_31_0 - var_31_1) / var_31_4) - math.floor((var_31_2 - var_31_1) / var_31_4)

		return (math.min(var_0_2.hero_dic[arg_31_1].fatigue + var_31_5, var_31_3))
	else
		return 0
	end
end

function var_0_0.GetFightHeroList(arg_32_0)
	return var_0_2.hero_list
end

function var_0_0.GetMaxNodeId(arg_33_0)
	local var_33_0 = arg_33_0:GetCurRunActivityID()
	local var_33_1 = ActivityClubSPMapCfg.get_id_list_by_activity[var_33_0]

	if var_33_1 then
		local var_33_2 = var_33_1[#var_33_1]
		local var_33_3 = ActivityClubSPCfg.get_id_list_by_map_id[var_33_2]

		if var_33_3 then
			for iter_33_0, iter_33_1 in ipairs(var_33_3) do
				if ActivityClubSPCfg[iter_33_1].type == 4 then
					return iter_33_1
				end
			end
		end
	end
end

function var_0_0.GetTotalCoinToGet(arg_34_0, arg_34_1)
	local var_34_0 = 0

	for iter_34_0, iter_34_1 in pairs(var_0_2.grid_dic) do
		local var_34_1 = ActivityClubSPCfg[iter_34_1.id]
		local var_34_2 = manager.time:GetServerTime()
		local var_34_3 = var_0_2.last_receive_time

		if iter_34_1.dispatch_time > 0 then
			local var_34_4 = math.max(var_34_3, iter_34_1.dispatch_time)
			local var_34_5 = var_0_2.benchmark_time
			local var_34_6 = GameSetting.activity_club_sp_coin_calculate_time.value[1] * 60

			var_34_0 = var_34_0 + (math.floor((var_34_2 - var_34_5) / var_34_6) - math.floor((var_34_4 - var_34_5) / var_34_6)) * var_34_1.token_get / (3600 / var_34_6)
		end
	end

	return var_34_0
end

function var_0_0.GetCoinGain(arg_35_0)
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in pairs(var_0_2.grid_dic) do
		local var_35_1 = ActivityClubSPCfg[iter_35_1.id]

		if iter_35_1.dispatch_cat_id > 0 and (var_35_1.type == 1 or var_35_1.type == 2) then
			var_35_0 = var_35_0 + var_35_1.token_get
		end
	end

	return var_35_0
end

function var_0_0.GetLastReceiveTimestamp(arg_36_0)
	return var_0_2.last_receive_time
end

function var_0_0.GetSelfNodeData(arg_37_0, arg_37_1)
	return var_0_2.grid_dic[arg_37_1]
end

function var_0_0.GetNodeData(arg_38_0, arg_38_1)
	return var_0_3[arg_38_1]
end

function var_0_0.CanTakeOnFightNum(arg_39_0)
	local var_39_0 = var_0_0:GetCurRunActivityID()

	return ActivityClubSPLevelSettingCfg[arg_39_0:GetCurRateID(var_39_0)].max_hero
end

function var_0_0.CheckHeroFightIsFull(arg_40_0)
	local var_40_0 = true

	for iter_40_0, iter_40_1 in ipairs(var_0_2.hero_list) do
		if arg_40_0:GetHeroFatigue(iter_40_1.id) < GameSetting.activity_club_sp_hero_fatigue_max.value[1] then
			var_40_0 = false

			break
		end
	end

	return var_40_0
end

function var_0_0.HaveTakeOnFightNum(arg_41_0)
	return #var_0_2.hero_list
end

function var_0_0.IsMyOccupiedNode(arg_42_0, arg_42_1)
	return var_0_2.grid_dic[arg_42_1] ~= nil and var_0_2.grid_dic[arg_42_1].is_occupied > 0
end

function var_0_0.IsNodeCanReach(arg_43_0, arg_43_1)
	local var_43_0 = {}
	local var_43_1 = {}

	return (arg_43_0:HandleNode1(arg_43_1, arg_43_1, var_43_0, var_43_1))
end

function var_0_0.HandleNode(arg_44_0, arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
	local var_44_0 = ActivityClubSPCfg[arg_44_2]

	if arg_44_2 == arg_44_1 then
		for iter_44_0 = #arg_44_3, 1, -1 do
			table.insert(arg_44_5, arg_44_3[iter_44_0])
		end

		table.insert(arg_44_5, arg_44_2)

		return true
	end

	if table.indexof(arg_44_3, arg_44_2) then
		return false
	end

	if table.indexof(arg_44_4, arg_44_2) then
		return false
	end

	local var_44_1 = false

	if var_44_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_44_2) then
		var_44_1 = true
	elseif var_44_0.type == 3 then
		local var_44_2 = var_44_0.map_id
		local var_44_3 = GuildActivitySPData:GetCurRunActivityID()
		local var_44_4 = ActivityClubSPMapCfg.get_id_list_by_activity[var_44_3]

		if table.indexof(var_44_4, var_44_2) < #var_0_2.spawn_id_list then
			var_44_1 = true
		end
	elseif var_0_3[arg_44_2] and var_0_3[arg_44_2].occupied_num > 0 then
		var_44_1 = true
	end

	if not var_44_1 then
		return false
	end

	table.insert(arg_44_3, arg_44_2)

	local var_44_5 = false

	for iter_44_1, iter_44_2 in ipairs(var_44_0.neighbours) do
		if arg_44_0:HandleNode(arg_44_1, iter_44_2, arg_44_3, arg_44_4, arg_44_5) then
			var_44_5 = true

			break
		end
	end

	return var_44_5
end

function var_0_0.HandleNode1(arg_45_0, arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	local var_45_0 = ActivityClubSPCfg[arg_45_2]
	local var_45_1 = var_0_2.grid_dic[arg_45_2] and var_0_2.grid_dic[arg_45_2].is_occupied > 0

	if var_45_0.type == 4 then
		local var_45_2 = var_45_0.map_id
		local var_45_3 = GuildActivitySPData:GetCurRunActivityID()
		local var_45_4 = ActivityClubSPMapCfg.get_id_list_by_activity[var_45_3]

		if table.indexof(var_45_4, var_45_2) < #var_0_2.spawn_id_list then
			var_45_1 = true
		end
	elseif var_45_0.type == 3 and var_0_3[arg_45_2] and var_0_3[arg_45_2].health <= 0 then
		var_45_1 = true
	elseif var_45_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_45_2) then
		var_45_1 = true
	end

	if var_45_1 then
		return true
	end

	if table.indexof(arg_45_3, arg_45_2) then
		return false
	end

	if table.indexof(arg_45_4, arg_45_2) then
		return false
	end

	local var_45_5 = false

	if arg_45_1 == arg_45_2 and var_45_0.type ~= 0 then
		var_45_5 = true
	elseif var_45_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_45_2) then
		var_45_5 = true
	elseif var_45_0.type == 4 then
		local var_45_6 = var_45_0.map_id
		local var_45_7 = GuildActivitySPData:GetCurRunActivityID()
		local var_45_8 = ActivityClubSPMapCfg.get_id_list_by_activity[var_45_7]

		if table.indexof(var_45_8, var_45_6) < #var_0_2.spawn_id_list then
			var_45_5 = true

			return var_45_5
		end
	elseif var_0_2.grid_dic[arg_45_2] and var_0_2.grid_dic[arg_45_2].is_occupied > 0 then
		var_45_5 = true
	end

	if not var_45_5 then
		return false
	end

	table.insert(arg_45_3, arg_45_2)

	local var_45_9 = false

	for iter_45_0, iter_45_1 in ipairs(var_45_0.neighbours) do
		if arg_45_0:HandleNode1(arg_45_1, iter_45_1, arg_45_3, arg_45_4) then
			var_45_9 = true

			break
		end
	end

	return var_45_9
end

function var_0_0.GetMySpawnNodeId(arg_46_0, arg_46_1)
	return var_0_2.spawn_id_list[arg_46_1]
end

function var_0_0.HaveRegister(arg_47_0)
	return var_0_5 > 0
end

function var_0_0.OnGridGiveUp(arg_48_0, arg_48_1)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_ON_GRID_CANCEL_OCCUPYING, arg_48_1)
end

function var_0_0.OnGridCancelOccupy(arg_49_0, arg_49_1)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_ON_GRID_CANCEL_OCCUPYING, arg_49_1)
end

function var_0_0.HaveBossBeKilled(arg_50_0, arg_50_1)
	local var_50_0 = ActivityClubSPCfg.get_id_list_by_map_id[arg_50_1]

	for iter_50_0, iter_50_1 in ipairs(var_50_0) do
		if ActivityClubSPCfg[iter_50_1].type == 3 and var_0_3[iter_50_1] and var_0_3[iter_50_1].occupied_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0.HaveBigBossBeKilled(arg_51_0, arg_51_1)
	local var_51_0 = ActivityClubSPCfg.get_id_list_by_map_id[arg_51_1]

	for iter_51_0, iter_51_1 in ipairs(var_51_0) do
		if ActivityClubSPCfg[iter_51_1].type == 4 and var_0_3[iter_51_1] and var_0_3[iter_51_1].occupied_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetBigBossNode(arg_52_0, arg_52_1)
	local var_52_0 = ActivityClubSPCfg.get_id_list_by_map_id[arg_52_1]

	for iter_52_0, iter_52_1 in ipairs(var_52_0) do
		if ActivityClubSPCfg[iter_52_1].type == 4 then
			return iter_52_1, var_0_3[iter_52_1]
		end
	end

	return 0, nil
end

function var_0_0.GetCurRateID(arg_53_0, arg_53_1, arg_53_2)
	local var_53_0 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_53_1]
	local var_53_1 = var_53_0[1]

	for iter_53_0 = 2, #var_53_0 do
		local var_53_2 = ActivityClubSPLevelSettingCfg[var_53_0[iter_53_0]].condition
		local var_53_3 = true

		for iter_53_1, iter_53_2 in ipairs(var_53_2) do
			var_53_3 = IsConditionAchieved(iter_53_2)

			if not var_53_3 then
				break
			end
		end

		if not var_53_3 then
			break
		end

		var_53_1 = var_53_0[iter_53_0]
	end

	arg_53_0.curRateID_ = var_53_1

	if arg_53_2 == true and arg_53_0.preRateID_ == nil then
		arg_53_0.preRateID_ = var_53_1
	end

	return arg_53_0.curRateID_, arg_53_0.preRateID_
end

function var_0_0.CheckRateUpgrade(arg_54_0, arg_54_1)
	local var_54_0, var_54_1 = arg_54_0:GetCurRateID(arg_54_1, true)

	if var_54_0 ~= ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_54_1][1] and var_54_0 ~= var_54_1 then
		arg_54_0.preRateID_ = var_54_0

		return true, var_54_0
	end

	return false
end

function var_0_0.GetSortedRateIDList(arg_55_0, arg_55_1)
	local var_55_0 = {}
	local var_55_1 = {}
	local var_55_2 = {}
	local var_55_3 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_55_1]
	local var_55_4 = {}

	for iter_55_0 = 2, #var_55_3 do
		var_55_4[#var_55_4 + 1] = var_55_3[iter_55_0]
	end

	local var_55_5 = {}
	local var_55_6 = arg_55_0:GetCurRateID(arg_55_1)
	local var_55_7 = ActivityClubSPLevelSettingCfg[var_55_6].user_level

	for iter_55_1, iter_55_2 in ipairs(var_55_4) do
		if var_55_7 >= ActivityClubSPLevelSettingCfg[iter_55_2].user_level and table.keyof(var_55_5, ActivityClubSPLevelSettingCfg[iter_55_2].user_level) == nil then
			table.insert(var_55_0, iter_55_2)
		elseif var_55_7 < ActivityClubSPLevelSettingCfg[iter_55_2].user_level then
			table.insert(var_55_1, iter_55_2)
		elseif table.keyof(var_55_5, ActivityClubSPLevelSettingCfg[iter_55_2].user_level) ~= nil then
			table.insert(var_55_2, iter_55_2)
		end
	end

	table.insertto(var_55_0, var_55_1)
	table.insertto(var_55_0, var_55_2)

	return var_55_0
end

function var_0_0.SetReceivedList(arg_56_0, arg_56_1, arg_56_2)
	local var_56_0 = ActivityClubSPLevelSettingCfg[arg_56_2].user_level

	table.insert(var_0_2.receive_list, var_56_0)
	arg_56_0:RefreshRateRedPoint(arg_56_1)
end

function var_0_0.GetReceivedList(arg_57_0)
	return var_0_2.receive_list
end

function var_0_0.RefreshRateRedPoint(arg_58_0, arg_58_1)
	local var_58_0 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_58_1]
	local var_58_1 = arg_58_0:GetCurRateID(arg_58_1)
	local var_58_2 = ActivityClubSPLevelSettingCfg[var_58_1].user_level
	local var_58_3 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_RATE, arg_58_1)
	local var_58_4

	for iter_58_0 = 2, #var_58_0 do
		if var_58_2 >= ActivityClubSPLevelSettingCfg[var_58_0[iter_58_0]].user_level then
			manager.redPoint:setTip(var_58_3, 1)

			return
		end
	end

	manager.redPoint:setTip(var_58_3, 0)
end

function var_0_0.GetSelectRaceID(arg_59_0, arg_59_1)
	return getData("Guild_Activity_SelectRaceID", tostring(arg_59_1))
end

function var_0_0.SetSelectRaceID(arg_60_0, arg_60_1, arg_60_2)
	saveData("Guild_Activity_SelectRaceID", tostring(arg_60_1), arg_60_2)
end

function var_0_0.GetSelectAffixID(arg_61_0, arg_61_1, arg_61_2)
	return getData(string.format("Guild_Activity_%d_SelectAffixID", arg_61_1), tostring(arg_61_2))
end

function var_0_0.SetSelectAffixID(arg_62_0, arg_62_1, arg_62_2, arg_62_3)
	saveData(string.format("Guild_Activity_%d_SelectAffixID", arg_62_1), tostring(arg_62_2), arg_62_3)
end

function var_0_0.GetUnLockAffixList(arg_63_0)
	return var_0_2.talent_list
end

function var_0_0.UpgradeAffix(arg_64_0, arg_64_1, arg_64_2)
	if var_0_2.talent_list[arg_64_2] == nil then
		var_0_2.talent_list[arg_64_2] = {
			level = 1,
			id = arg_64_2
		}
	else
		local var_64_0 = var_0_2.talent_list[arg_64_2].level + 1
		local var_64_1 = TalentTreeCfg[arg_64_2].max_level

		var_64_0 = var_64_0 <= var_64_1 and var_64_0 or var_64_1
		var_0_2.talent_list[arg_64_2].level = var_64_0
	end

	arg_64_0:RefreshAffixRedPoint()
end

function var_0_0.RefreshAffixRedPoint(arg_65_0)
	local var_65_0 = GuildActivitySPTools.GetCurActivityIDInfo(var_0_6).start
	local var_65_1 = TalentTreeCfg.get_id_list_by_activity_id[var_65_0]

	if var_65_1 then
		local var_65_2 = TalentTreeCfg[var_65_1[1]].cost[1][1]
		local var_65_3 = ItemTools.getItemNum(var_65_2) or 0
		local var_65_4
		local var_65_5
		local var_65_6
		local var_65_7 = false

		for iter_65_0, iter_65_1 in ipairs(var_65_1) do
			local var_65_8 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, var_65_0, TalentTreeCfg[iter_65_1].race, iter_65_1)

			if var_0_2.talent_list[iter_65_1] then
				var_65_4 = var_0_2.talent_list[iter_65_1].level + 1
			else
				var_65_4 = 1
			end

			if TalentTreeCfg[iter_65_1].cost[var_65_4] ~= nil then
				var_65_5 = TalentTreeCfg[iter_65_1].cost[var_65_4][2]
			else
				var_65_5 = -1
			end

			if var_65_5 ~= -1 and var_65_5 <= var_65_3 then
				manager.redPoint:setTip(var_65_8, 1)

				var_65_7 = true
			else
				manager.redPoint:setTip(var_65_8, 0)
			end
		end

		return var_65_7
	end
end

function var_0_0.SetTempEffectiveAffixList(arg_66_0, arg_66_1)
	arg_66_0.effectiveAffixIDList_ = arg_66_1
end

function var_0_0.GetTempEffectiveAffixList(arg_67_0, arg_67_1)
	return arg_67_0.effectiveAffixIDList_ or {}
end

function var_0_0.IsAllAffixMax(arg_68_0, arg_68_1)
	local var_68_0 = TalentTreeCfg.get_id_list_by_activity_id[arg_68_1]

	if var_68_0 then
		for iter_68_0, iter_68_1 in ipairs(var_68_0) do
			if var_0_2.talent_list[iter_68_1] then
				if TalentTreeCfg[iter_68_1].max_level > var_0_2.talent_list[iter_68_1].level then
					return false
				end
			else
				return false
			end
		end

		return true
	end
end

function var_0_0.SetRankData(arg_69_0, arg_69_1)
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in ipairs(arg_69_1.records or {}) do
		local var_69_1 = GuildActivityRankStruct.New(iter_69_1)

		table.insert(var_69_0, var_69_1)
	end

	var_0_1 = {}
	var_0_1.rankList = var_69_0

	table.sort(var_0_1.rankList, function(arg_70_0, arg_70_1)
		if arg_70_0.score == arg_70_1.score then
			if arg_70_0.time_stamp == arg_70_1.time_stamp then
				return arg_70_0.user_id > arg_70_1.user_id
			else
				return arg_70_0.time_stamp < arg_70_1.time_stamp
			end
		else
			return arg_70_0.score > arg_70_1.score
		end
	end)

	for iter_69_2, iter_69_3 in ipairs(var_0_1.rankList) do
		iter_69_3.rank = iter_69_2
	end
end

function var_0_0.GetRankList(arg_71_0)
	return var_0_1.rankList or {}
end

function var_0_0.OnDispatch(arg_72_0, arg_72_1, arg_72_2)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_DISPATCHED, arg_72_1, arg_72_2)
end

function var_0_0.GetDispatchCatNum(arg_73_0)
	local var_73_0 = 0

	for iter_73_0, iter_73_1 in pairs(var_0_2.grid_dic) do
		if iter_73_1.dispatch_cat_id and iter_73_1.dispatch_cat_id ~= 0 then
			var_73_0 = var_73_0 + 1
		end
	end

	return var_73_0
end

function var_0_0.OnCancelDispatch(arg_74_0, arg_74_1)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_CANCEL_DISPATCH, arg_74_1)
end

function var_0_0.IsDispatched(arg_75_0, arg_75_1)
	return arg_75_0:GetSelfNodeData(arg_75_1).dispatch_cat_id > 0
end

function var_0_0.IsDispatchMax(arg_76_0, arg_76_1)
	return arg_76_0:GetNodeData(arg_76_1).dispatch_num >= 10
end

function var_0_0.GetAllDispatchCatList(arg_77_0)
	local var_77_0 = ActivityClubSPLevelSettingCfg.all[#ActivityClubSPLevelSettingCfg.all]

	return ActivityClubSPLevelSettingCfg[var_77_0].dispatch
end

function var_0_0.GetCanDispatchCatList(arg_78_0)
	local var_78_0 = var_0_0:GetCurRunActivityID()
	local var_78_1 = arg_78_0:GetCurRateID(var_78_0)

	return ActivityClubSPLevelSettingCfg[var_78_1].dispatch
end

function var_0_0.IsCatDispatched(arg_79_0, arg_79_1)
	for iter_79_0, iter_79_1 in pairs(var_0_2.grid_dic) do
		if iter_79_1.dispatch_cat_id == arg_79_1 then
			return true, iter_79_1.id
		end
	end

	return false, 0
end

function var_0_0.IsAllLittleBossPass(arg_80_0, arg_80_1)
	local var_80_0 = ActivityClubSPCfg.get_id_list_by_map_id[arg_80_1]

	for iter_80_0, iter_80_1 in ipairs(var_80_0) do
		if ActivityClubSPCfg[iter_80_1].type == 3 then
			if arg_80_0:GetNodeData(iter_80_1) == nil then
				return 0
			end

			if arg_80_0:GetNodeData(iter_80_1).health > 0 then
				return 0
			end
		end
	end

	return 1
end

function var_0_0.GetNowStage(arg_81_0)
	local var_81_0 = var_0_0:GetCurRunActivityID()

	if var_81_0 and ActivityData:GetActivityIsOpen(var_81_0) then
		local var_81_1 = manager.time:GetServerTime()
		local var_81_2 = ActivityData:GetActivityData(var_81_0)
		local var_81_3 = var_81_2.startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600
		local var_81_4 = var_81_2.stopTime

		if var_81_3 < var_81_1 then
			return 2
		else
			return 1
		end
	else
		return 0
	end
end

function var_0_0.GetCatUnlockLevel(arg_82_0, arg_82_1)
	for iter_82_0, iter_82_1 in ipairs(ActivityClubSPLevelSettingCfg.all) do
		local var_82_0 = ActivityClubSPLevelSettingCfg[iter_82_1]

		if table.indexof(var_82_0.dispatch, arg_82_1) then
			return var_82_0.user_level
		end
	end
end

return var_0_0
