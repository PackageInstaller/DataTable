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

local var_0_0 = singletonClass("GuildActivityData")
local var_0_1 = {}
local var_0_2 = {}
local var_0_3 = {}
local var_0_4 = {}
local var_0_5 = 0

function var_0_0.Init(arg_2_0)
	var_0_5 = 0
	var_0_4 = {}
	var_0_2 = {
		benchmark_time = 0,
		current_grid = 1,
		is_init_hero_list = 0,
		spawn_id_list = {},
		grid_list = {},
		talent_list = {},
		receive_list = {},
		grid_dic = {},
		hero_list = {},
		max_node_id = ActivityClubCfg.all[#ActivityClubCfg.all]
	}
end

function var_0_0.InitMainDataFromServer(arg_3_0, arg_3_1)
	var_0_2 = {
		current_grid = arg_3_1.stay_id,
		last_receive_time = arg_3_1.last_receive_time,
		is_init_hero_list = arg_3_1.is_init_hero_list,
		benchmark_time = arg_3_1.benchmark_time
	}
	var_0_2.hero_list = {}
	var_0_2.hero_dic = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.hero_list) do
		local var_3_0 = {
			id = iter_3_1.id,
			fatigue = iter_3_1.fatigue,
			last_update_time = iter_3_1.last_update_time
		}

		var_0_2.hero_dic[iter_3_1.id] = var_3_0

		table.insert(var_0_2.hero_list, var_3_0)
	end

	var_0_2.spawn_id_list = {}

	for iter_3_2, iter_3_3 in ipairs(arg_3_1.spawn_id_list) do
		if not table.indexof(var_0_2.spawn_id_list, iter_3_3) then
			table.insert(var_0_2.spawn_id_list, iter_3_3)
		end
	end

	table.sort(var_0_2.spawn_id_list, function(arg_4_0, arg_4_1)
		return arg_4_0 < arg_4_1
	end)

	var_0_2.grid_dic = {}

	for iter_3_4, iter_3_5 in ipairs(arg_3_1.grid_list) do
		local var_3_1 = {
			id = iter_3_5.id,
			occupied_timestamp = iter_3_5.occupied_timestamp,
			processing_type = iter_3_5.processing_type,
			processing_timestamp = iter_3_5.processing_timestamp,
			elite_health_rate = iter_3_5.elite_health_rate
		}

		var_0_2.grid_dic[var_3_1.id] = var_3_1
	end

	var_0_2.talent_list = {}

	for iter_3_6, iter_3_7 in ipairs(arg_3_1.talent_list) do
		var_0_2.talent_list[iter_3_7.id] = {}
		var_0_2.talent_list[iter_3_7.id] = {
			id = iter_3_7.id,
			level = iter_3_7.level
		}
	end

	arg_3_0:RefreshAffixRedPoint(ActivityConst.GUILD_ACTIVITY_START)

	var_0_2.receive_list = {}

	for iter_3_8, iter_3_9 in ipairs(arg_3_1.receive_list) do
		table.insert(var_0_2.receive_list, iter_3_9)
	end
end

function var_0_0.InitGridsDataFromServer(arg_5_0, arg_5_1)
	var_0_3 = {}

	local var_5_0 = arg_5_0:CreateDefaultDataList()
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		var_5_1[iter_5_1.id] = iter_5_1
	end

	for iter_5_2, iter_5_3 in ipairs(ActivityClubCfg.all) do
		local var_5_2 = ActivityClubCfg[iter_5_3]

		if var_5_2.type ~= 0 then
			local var_5_3 = var_5_1[iter_5_3]

			if iter_5_3 == 11999 then
				CustomLog.Log(debug.traceback(string.format("11999")))
			end

			local var_5_4

			if var_5_3 then
				var_5_4 = {
					id = iter_5_3,
					occupied_num = var_5_3.occupied_num,
					processing_num = var_5_3.processing_num,
					health = var_5_3.health,
					history_occupied_num = var_5_3.history_occupied_num
				}
			else
				var_5_4 = {
					history_occupied_num = 0,
					processing_num = 0,
					occupied_num = 0,
					id = iter_5_3,
					health = var_5_2.boss_score
				}
			end

			var_0_3[var_5_4.id] = var_5_4

			local var_5_5 = arg_5_0:CreateNodeData(var_5_4.id)

			var_5_5.occupied_num = var_5_4.occupied_num
			var_5_5.processing_num = var_5_4.processing_num
			var_5_5.health = math.floor(var_5_4.health / 100)

			if var_5_5.health == 0 and var_5_4.health > 0 then
				var_5_5.health = 1
			end

			if var_0_2.grid_dic[var_5_4.id] then
				if var_0_2.grid_dic[var_5_4.id].occupied_timestamp > 0 then
					var_5_5.myOccupiedTimestamp = var_0_2.grid_dic[var_5_4.id].occupied_timestamp
				end

				if var_0_2.grid_dic[var_5_4.id].processing_type > 0 then
					var_5_5.processingType = var_0_2.grid_dic[var_5_4.id].processing_type
				end

				if var_0_2.grid_dic[var_5_4.id].processing_timestamp > 0 then
					var_5_5.myProcessingTimestamp = var_0_2.grid_dic[var_5_4.id].processing_timestamp
				end
			end

			var_5_0.dataList:Add(var_5_5)
		end
	end

	manager.notify:Invoke(INIT_GUILD_ACTIVITY_MAIN_DATA, {})

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(var_5_0, true)
	end
end

function var_0_0.InitFightRecordFromServer(arg_6_0, arg_6_1)
	var_0_4 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		local var_6_0 = {
			uid = iter_6_1.uid,
			icon = iter_6_1.icon,
			icon_frame = iter_6_1.icon_frame,
			name = iter_6_1.name,
			damage = iter_6_1.damage,
			hero_list = iter_6_1.hero_list,
			timestamp = iter_6_1.timestamp
		}

		table.insert(var_0_4, var_6_0)
	end

	table.sort(var_0_4, function(arg_7_0, arg_7_1)
		return arg_7_0.damage > arg_7_1.damage
	end)
	manager.notify:Invoke(FIGHT_RECORD_GET, {})
end

function var_0_0.UpdateSelfGridDataFromServer(arg_8_0, arg_8_1)
	if arg_8_1.spawn_id_list ~= nil and #arg_8_1.spawn_id_list > 0 then
		for iter_8_0, iter_8_1 in ipairs(arg_8_1.spawn_id_list) do
			if table.indexof(var_0_2.spawn_id_list, iter_8_1) then
				-- block empty
			else
				table.insert(var_0_2.spawn_id_list, iter_8_1)
			end
		end

		table.sort(var_0_2.spawn_id_list, function(arg_9_0, arg_9_1)
			return arg_9_0 < arg_9_1
		end)
		manager.notify:Invoke(SPAWN_ID_UPDATE, {})
	end

	local var_8_0 = arg_8_0:CreateDefaultDataList()
	local var_8_1 = arg_8_1.type
	local var_8_2 = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_1.grid_list) do
		table.insert(var_8_2, iter_8_3.id)

		if var_8_1 == 1 then
			local var_8_3 = {
				id = iter_8_3.id,
				occupied_timestamp = iter_8_3.occupied_timestamp,
				processing_type = iter_8_3.processing_type,
				processing_timestamp = iter_8_3.processing_timestamp,
				elite_health_rate = iter_8_3.elite_health_rate
			}

			var_0_2.grid_dic[iter_8_3.id] = var_8_3

			local var_8_4 = var_0_3[iter_8_3.id]

			if var_8_4 then
				local var_8_5 = arg_8_0:CreateNodeData(iter_8_3.id)

				var_8_5.occupied_num = var_8_4.occupied_num
				var_8_5.processing_num = var_8_4.processing_num
				var_8_5.health = math.floor(var_8_4.health / 100)

				if var_8_5.health == 0 and var_8_4.health > 0 then
					var_8_5.health = 1
				end

				if var_8_3 and var_8_3.occupied_timestamp > 0 then
					if var_8_3.occupied_timestamp > 0 then
						var_8_5.myOccupiedTimestamp = var_8_3.occupied_timestamp
					end

					if var_8_3.processing_type > 0 then
						var_8_5.processingType = var_8_3.processing_type
					end

					if var_8_3.processing_timestamp > 0 then
						var_8_5.myProcessingTimestamp = var_8_3.processing_timestamp
					end
				end

				var_8_0.dataList:Add(var_8_5)
			end
		else
			var_0_2.grid_dic[iter_8_3.id] = nil

			local var_8_6 = var_0_3[iter_8_3.id]

			if var_8_6 then
				local var_8_7 = arg_8_0:CreateNodeData(iter_8_3.id)

				var_8_7.occupied_num = var_8_6.occupied_num
				var_8_7.processing_num = var_8_6.processing_num
				var_8_7.health = var_8_6.health
				var_8_7.myOccupiedTimestamp = 0
				var_8_7.processingType = 0
				var_8_7.myProcessingTimestamp = 0

				var_8_0.dataList:Add(var_8_7)
			end
		end
	end

	manager.notify:Invoke(UPDATE_GRIDS_DATA, var_8_2)

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(var_8_0)
	end
end

function var_0_0.UpdateGridsDataFromServer(arg_10_0, arg_10_1)
	local var_10_0 = {}

	for iter_10_0, iter_10_1 in ipairs(arg_10_1) do
		local var_10_1 = {
			id = iter_10_1.id,
			occupied_num = iter_10_1.occupied_num,
			processing_num = iter_10_1.processing_num,
			health = iter_10_1.health,
			history_occupied_num = iter_10_1.history_occupied_num
		}

		table.insert(var_10_0, var_10_1.id)

		var_0_3[var_10_1.id] = var_10_1
	end

	manager.notify:Invoke(UPDATE_GRIDS_DATA, var_10_0)

	if GuildActivityLuaBridge.GetManager() then
		local var_10_2 = arg_10_0:CreateDefaultDataList()

		for iter_10_2, iter_10_3 in ipairs(arg_10_1) do
			local var_10_3 = arg_10_0:CreateNodeData(iter_10_3.id)

			var_10_3.occupied_num = iter_10_3.occupied_num
			var_10_3.processing_num = iter_10_3.processing_num
			var_10_3.health = math.floor(iter_10_3.health / 100)

			if var_10_3.health == 0 and iter_10_3.health > 0 then
				var_10_3.health = 1
			end

			if var_0_2.grid_dic[iter_10_3.id] then
				if var_0_2.grid_dic[iter_10_3.id].occupied_timestamp > 0 then
					var_10_3.myOccupiedTimestamp = var_0_2.grid_dic[iter_10_3.id].occupied_timestamp
				end

				if var_0_2.grid_dic[iter_10_3.id].processing_type > 0 then
					var_10_3.processingType = var_0_2.grid_dic[iter_10_3.id].processing_type
				end

				if var_0_2.grid_dic[iter_10_3.id].processing_timestamp > 0 then
					var_10_3.myProcessingTimestamp = var_0_2.grid_dic[iter_10_3.id].processing_timestamp
				end
			end

			var_10_2.dataList:Add(var_10_3)
		end

		GuildActivityLuaBridge.GetManager():UpdateNodeData(var_10_2)
	end
end

function var_0_0.GetSpawnIdList(arg_11_0)
	return var_0_2.spawn_id_list
end

function var_0_0.GetFightRecords(arg_12_0)
	return var_0_4
end

function var_0_0.CreateNodeData(arg_13_0, arg_13_1)
	local var_13_0 = GuildActivityNodeData.New()
	local var_13_1 = ActivityClubCfg[arg_13_1]

	var_13_0.id = arg_13_1
	var_13_0.map_id = var_13_1.map_id
	var_13_0.type = var_13_1.type
	var_13_0.level = var_13_1.level
	var_13_0.stage_id = var_13_1.stage_id
	var_13_0.vitality_cost = var_13_1.vitality_cost
	var_13_0.token_get = var_13_1.token_get
	var_13_0.boss_score = math.floor(var_13_1.boss_score / 100)
	var_13_0.boss_stage_hp = var_13_1.boss_stage_hp
	var_13_0.boss_name = var_13_1.boss_name

	return var_13_0
end

function var_0_0.CreateDefaultDataList(arg_14_0)
	local var_14_0 = GuildActivityNodeDataList.New()

	var_14_0.selfData.benchmark_time = var_0_2.benchmark_time
	var_14_0.selfData.coinRefreshMinutes = GameSetting.activity_club_coin_calculate_time.value[1]
	var_14_0.selfData.curNode = var_0_2.current_grid
	var_14_0.selfData.mapCount = #ActivityClubMapCfg.all
	var_14_0.selfData.myLastReceiveTimestamp = var_0_2.last_receive_time
	var_14_0.selfData.maxNodeId = ActivityClubCfg.all[#ActivityClubCfg.all]

	for iter_14_0, iter_14_1 in ipairs(var_0_2.spawn_id_list) do
		var_14_0.selfData.spawnNodeIdList:Add(iter_14_1)
	end

	local var_14_1 = {}

	for iter_14_2, iter_14_3 in pairs(ActivityClubCfg.get_id_list_by_map_id) do
		local var_14_2 = table.indexof(ActivityClubMapCfg.all, iter_14_2)
		local var_14_3 = ActivityClubCfg.get_id_list_by_map_id[iter_14_2]

		var_14_1[var_14_2] = var_14_3[#var_14_3]
	end

	for iter_14_4, iter_14_5 in ipairs(var_14_1) do
		var_14_0.selfData.bossIdList:Add(iter_14_5)
	end

	return var_14_0
end

function var_0_0.OnGetCoin(arg_15_0, arg_15_1)
	var_0_2.last_receive_time = arg_15_1

	local var_15_0 = arg_15_0:CreateDefaultDataList()

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(var_15_0)
	end
end

function var_0_0.OnSetFightMember(arg_16_0)
	var_0_2.is_init_hero_list = 1
end

function var_0_0.GetCurrentGrid(arg_17_0)
	return var_0_2.current_grid
end

function var_0_0.SetIsSignFromServer(arg_18_0, arg_18_1)
	var_0_5 = arg_18_1
end

function var_0_0.SignUpSuccess(arg_19_0)
	var_0_5 = 1
end

function var_0_0.UpdateGuildActivityHeroes(arg_20_0, arg_20_1)
	var_0_2.hero_dic = {}
	var_0_2.hero_list = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_1) do
		local var_20_0 = {
			id = iter_20_1.id,
			fatigue = iter_20_1.fatigue,
			last_update_time = iter_20_1.last_update_time
		}

		var_0_2.hero_dic[iter_20_1.id] = var_20_0

		table.insert(var_0_2.hero_list, var_20_0)
	end

	manager.notify:Invoke(GUILD_ACTIVITY_HERO_LIST_UPDATE, {})
end

function var_0_0.IsFirstConfigFightRole(arg_21_0)
	return var_0_2.is_init_hero_list == 0
end

function var_0_0.GetMyOccupiedNum(arg_22_0)
	local var_22_0 = 0

	for iter_22_0, iter_22_1 in pairs(var_0_2.grid_dic) do
		if iter_22_1.occupied_timestamp > 0 then
			var_22_0 = var_22_0 + 1
		end
	end

	return var_22_0
end

function var_0_0.GetMaxFightHeroCount(arg_23_0)
	return ActivityClubLevelSettingCfg[arg_23_0:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_hero
end

function var_0_0.GetMaxOccupyCount(arg_24_0)
	return ActivityClubLevelSettingCfg[arg_24_0:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_domain
end

function var_0_0.GetFightHeroById(arg_25_0, arg_25_1)
	return var_0_2.hero_dic[arg_25_1]
end

function var_0_0.GetHeroFatigue(arg_26_0, arg_26_1)
	if arg_26_0:IsFirstConfigFightRole() then
		return GameSetting.activity_club_hero_fatigue_max.value[1]
	end

	local var_26_0 = manager.time:GetServerTime()
	local var_26_1 = var_0_2.benchmark_time

	if var_0_2.hero_dic[arg_26_1] then
		local var_26_2 = var_0_2.hero_dic[arg_26_1].last_update_time
		local var_26_3 = GameSetting.activity_club_hero_fatigue_max.value[1]
		local var_26_4 = GameSetting.activity_club_hero_fatigue_recovery.value[1] * 60
		local var_26_5 = math.floor((var_26_0 - var_26_1) / var_26_4) - math.floor((var_26_2 - var_26_1) / var_26_4)

		return (math.min(var_0_2.hero_dic[arg_26_1].fatigue + var_26_5, var_26_3))
	else
		return 0
	end
end

function var_0_0.GetFightHeroList(arg_27_0)
	return var_0_2.hero_list
end

function var_0_0.GetMaxNodeId(arg_28_0)
	return ActivityClubCfg.all[#ActivityClubCfg.all]
end

function var_0_0.GetTotalCoinToGet(arg_29_0, arg_29_1)
	local var_29_0 = 0

	for iter_29_0, iter_29_1 in pairs(var_0_2.grid_dic) do
		local var_29_1 = ActivityClubCfg[iter_29_1.id]
		local var_29_2 = manager.time:GetServerTime()
		local var_29_3 = var_0_2.last_receive_time

		if iter_29_1.occupied_timestamp > 0 then
			local var_29_4 = math.max(var_29_3, iter_29_1.occupied_timestamp)
			local var_29_5 = var_0_2.benchmark_time
			local var_29_6 = GameSetting.activity_club_coin_calculate_time.value[1] * 60

			var_29_0 = var_29_0 + (math.floor((var_29_2 - var_29_5) / var_29_6) - math.floor((var_29_4 - var_29_5) / var_29_6)) * var_29_1.token_get / (3600 / var_29_6)
		end
	end

	return var_29_0
end

function var_0_0.GetCoinGain(arg_30_0)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(var_0_2.grid_dic) do
		local var_30_1 = ActivityClubCfg[iter_30_1.id]

		if iter_30_1.occupied_timestamp > 0 and (var_30_1.type == 1 or var_30_1.type == 2) then
			var_30_0 = var_30_0 + var_30_1.token_get
		end
	end

	return var_30_0
end

function var_0_0.GetLastReceiveTimestamp(arg_31_0)
	return var_0_2.last_receive_time
end

function var_0_0.GetSelfNodeData(arg_32_0, arg_32_1)
	return var_0_2.grid_dic[arg_32_1]
end

function var_0_0.GetNodeData(arg_33_0, arg_33_1)
	return var_0_3[arg_33_1]
end

function var_0_0.CanTakeOnFightNum(arg_34_0)
	return ActivityClubLevelSettingCfg[arg_34_0:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_hero
end

function var_0_0.HaveTakeOnFightNum(arg_35_0)
	return #var_0_2.hero_list
end

function var_0_0.IsMyOccupiedNode(arg_36_0, arg_36_1)
	return var_0_2.grid_dic[arg_36_1] ~= nil and var_0_2.grid_dic[arg_36_1].occupied_timestamp > 0
end

function var_0_0.IsNodeCanReach(arg_37_0, arg_37_1)
	local var_37_0 = {}
	local var_37_1 = {}

	return (arg_37_0:HandleNode1(arg_37_1, arg_37_1, var_37_0, var_37_1))
end

function var_0_0.ConstructPath(arg_38_0, arg_38_1, arg_38_2)
	local var_38_0 = {}
	local var_38_1 = {}
	local var_38_2 = {}

	arg_38_0:HandleNode(arg_38_2, arg_38_1, var_38_0, var_38_1, var_38_2)

	return var_38_2
end

function var_0_0.HandleNode(arg_39_0, arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
	local var_39_0 = ActivityClubCfg[arg_39_2]

	if arg_39_2 == arg_39_1 then
		for iter_39_0 = #arg_39_3, 1, -1 do
			table.insert(arg_39_5, arg_39_3[iter_39_0])
		end

		table.insert(arg_39_5, arg_39_2)

		return true
	end

	if table.indexof(arg_39_3, arg_39_2) then
		return false
	end

	if table.indexof(arg_39_4, arg_39_2) then
		return false
	end

	local var_39_1 = false

	if var_39_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_39_2) then
		var_39_1 = true
	elseif var_39_0.type == 3 then
		local var_39_2 = var_39_0.map_id

		if table.indexof(ActivityClubMapCfg.all, var_39_2) < #var_0_2.spawn_id_list then
			var_39_1 = true
		end
	elseif var_0_3[arg_39_2] and var_0_3[arg_39_2].occupied_num > 0 then
		var_39_1 = true
	end

	if not var_39_1 then
		return false
	end

	table.insert(arg_39_3, arg_39_2)

	local var_39_3 = false

	for iter_39_1, iter_39_2 in ipairs(var_39_0.neighbours) do
		if arg_39_0:HandleNode(arg_39_1, iter_39_2, arg_39_3, arg_39_4, arg_39_5) then
			var_39_3 = true

			break
		end
	end

	return var_39_3
end

function var_0_0.HandleNode1(arg_40_0, arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = ActivityClubCfg[arg_40_2]
	local var_40_1 = var_0_2.grid_dic[arg_40_2] and var_0_2.grid_dic[arg_40_2].occupied_timestamp > 0

	if var_40_0.type == 3 then
		local var_40_2 = var_40_0.map_id

		if table.indexof(ActivityClubMapCfg.all, var_40_2) < #var_0_2.spawn_id_list then
			var_40_1 = true
		end
	elseif var_40_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_40_2) then
		var_40_1 = true
	end

	if var_40_1 then
		return true
	end

	if table.indexof(arg_40_3, arg_40_2) then
		return false
	end

	if table.indexof(arg_40_4, arg_40_2) then
		return false
	end

	local var_40_3 = false

	if arg_40_1 == arg_40_2 and var_40_0.type ~= 0 then
		var_40_3 = true
	elseif var_40_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_40_2) then
		var_40_3 = true
	elseif var_40_0.type == 3 then
		local var_40_4 = var_40_0.map_id

		if table.indexof(ActivityClubMapCfg.all, var_40_4) < #var_0_2.spawn_id_list then
			var_40_3 = true
		end
	elseif var_0_3[arg_40_2] and var_0_3[arg_40_2].occupied_num > 0 then
		var_40_3 = true
	end

	if not var_40_3 then
		return false
	end

	table.insert(arg_40_3, arg_40_2)

	local var_40_5 = false

	for iter_40_0, iter_40_1 in ipairs(var_40_0.neighbours) do
		if arg_40_0:HandleNode1(arg_40_1, iter_40_1, arg_40_3, arg_40_4) then
			var_40_5 = true

			break
		end
	end

	return var_40_5
end

function var_0_0.GetMySpawnNodeId(arg_41_0, arg_41_1)
	return var_0_2.spawn_id_list[arg_41_1]
end

function var_0_0.IsMySpawnPoint(arg_42_0, arg_42_1)
	local var_42_0 = ActivityClubCfg[arg_42_1]

	if var_42_0.type ~= 0 then
		return false
	end

	if var_42_0.map_id > 101 then
		return true
	end

	if table.indexof(var_0_2.spawn_id_list, arg_42_1) then
		return true
	else
		return false
	end
end

function var_0_0.HaveRegister(arg_43_0)
	return var_0_5 > 0
end

function var_0_0.OnGridGiveUp(arg_44_0, arg_44_1)
	manager.notify:Invoke(ON_GRID_CANCEL_OCCUPYING, arg_44_1)
end

function var_0_0.OnGridOccupying(arg_45_0, arg_45_1)
	manager.notify:Invoke(ON_GRID_OCCUPYING, arg_45_1)
end

function var_0_0.OnGridCancelOccupy(arg_46_0, arg_46_1)
	manager.notify:Invoke(ON_GRID_CANCEL_OCCUPYING, arg_46_1)
end

function var_0_0.HaveBossBeKilled(arg_47_0, arg_47_1)
	local var_47_0 = ActivityClubCfg.get_id_list_by_map_id[arg_47_1]

	for iter_47_0, iter_47_1 in ipairs(var_47_0) do
		if ActivityClubCfg[iter_47_1].type == 3 and var_0_3[iter_47_1] and var_0_3[iter_47_1].occupied_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetCurRateID(arg_48_0, arg_48_1, arg_48_2)
	local var_48_0 = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_48_1]
	local var_48_1 = var_48_0[1]

	for iter_48_0 = 2, #var_48_0 do
		local var_48_2 = ActivityClubLevelSettingCfg[var_48_0[iter_48_0]].condition
		local var_48_3 = true

		for iter_48_1, iter_48_2 in ipairs(var_48_2) do
			var_48_3 = GuildActivityTools.IsConditionAchieved(iter_48_2)

			if not var_48_3 then
				break
			end
		end

		if not var_48_3 then
			break
		end

		var_48_1 = var_48_0[iter_48_0]
	end

	arg_48_0.curRateID_ = var_48_1

	if arg_48_2 == true and arg_48_0.preRateID_ == nil then
		arg_48_0.preRateID_ = var_48_1
	end

	return arg_48_0.curRateID_, arg_48_0.preRateID_
end

function var_0_0.CheckRateUpgrade(arg_49_0, arg_49_1)
	local var_49_0, var_49_1 = arg_49_0:GetCurRateID(arg_49_1, true)

	if var_49_0 ~= ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_49_1][1] and var_49_0 ~= var_49_1 then
		arg_49_0.preRateID_ = var_49_0

		return true, var_49_0
	end

	return false
end

function var_0_0.GetSortedRateIDList(arg_50_0, arg_50_1)
	local var_50_0 = {}
	local var_50_1 = {}
	local var_50_2 = {}
	local var_50_3 = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_50_1]
	local var_50_4 = {}

	for iter_50_0 = 2, #var_50_3 do
		var_50_4[#var_50_4 + 1] = var_50_3[iter_50_0]
	end

	local var_50_5 = var_0_2.receive_list
	local var_50_6 = arg_50_0:GetCurRateID(arg_50_1)
	local var_50_7 = ActivityClubLevelSettingCfg[var_50_6].user_level

	for iter_50_1, iter_50_2 in ipairs(var_50_4) do
		if var_50_7 >= ActivityClubLevelSettingCfg[iter_50_2].user_level and table.keyof(var_50_5, ActivityClubLevelSettingCfg[iter_50_2].user_level) == nil then
			table.insert(var_50_0, iter_50_2)
		elseif var_50_7 < ActivityClubLevelSettingCfg[iter_50_2].user_level then
			table.insert(var_50_1, iter_50_2)
		elseif table.keyof(var_50_5, ActivityClubLevelSettingCfg[iter_50_2].user_level) ~= nil then
			table.insert(var_50_2, iter_50_2)
		end
	end

	table.insertto(var_50_0, var_50_1)
	table.insertto(var_50_0, var_50_2)

	return var_50_0
end

function var_0_0.SetReceivedList(arg_51_0, arg_51_1, arg_51_2)
	local var_51_0 = ActivityClubLevelSettingCfg[arg_51_2].user_level

	table.insert(var_0_2.receive_list, var_51_0)
	arg_51_0:RefreshRateRedPoint(arg_51_1)
end

function var_0_0.GetReceivedList(arg_52_0)
	return var_0_2.receive_list
end

function var_0_0.RefreshRateRedPoint(arg_53_0, arg_53_1)
	local var_53_0 = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_53_1]
	local var_53_1 = var_0_2.receive_list
	local var_53_2 = arg_53_0:GetCurRateID(arg_53_1)
	local var_53_3 = ActivityClubLevelSettingCfg[var_53_2].user_level
	local var_53_4 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, arg_53_1)
	local var_53_5

	for iter_53_0 = 2, #var_53_0 do
		local var_53_6 = ActivityClubLevelSettingCfg[var_53_0[iter_53_0]].user_level

		if var_53_6 <= var_53_3 and table.keyof(var_53_1, var_53_6) == nil then
			manager.redPoint:setTip(var_53_4, 1)

			return
		end
	end

	manager.redPoint:setTip(var_53_4, 0)
end

function var_0_0.GetSelectRaceID(arg_54_0, arg_54_1)
	return getData("Guild_Activity_SelectRaceID", tostring(arg_54_1))
end

function var_0_0.SetSelectRaceID(arg_55_0, arg_55_1, arg_55_2)
	saveData("Guild_Activity_SelectRaceID", tostring(arg_55_1), arg_55_2)
end

function var_0_0.GetSelectAffixID(arg_56_0, arg_56_1, arg_56_2)
	return getData(string.format("Guild_Activity_%d_SelectAffixID", arg_56_1), tostring(arg_56_2))
end

function var_0_0.SetSelectAffixID(arg_57_0, arg_57_1, arg_57_2, arg_57_3)
	saveData(string.format("Guild_Activity_%d_SelectAffixID", arg_57_1), tostring(arg_57_2), arg_57_3)
end

function var_0_0.GetUnLockAffixList(arg_58_0)
	return var_0_2.talent_list
end

function var_0_0.UpgradeAffix(arg_59_0, arg_59_1, arg_59_2)
	if var_0_2.talent_list[arg_59_2] == nil then
		var_0_2.talent_list[arg_59_2] = {
			level = 1,
			id = arg_59_2
		}
	else
		local var_59_0 = var_0_2.talent_list[arg_59_2].level + 1
		local var_59_1 = TalentTreeCfg[arg_59_2].max_level

		var_59_0 = var_59_0 <= var_59_1 and var_59_0 or var_59_1
		var_0_2.talent_list[arg_59_2].level = var_59_0
	end

	arg_59_0:RefreshAffixRedPoint(arg_59_1)
end

function var_0_0.RefreshAffixRedPoint(arg_60_0, arg_60_1)
	local var_60_0 = TalentTreeCfg.get_id_list_by_activity_id[arg_60_1]
	local var_60_1 = TalentTreeCfg[var_60_0[1]].cost[1][1]
	local var_60_2 = ItemTools.getItemNum(var_60_1) or 0
	local var_60_3
	local var_60_4
	local var_60_5

	for iter_60_0, iter_60_1 in ipairs(var_60_0) do
		local var_60_6 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_60_1, TalentTreeCfg[iter_60_1].race, iter_60_1)

		if var_0_2.talent_list[iter_60_1] then
			var_60_3 = var_0_2.talent_list[iter_60_1].level + 1
		else
			var_60_3 = 1
		end

		if TalentTreeCfg[iter_60_1].cost[var_60_3] ~= nil then
			var_60_4 = TalentTreeCfg[iter_60_1].cost[var_60_3][2]
		else
			var_60_4 = -1
		end

		if var_60_4 ~= -1 and var_60_4 <= var_60_2 then
			manager.redPoint:setTip(var_60_6, 1)
		else
			manager.redPoint:setTip(var_60_6, 0)
		end
	end
end

function var_0_0.SetTempEffectiveAffixList(arg_61_0, arg_61_1)
	arg_61_0.effectiveAffixIDList_ = arg_61_1
end

function var_0_0.GetTempEffectiveAffixList(arg_62_0, arg_62_1)
	return arg_62_0.effectiveAffixIDList_ or {}
end

function var_0_0.IsAllAffixMax(arg_63_0, arg_63_1)
	local var_63_0 = TalentTreeCfg.get_id_list_by_activity_id[arg_63_1]

	for iter_63_0, iter_63_1 in ipairs(var_63_0) do
		if var_0_2.talent_list[iter_63_1] then
			if TalentTreeCfg[iter_63_1].max_level > var_0_2.talent_list[iter_63_1].level then
				return false
			end
		else
			return false
		end
	end

	return true
end

function var_0_0.SetRankData(arg_64_0, arg_64_1)
	local var_64_0 = {}

	for iter_64_0, iter_64_1 in ipairs(arg_64_1.records or {}) do
		local var_64_1 = GuildActivityRankStruct.New(iter_64_1)

		table.insert(var_64_0, var_64_1)
	end

	var_0_1 = {}
	var_0_1.rankList = var_64_0

	table.sort(var_0_1.rankList, function(arg_65_0, arg_65_1)
		if arg_65_0.score == arg_65_1.score then
			if arg_65_0.time_stamp == arg_65_1.time_stamp then
				return arg_65_0.user_id > arg_65_1.user_id
			else
				return arg_65_0.time_stamp < arg_65_1.time_stamp
			end
		else
			return arg_65_0.score > arg_65_1.score
		end
	end)

	for iter_64_2, iter_64_3 in ipairs(var_0_1.rankList) do
		iter_64_3.rank = iter_64_2
	end
end

function var_0_0.GetRankList(arg_66_0)
	return var_0_1.rankList or {}
end

return var_0_0
