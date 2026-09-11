local var_0_0 = {
	GRID_ENTRUST = 2,
	GRID_NORMAL = 1,
	GRID_BOSS = 3,
	GRID_BLANK = 4
}
local PlayGridData = class("PlayGridData")

local function var_0_2(arg_1_0)
	return arg_1_0 == var_0_0.GRID_NORMAL or arg_1_0 == var_0_0.GRID_BOSS or arg_1_0 == var_0_0.GRID_ENTRUST
end

function PlayGridData:Ctor(arg_2_1)
	if not var_0_2(arg_2_1.type) then
		-- block empty
	end

	self.id = arg_2_1.id
	self.type = arg_2_1.type
	self.cleared = arg_2_1.cleared
	self.minTime = arg_2_1.minTime
	self.level_ = arg_2_1.level
	self.stageId_ = arg_2_1.stageId
end

function PlayGridData:IsBattle()
	return self.type == var_0_0.GRID_NORMAL or self.type == var_0_0.GRID_BOSS
end

function PlayGridData:IsEntrust()
	return self.type == var_0_0.GRID_ENTRUST
end

function PlayGridData:IsBoss()
	return self.type == var_0_0.GRID_BOSS
end

function PlayGridData:GetLevel()
	return self.level_
end

function PlayGridData:GetBattleStageId()
	return self.stageId_
end

function PlayGridData:GetBattleStageCfg()
	return BattleStageTools.GetStageCfg(BattleConst.STAGE_TYPE_NEW.ACTIVITY_JJT_MAP_GAME, self.stageId_)
end

function PlayGridData:GetName()
	if self:IsBattle() then
		return self:GetBattleStageCfg().name
	end

	return GetTips(KagutsuchiWorkData:GetEntrustTips(self:GetEntrustIndex())[1])
end

function PlayGridData:GetSummary()
	if self:IsBattle() then
		return self:GetBattleStageCfg().tips
	end

	return GetTips(KagutsuchiWorkData:GetEntrustTips(self:GetEntrustIndex())[2])
end

function PlayGridData:GetCompleteText()
	if self:IsBattle() then
		return "no text"
	end

	return GetTips(KagutsuchiWorkData:GetEntrustTips(self:GetEntrustIndex())[3])
end

function PlayGridData:GetReward()
	if self.type == var_0_0.GRID_ENTRUST then
		return GameSetting.activity_kagutsuchi_battle_entrust_reward.value[1][2]
	end

	local var_12_0 = self:GetBattleStageCfg().drop_lib_id

	if var_12_0 == 0 then
		return 0
	end

	local var_12_1 = getRewardFromDropCfg(var_12_0, not self.cleared)
	local var_12_2 = ActivityKagutsuchiBattleCfg[self:GetLevel()].addition_reward

	if #var_12_1 == 0 then
		return 0
	end

	return var_12_1[1].num + var_12_2[self:IsBoss() and 2 or 1]
end

function PlayGridData:IsCleared()
	return self.cleared
end

function PlayGridData:GetCost()
	if self:IsCleared() then
		return 0
	end

	if self.type == var_0_0.GRID_NORMAL then
		return GameSetting.activity_kagutsuchi_battle_fatigue_normal_stage_cost.value[1]
	elseif self.type == var_0_0.GRID_BOSS then
		return GameSetting.activity_kagutsuchi_battle_fatigue_boss_stage_cost.value[1]
	end

	return 0
end

function PlayGridData:GetId()
	return self.id
end

function PlayGridData:GetEntrustIndex()
	return self.id - KagutsuchiWorkData:GetBattleGridCount()
end

function PlayGridData:GetBattleMinTime()
	return self.minTime
end

local var_0_3 = singletonClass("KagutsuchiWorkData")

function var_0_3:InitData(arg_18_1)
	self.activityId = arg_18_1.activity_id
	self.day = arg_18_1.map_type
	self.mapLevel = arg_18_1.map_level
	self.totalCoins = arg_18_1.total_currency_num
	self.maxMapLevel = 10

	self:InitEntrustHeros(arg_18_1)
	self:InitPlayGrids(arg_18_1)
	manager.notify:CallUpdateFunc("OnKagutsuchiWorkDataInit")
end

function var_0_3:InitPlayGrids(arg_19_1)
	local var_19_0 = {}
	local var_19_1 = self:IsBossDay() and GameSetting.activity_kagutsuchi_battle_boss_stage_list.value[self:GetBossDayIndex()] or GameSetting.activity_kagutsuchi_battle_normal_stage_list.value[self:GetNormalDayIndex()]

	for iter_19_0, iter_19_1 in ipairs(var_19_1) do
		local var_19_2 = {
			id = iter_19_0,
			level = self.mapLevel,
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

		var_19_2.type = self:IsBossDay() and var_0_0.GRID_BOSS or var_0_0.GRID_NORMAL

		table.insert(var_19_0, (PlayGridData.New(var_19_2)))
	end

	if not self:IsBossDay() then
		for iter_19_4 = 1, GameSetting.activity_kagutsuchi_battle_entrust_num.value[1] do
			local var_19_4 = {
				id = iter_19_4 + #var_19_1,
				level = self.mapLevel
			}

			var_19_4.cleared = false
			var_19_4.type = var_0_0.GRID_ENTRUST

			for iter_19_5, iter_19_6 in ipairs(arg_19_1.entrust_battle_list) do
				if iter_19_6.grid_id == var_19_4.id then
					var_19_4.cleared = true

					break
				end
			end

			table.insert(var_19_0, (PlayGridData.New(var_19_4)))
		end
	end

	self.playGridList = var_19_0
end

function var_0_3:InitEntrustHeros(arg_20_1)
	self.entrustHeroIds = GameSetting.activity_kagutsuchi_battle_entrust_hero_list.value
	self.isHeroEntrusted = {}

	for iter_20_0, iter_20_1 in ipairs(self.entrustHeroIds) do
		self.isHeroEntrusted[iter_20_1] = false
	end

	for iter_20_2, iter_20_3 in ipairs(arg_20_1.entrust_battle_list) do
		self:UpdateEntrustedHeros(iter_20_3.hero_list)
	end
end

function var_0_3:UpdateEntrustedHeros(arg_21_1)
	for iter_21_0, iter_21_1 in ipairs(arg_21_1) do
		self.isHeroEntrusted[iter_21_1] = true
	end
end

function var_0_3:GetUpgradeCondition()
	return ConditionCfg[ActivityKagutsuchiBattleCfg[self.mapLevel].level_up_condition[1]]
end

function var_0_3:GetUpgradeConditionText()
	local var_23_0 = self:GetUpgradeCondition()

	return string.format(var_23_0.desc, var_23_0.params[1], self.mapLevel + 1)
end

function var_0_3:IsMaxLevel()
	return self.mapLevel == self.maxMapLevel
end

function var_0_3:IsBossDay()
	return math.fmod(self.day, GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1) == 0
end

function var_0_3:GetEntrustHeroList()
	local var_26_0 = {}
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(self.entrustHeroIds) do
		var_26_1[iter_26_1] = true
	end

	for iter_26_2, iter_26_3 in pairs((HeroData:GetHeroList())) do
		if var_26_1[iter_26_3.id] then
			table.insert(var_26_0, iter_26_3)
		end
	end

	return var_26_0
end

function var_0_3:GetEntrustHeroIdList()
	return self.entrustHeroIds
end

function var_0_3:GetAttributeFactor()
	if ActivityKagutsuchiBattleCfg[self.mapLevel].attribute_factor and ActivityKagutsuchiBattleCfg[self.mapLevel].attribute_factor[3] then
		return Vector3.New(ActivityKagutsuchiBattleCfg[self.mapLevel].attribute_factor[1] / 1000, ActivityKagutsuchiBattleCfg[self.mapLevel].attribute_factor[2] / 1000, ActivityKagutsuchiBattleCfg[self.mapLevel].attribute_factor[3] / 1000)
	end

	return Vector3.New(1, 1, 1)
end

function var_0_3:IsEntrusted(arg_29_1)
	return self.isHeroEntrusted[arg_29_1]
end

function var_0_3.GetMinEntrustHeroNum(arg_30_0)
	return GameSetting.activity_kagutsuchi_battle_entrust_hero_num_need.value[1]
end

function var_0_3.GetMinEntrustHeroLevel(arg_31_0)
	return GameSetting.activity_kagutsuchi_battle_entrust_hero_level.value[1]
end

function var_0_3:GetIndexByStageId(arg_32_1)
	for iter_32_0, iter_32_1 in ipairs(self.playGridList) do
		if iter_32_1:GetBattleStageId() == arg_32_1 then
			return iter_32_0
		end
	end

	return -1
end

function var_0_3:GetPlayGridData(arg_33_1)
	return self.playGridList[arg_33_1]
end

function var_0_3:GetPlayGridNum()
	return #self.playGridList
end

function var_0_3.GetCoins(arg_35_0)
	return ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_COIN.item_id)
end

function var_0_3.GetStamina(arg_36_0)
	return ItemTools.getItemNum(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
end

function var_0_3:GetTotalCoins()
	return self.totalCoins
end

function var_0_3:GetDay()
	return self.day
end

function var_0_3:GetNextBossTime()
	local var_39_0 = ActivityData:GetActivityData(self:GetActivityID()).startTime + 86400 * ((math.floor(self.day / (GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1)) + 1) * (GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1) - 1)

	return var_39_0 - (tonumber(manager.time:STimeDescS(var_39_0, "!%H")) - tonumber(manager.time:STimeDescS(manager.time:GetNextFreshTime(), "!%H"))) * 3600
end

function var_0_3:GetBossDayIndex()
	return math.fmod(math.floor(self.day / (GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1)) - 1, #GameSetting.activity_kagutsuchi_battle_boss_stage_list.value) + 1
end

function var_0_3:GetNormalDayIndex()
	return math.fmod(self.day - math.floor(self.day / (GameSetting.activity_kagutsuchi_battle_boss_come.value[1] + 1)) - 1, #GameSetting.activity_kagutsuchi_battle_normal_stage_list.value) + 1
end

function var_0_3:GetBattleGridCount()
	if self:IsBossDay() then
		return #GameSetting.activity_kagutsuchi_battle_boss_stage_list.value[self:GetBossDayIndex()]
	else
		return #GameSetting.activity_kagutsuchi_battle_normal_stage_list.value[self:GetNormalDayIndex()]
	end
end

function var_0_3:GetEntrustTips(arg_43_1)
	return GameSetting.activity_kagutsuchi_battle_entrust_tips.value[math.fmod(self:GetNormalDayIndex() + arg_43_1 - 1, #GameSetting.activity_kagutsuchi_battle_entrust_tips.value) + 1]
end

function var_0_3:IsUpgraded()
	local var_44_0 = self:GetUpgradeCondition().params[1]

	for iter_44_0, iter_44_1 in ipairs(self.playGridList) do
		if iter_44_1.cleared and iter_44_1:IsBattle() and iter_44_1.minTime >= 0 and var_44_0 >= iter_44_1.minTime then
			return true
		end
	end

	return false
end

function var_0_3:IsAllClear()
	for iter_45_0, iter_45_1 in ipairs(self.playGridList) do
		if not iter_45_1:IsCleared() then
			return false
		end
	end

	return true
end

function var_0_3:GetMapSeed()
	return self.day
end

function var_0_3:SetGridClear(arg_47_1)
	local var_47_0 = self:GetPlayGridData(arg_47_1)

	if var_47_0:IsBattle() then
		local var_47_1 = LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime

		var_47_0.minTime = var_47_0.minTime >= 0 and math.min(var_47_1, var_47_0.minTime) or var_47_1
	end

	if var_47_0.cleared then
		return
	end

	local var_47_2 = var_47_0:GetReward()
	local var_47_3 = var_47_0:GetCost()

	var_47_0.cleared = true
	self.totalCoins = self.totalCoins + var_47_2
end

function var_0_3.GetActivityID(arg_48_0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function var_0_3:GetServerActivityID()
	return self.activityId
end

return var_0_3
