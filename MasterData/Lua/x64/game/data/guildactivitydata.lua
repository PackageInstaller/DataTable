GuildActivityRankStruct = class("GuildActivityRankStruct")

function GuildActivityRankStruct:Ctor(arg_1_1)
	self.score = arg_1_1.damage
	self.user_id = arg_1_1.uid
	self.nick = arg_1_1.base_info.nick
	self.icon = arg_1_1.base_info.icon
	self.icon_frame = arg_1_1.base_info.icon_frame
	self.time_stamp = arg_1_1.timestamp
	self.select_hero_id_list = {}

	for iter_1_0, iter_1_1 in ipairs(arg_1_1.hero_list or {}) do
		table.insert(self.select_hero_id_list, iter_1_1)
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

function var_0_0:InitMainDataFromServer(arg_3_1)
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

	self:RefreshAffixRedPoint(ActivityConst.GUILD_ACTIVITY_START)

	var_0_2.receive_list = {}

	for iter_3_8, iter_3_9 in ipairs(arg_3_1.receive_list) do
		table.insert(var_0_2.receive_list, iter_3_9)
	end
end

function var_0_0:InitGridsDataFromServer(arg_5_1)
	var_0_3 = {}

	local var_5_0 = self:CreateDefaultDataList()
	local var_5_1 = {}

	for iter_5_0, iter_5_1 in ipairs(arg_5_1) do
		var_5_1[iter_5_1.id] = iter_5_1
	end

	for iter_5_2, iter_5_3 in ipairs(ActivityClubCfg.all) do
		if ActivityClubCfg[iter_5_3].type ~= 0 then
			if iter_5_3 == 11999 then
				CustomLog.Log(debug.traceback(string.format("11999")))
			end

			local var_5_2 = var_5_1[iter_5_3] and {
				id = iter_5_3,
				occupied_num = var_5_1[iter_5_3].occupied_num,
				processing_num = var_5_1[iter_5_3].processing_num,
				health = var_5_1[iter_5_3].health,
				history_occupied_num = var_5_1[iter_5_3].history_occupied_num
			} or {
				history_occupied_num = 0,
				processing_num = 0,
				occupied_num = 0,
				id = iter_5_3,
				health = ActivityClubCfg[iter_5_3].boss_score
			}

			var_0_3[var_5_2.id] = var_5_2

			local var_5_3 = self:CreateNodeData(var_5_2.id)

			var_5_3.occupied_num = var_5_2.occupied_num
			var_5_3.processing_num = var_5_2.processing_num
			var_5_3.health = math.floor(var_5_2.health / 100)

			if var_5_3.health == 0 and var_5_2.health > 0 then
				var_5_3.health = 1
			end

			if var_0_2.grid_dic[var_5_2.id] then
				if var_0_2.grid_dic[var_5_2.id].occupied_timestamp > 0 then
					var_5_3.myOccupiedTimestamp = var_0_2.grid_dic[var_5_2.id].occupied_timestamp
				end

				if var_0_2.grid_dic[var_5_2.id].processing_type > 0 then
					var_5_3.processingType = var_0_2.grid_dic[var_5_2.id].processing_type
				end

				if var_0_2.grid_dic[var_5_2.id].processing_timestamp > 0 then
					var_5_3.myProcessingTimestamp = var_0_2.grid_dic[var_5_2.id].processing_timestamp
				end
			end

			var_5_0.dataList:Add(var_5_3)
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
		table.insert(var_0_4, {
			uid = iter_6_1.uid,
			icon = iter_6_1.icon,
			icon_frame = iter_6_1.icon_frame,
			name = iter_6_1.name,
			damage = iter_6_1.damage,
			hero_list = iter_6_1.hero_list,
			timestamp = iter_6_1.timestamp
		})
	end

	table.sort(var_0_4, function(arg_7_0, arg_7_1)
		return arg_7_0.damage > arg_7_1.damage
	end)
	manager.notify:Invoke(FIGHT_RECORD_GET, {})
end

function var_0_0:UpdateSelfGridDataFromServer(arg_8_1)
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

	local var_8_0 = self:CreateDefaultDataList()
	local var_8_1 = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_1.grid_list) do
		table.insert(var_8_1, iter_8_3.id)

		if arg_8_1.type == 1 then
			local var_8_2 = {
				id = iter_8_3.id,
				occupied_timestamp = iter_8_3.occupied_timestamp,
				processing_type = iter_8_3.processing_type,
				processing_timestamp = iter_8_3.processing_timestamp,
				elite_health_rate = iter_8_3.elite_health_rate
			}

			var_0_2.grid_dic[iter_8_3.id] = var_8_2

			if var_0_3[iter_8_3.id] then
				local var_8_3 = self:CreateNodeData(iter_8_3.id)

				var_8_3.occupied_num = var_0_3[iter_8_3.id].occupied_num
				var_8_3.processing_num = var_0_3[iter_8_3.id].processing_num
				var_8_3.health = math.floor(var_0_3[iter_8_3.id].health / 100)

				if var_8_3.health == 0 and var_0_3[iter_8_3.id].health > 0 then
					var_8_3.health = 1
				end

				if var_8_2 and var_8_2.occupied_timestamp > 0 then
					if var_8_2.occupied_timestamp > 0 then
						var_8_3.myOccupiedTimestamp = var_8_2.occupied_timestamp
					end

					if var_8_2.processing_type > 0 then
						var_8_3.processingType = var_8_2.processing_type
					end

					if var_8_2.processing_timestamp > 0 then
						var_8_3.myProcessingTimestamp = var_8_2.processing_timestamp
					end
				end

				var_8_0.dataList:Add(var_8_3)
			end
		else
			var_0_2.grid_dic[iter_8_3.id] = nil

			if var_0_3[iter_8_3.id] then
				local var_8_4 = self:CreateNodeData(iter_8_3.id)

				var_8_4.occupied_num = var_0_3[iter_8_3.id].occupied_num
				var_8_4.processing_num = var_0_3[iter_8_3.id].processing_num
				var_8_4.health = var_0_3[iter_8_3.id].health
				var_8_4.myOccupiedTimestamp = 0
				var_8_4.processingType = 0
				var_8_4.myProcessingTimestamp = 0

				var_8_0.dataList:Add(var_8_4)
			end
		end
	end

	manager.notify:Invoke(UPDATE_GRIDS_DATA, var_8_1)

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData(var_8_0)
	end
end

function var_0_0:UpdateGridsDataFromServer(arg_10_1)
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
		local var_10_2 = self:CreateDefaultDataList()

		for iter_10_2, iter_10_3 in ipairs(arg_10_1) do
			local var_10_3 = self:CreateNodeData(iter_10_3.id)

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

	var_13_0.id = arg_13_1
	var_13_0.map_id = ActivityClubCfg[arg_13_1].map_id
	var_13_0.type = ActivityClubCfg[arg_13_1].type
	var_13_0.level = ActivityClubCfg[arg_13_1].level
	var_13_0.stage_id = ActivityClubCfg[arg_13_1].stage_id
	var_13_0.vitality_cost = ActivityClubCfg[arg_13_1].vitality_cost
	var_13_0.token_get = ActivityClubCfg[arg_13_1].token_get
	var_13_0.boss_score = math.floor(ActivityClubCfg[arg_13_1].boss_score / 100)
	var_13_0.boss_stage_hp = ActivityClubCfg[arg_13_1].boss_stage_hp
	var_13_0.boss_name = ActivityClubCfg[arg_13_1].boss_name

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
		var_14_1[table.indexof(ActivityClubMapCfg.all, iter_14_2)] = ActivityClubCfg.get_id_list_by_map_id[iter_14_2][#ActivityClubCfg.get_id_list_by_map_id[iter_14_2]]
	end

	for iter_14_4, iter_14_5 in ipairs(var_14_1) do
		var_14_0.selfData.bossIdList:Add(iter_14_5)
	end

	return var_14_0
end

function var_0_0:OnGetCoin(arg_15_1)
	var_0_2.last_receive_time = arg_15_1

	if GuildActivityLuaBridge.GetManager() then
		GuildActivityLuaBridge.GetManager():UpdateNodeData((self:CreateDefaultDataList()))
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

function var_0_0:GetMaxFightHeroCount()
	return ActivityClubLevelSettingCfg[self:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_hero
end

function var_0_0:GetMaxOccupyCount()
	return ActivityClubLevelSettingCfg[self:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_domain
end

function var_0_0.GetFightHeroById(arg_25_0, arg_25_1)
	return var_0_2.hero_dic[arg_25_1]
end

function var_0_0:GetHeroFatigue(arg_26_1)
	if self:IsFirstConfigFightRole() then
		return GameSetting.activity_club_hero_fatigue_max.value[1]
	end

	if var_0_2.hero_dic[arg_26_1] then
		return (math.min(var_0_2.hero_dic[arg_26_1].fatigue + (math.floor((manager.time:GetServerTime() - var_0_2.benchmark_time) / (GameSetting.activity_club_hero_fatigue_recovery.value[1] * 60)) - math.floor((var_0_2.hero_dic[arg_26_1].last_update_time - var_0_2.benchmark_time) / (GameSetting.activity_club_hero_fatigue_recovery.value[1] * 60))), GameSetting.activity_club_hero_fatigue_max.value[1]))
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
		if iter_29_1.occupied_timestamp > 0 then
			var_29_0 = var_29_0 + (math.floor((manager.time:GetServerTime() - var_0_2.benchmark_time) / (GameSetting.activity_club_coin_calculate_time.value[1] * 60)) - math.floor((math.max(var_0_2.last_receive_time, iter_29_1.occupied_timestamp) - var_0_2.benchmark_time) / (GameSetting.activity_club_coin_calculate_time.value[1] * 60))) * ActivityClubCfg[iter_29_1.id].token_get / (3600 / (GameSetting.activity_club_coin_calculate_time.value[1] * 60))
		end
	end

	return var_29_0
end

function var_0_0.GetCoinGain(arg_30_0)
	local var_30_0 = 0

	for iter_30_0, iter_30_1 in pairs(var_0_2.grid_dic) do
		if iter_30_1.occupied_timestamp > 0 and (ActivityClubCfg[iter_30_1.id].type == 1 or ActivityClubCfg[iter_30_1.id].type == 2) then
			var_30_0 = var_30_0 + ActivityClubCfg[iter_30_1.id].token_get
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

function var_0_0:CanTakeOnFightNum()
	return ActivityClubLevelSettingCfg[self:GetCurRateID(ActivityConst.GUILD_ACTIVITY_START)].max_hero
end

function var_0_0.HaveTakeOnFightNum(arg_35_0)
	return #var_0_2.hero_list
end

function var_0_0.IsMyOccupiedNode(arg_36_0, arg_36_1)
	return var_0_2.grid_dic[arg_36_1] ~= nil and var_0_2.grid_dic[arg_36_1].occupied_timestamp > 0
end

function var_0_0:IsNodeCanReach(arg_37_1)
	return (self:HandleNode1(arg_37_1, arg_37_1, {}, {}))
end

function var_0_0:ConstructPath(arg_38_1, arg_38_2)
	local var_38_0 = {}

	self:HandleNode(arg_38_2, arg_38_1, {}, {}, var_38_0)

	return var_38_0
end

function var_0_0:HandleNode(arg_39_1, arg_39_2, arg_39_3, arg_39_4, arg_39_5)
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
		if table.indexof(ActivityClubMapCfg.all, var_39_0.map_id) < #var_0_2.spawn_id_list then
			var_39_1 = true
		end
	elseif var_0_3[arg_39_2] and var_0_3[arg_39_2].occupied_num > 0 then
		var_39_1 = true
	end

	if not var_39_1 then
		return false
	end

	table.insert(arg_39_3, arg_39_2)

	local var_39_2 = false

	for iter_39_1, iter_39_2 in ipairs(var_39_0.neighbours) do
		if self:HandleNode(arg_39_1, iter_39_2, arg_39_3, arg_39_4, arg_39_5) then
			var_39_2 = true

			break
		end
	end

	return var_39_2
end

function var_0_0:HandleNode1(arg_40_1, arg_40_2, arg_40_3, arg_40_4)
	local var_40_0 = ActivityClubCfg[arg_40_2]
	local var_40_1 = var_0_2.grid_dic[arg_40_2] and var_0_2.grid_dic[arg_40_2].occupied_timestamp > 0

	if var_40_0.type == 3 then
		if table.indexof(ActivityClubMapCfg.all, var_40_0.map_id) < #var_0_2.spawn_id_list then
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

	local var_40_2 = false

	if arg_40_1 == arg_40_2 and var_40_0.type ~= 0 then
		var_40_2 = true
	elseif var_40_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_40_2) then
		var_40_2 = true
	elseif var_40_0.type == 3 then
		if table.indexof(ActivityClubMapCfg.all, var_40_0.map_id) < #var_0_2.spawn_id_list then
			var_40_2 = true
		end
	elseif var_0_3[arg_40_2] and var_0_3[arg_40_2].occupied_num > 0 then
		var_40_2 = true
	end

	if not var_40_2 then
		return false
	end

	table.insert(arg_40_3, arg_40_2)

	local var_40_3 = false

	for iter_40_0, iter_40_1 in ipairs(var_40_0.neighbours) do
		if self:HandleNode1(arg_40_1, iter_40_1, arg_40_3, arg_40_4) then
			var_40_3 = true

			break
		end
	end

	return var_40_3
end

function var_0_0.GetMySpawnNodeId(arg_41_0, arg_41_1)
	return var_0_2.spawn_id_list[arg_41_1]
end

function var_0_0.IsMySpawnPoint(arg_42_0, arg_42_1)
	if ActivityClubCfg[arg_42_1].type ~= 0 then
		return false
	end

	if ActivityClubCfg[arg_42_1].map_id > 101 then
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
	for iter_47_0, iter_47_1 in ipairs(ActivityClubCfg.get_id_list_by_map_id[arg_47_1]) do
		if ActivityClubCfg[iter_47_1].type == 3 and var_0_3[iter_47_1] and var_0_3[iter_47_1].occupied_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0:GetCurRateID(arg_48_1, arg_48_2)
	local var_48_0 = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_48_1][1]

	for iter_48_0 = 2, #ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_48_1] do
		local var_48_1 = true

		for iter_48_1, iter_48_2 in ipairs(ActivityClubLevelSettingCfg[ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_48_1][iter_48_0]].condition) do
			var_48_1 = GuildActivityTools.IsConditionAchieved(iter_48_2)

			if not var_48_1 then
				break
			end
		end

		if not var_48_1 then
			break
		end

		var_48_0 = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_48_1][iter_48_0]
	end

	self.curRateID_ = var_48_0

	if arg_48_2 == true and self.preRateID_ == nil then
		self.preRateID_ = var_48_0
	end

	return self.curRateID_, self.preRateID_
end

function var_0_0:CheckRateUpgrade(arg_49_1)
	local var_49_0, var_49_1 = self:GetCurRateID(arg_49_1, true)

	if var_49_0 ~= ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_49_1][1] and var_49_0 ~= var_49_1 then
		self.preRateID_ = var_49_0

		return true, var_49_0
	end

	return false
end

function var_0_0:GetSortedRateIDList(arg_50_1)
	local var_50_0 = {}
	local var_50_1 = {}
	local var_50_2 = {}
	local var_50_3 = {}

	for iter_50_0 = 2, #ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_50_1] do
		var_50_3[#var_50_3 + 1] = ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_50_1][iter_50_0]
	end

	local var_50_4 = ActivityClubLevelSettingCfg[self:GetCurRateID(arg_50_1)].user_level

	for iter_50_1, iter_50_2 in ipairs(var_50_3) do
		if var_50_4 >= ActivityClubLevelSettingCfg[iter_50_2].user_level and table.keyof(var_0_2.receive_list, ActivityClubLevelSettingCfg[iter_50_2].user_level) == nil then
			table.insert(var_50_0, iter_50_2)
		elseif var_50_4 < ActivityClubLevelSettingCfg[iter_50_2].user_level then
			table.insert(var_50_1, iter_50_2)
		elseif table.keyof(var_0_2.receive_list, ActivityClubLevelSettingCfg[iter_50_2].user_level) ~= nil then
			table.insert(var_50_2, iter_50_2)
		end
	end

	table.insertto(var_50_0, var_50_1)
	table.insertto(var_50_0, var_50_2)

	return var_50_0
end

function var_0_0:SetReceivedList(arg_51_1, arg_51_2)
	table.insert(var_0_2.receive_list, ActivityClubLevelSettingCfg[arg_51_2].user_level)
	self:RefreshRateRedPoint(arg_51_1)
end

function var_0_0.GetReceivedList(arg_52_0)
	return var_0_2.receive_list
end

function var_0_0:RefreshRateRedPoint(arg_53_1)
	local var_53_0 = ActivityClubLevelSettingCfg[self:GetCurRateID(arg_53_1)].user_level
	local var_53_1 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_RATE, arg_53_1)

	for iter_53_0 = 2, #ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_53_1] do
		if ActivityClubLevelSettingCfg[ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_53_1][iter_53_0]].user_level <= var_53_0 and table.keyof(var_0_2.receive_list, ActivityClubLevelSettingCfg[ActivityClubLevelSettingCfg.get_id_list_by_activity[arg_53_1][iter_53_0]].user_level) == nil then
			manager.redPoint:setTip(var_53_1, 1)

			return
		end
	end

	manager.redPoint:setTip(var_53_1, 0)
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

function var_0_0:UpgradeAffix(arg_59_1, arg_59_2)
	if var_0_2.talent_list[arg_59_2] == nil then
		var_0_2.talent_list[arg_59_2] = {
			level = 1,
			id = arg_59_2
		}
	else
		local var_59_0 = var_0_2.talent_list[arg_59_2].level + 1

		var_59_0 = var_0_2.talent_list[arg_59_2].level + 1 <= TalentTreeCfg[arg_59_2].max_level and var_59_0 or TalentTreeCfg[arg_59_2].max_level
		var_0_2.talent_list[arg_59_2].level = var_59_0
	end

	self:RefreshAffixRedPoint(arg_59_1)
end

function var_0_0.RefreshAffixRedPoint(arg_60_0, arg_60_1)
	local var_60_0 = ItemTools.getItemNum(TalentTreeCfg[TalentTreeCfg.get_id_list_by_activity_id[arg_60_1][1]].cost[1][1]) or 0
	local var_60_1
	local var_60_2

	for iter_60_0, iter_60_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[arg_60_1]) do
		local var_60_4 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_AFFIX, arg_60_1, TalentTreeCfg[iter_60_1].race, iter_60_1)

		var_60_1 = var_0_2.talent_list[iter_60_1] and var_0_2.talent_list[iter_60_1].level + 1 or 1
		var_60_2 = TalentTreeCfg[iter_60_1].cost[var_60_1] ~= nil and TalentTreeCfg[iter_60_1].cost[var_60_1][2] or -1

		if var_60_2 ~= -1 and var_60_2 <= var_60_0 then
			manager.redPoint:setTip(var_60_4, 1)
		else
			manager.redPoint:setTip(var_60_4, 0)
		end
	end
end

function var_0_0.SetTempEffectiveAffixList(arg_61_0, arg_61_1)
	arg_61_0.effectiveAffixIDList_ = arg_61_1
end

function var_0_0:GetTempEffectiveAffixList(arg_62_1)
	return self.effectiveAffixIDList_ or {}
end

function var_0_0.IsAllAffixMax(arg_63_0, arg_63_1)
	for iter_63_0, iter_63_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[arg_63_1]) do
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
		table.insert(var_64_0, (GuildActivityRankStruct.New(iter_64_1)))
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
