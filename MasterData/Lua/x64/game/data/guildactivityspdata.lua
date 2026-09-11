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

function var_0_0:InitMainDataFromServer(arg_4_1)
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
			is_occupied = iter_4_5.is_occupied
		}

		var_4_1.dispatch_cat_id = iter_4_5.dispatch_cat_id or 0
		var_4_1.dispatch_time = iter_4_5.dispatch_time or 0
		var_4_1.elite_health_rate = iter_4_5.elite_health_rate
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

	self:RefreshAffixRedPoint()

	var_0_2.receive_list = {}

	for iter_4_8, iter_4_9 in ipairs(arg_4_1.receive_list) do
		table.insert(var_0_2.receive_list, iter_4_9)
	end
end

function var_0_0:InitGridsDataFromServer(arg_6_1)
	var_0_3 = {}

	local var_6_0 = self:CreateDefaultDataList()
	local var_6_1 = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		var_6_1[iter_6_1.id] = iter_6_1
	end

	local var_6_2 = ActivityClubSPCfg.get_id_list_by_activity[self:GetCurRunActivityID()]

	if var_6_2 then
		for iter_6_2, iter_6_3 in ipairs(var_6_2) do
			if ActivityClubSPCfg[iter_6_3].type ~= 0 then
				local var_6_3

				if var_6_1[iter_6_3] then
					local var_6_4 = {
						id = iter_6_3,
						occupied_num = var_6_1[iter_6_3].occupied_num
					}

					var_6_4.health = var_6_1[iter_6_3].health or ActivityClubSPCfg[iter_6_3].boss_score
					var_6_4.dispatch_num = var_6_1[iter_6_3].dispatch_num
					var_6_3 = var_6_4
				else
					var_6_3 = {
						dispatch_num = 0,
						occupied_num = 0,
						id = iter_6_3,
						health = ActivityClubSPCfg[iter_6_3].boss_score
					}
				end

				var_0_3[var_6_3.id] = var_6_3

				local var_6_5 = self:CreateNodeData(var_6_3.id)

				var_6_5.occupied_num = var_6_3.occupied_num
				var_6_5.health = math.floor(var_6_3.health / 100)

				if var_6_5.health == 0 and var_6_3.health > 0 then
					var_6_5.health = 1
				end

				var_6_5.is_occupied = var_0_2.grid_dic[var_6_3.id] and var_0_2.grid_dic[var_6_3.id].is_occupied > 0 and var_0_2.grid_dic[var_6_3.id].is_occupied or 0
				var_6_5.eliteHealthRate = var_0_2.grid_dic[var_6_3.id] and var_0_2.grid_dic[var_6_3.id].elite_health_rate > 0 and var_0_2.grid_dic[var_6_3.id].elite_health_rate or 0
				var_6_5.myDispatchCatId = var_0_2.grid_dic[var_6_3.id] and var_0_2.grid_dic[var_6_3.id].dispatch_cat_id > 0 and var_0_2.grid_dic[var_6_3.id].dispatch_cat_id or 0
				var_6_5.myDispatchTime = var_0_2.grid_dic[var_6_3.id] and var_0_2.grid_dic[var_6_3.id].dispatch_time > 0 and var_0_2.grid_dic[var_6_3.id].dispatch_time or 0
				var_6_5.dispatch_num = var_6_3.dispatch_num

				var_6_0.dataList:Add(var_6_5)
			end
		end

		manager.notify:Invoke(INIT_GUILD_ACTIVITY_SP_MAIN_DATA, {})
		self:UpdateBigBossStatus(var_6_0)

		if GuildActivitySPLuaBridge.GetManager() then
			GuildActivitySPLuaBridge.GetManager():UpdateNodeData(var_6_0, true)
		end
	end
end

function var_0_0.InitFightRecordFromServer(arg_7_0, arg_7_1)
	var_0_4 = {}

	for iter_7_0, iter_7_1 in ipairs(arg_7_1) do
		table.insert(var_0_4, {
			uid = iter_7_1.uid,
			icon = iter_7_1.icon,
			icon_frame = iter_7_1.icon_frame,
			name = iter_7_1.name,
			damage = iter_7_1.damage,
			hero_list = iter_7_1.hero_list,
			timestamp = iter_7_1.timestamp
		})
	end

	table.sort(var_0_4, function(arg_8_0, arg_8_1)
		return arg_8_0.damage > arg_8_1.damage
	end)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_FIGHT_RECORD_GET, {})
end

function var_0_0:UpdateSelfGridDataFromServer(arg_9_1)
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

	local var_9_0 = self:CreateDefaultDataList()
	local var_9_1 = {}

	for iter_9_2, iter_9_3 in ipairs(arg_9_1.grid_list) do
		table.insert(var_9_1, iter_9_3.id)

		if arg_9_1.type == 1 then
			local var_9_2 = {
				id = iter_9_3.id,
				is_occupied = iter_9_3.is_occupied
			}

			var_9_2.dispatch_cat_id = iter_9_3.dispatch_cat_id or 0
			var_9_2.dispatch_time = iter_9_3.dispatch_time or 0
			var_9_2.elite_health_rate = iter_9_3.elite_health_rate

			if var_9_2.id == 21128 then
				CustomLog.Log(debug.traceback(string.format("21128 is occupied = %d", var_9_2.is_occupied)))
			end

			var_0_2.grid_dic[iter_9_3.id] = var_9_2

			local var_9_3 = var_0_3[iter_9_3.id]

			if var_0_3[iter_9_3.id] then
				local var_9_4 = self:CreateNodeData(iter_9_3.id)

				var_9_4.occupied_num = var_9_3.occupied_num
				var_9_4.health = math.floor(var_9_3.health / 100)

				if var_9_4.health == 0 and var_9_3.health > 0 then
					var_9_4.health = 1
				end

				var_9_4.is_occupied = var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].is_occupied > 0 and var_0_2.grid_dic[iter_9_3.id].is_occupied or 0
				var_9_4.eliteHealthRate = var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].elite_health_rate > 0 and var_0_2.grid_dic[iter_9_3.id].elite_health_rate or 0
				var_9_4.myDispatchCatId = var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].dispatch_cat_id > 0 and var_0_2.grid_dic[iter_9_3.id].dispatch_cat_id or 0
				var_9_4.myDispatchTime = var_0_2.grid_dic[iter_9_3.id] and var_0_2.grid_dic[iter_9_3.id].dispatch_time > 0 and var_0_2.grid_dic[iter_9_3.id].dispatch_time or 0
				var_9_4.dispatch_num = var_9_3.dispatch_num

				var_9_0.dataList:Add(var_9_4)
			end
		else
			var_0_2.grid_dic[iter_9_3.id] = nil

			if var_0_3[iter_9_3.id] then
				local var_9_5 = self:CreateNodeData(iter_9_3.id)

				var_9_5.is_occupied = 0
				var_9_5.eliteHealthRate = 0
				var_9_5.occupied_num = var_0_3[iter_9_3.id].occupied_num
				var_9_5.health = var_0_3[iter_9_3.id].health
				var_9_5.myOccupiedTimestamp = 0
				var_9_5.processingType = 0
				var_9_5.myProcessingTimestamp = 0
				var_9_5.dispatch_num = 0
				var_9_5.myDispatchCatId = 0
				var_9_5.myDispatchTime = 0

				var_9_0.dataList:Add(var_9_5)
			end
		end
	end

	self:UpdateBigBossStatus(var_9_0)
	manager.notify:Invoke(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, var_9_1)

	if GuildActivitySPLuaBridge.GetManager() then
		GuildActivitySPLuaBridge.GetManager():UpdateNodeData(var_9_0)
	end
end

function var_0_0:UpdateGridsDataFromServer(arg_11_1)
	local var_11_0 = {}

	for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
		local var_11_1 = {
			id = iter_11_1.id,
			occupied_num = iter_11_1.occupied_num
		}

		var_11_1.health = iter_11_1.health or ActivityClubSPCfg[iter_11_1.id].boss_score
		var_11_1.dispatch_num = iter_11_1.dispatch_num

		table.insert(var_11_0, var_11_1.id)

		var_0_3[var_11_1.id] = var_11_1
	end

	manager.notify:Invoke(GUILD_ACTIVITY_SP_UPDATE_GRIDS_DATA, var_11_0)

	if GuildActivitySPLuaBridge.GetManager() then
		local var_11_2 = self:CreateDefaultDataList()

		for iter_11_2, iter_11_3 in ipairs(arg_11_1) do
			local var_11_3 = self:CreateNodeData(iter_11_3.id)

			var_11_3.occupied_num = iter_11_3.occupied_num
			var_11_3.health = math.floor(iter_11_3.health / 100)

			if var_11_3.health == 0 and iter_11_3.health > 0 then
				var_11_3.health = 1
			end

			var_11_3.is_occupied = var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].is_occupied > 0 and var_0_2.grid_dic[iter_11_3.id].is_occupied or 0
			var_11_3.eliteHealthRate = var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].elite_health_rate > 0 and var_0_2.grid_dic[iter_11_3.id].elite_health_rate or 0
			var_11_3.myDispatchCatId = var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].dispatch_cat_id > 0 and var_0_2.grid_dic[iter_11_3.id].dispatch_cat_id or 0
			var_11_3.myDispatchTime = var_0_2.grid_dic[iter_11_3.id] and var_0_2.grid_dic[iter_11_3.id].dispatch_time > 0 and var_0_2.grid_dic[iter_11_3.id].dispatch_time or 0
			var_11_3.dispatch_num = iter_11_3.dispatch_num

			var_11_2.dataList:Add(var_11_3)
		end

		self:UpdateBigBossStatus(var_11_2)
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

	var_14_0.id = arg_14_1
	var_14_0.map_id = ActivityClubSPCfg[arg_14_1].map_id
	var_14_0.type = ActivityClubSPCfg[arg_14_1].type
	var_14_0.level = ActivityClubSPCfg[arg_14_1].level
	var_14_0.stage_id = ActivityClubSPCfg[arg_14_1].stage_id
	var_14_0.vitality_cost = ActivityClubSPCfg[arg_14_1].vitality_cost
	var_14_0.token_get = ActivityClubSPCfg[arg_14_1].token_get
	var_14_0.boss_score = math.floor(ActivityClubSPCfg[arg_14_1].boss_score / 100)
	var_14_0.boss_stage_hp = ActivityClubSPCfg[arg_14_1].boss_stage_hp
	var_14_0.boss_name = ActivityClubSPCfg[arg_14_1].boss_name

	return var_14_0
end

function var_0_0:UpdateBigBossStatus(arg_15_1)
	for iter_15_0, iter_15_1 in pairs(ActivityClubSPCfg.get_id_list_by_map_id) do
		if self:IsAllLittleBossPass(iter_15_0) > 0 then
			arg_15_1.selfData.bigBossUnlockMapList:Add(iter_15_0)
		end
	end
end

function var_0_0.CreateDefaultDataList(arg_16_0)
	local var_16_0 = GuildActivitySPNodeDataList.New()

	var_16_0.selfData.benchmark_time = var_0_2.benchmark_time
	var_16_0.selfData.coinRefreshMinutes = GameSetting.activity_club_sp_coin_calculate_time.value[1]
	var_16_0.selfData.curNode = var_0_2.current_grid
	var_16_0.selfData.mapCount = #ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()]
	var_16_0.selfData.myLastReceiveTimestamp = var_0_2.last_receive_time
	var_16_0.selfData.maxNodeId = GuildActivitySPData:GetMaxNodeId()

	for iter_16_0, iter_16_1 in ipairs(var_0_2.spawn_id_list) do
		var_16_0.selfData.spawnNodeIdList:Add(iter_16_1)
	end

	local var_16_1 = {}

	for iter_16_2, iter_16_3 in pairs(ActivityClubSPCfg.get_id_list_by_map_id) do
		var_16_1[table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], iter_16_2)] = ActivityClubSPCfg.get_id_list_by_map_id[iter_16_2][#ActivityClubSPCfg.get_id_list_by_map_id[iter_16_2]]
	end

	for iter_16_4, iter_16_5 in ipairs(var_16_1) do
		var_16_0.selfData.bossIdList:Add(iter_16_5)
	end

	return var_16_0
end

function var_0_0:OnGetCoin(arg_17_1)
	var_0_2.last_receive_time = arg_17_1

	local var_17_0 = self:CreateDefaultDataList()

	self:UpdateBigBossStatus(var_17_0)

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

function var_0_0:GetMaxFightHeroCount()
	return ActivityClubSPLevelSettingCfg[self:GetCurRateID((GuildActivitySPData:GetCurRunActivityID()))].max_hero
end

function var_0_0.GetMaxOccupyCount(arg_29_0)
	return 99999
end

function var_0_0.GetFightHeroById(arg_30_0, arg_30_1)
	return var_0_2.hero_dic[arg_30_1]
end

function var_0_0:GetHeroFatigue(arg_31_1)
	if self:IsFirstConfigFightRole() then
		return GameSetting.activity_club_sp_hero_fatigue_max.value[1]
	end

	if var_0_2.hero_dic[arg_31_1] then
		return (math.min(var_0_2.hero_dic[arg_31_1].fatigue + (math.floor((manager.time:GetServerTime() - var_0_2.benchmark_time) / (GameSetting.activity_club_sp_hero_fatigue_recovery.value[1] * 60)) - math.floor((var_0_2.hero_dic[arg_31_1].last_update_time - var_0_2.benchmark_time) / (GameSetting.activity_club_sp_hero_fatigue_recovery.value[1] * 60))), GameSetting.activity_club_sp_hero_fatigue_max.value[1]))
	else
		return 0
	end
end

function var_0_0.GetFightHeroList(arg_32_0)
	return var_0_2.hero_list
end

function var_0_0:GetMaxNodeId()
	local var_33_0 = ActivityClubSPMapCfg.get_id_list_by_activity[self:GetCurRunActivityID()]

	if var_33_0 then
		if ActivityClubSPCfg.get_id_list_by_map_id[var_33_0[#var_33_0]] then
			for iter_33_0, iter_33_1 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[var_33_0[#var_33_0]]) do
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
		if iter_34_1.dispatch_time > 0 then
			var_34_0 = var_34_0 + (math.floor((manager.time:GetServerTime() - var_0_2.benchmark_time) / (GameSetting.activity_club_sp_coin_calculate_time.value[1] * 60)) - math.floor((math.max(var_0_2.last_receive_time, iter_34_1.dispatch_time) - var_0_2.benchmark_time) / (GameSetting.activity_club_sp_coin_calculate_time.value[1] * 60))) * ActivityClubSPCfg[iter_34_1.id].token_get / (3600 / (GameSetting.activity_club_sp_coin_calculate_time.value[1] * 60))
		end
	end

	return var_34_0
end

function var_0_0.GetCoinGain(arg_35_0)
	local var_35_0 = 0

	for iter_35_0, iter_35_1 in pairs(var_0_2.grid_dic) do
		if iter_35_1.dispatch_cat_id > 0 and (ActivityClubSPCfg[iter_35_1.id].type == 1 or ActivityClubSPCfg[iter_35_1.id].type == 2) then
			var_35_0 = var_35_0 + ActivityClubSPCfg[iter_35_1.id].token_get
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

function var_0_0:CanTakeOnFightNum()
	return ActivityClubSPLevelSettingCfg[self:GetCurRateID((var_0_0:GetCurRunActivityID()))].max_hero
end

function var_0_0:CheckHeroFightIsFull()
	local var_40_0 = true

	for iter_40_0, iter_40_1 in ipairs(var_0_2.hero_list) do
		if self:GetHeroFatigue(iter_40_1.id) < GameSetting.activity_club_sp_hero_fatigue_max.value[1] then
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

function var_0_0:IsNodeCanReach(arg_43_1)
	return (self:HandleNode1(arg_43_1, arg_43_1, {}, {}))
end

function var_0_0:HandleNode(arg_44_1, arg_44_2, arg_44_3, arg_44_4, arg_44_5)
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
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], var_44_0.map_id) < #var_0_2.spawn_id_list then
			var_44_1 = true
		end
	elseif var_0_3[arg_44_2] and var_0_3[arg_44_2].occupied_num > 0 then
		var_44_1 = true
	end

	if not var_44_1 then
		return false
	end

	table.insert(arg_44_3, arg_44_2)

	local var_44_2 = false

	for iter_44_1, iter_44_2 in ipairs(var_44_0.neighbours) do
		if self:HandleNode(arg_44_1, iter_44_2, arg_44_3, arg_44_4, arg_44_5) then
			var_44_2 = true

			break
		end
	end

	return var_44_2
end

function var_0_0:HandleNode1(arg_45_1, arg_45_2, arg_45_3, arg_45_4)
	local var_45_0 = ActivityClubSPCfg[arg_45_2]
	local var_45_1 = var_0_2.grid_dic[arg_45_2] and var_0_2.grid_dic[arg_45_2].is_occupied > 0

	if var_45_0.type == 4 then
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], var_45_0.map_id) < #var_0_2.spawn_id_list then
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

	local var_45_2 = false

	if arg_45_1 == arg_45_2 and var_45_0.type ~= 0 then
		var_45_2 = true
	elseif var_45_0.type == 0 and table.indexof(var_0_2.spawn_id_list, arg_45_2) then
		var_45_2 = true
	elseif var_45_0.type == 4 then
		if table.indexof(ActivityClubSPMapCfg.get_id_list_by_activity[GuildActivitySPData:GetCurRunActivityID()], var_45_0.map_id) < #var_0_2.spawn_id_list then
			var_45_2 = true

			return true
		end
	elseif var_0_2.grid_dic[arg_45_2] and var_0_2.grid_dic[arg_45_2].is_occupied > 0 then
		var_45_2 = true
	end

	if not var_45_2 then
		return false
	end

	table.insert(arg_45_3, arg_45_2)

	local var_45_3 = false

	for iter_45_0, iter_45_1 in ipairs(var_45_0.neighbours) do
		if self:HandleNode1(arg_45_1, iter_45_1, arg_45_3, arg_45_4) then
			var_45_3 = true

			break
		end
	end

	return var_45_3
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
	for iter_50_0, iter_50_1 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[arg_50_1]) do
		if ActivityClubSPCfg[iter_50_1].type == 3 and var_0_3[iter_50_1] and var_0_3[iter_50_1].occupied_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0.HaveBigBossBeKilled(arg_51_0, arg_51_1)
	for iter_51_0, iter_51_1 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[arg_51_1]) do
		if ActivityClubSPCfg[iter_51_1].type == 4 and var_0_3[iter_51_1] and var_0_3[iter_51_1].occupied_num > 0 then
			return true
		end
	end

	return false
end

function var_0_0.GetBigBossNode(arg_52_0, arg_52_1)
	for iter_52_0, iter_52_1 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[arg_52_1]) do
		if ActivityClubSPCfg[iter_52_1].type == 4 then
			return iter_52_1, var_0_3[iter_52_1]
		end
	end

	return 0, nil
end

function var_0_0:GetCurRateID(arg_53_1, arg_53_2)
	local var_53_0 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_53_1][1]

	for iter_53_0 = 2, #ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_53_1] do
		local var_53_1 = true

		for iter_53_1, iter_53_2 in ipairs(ActivityClubSPLevelSettingCfg[ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_53_1][iter_53_0]].condition) do
			var_53_1 = IsConditionAchieved(iter_53_2)

			if not var_53_1 then
				break
			end
		end

		if not var_53_1 then
			break
		end

		var_53_0 = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_53_1][iter_53_0]
	end

	self.curRateID_ = var_53_0

	if arg_53_2 == true and self.preRateID_ == nil then
		self.preRateID_ = var_53_0
	end

	return self.curRateID_, self.preRateID_
end

function var_0_0:CheckRateUpgrade(arg_54_1)
	local var_54_0, var_54_1 = self:GetCurRateID(arg_54_1, true)

	if var_54_0 ~= ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_54_1][1] and var_54_0 ~= var_54_1 then
		self.preRateID_ = var_54_0

		return true, var_54_0
	end

	return false
end

function var_0_0:GetSortedRateIDList(arg_55_1)
	local var_55_0 = {}
	local var_55_1 = {}
	local var_55_2 = {}
	local var_55_3 = {}

	for iter_55_0 = 2, #ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_55_1] do
		var_55_3[#var_55_3 + 1] = ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_55_1][iter_55_0]
	end

	local var_55_4 = {}
	local var_55_5 = ActivityClubSPLevelSettingCfg[self:GetCurRateID(arg_55_1)].user_level

	for iter_55_1, iter_55_2 in ipairs(var_55_3) do
		if var_55_5 >= ActivityClubSPLevelSettingCfg[iter_55_2].user_level and table.keyof(var_55_4, ActivityClubSPLevelSettingCfg[iter_55_2].user_level) == nil then
			table.insert(var_55_0, iter_55_2)
		elseif var_55_5 < ActivityClubSPLevelSettingCfg[iter_55_2].user_level then
			table.insert(var_55_1, iter_55_2)
		elseif table.keyof(var_55_4, ActivityClubSPLevelSettingCfg[iter_55_2].user_level) ~= nil then
			table.insert(var_55_2, iter_55_2)
		end
	end

	table.insertto(var_55_0, var_55_1)
	table.insertto(var_55_0, var_55_2)

	return var_55_0
end

function var_0_0:SetReceivedList(arg_56_1, arg_56_2)
	table.insert(var_0_2.receive_list, ActivityClubSPLevelSettingCfg[arg_56_2].user_level)
	self:RefreshRateRedPoint(arg_56_1)
end

function var_0_0.GetReceivedList(arg_57_0)
	return var_0_2.receive_list
end

function var_0_0:RefreshRateRedPoint(arg_58_1)
	local var_58_0 = ActivityClubSPLevelSettingCfg[self:GetCurRateID(arg_58_1)].user_level
	local var_58_1 = string.format("%s_%d", RedPointConst.GUILD_ACTIVITY_SP_RATE, arg_58_1)

	for iter_58_0 = 2, #ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_58_1] do
		if var_58_0 >= ActivityClubSPLevelSettingCfg[ActivityClubSPLevelSettingCfg.get_id_list_by_activity[arg_58_1][iter_58_0]].user_level then
			manager.redPoint:setTip(var_58_1, 1)

			return
		end
	end

	manager.redPoint:setTip(var_58_1, 0)
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

function var_0_0:UpgradeAffix(arg_64_1, arg_64_2)
	if var_0_2.talent_list[arg_64_2] == nil then
		var_0_2.talent_list[arg_64_2] = {
			level = 1,
			id = arg_64_2
		}
	else
		local var_64_0 = var_0_2.talent_list[arg_64_2].level + 1

		var_64_0 = var_0_2.talent_list[arg_64_2].level + 1 <= TalentTreeCfg[arg_64_2].max_level and var_64_0 or TalentTreeCfg[arg_64_2].max_level
		var_0_2.talent_list[arg_64_2].level = var_64_0
	end

	self:RefreshAffixRedPoint()
end

function var_0_0.RefreshAffixRedPoint(arg_65_0)
	local var_65_0 = GuildActivitySPTools.GetCurActivityIDInfo(var_0_6).start

	if TalentTreeCfg.get_id_list_by_activity_id[var_65_0] then
		local var_65_1 = ItemTools.getItemNum(TalentTreeCfg[TalentTreeCfg.get_id_list_by_activity_id[var_65_0][1]].cost[1][1]) or 0
		local var_65_2
		local var_65_3
		local var_65_5 = false

		for iter_65_0, iter_65_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[var_65_0]) do
			local var_65_6 = string.format("%s_%d_%d_%d", RedPointConst.GUILD_ACTIVITY_SP_AFFIX, var_65_0, TalentTreeCfg[iter_65_1].race, iter_65_1)

			var_65_2 = var_0_2.talent_list[iter_65_1] and var_0_2.talent_list[iter_65_1].level + 1 or 1
			var_65_3 = TalentTreeCfg[iter_65_1].cost[var_65_2] ~= nil and TalentTreeCfg[iter_65_1].cost[var_65_2][2] or -1

			if var_65_3 ~= -1 and var_65_3 <= var_65_1 then
				manager.redPoint:setTip(var_65_6, 1)

				var_65_5 = true
			else
				manager.redPoint:setTip(var_65_6, 0)
			end
		end

		return var_65_5
	end
end

function var_0_0.SetTempEffectiveAffixList(arg_66_0, arg_66_1)
	arg_66_0.effectiveAffixIDList_ = arg_66_1
end

function var_0_0:GetTempEffectiveAffixList(arg_67_1)
	return self.effectiveAffixIDList_ or {}
end

function var_0_0.IsAllAffixMax(arg_68_0, arg_68_1)
	if TalentTreeCfg.get_id_list_by_activity_id[arg_68_1] then
		for iter_68_0, iter_68_1 in ipairs(TalentTreeCfg.get_id_list_by_activity_id[arg_68_1]) do
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
		table.insert(var_69_0, (GuildActivityRankStruct.New(iter_69_1)))
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

function var_0_0:IsDispatched(arg_75_1)
	return self:GetSelfNodeData(arg_75_1).dispatch_cat_id > 0
end

function var_0_0:IsDispatchMax(arg_76_1)
	return self:GetNodeData(arg_76_1).dispatch_num >= 10
end

function var_0_0.GetAllDispatchCatList(arg_77_0)
	return ActivityClubSPLevelSettingCfg[ActivityClubSPLevelSettingCfg.all[#ActivityClubSPLevelSettingCfg.all]].dispatch
end

function var_0_0:GetCanDispatchCatList()
	return ActivityClubSPLevelSettingCfg[self:GetCurRateID((var_0_0:GetCurRunActivityID()))].dispatch
end

function var_0_0.IsCatDispatched(arg_79_0, arg_79_1)
	for iter_79_0, iter_79_1 in pairs(var_0_2.grid_dic) do
		if iter_79_1.dispatch_cat_id == arg_79_1 then
			return true, iter_79_1.id
		end
	end

	return false, 0
end

function var_0_0:IsAllLittleBossPass(arg_80_1)
	for iter_80_0, iter_80_1 in ipairs(ActivityClubSPCfg.get_id_list_by_map_id[arg_80_1]) do
		if ActivityClubSPCfg[iter_80_1].type == 3 then
			if self:GetNodeData(iter_80_1) == nil then
				return 0
			end

			if self:GetNodeData(iter_80_1).health > 0 then
				return 0
			end
		end
	end

	return 1
end

function var_0_0.GetNowStage(arg_81_0)
	local var_81_0 = var_0_0:GetCurRunActivityID()

	if var_81_0 and ActivityData:GetActivityIsOpen(var_81_0) then
		if ActivityData:GetActivityData(var_81_0).startTime + GameSetting.activity_club_sp_phase_two_open.value[1] * 24 * 3600 < manager.time:GetServerTime() then
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
		if table.indexof(ActivityClubSPLevelSettingCfg[iter_82_1].dispatch, arg_82_1) then
			return ActivityClubSPLevelSettingCfg[iter_82_1].user_level
		end
	end
end

return var_0_0
