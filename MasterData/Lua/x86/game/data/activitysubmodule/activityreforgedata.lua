local var_0_0 = singletonClass("ActivityReforgeData")

var_0_0.FinishLevelDataType = {
	"time",
	"point",
	"gold"
}

function var_0_0.Init(arg_1_0)
	arg_1_0.activityData_ = {}
	arg_1_0.chapterData_ = {}
	arg_1_0.finishLevelData_ = {}
	arg_1_0.curLevelData_ = {}
	arg_1_0.cacheFinishLevelAllPlayerData_ = {}
	arg_1_0.cachePopBattleInfoView_ = false
	arg_1_0.cacheAddGoldNum_ = 0
end

function var_0_0:SetActivityData(arg_2_1)
	self.activityData_[arg_2_1.activity_id] = {}
	self.activityData_[arg_2_1.activity_id].goldMax = arg_2_1.gold
	self.activityData_[arg_2_1.activity_id].unlockSkillList = cleanProtoTable(arg_2_1.skill)
end

function var_0_0:SetChapterData(arg_3_1)
	self.chapterData_[arg_3_1.chapter_id] = {}
	self.chapterData_[arg_3_1.chapter_id].finishLevelIDList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.finish_stage_list) do
		table.insert(self.chapterData_[arg_3_1.chapter_id].finishLevelIDList, iter_3_1.stage_id)

		self.finishLevelData_[iter_3_1.stage_id] = {}
		self.finishLevelData_[iter_3_1.stage_id].times = iter_3_1.times
		self.finishLevelData_[iter_3_1.stage_id].minLosePoint = iter_3_1.min_lose_point
		self.finishLevelData_[iter_3_1.stage_id].minUseGold = iter_3_1.min_use_gold
		self.finishLevelData_[iter_3_1.stage_id].minUseSeconds = iter_3_1.min_use_seconds
	end

	self.chapterData_[arg_3_1.chapter_id].isReward = arg_3_1.is_reward == 1
	self.chapterData_[arg_3_1.chapter_id].isUnlock = arg_3_1.is_unlock == 1

	if arg_3_1.is_being_challenged > 0 then
		self:SetCurLevelData(arg_3_1)
	end
end

function var_0_0:InitCurLevelData(arg_4_1, arg_4_2)
	self.curLevelData_ = {}
	self.curLevelData_.curLevelID = arg_4_2
	self.curLevelData_.canUseGold = self.activityData_[ActivityTools.GetMainActivityId(arg_4_1)].goldMax
	self.curLevelData_.waveDataList = {}

	for iter_4_0, iter_4_1 in pairs(ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].wave_list) do
		local var_4_0 = {
			waveID = iter_4_1
		}

		var_4_0.teamID = 0
		var_4_0.isPass = false
		self.curLevelData_.waveDataList[var_4_0.waveID] = var_4_0
	end

	self.curLevelData_.skillData = {}

	for iter_4_2, iter_4_3 in pairs(ActivityReforgeSkillCfg.all) do
		self.curLevelData_.skillData[iter_4_3] = 0
	end

	self.curLevelData_.teamData = {}

	for iter_4_4, iter_4_5 in pairs(ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].team_list) do
		self.curLevelData_.teamData[iter_4_5] = {
			level = 1,
			teamID = iter_4_5
		}
	end

	self.curLevelData_.selectInitiativeSkillList = {
		0,
		0,
		0,
		0
	}
	self.curLevelData_.selectPassiveSkillList = {}
end

function var_0_0:SetCurLevelData(arg_5_1)
	self.curLevelData_ = {}
	self.curLevelData_.curLevelID = arg_5_1.save_stage_info.stage_id
	self.curLevelData_.canUseGold = arg_5_1.save_stage_info.gold
	self.curLevelData_.waveDataList = {}

	for iter_5_0, iter_5_1 in pairs(ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].wave_list) do
		local var_5_0 = {
			waveID = iter_5_1
		}

		var_5_0.teamID = 0
		var_5_0.isPass = false
		self.curLevelData_.waveDataList[var_5_0.waveID] = var_5_0
	end

	self.curLevelData_.skillData = {}

	for iter_5_2, iter_5_3 in pairs(ActivityReforgeSkillCfg.all) do
		self.curLevelData_.skillData[iter_5_3] = 0
	end

	self.curLevelData_.teamData = {}

	for iter_5_4, iter_5_5 in pairs(ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].team_list) do
		self.curLevelData_.teamData[iter_5_5] = {
			level = 1,
			teamID = iter_5_5
		}
	end

	self.curLevelData_.selectInitiativeSkillList = {
		0,
		0,
		0,
		0
	}
	self.curLevelData_.selectPassiveSkillList = {}

	for iter_5_6, iter_5_7 in ipairs(arg_5_1.save_stage_info.wave_list) do
		local var_5_1 = {
			waveID = iter_5_7.wave_id,
			teamID = iter_5_7.team
		}

		var_5_1.isPass = iter_5_7.is_pass == 1

		if var_5_1.isPass then
			var_5_1.losePoint = iter_5_7.wave_battle_end_info.lose_point
			var_5_1.useSeconds = iter_5_7.wave_battle_end_info.use_seconds
			var_5_1.useGold = iter_5_7.wave_battle_end_info.use_gold
			var_5_1.battleParams = iter_5_7.wave_battle_end_info.token
			var_5_1.heroInfo = {}

			for iter_5_8, iter_5_9 in ipairs(iter_5_7.wave_battle_end_info.battle_hero_list) do
				table.insert(var_5_1.heroInfo, {
					heroID = iter_5_9.hero_id,
					leftHp = iter_5_9.left_hp,
					maxHp = iter_5_9.max_hp
				})
			end

			var_5_1.selectInitiativeSkillList = {
				0,
				0,
				0,
				0
			}

			for iter_5_10, iter_5_11 in ipairs(iter_5_7.wave_battle_end_info.select_active_skill_list) do
				var_5_1.selectInitiativeSkillList[iter_5_11.slot] = iter_5_11.id
			end

			var_5_1.selectPassiveSkillList = cleanProtoTable(iter_5_7.wave_battle_end_info.select_passive_skill_list)
		else
			var_5_1.isPass = false
		end

		self.curLevelData_.waveDataList[var_5_1.waveID] = var_5_1
	end

	for iter_5_12, iter_5_13 in ipairs(arg_5_1.save_stage_info.skill_list) do
		self.curLevelData_.skillData[iter_5_13.skill_id] = ActivityReforgeSkillCfg[iter_5_13.skill_id].count == -1 and -1 or ActivityReforgeSkillCfg[iter_5_13.skill_id].count - iter_5_13.use_times
	end

	for iter_5_14, iter_5_15 in ipairs(arg_5_1.save_stage_info.team_list) do
		self.curLevelData_.teamData[iter_5_15.team_id].level = iter_5_15.level
	end

	for iter_5_16, iter_5_17 in ipairs(arg_5_1.save_stage_info.select_active_skill_list) do
		self.curLevelData_.selectInitiativeSkillList[iter_5_17.slot] = iter_5_17.id
	end

	for iter_5_18, iter_5_19 in ipairs(arg_5_1.save_stage_info.select_passive_skill_list) do
		table.insert(self.curLevelData_.selectPassiveSkillList, iter_5_19)
	end
end

function var_0_0.ClearCurLevelData(arg_6_0)
	arg_6_0.curLevelData_ = {}
end

function var_0_0:GetChapterIsUnlock(arg_7_1)
	if ActivityData:GetActivityIsOpen(arg_7_1) then
		return self.chapterData_[arg_7_1].isUnlock
	else
		return false
	end
end

function var_0_0:GetCurLevel()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	return self.curLevelData_.curLevelID
end

function var_0_0:GetGoldMaxNum(arg_9_1)
	if self.activityData_[arg_9_1] == nil then
		return 0
	end

	return self.activityData_[arg_9_1].goldMax
end

function var_0_0:SubGoldMaxNum(arg_10_1, arg_10_2)
	if self.activityData_[arg_10_1] == nil then
		return 0
	end

	self.activityData_[arg_10_1].goldMax = self.activityData_[arg_10_1].goldMax + arg_10_2

	return self.activityData_[arg_10_1].goldMax
end

function var_0_0:GetChapterFinishLevelNum(arg_11_1)
	if self.chapterData_[arg_11_1] == nil then
		return 0
	end

	return #self.chapterData_[arg_11_1].finishLevelIDList
end

function var_0_0:GetLevelIsFinish(arg_12_1, arg_12_2)
	if self.chapterData_[arg_12_1] == nil then
		return false
	end

	return table.indexof(self.chapterData_[arg_12_1].finishLevelIDList, arg_12_2)
end

function var_0_0:FinishLevel(arg_13_1, arg_13_2, arg_13_3)
	self.curLevelData_ = {}

	if self:GetLevelIsFinish(arg_13_1, arg_13_2) then
		return
	end

	if self.chapterData_[arg_13_1] == nil then
		return
	end

	if self.finishLevelData_[arg_13_2] == nil then
		self.finishLevelData_[arg_13_2] = {}
		self.finishLevelData_[arg_13_2].times = 1
		self.finishLevelData_[arg_13_2].minLosePoint = arg_13_3.minLosePoint
		self.finishLevelData_[arg_13_2].minUseGold = arg_13_3.minUseGold
		self.finishLevelData_[arg_13_2].minUseSeconds = arg_13_3.minUseSeconds
	end

	table.insert(self.chapterData_[arg_13_1].finishLevelIDList, arg_13_2)
	ActivityReforgeData:AddCacheAddGoldNum(ActivityReforgeLevelCfg[arg_13_2].reward_money)

	if #self.chapterData_[arg_13_1].finishLevelIDList >= #ActivityReforgeChapterCfg[arg_13_1].level_list and not self:GetChapterIsReward(arg_13_1) then
		self:FinishChapter(arg_13_1)
	end
end

function var_0_0:FinishChapter(arg_14_1)
	local var_14_0 = ActivityTools.GetMainActivityId(arg_14_1)

	self:AddCacheAddGoldNum(ActivityReforgeChapterCfg[arg_14_1].reward_money)

	for iter_14_0, iter_14_1 in pairs(ActivityReforgeChapterCfg[arg_14_1].get_skill_list) do
		table.insert(self.activityData_[var_14_0].unlockSkillList, iter_14_1)
	end

	for iter_14_2, iter_14_3 in pairs(ActivityReforgeChapterCfg.all) do
		if ActivityReforgeChapterCfg[iter_14_3].front_chapter_activity_id == arg_14_1 and self.chapterData_[iter_14_3] then
			self.chapterData_[iter_14_3].isUnlock = true
		end
	end

	for iter_14_4, iter_14_5 in pairs(ActivityReforgeChapterCfg[arg_14_1].get_skill_list) do
		manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_SKILL .. iter_14_5, 1)
	end

	for iter_14_6, iter_14_7 in pairs(ActivityReforgeChapterCfg.all) do
		if ActivityReforgeChapterCfg[iter_14_7].front_chapter_activity_id == arg_14_1 and ActivityData:GetActivityIsOpen(iter_14_7) then
			manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. iter_14_7, 1)
		end
	end
end

function var_0_0:GetWaveTeamInfo(arg_15_1)
	if table.isEmpty(self.curLevelData_) then
		return nil
	end

	if self.curLevelData_.waveDataList[arg_15_1].teamID == 0 then
		return nil
	end

	return (deepClone(self.curLevelData_.teamData[self.curLevelData_.waveDataList[arg_15_1].teamID]))
end

function var_0_0:GetTeamInfo(arg_16_1)
	if table.isEmpty(self.curLevelData_) then
		return nil
	end

	return (deepClone(self.curLevelData_.teamData[arg_16_1]))
end

function var_0_0:CheckLevelCanStart()
	if table.isEmpty(self.curLevelData_) then
		return false
	end

	for iter_17_0, iter_17_1 in pairs(self.curLevelData_.waveDataList) do
		if iter_17_1.teamID == 0 then
			return false
		end
	end

	return true
end

function var_0_0:GetTeamCurUsingWaveID(arg_18_1)
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	for iter_18_0, iter_18_1 in pairs(self.curLevelData_.waveDataList) do
		if iter_18_1.teamID == arg_18_1 then
			return iter_18_1.waveID
		end
	end

	return 0
end

function var_0_0:GetSkillStatus(arg_19_1, arg_19_2, arg_19_3)
	if table.isEmpty(self.curLevelData_) then
		return
	end

	local var_19_0 = ActivityReforgeSkillCfg[arg_19_3]

	if ActivityReforgeSkillCfg[arg_19_3].is_lock == 1 and table.indexof(self.activityData_[arg_19_1].unlockSkillList, arg_19_3) == false then
		return "lock", 0
	else
		local var_19_1 = ActivityReforgeLevelCfg[arg_19_2]

		if table.indexof(ActivityReforgeLevelCfg[arg_19_2].ban_skill_list, arg_19_3) then
			return "ban", 0
		end

		if table.indexof(var_19_1.free_skill_list, arg_19_3) then
			if var_19_0.type == 1 then
				if table.indexof(self.curLevelData_.selectInitiativeSkillList, arg_19_3) then
					return "freeUsing", nil
				else
					return "freeNormal", nil
				end
			elseif table.indexof(self.curLevelData_.selectPassiveSkillList, arg_19_3) then
				return "freeUsing", nil
			else
				return "freeNormal", nil
			end
		end

		if var_19_0.count == -1 and self.curLevelData_.skillData[arg_19_3] == 0 then
			return "haveNotFree", nil
		elseif self.curLevelData_.skillData[arg_19_3] == 0 then
			return "haveNot", 0
		end

		if var_19_0.type == 1 then
			if table.indexof(self.curLevelData_.selectInitiativeSkillList, arg_19_3) then
				if self.curLevelData_.skillData[arg_19_3] == -1 then
					return "infiniteUsing", nil
				else
					return "using", self.curLevelData_.skillData[arg_19_3]
				end
			elseif self.curLevelData_.skillData[arg_19_3] == -1 then
				return "infiniteNormal", nil
			else
				return "normal", self.curLevelData_.skillData[arg_19_3]
			end
		elseif table.indexof(self.curLevelData_.selectPassiveSkillList, arg_19_3) then
			if self.curLevelData_.skillData[arg_19_3] == -1 then
				return "infiniteUsing", nil
			else
				return "using", self.curLevelData_.skillData[arg_19_3]
			end
		elseif self.curLevelData_.skillData[arg_19_3] == -1 then
			return "infiniteNormal", nil
		else
			return "normal", self.curLevelData_.skillData[arg_19_3]
		end
	end
end

function var_0_0:GetSkillIsLock(arg_20_1, arg_20_2)
	if table.isEmpty(self.activityData_) then
		return
	end

	if ActivityReforgeSkillCfg[arg_20_2].is_lock == 1 and table.indexof(self.activityData_[arg_20_1].unlockSkillList, arg_20_2) == false then
		return true
	end

	return false
end

function var_0_0:GetInitiativeSkillUseNum(arg_21_1)
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	if self.curLevelData_.selectInitiativeSkillList[arg_21_1] ~= 0 then
		return 1
	end

	return 0
end

function var_0_0:GetPassiveSkillUseNum()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	return #self.curLevelData_.selectPassiveSkillList
end

function var_0_0:GetCurNextWaveID()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	local var_23_0 = ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].wave_list

	if table.nums(self.curLevelData_.waveDataList) > 0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if self.curLevelData_.waveDataList[iter_23_1].isPass == false then
				return iter_23_1
			end
		end
	else
		return var_23_0[1]
	end
end

function var_0_0:GetCurLevelFinishWave()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(self.curLevelData_.waveDataList) do
		if iter_24_1.isPass == true then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_0:GetCurLastWinWaveID()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	if table.nums(self.curLevelData_.waveDataList) > 0 then
		local var_25_0 = 0

		for iter_25_0, iter_25_1 in pairs(ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].wave_list) do
			if self.curLevelData_.waveDataList[iter_25_1].isPass == true then
				var_25_0 = iter_25_1
			end
		end

		return var_25_0
	else
		return 0
	end
end

function var_0_0:GetCurUsingInitiativeSkill(arg_26_1)
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	return self.curLevelData_.selectInitiativeSkillList[arg_26_1]
end

function var_0_0:GetCurUsingInitiativeSkillList()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	local var_27_0 = {}

	for iter_27_0 = 1, 4 do
		if self.curLevelData_.selectInitiativeSkillList[iter_27_0] > 0 then
			table.insert(var_27_0, self.curLevelData_.selectInitiativeSkillList[iter_27_0])
		end
	end

	return var_27_0
end

function var_0_0:GetCurUsingPassiveSkillList()
	if table.isEmpty(self.curLevelData_) then
		return {}
	end

	return self.curLevelData_.selectPassiveSkillList
end

function var_0_0:GetWaveFinishData(arg_29_1)
	local var_29_0 = {
		isPass = self.curLevelData_.waveDataList[arg_29_1].isPass
	}

	if self.curLevelData_.waveDataList[arg_29_1].isPass then
		var_29_0.useSeconds = self.curLevelData_.waveDataList[arg_29_1].useSeconds
		var_29_0.losePoint = self.curLevelData_.waveDataList[arg_29_1].losePoint
		var_29_0.useGold = self.curLevelData_.waveDataList[arg_29_1].useGold
	else
		var_29_0.useSeconds = 0
		var_29_0.losePoint = 0
		var_29_0.useGold = 0
	end

	return var_29_0
end

function var_0_0:GetFinishWaveHeroInfo(arg_30_1, arg_30_2)
	if table.isEmpty(self.curLevelData_) then
		return nil
	end

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(self.curLevelData_.waveDataList[arg_30_1].heroInfo) do
		if iter_30_1.heroID == arg_30_2 then
			var_30_0.leftHp = iter_30_1.leftHp
			var_30_0.maxHp = iter_30_1.maxHp

			return var_30_0
		end
	end
end

function var_0_0:GetCurUsingSkillList()
	if table.isEmpty(self.curLevelData_) then
		return {}
	end

	local var_31_0 = true
	local var_31_1 = {}

	for iter_31_0 = 1, 4 do
		if self.curLevelData_.selectInitiativeSkillList[iter_31_0] > 0 then
			var_31_0 = false

			table.insert(var_31_1, self.curLevelData_.selectInitiativeSkillList[iter_31_0])
		else
			table.insert(var_31_1, 0)
		end
	end

	for iter_31_1, iter_31_2 in pairs(self.curLevelData_.selectPassiveSkillList) do
		var_31_0 = false

		table.insert(var_31_1, iter_31_2)
	end

	return var_31_1, var_31_0
end

function var_0_0:GetFrontWaveBattleParams(arg_32_1)
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	local var_32_0 = 0

	for iter_32_0, iter_32_1 in pairs(ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].wave_list) do
		if iter_32_1 == arg_32_1 then
			if iter_32_0 == 1 then
				return 0
			else
				var_32_0 = ActivityReforgeLevelCfg[self.curLevelData_.curLevelID].wave_list[iter_32_0 - 1]

				break
			end
		end
	end

	return self.curLevelData_.waveDataList[var_32_0].battleParams
end

function var_0_0:GetPassWaveUsedSkillList(arg_33_1)
	if table.isEmpty(self.curLevelData_) then
		return {}
	end

	local var_33_0 = {}

	for iter_33_0 = 1, 4 do
		if self.curLevelData_.waveDataList[arg_33_1].selectInitiativeSkillList[iter_33_0] > 0 then
			table.insert(var_33_0, self.curLevelData_.waveDataList[arg_33_1].selectInitiativeSkillList[iter_33_0])
		else
			table.insert(var_33_0, 0)
		end
	end

	for iter_33_1, iter_33_2 in pairs(self.curLevelData_.waveDataList[arg_33_1].selectPassiveSkillList) do
		table.insert(var_33_0, iter_33_2)
	end

	return var_33_0
end

function var_0_0:SetCurFinishLevelServerData(arg_34_1)
	self.curLevelData_.finishLevelData_ = {}
	self.curLevelData_.finishLevelData_.stageID = arg_34_1.stage_id
	self.curLevelData_.finishLevelData_.times = arg_34_1.times
	self.curLevelData_.finishLevelData_.minLosePoint = arg_34_1.min_lose_point
	self.curLevelData_.finishLevelData_.minUseGold = arg_34_1.min_use_gold
	self.curLevelData_.finishLevelData_.minUseSeconds = arg_34_1.min_use_seconds
end

function var_0_0:GetCurFinishLevelServerData()
	if table.isEmpty(self.curLevelData_) then
		return nil
	end

	return self.curLevelData_.finishLevelData_
end

function var_0_0:SetLevelAllPlayerServerData(arg_36_1, arg_36_2, arg_36_3)
	self.cacheFinishLevelAllPlayerData_[arg_36_2] = {}

	local var_36_0 = ActivityReforgeGameSettingCfg[ActivityTools.GetMainActivityId(arg_36_1)].bar_num_max

	for iter_36_0, iter_36_1 in ipairs(arg_36_3) do
		if iter_36_1.id == 1 then
			self.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint = {}
			self.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeValue = {}

			for iter_36_2 = 1, var_36_0 do
				self.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeValue[iter_36_2] = 0
			end

			self.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeLength = iter_36_1.step

			for iter_36_3, iter_36_4 in ipairs(iter_36_1.range_value_list) do
				self.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeValue[iter_36_4.index] = iter_36_4.value
			end
		elseif iter_36_1.id == 2 then
			self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold = {}
			self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeValue = {}

			for iter_36_5 = 1, var_36_0 do
				self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeValue[iter_36_5] = 0
			end

			self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeLength = iter_36_1.step

			for iter_36_6, iter_36_7 in ipairs(iter_36_1.range_value_list) do
				self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeValue[iter_36_7.index] = iter_36_7.value
			end
		elseif iter_36_1.id == 3 then
			self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds = {}
			self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeValue = {}

			for iter_36_8 = 1, var_36_0 do
				self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeValue[iter_36_8] = 0
			end

			self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeLength = iter_36_1.step

			for iter_36_9, iter_36_10 in ipairs(iter_36_1.range_value_list) do
				self.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeValue[iter_36_10.index] = iter_36_10.value
			end
		end
	end
end

function var_0_0:GetLevelAllPlayerServerData(arg_37_1)
	if table.isEmpty(self.cacheFinishLevelAllPlayerData_) or table.isEmpty(self.cacheFinishLevelAllPlayerData_[arg_37_1]) then
		return nil
	end

	return self.cacheFinishLevelAllPlayerData_[arg_37_1]
end

function var_0_0:GetBestFinishLevelServerData(arg_38_1)
	if self.finishLevelData_[arg_38_1] then
		return self.finishLevelData_[arg_38_1]
	end

	return nil
end

function var_0_0.SetCachePopBattleInfoView(arg_39_0, arg_39_1)
	arg_39_0.cachePopBattleInfoView_ = arg_39_1
end

function var_0_0:GetCachePopBattleInfoView()
	return self.cachePopBattleInfoView_
end

function var_0_0:GetCurCanUseGold()
	if table.isEmpty(self.curLevelData_) then
		return 0
	end

	return self.curLevelData_.canUseGold
end

function var_0_0:AddCacheAddGoldNum(arg_42_1)
	self.cacheAddGoldNum_ = self.cacheAddGoldNum_ + arg_42_1
end

function var_0_0:GetCacheAddGoldNum()
	return self.cacheAddGoldNum_
end

function var_0_0.ClearCacheAddGoldNum(arg_44_0)
	arg_44_0.cacheAddGoldNum_ = 0
end

function var_0_0:GetChapterIsReward(arg_45_1)
	return self.chapterData_[arg_45_1].isReward
end

return var_0_0
