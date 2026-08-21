local var_0_0 = {
	GRID_ENTRUST = 2,
	GRID_NORMAL = 1,
	GRID_BOSS = 3,
	GRID_BLANK = 4
}
local var_0_1 = class("PlayGridData")

local function var_0_2(arg_1_0)
	return arg_1_0 == var_0_0.GRID_NORMAL or arg_1_0 == var_0_0.GRID_BOSS or arg_1_0 == var_0_0.GRID_ENTRUST
end

function var_0_1.Ctor(arg_2_0, arg_2_1)
	if not var_0_2(arg_2_1.type) then
		-- block empty
	end

	arg_2_0.id = arg_2_1.id
	arg_2_0.type = arg_2_1.type
	arg_2_0.cleared = arg_2_1.cleared
	arg_2_0.minTime = arg_2_1.minTime
	arg_2_0.level_ = arg_2_1.level
	arg_2_0.stageId_ = arg_2_1.stageId
end

function var_0_1.IsBattle(arg_3_0)
	return arg_3_0.type == var_0_0.GRID_NORMAL or arg_3_0.type == var_0_0.GRID_BOSS
end

function var_0_1.IsEntrust(arg_4_0)
	return arg_4_0.type == var_0_0.GRID_ENTRUST
end

function var_0_1.IsBoss(arg_5_0)
	return arg_5_0.type == var_0_0.GRID_BOSS
end

function var_0_1.GetLevel(arg_6_0)
	return arg_6_0.level_
end

function var_0_1.GetBattleStageId(arg_7_0)
	return arg_7_0.stageId_
end

function var_0_1.GetBattleStageCfg(arg_8_0)
	return BattleStageTools.GetStageCfg(BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME, arg_8_0.stageId_)
end

function var_0_1.GetName(arg_9_0)
	if arg_9_0:IsBattle() then
		return arg_9_0:GetBattleStageCfg().name
	end

	local var_9_0 = KagutsuchiWorkData:GetEntrustTips(arg_9_0:GetEntrustIndex())[1]

	return GetTips(var_9_0)
end

function var_0_1.GetSummary(arg_10_0)
	if arg_10_0:IsBattle() then
		return arg_10_0:GetBattleStageCfg().tips
	end

	local var_10_0 = KagutsuchiWorkData:GetEntrustTips(arg_10_0:GetEntrustIndex())[2]

	return GetTips(var_10_0)
end

function var_0_1.GetCompleteText(arg_11_0)
	if arg_11_0:IsBattle() then
		return "no text"
	end

	local var_11_0 = KagutsuchiWorkData:GetEntrustTips(arg_11_0:GetEntrustIndex())[3]

	return GetTips(var_11_0)
end

function var_0_1.GetReward(arg_12_0)
	if arg_12_0.type == var_0_0.GRID_ENTRUST then
		return GameSetting.activity_kagutsuchi_battle_entrust_reward.value[1][2]
	end

	local var_12_0 = arg_12_0:GetBattleStageCfg().drop_lib_id

	if var_12_0 == 0 then
		return 0
	end

	local var_12_1 = getRewardFromDropCfg(var_12_0, not arg_12_0.cleared)
	local var_12_2 = ActivityKagutsuchiBattleCfg[arg_12_0:GetLevel()].addition_reward

	if #var_12_1 == 0 then
		return 0
	end

	return var_12_1[1].num + var_12_2[arg_12_0:IsBoss() and 2 or 1]
end

function var_0_1.IsCleared(arg_13_0)
	return arg_13_0.cleared
end

function var_0_1.GetCost(arg_14_0)
	if arg_14_0:IsCleared() then
		return 0
	end

	if arg_14_0.type == var_0_0.GRID_NORMAL then
		return GameSetting.activity_kagutsuchi_battle_fatigue_normal_stage_cost.value[1]
	elseif arg_14_0.type == var_0_0.GRID_BOSS then
		return GameSetting.activity_kagutsuchi_battle_fatigue_boss_stage_cost.value[1]
	end

	return 0
end

function var_0_1.GetId(arg_15_0)
	return arg_15_0.id
end

function var_0_1.GetEntrustIndex(arg_16_0)
	local var_16_0 = KagutsuchiWorkData:GetBattleGridCount()

	return arg_16_0.id - var_16_0
end

function var_0_1.GetBattleMinTime(arg_17_0)
	return arg_17_0.minTime
end

local var_0_3 = singletonClass("KagutsuchiWorkData")

function var_0_3.InitData(arg_18_0, arg_18_1)
	arg_18_0.activityId = arg_18_1.activity_id
	arg_18_0.day = arg_18_1.map_type
	arg_18_0.mapLevel = arg_18_1.map_level
	arg_18_0.totalCoins = arg_18_1.total_currency_num
	arg_18_0.maxMapLevel = 10

	arg_18_0:InitEntrustHeros(arg_18_1)
	arg_18_0:InitPlayGrids(arg_18_1)
	manager.notify:CallUpdateFunc("OnKagutsuchiWorkDataInit")
end

function var_0_3.InitPlayGrids(arg_19_0, arg_19_1)
	local var_19_0 = {}
	local var_19_1

	if arg_19_0:IsBossDay() then
		var_19_1 = GameSetting.activity_kagutsuchi_battle_boss_stage_list.value[arg_19_0:GetBossDayIndex()]
	else
		var_19_1 = GameSetting.activity_kagutsuchi_battle_normal_stage_list.value[arg_19_0:GetNormalDayIndex()]
	end

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		local var_19_2 = {
			id = iter_19_0,
			level = arg_19_0.mapLevel,
			stageId = iter_19_1
		}

		var_19_2.cleared = false
		var_19_2.minTime = -1

		for iter_19_2, iter_19_3 in ipairs(arg_19_1.mission_list) do
			if iter_19_3.id == iter_19_1 then
				var_19_2.cleared = iter_19_3.clear_times > 0
				var_19_2.minTime = iter_19_3.min_time

				break
			end
		end

		if arg_19_0:IsBossDay() then
			var_19_2.type = var_0_0.GRID_BOSS
		else
			var_19_2.type = var_0_0.GRID_NORMAL
		end

		local var_19_3 = var_0_1.New(var_19_2)

		table.insert(var_19_0, var_19_3)
	end

	local var_19_4 = GameSetting.activity_kagutsuchi_battle_entrust_num.value[1]

	if not arg_19_0:IsBossDay() then
		for iter_19_4 = 1, var_19_4 do
			local var_19_5 = {
				id = iter_19_4 + #var_19_1,
				level = arg_19_0.mapLevel
			}

			var_19_5.cleared = false
			var_19_5.type = var_0_0.GRID_ENTRUST

			for iter_19_5, iter_19_6 in ipairs(arg_19_1.entrust_battle_list) do
				if iter_19_6.grid_id == var_19_5.id then
					var_19_5.cleared = true

					break
				end
			end

			local var_19_6 = var_0_1.New(var_19_5)

			table.insert(var_19_0, var_19_6)
		end
	end

	arg_19_0.playGridList = var_19_0
end

function var_0_3.InitEntrustHeros(arg_20_0, arg_20_1)
	arg_20_0.entrustHeroIds = GameSetting.activity_kagutsuchi_battle_entrust_hero_list.value
	arg_20_0.isHeroEntrusted = {}

	for iter_20_0, iter_20_1 in ipairs(arg_20_0.entrustHeroIds) do
		arg_20_0.isHeroEntrusted[iter_20_1] = false
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_1.entrust_battle_list) do
		arg_20_0:UpdateEntrustedHeros(iter_20_3.hero_list)
	end
end

function var_0_3.UpdateEntrustedHeros(arg_21_0, arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		arg_21_0.isHeroEntrusted[iter_21_1] = true
	end
end

function var_0_3.GetUpgradeCondition(arg_22_0)
	local var_22_0 = ActivityKagutsuchiBattleCfg[arg_22_0.mapLevel].level_up_condition[1]

	return ConditionCfg[var_22_0]
end

function var_0_3.GetUpgradeConditionText(arg_23_0)
	local var_23_0 = arg_23_0:GetUpgradeCondition()

	return string.format(var_23_0.desc, var_23_0.params[1], arg_23_0.mapLevel + 1)
end

function var_0_3.IsMaxLevel(arg_24_0)
	return arg_24_0.mapLevel == arg_24_0.maxMapLevel
end

function var_0_3.IsBossDay(arg_25_0)
	local var_25_0 = GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1

	return math.fmod(arg_25_0.day, var_25_0) == 0
end

function var_0_3.GetEntrustHeroList(arg_26_0)
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(arg_26_0.entrustHeroIds) do
		var_26_1[iter_26_1] = true
	end

	local var_26_2 = HeroData:GetHeroList()

	for iter_26_2, iter_26_3 in pairs(var_26_2) do
		if var_26_1[iter_26_3.id] then
			table.insert(var_26_0, iter_26_3)
		end
	end

	return var_26_0
end

function var_0_3.GetEntrustHeroIdList(arg_27_0)
	return arg_27_0.entrustHeroIds
end

function var_0_3.GetAttributeFactor(arg_28_0)
	local var_28_0 = ActivityKagutsuchiBattleCfg[arg_28_0.mapLevel].attribute_factor

	if var_28_0 and var_28_0[3] then
		local var_28_1 = var_28_0[1] / 1000
		local var_28_2 = var_28_0[2] / 1000
		local var_28_3 = var_28_0[3] / 1000

		return Vector3.New(var_28_1, var_28_2, var_28_3)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_3.IsEntrusted(arg_29_0, arg_29_1)
	return arg_29_0.isHeroEntrusted[arg_29_1]
end

function var_0_3.GetMinEntrustHeroNum(arg_30_0)
	return GameSetting.activity_kagutsuchi_battle_entrust_hero_num_need.value[1]
end

function var_0_3.GetMinEntrustHeroLevel(arg_31_0)
	return GameSetting.activity_kagutsuchi_battle_entrust_hero_level.value[1]
end

function var_0_3.GetIndexByStageId(arg_32_0, arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(arg_32_0.playGridList) do
		if iter_32_1:GetBattleStageId() == arg_32_1 then
			return iter_32_0
		end
	end

	return -1
end

function var_0_3.GetPlayGridData(arg_33_0, arg_33_1)
	return arg_33_0.playGridList[arg_33_1]
end

function var_0_3.GetPlayGridNum(arg_34_0)
	return #arg_34_0.playGridList
end

function var_0_3.GetCoins(arg_35_0)
	local var_35_0 = CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id

	return ItemTools.getItemNum(var_35_0)
end

function var_0_3.GetStamina(arg_36_0)
	local var_36_0 = CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id

	return ItemTools.getItemNum(var_36_0)
end

function var_0_3.GetTotalCoins(arg_37_0)
	return arg_37_0.totalCoins
end

function var_0_3.GetDay(arg_38_0)
	return arg_38_0.day
end

function var_0_3.GetNextBossTime(arg_39_0)
	local var_39_0 = 86400
	local var_39_1 = 3600
	local var_39_2 = GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1
	local var_39_3 = ActivityData:GetActivityData(arg_39_0:GetActivityID())
	local var_39_4 = arg_39_0.day
	local var_39_5 = (math.floor(var_39_4 / var_39_2) + 1) * var_39_2
	local var_39_6 = var_39_3.startTime + var_39_0 * (var_39_5 - 1)
	local var_39_7 = manager.time:GetNextFreshTime()

	return var_39_6 - (tonumber(manager.time:STimeDescS(var_39_6, "!%H")) - tonumber(manager.time:STimeDescS(var_39_7, "!%H"))) * var_39_1
end

function var_0_3.GetBossDayIndex(arg_40_0)
	local var_40_0 = GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1
	local var_40_1 = #GameSetting.activity_kagutsuchi_battle_boss_stage_list.value
	local var_40_2 = math.floor(arg_40_0.day / var_40_0) - 1

	return math.fmod(var_40_2, var_40_1) + 1
end

function var_0_3.GetNormalDayIndex(arg_41_0)
	local var_41_0 = GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1
	local var_41_1 = #GameSetting.activity_kagutsuchi_battle_normal_stage_list.value
	local var_41_2 = arg_41_0.day - math.floor(arg_41_0.day / var_41_0) - 1

	return math.fmod(var_41_2, var_41_1) + 1
end

function var_0_3.GetBattleGridCount(arg_42_0)
	if arg_42_0:IsBossDay() then
		return #GameSetting.activity_kagutsuchi_battle_boss_stage_list.value[arg_42_0:GetBossDayIndex()]
	else
		return #GameSetting.activity_kagutsuchi_battle_normal_stage_list.value[arg_42_0:GetNormalDayIndex()]
	end
end

function var_0_3.GetEntrustTips(arg_43_0, arg_43_1)
	local var_43_0 = GameSetting.activity_kagutsuchi_battle_entrust_tips.value
	local var_43_1 = arg_43_0:GetNormalDayIndex() + arg_43_1 - 1

	return var_43_0[math.fmod(var_43_1, #var_43_0) + 1]
end

function var_0_3.IsUpgraded(arg_44_0)
	local var_44_0 = arg_44_0:GetUpgradeCondition().params[1]

	for iter_44_0, iter_44_1 in ipairs(arg_44_0.playGridList) do
		if iter_44_1.cleared and iter_44_1:IsBattle() and iter_44_1.minTime >= 0 and var_44_0 >= iter_44_1.minTime then
			return true
		end
	end

	return false
end

function var_0_3.IsAllClear(arg_45_0)
	for iter_45_0, iter_45_1 in ipairs(arg_45_0.playGridList) do
		if not iter_45_1:IsCleared() then
			return false
		end
	end

	return true
end

function var_0_3.GetMapSeed(arg_46_0)
	return arg_46_0.day
end

function var_0_3.SetGridClear(arg_47_0, arg_47_1)
	local var_47_0 = arg_47_0:GetPlayGridData(arg_47_1)

	if var_47_0:IsBattle() then
		local var_47_1 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

		if var_47_0.minTime >= 0 then
			var_47_0.minTime = math.min(var_47_1, var_47_0.minTime)
		else
			var_47_0.minTime = var_47_1
		end
	end

	if var_47_0.cleared then
		return
	end

	local var_47_2 = var_47_0:GetReward()
	local var_47_3 = var_47_0:GetCost()

	var_47_0.cleared = true
	arg_47_0.totalCoins = arg_47_0.totalCoins + var_47_2
end

function var_0_3.GetActivityID(arg_48_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function var_0_3.GetServerActivityID(arg_49_0)
	return arg_49_0.activityId
end

return var_0_3
