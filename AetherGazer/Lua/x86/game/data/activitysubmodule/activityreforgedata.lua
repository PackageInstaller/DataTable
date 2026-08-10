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

function var_0_0.SetActivityData(arg_2_0, arg_2_1)
	arg_2_0.activityData_[arg_2_1.activity_id] = {}
	arg_2_0.activityData_[arg_2_1.activity_id].goldMax = arg_2_1.gold
	arg_2_0.activityData_[arg_2_1.activity_id].unlockSkillList = cleanProtoTable(arg_2_1.skill)
end

function var_0_0.SetChapterData(arg_3_0, arg_3_1)
	arg_3_0.chapterData_[arg_3_1.chapter_id] = {}
	arg_3_0.chapterData_[arg_3_1.chapter_id].finishLevelIDList = {}

	for iter_3_0, iter_3_1 in ipairs(arg_3_1.finish_stage_list) do
		table.insert(arg_3_0.chapterData_[arg_3_1.chapter_id].finishLevelIDList, iter_3_1.stage_id)

		arg_3_0.finishLevelData_[iter_3_1.stage_id] = {}
		arg_3_0.finishLevelData_[iter_3_1.stage_id].times = iter_3_1.times
		arg_3_0.finishLevelData_[iter_3_1.stage_id].minLosePoint = iter_3_1.min_lose_point
		arg_3_0.finishLevelData_[iter_3_1.stage_id].minUseGold = iter_3_1.min_use_gold
		arg_3_0.finishLevelData_[iter_3_1.stage_id].minUseSeconds = iter_3_1.min_use_seconds
	end

	local var_3_0 = false

	if arg_3_1.is_reward == 1 then
		var_3_0 = true
	end

	arg_3_0.chapterData_[arg_3_1.chapter_id].isReward = var_3_0

	local var_3_1 = false

	if arg_3_1.is_unlock == 1 then
		var_3_1 = true
	end

	arg_3_0.chapterData_[arg_3_1.chapter_id].isUnlock = var_3_1

	if arg_3_1.is_being_challenged > 0 then
		arg_3_0:SetCurLevelData(arg_3_1)
	end
end

function var_0_0.InitCurLevelData(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.curLevelData_ = {}
	arg_4_0.curLevelData_.curLevelID = arg_4_2
	arg_4_0.curLevelData_.canUseGold = arg_4_0.activityData_[ActivityTools.GetMainActivityId(arg_4_1)].goldMax
	arg_4_0.curLevelData_.waveDataList = {}

	for iter_4_0, iter_4_1 in pairs(ActivityReforgeLevelCfg[arg_4_0.curLevelData_.curLevelID].wave_list) do
		local var_4_0 = {
			waveID = iter_4_1
		}

		var_4_0.teamID = 0
		var_4_0.isPass = false
		arg_4_0.curLevelData_.waveDataList[var_4_0.waveID] = var_4_0
	end

	local var_4_1 = ActivityReforgeLevelCfg[arg_4_0.curLevelData_.curLevelID]

	arg_4_0.curLevelData_.skillData = {}

	for iter_4_2, iter_4_3 in pairs(ActivityReforgeSkillCfg.all) do
		arg_4_0.curLevelData_.skillData[iter_4_3] = 0
	end

	arg_4_0.curLevelData_.teamData = {}

	for iter_4_4, iter_4_5 in pairs(var_4_1.team_list) do
		arg_4_0.curLevelData_.teamData[iter_4_5] = {
			level = 1,
			teamID = iter_4_5
		}
	end

	arg_4_0.curLevelData_.selectInitiativeSkillList = {
		0,
		0,
		0,
		0
	}
	arg_4_0.curLevelData_.selectPassiveSkillList = {}
end

function var_0_0.SetCurLevelData(arg_5_0, arg_5_1)
	arg_5_0.curLevelData_ = {}
	arg_5_0.curLevelData_.curLevelID = arg_5_1.save_stage_info.stage_id
	arg_5_0.curLevelData_.canUseGold = arg_5_1.save_stage_info.gold
	arg_5_0.curLevelData_.waveDataList = {}

	for iter_5_0, iter_5_1 in pairs(ActivityReforgeLevelCfg[arg_5_0.curLevelData_.curLevelID].wave_list) do
		local var_5_0 = {
			waveID = iter_5_1
		}

		var_5_0.teamID = 0
		var_5_0.isPass = false
		arg_5_0.curLevelData_.waveDataList[var_5_0.waveID] = var_5_0
	end

	local var_5_1 = ActivityReforgeLevelCfg[arg_5_0.curLevelData_.curLevelID]

	arg_5_0.curLevelData_.skillData = {}

	for iter_5_2, iter_5_3 in pairs(ActivityReforgeSkillCfg.all) do
		arg_5_0.curLevelData_.skillData[iter_5_3] = 0
	end

	arg_5_0.curLevelData_.teamData = {}

	for iter_5_4, iter_5_5 in pairs(var_5_1.team_list) do
		arg_5_0.curLevelData_.teamData[iter_5_5] = {
			level = 1,
			teamID = iter_5_5
		}
	end

	arg_5_0.curLevelData_.selectInitiativeSkillList = {
		0,
		0,
		0,
		0
	}
	arg_5_0.curLevelData_.selectPassiveSkillList = {}

	for iter_5_6, iter_5_7 in ipairs(arg_5_1.save_stage_info.wave_list) do
		local var_5_2 = {
			waveID = iter_5_7.wave_id,
			teamID = iter_5_7.team
		}

		if iter_5_7.is_pass == 1 then
			var_5_2.isPass = true
		else
			var_5_2.isPass = false
		end

		if var_5_2.isPass then
			var_5_2.losePoint = iter_5_7.wave_battle_end_info.lose_point
			var_5_2.useSeconds = iter_5_7.wave_battle_end_info.use_seconds
			var_5_2.useGold = iter_5_7.wave_battle_end_info.use_gold
			var_5_2.battleParams = iter_5_7.wave_battle_end_info.token
			var_5_2.heroInfo = {}

			for iter_5_8, iter_5_9 in ipairs(iter_5_7.wave_battle_end_info.battle_hero_list) do
				table.insert(var_5_2.heroInfo, {
					heroID = iter_5_9.hero_id,
					leftHp = iter_5_9.left_hp,
					maxHp = iter_5_9.max_hp
				})
			end

			var_5_2.selectInitiativeSkillList = {
				0,
				0,
				0,
				0
			}

			for iter_5_10, iter_5_11 in ipairs(iter_5_7.wave_battle_end_info.select_active_skill_list) do
				var_5_2.selectInitiativeSkillList[iter_5_11.slot] = iter_5_11.id
			end

			var_5_2.selectPassiveSkillList = cleanProtoTable(iter_5_7.wave_battle_end_info.select_passive_skill_list)
		else
			var_5_2.isPass = false
		end

		arg_5_0.curLevelData_.waveDataList[var_5_2.waveID] = var_5_2
	end

	for iter_5_12, iter_5_13 in ipairs(arg_5_1.save_stage_info.skill_list) do
		local var_5_3 = ActivityReforgeSkillCfg[iter_5_13.skill_id]

		if var_5_3.count == -1 then
			arg_5_0.curLevelData_.skillData[iter_5_13.skill_id] = -1
		else
			arg_5_0.curLevelData_.skillData[iter_5_13.skill_id] = var_5_3.count - iter_5_13.use_times
		end
	end

	for iter_5_14, iter_5_15 in ipairs(arg_5_1.save_stage_info.team_list) do
		arg_5_0.curLevelData_.teamData[iter_5_15.team_id].level = iter_5_15.level
	end

	for iter_5_16, iter_5_17 in ipairs(arg_5_1.save_stage_info.select_active_skill_list) do
		arg_5_0.curLevelData_.selectInitiativeSkillList[iter_5_17.slot] = iter_5_17.id
	end

	for iter_5_18, iter_5_19 in ipairs(arg_5_1.save_stage_info.select_passive_skill_list) do
		table.insert(arg_5_0.curLevelData_.selectPassiveSkillList, iter_5_19)
	end
end

function var_0_0.ClearCurLevelData(arg_6_0)
	arg_6_0.curLevelData_ = {}
end

function var_0_0.GetChapterIsUnlock(arg_7_0, arg_7_1)
	if ActivityData:GetActivityIsOpen(arg_7_1) then
		return arg_7_0.chapterData_[arg_7_1].isUnlock
	else
		return false
	end
end

function var_0_0.GetCurLevel(arg_8_0)
	if table.isEmpty(arg_8_0.curLevelData_) then
		return 0
	end

	return arg_8_0.curLevelData_.curLevelID
end

function var_0_0.GetGoldMaxNum(arg_9_0, arg_9_1)
	if arg_9_0.activityData_[arg_9_1] == nil then
		return 0
	end

	return arg_9_0.activityData_[arg_9_1].goldMax
end

function var_0_0.SubGoldMaxNum(arg_10_0, arg_10_1, arg_10_2)
	if arg_10_0.activityData_[arg_10_1] == nil then
		return 0
	end

	arg_10_0.activityData_[arg_10_1].goldMax = arg_10_0.activityData_[arg_10_1].goldMax + arg_10_2

	return arg_10_0.activityData_[arg_10_1].goldMax
end

function var_0_0.GetChapterFinishLevelNum(arg_11_0, arg_11_1)
	if arg_11_0.chapterData_[arg_11_1] == nil then
		return 0
	end

	return #arg_11_0.chapterData_[arg_11_1].finishLevelIDList
end

function var_0_0.GetLevelIsFinish(arg_12_0, arg_12_1, arg_12_2)
	if arg_12_0.chapterData_[arg_12_1] == nil then
		return false
	end

	return table.indexof(arg_12_0.chapterData_[arg_12_1].finishLevelIDList, arg_12_2)
end

function var_0_0.FinishLevel(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	arg_13_0.curLevelData_ = {}

	if arg_13_0:GetLevelIsFinish(arg_13_1, arg_13_2) then
		return
	end

	if arg_13_0.chapterData_[arg_13_1] == nil then
		return
	end

	if arg_13_0.finishLevelData_[arg_13_2] == nil then
		arg_13_0.finishLevelData_[arg_13_2] = {}
		arg_13_0.finishLevelData_[arg_13_2].times = 1
		arg_13_0.finishLevelData_[arg_13_2].minLosePoint = arg_13_3.minLosePoint
		arg_13_0.finishLevelData_[arg_13_2].minUseGold = arg_13_3.minUseGold
		arg_13_0.finishLevelData_[arg_13_2].minUseSeconds = arg_13_3.minUseSeconds
	end

	table.insert(arg_13_0.chapterData_[arg_13_1].finishLevelIDList, arg_13_2)

	local var_13_0 = ActivityReforgeLevelCfg[arg_13_2]

	ActivityReforgeData:AddCacheAddGoldNum(var_13_0.reward_money)

	local var_13_1 = ActivityReforgeChapterCfg[arg_13_1]

	if #arg_13_0.chapterData_[arg_13_1].finishLevelIDList >= #var_13_1.level_list and not arg_13_0:GetChapterIsReward(arg_13_1) then
		arg_13_0:FinishChapter(arg_13_1)
	end
end

function var_0_0.FinishChapter(arg_14_0, arg_14_1)
	local var_14_0 = ActivityTools.GetMainActivityId(arg_14_1)
	local var_14_1 = ActivityReforgeChapterCfg[arg_14_1]

	arg_14_0:AddCacheAddGoldNum(var_14_1.reward_money)

	for iter_14_0, iter_14_1 in pairs(var_14_1.get_skill_list) do
		table.insert(arg_14_0.activityData_[var_14_0].unlockSkillList, iter_14_1)
	end

	for iter_14_2, iter_14_3 in pairs(ActivityReforgeChapterCfg.all) do
		if ActivityReforgeChapterCfg[iter_14_3].front_chapter_activity_id == arg_14_1 and arg_14_0.chapterData_[iter_14_3] then
			arg_14_0.chapterData_[iter_14_3].isUnlock = true
		end
	end

	for iter_14_4, iter_14_5 in pairs(var_14_1.get_skill_list) do
		local var_14_2 = RedPointConst.ACTIVITY_REFORGE_SKILL .. iter_14_5

		manager.redPoint:setTip(var_14_2, 1)
	end

	for iter_14_6, iter_14_7 in pairs(ActivityReforgeChapterCfg.all) do
		if ActivityReforgeChapterCfg[iter_14_7].front_chapter_activity_id == arg_14_1 and ActivityData:GetActivityIsOpen(iter_14_7) then
			local var_14_3 = RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. iter_14_7

			manager.redPoint:setTip(var_14_3, 1)
		end
	end
end

function var_0_0.GetWaveTeamInfo(arg_15_0, arg_15_1)
	if table.isEmpty(arg_15_0.curLevelData_) then
		return nil
	end

	local var_15_0
	local var_15_1 = arg_15_0.curLevelData_.waveDataList[arg_15_1].teamID

	if var_15_1 == 0 then
		return var_15_0
	end

	return (deepClone(arg_15_0.curLevelData_.teamData[var_15_1]))
end

function var_0_0.GetTeamInfo(arg_16_0, arg_16_1)
	if table.isEmpty(arg_16_0.curLevelData_) then
		return nil
	end

	local var_16_0

	return (deepClone(arg_16_0.curLevelData_.teamData[arg_16_1]))
end

function var_0_0.CheckLevelCanStart(arg_17_0)
	if table.isEmpty(arg_17_0.curLevelData_) then
		return false
	end

	for iter_17_0, iter_17_1 in pairs(arg_17_0.curLevelData_.waveDataList) do
		if iter_17_1.teamID == 0 then
			return false
		end
	end

	return true
end

function var_0_0.GetTeamCurUsingWaveID(arg_18_0, arg_18_1)
	if table.isEmpty(arg_18_0.curLevelData_) then
		return 0
	end

	for iter_18_0, iter_18_1 in pairs(arg_18_0.curLevelData_.waveDataList) do
		if iter_18_1.teamID == arg_18_1 then
			return iter_18_1.waveID
		end
	end

	return 0
end

function var_0_0.GetSkillStatus(arg_19_0, arg_19_1, arg_19_2, arg_19_3)
	if table.isEmpty(arg_19_0.curLevelData_) then
		return
	end

	local var_19_0 = ActivityReforgeSkillCfg[arg_19_3]

	if var_19_0.is_lock == 1 and table.indexof(arg_19_0.activityData_[arg_19_1].unlockSkillList, arg_19_3) == false then
		return "lock", 0
	else
		local var_19_1 = ActivityReforgeLevelCfg[arg_19_2]

		if table.indexof(var_19_1.ban_skill_list, arg_19_3) then
			return "ban", 0
		end

		if table.indexof(var_19_1.free_skill_list, arg_19_3) then
			if var_19_0.type == 1 then
				if table.indexof(arg_19_0.curLevelData_.selectInitiativeSkillList, arg_19_3) then
					return "freeUsing", nil
				else
					return "freeNormal", nil
				end
			elseif table.indexof(arg_19_0.curLevelData_.selectPassiveSkillList, arg_19_3) then
				return "freeUsing", nil
			else
				return "freeNormal", nil
			end
		end

		if var_19_0.count == -1 and arg_19_0.curLevelData_.skillData[arg_19_3] == 0 then
			return "haveNotFree", nil
		elseif arg_19_0.curLevelData_.skillData[arg_19_3] == 0 then
			return "haveNot", 0
		end

		if var_19_0.type == 1 then
			if table.indexof(arg_19_0.curLevelData_.selectInitiativeSkillList, arg_19_3) then
				if arg_19_0.curLevelData_.skillData[arg_19_3] == -1 then
					return "infiniteUsing", nil
				else
					return "using", arg_19_0.curLevelData_.skillData[arg_19_3]
				end
			elseif arg_19_0.curLevelData_.skillData[arg_19_3] == -1 then
				return "infiniteNormal", nil
			else
				return "normal", arg_19_0.curLevelData_.skillData[arg_19_3]
			end
		elseif table.indexof(arg_19_0.curLevelData_.selectPassiveSkillList, arg_19_3) then
			if arg_19_0.curLevelData_.skillData[arg_19_3] == -1 then
				return "infiniteUsing", nil
			else
				return "using", arg_19_0.curLevelData_.skillData[arg_19_3]
			end
		elseif arg_19_0.curLevelData_.skillData[arg_19_3] == -1 then
			return "infiniteNormal", nil
		else
			return "normal", arg_19_0.curLevelData_.skillData[arg_19_3]
		end
	end
end

function var_0_0.GetSkillIsLock(arg_20_0, arg_20_1, arg_20_2)
	if table.isEmpty(arg_20_0.activityData_) then
		return
	end

	if ActivityReforgeSkillCfg[arg_20_2].is_lock == 1 and table.indexof(arg_20_0.activityData_[arg_20_1].unlockSkillList, arg_20_2) == false then
		return true
	end

	return false
end

function var_0_0.GetInitiativeSkillUseNum(arg_21_0, arg_21_1)
	if table.isEmpty(arg_21_0.curLevelData_) then
		return 0
	end

	if arg_21_0.curLevelData_.selectInitiativeSkillList[arg_21_1] ~= 0 then
		return 1
	end

	return 0
end

function var_0_0.GetPassiveSkillUseNum(arg_22_0)
	if table.isEmpty(arg_22_0.curLevelData_) then
		return 0
	end

	return #arg_22_0.curLevelData_.selectPassiveSkillList
end

function var_0_0.GetCurNextWaveID(arg_23_0)
	if table.isEmpty(arg_23_0.curLevelData_) then
		return 0
	end

	local var_23_0 = ActivityReforgeLevelCfg[arg_23_0.curLevelData_.curLevelID].wave_list

	if table.nums(arg_23_0.curLevelData_.waveDataList) > 0 then
		for iter_23_0, iter_23_1 in pairs(var_23_0) do
			if arg_23_0.curLevelData_.waveDataList[iter_23_1].isPass == false then
				return iter_23_1
			end
		end
	else
		return var_23_0[1]
	end
end

function var_0_0.GetCurLevelFinishWave(arg_24_0)
	if table.isEmpty(arg_24_0.curLevelData_) then
		return 0
	end

	local var_24_0 = 0

	for iter_24_0, iter_24_1 in pairs(arg_24_0.curLevelData_.waveDataList) do
		if iter_24_1.isPass == true then
			var_24_0 = var_24_0 + 1
		end
	end

	return var_24_0
end

function var_0_0.GetCurLastWinWaveID(arg_25_0)
	if table.isEmpty(arg_25_0.curLevelData_) then
		return 0
	end

	local var_25_0 = ActivityReforgeLevelCfg[arg_25_0.curLevelData_.curLevelID].wave_list

	if table.nums(arg_25_0.curLevelData_.waveDataList) > 0 then
		local var_25_1 = 0

		for iter_25_0, iter_25_1 in pairs(var_25_0) do
			if arg_25_0.curLevelData_.waveDataList[iter_25_1].isPass == true then
				var_25_1 = iter_25_1
			end
		end

		return var_25_1
	else
		return 0
	end
end

function var_0_0.GetCurUsingInitiativeSkill(arg_26_0, arg_26_1)
	if table.isEmpty(arg_26_0.curLevelData_) then
		return 0
	end

	return arg_26_0.curLevelData_.selectInitiativeSkillList[arg_26_1]
end

function var_0_0.GetCurUsingInitiativeSkillList(arg_27_0)
	if table.isEmpty(arg_27_0.curLevelData_) then
		return 0
	end

	local var_27_0 = {}

	for iter_27_0 = 1, 4 do
		local var_27_1 = arg_27_0.curLevelData_.selectInitiativeSkillList[iter_27_0]

		if var_27_1 > 0 then
			table.insert(var_27_0, var_27_1)
		end
	end

	return var_27_0
end

function var_0_0.GetCurUsingPassiveSkillList(arg_28_0)
	if table.isEmpty(arg_28_0.curLevelData_) then
		return {}
	end

	return arg_28_0.curLevelData_.selectPassiveSkillList
end

function var_0_0.GetWaveFinishData(arg_29_0, arg_29_1)
	local var_29_0 = {
		isPass = arg_29_0.curLevelData_.waveDataList[arg_29_1].isPass
	}

	if arg_29_0.curLevelData_.waveDataList[arg_29_1].isPass then
		var_29_0.useSeconds = arg_29_0.curLevelData_.waveDataList[arg_29_1].useSeconds
		var_29_0.losePoint = arg_29_0.curLevelData_.waveDataList[arg_29_1].losePoint
		var_29_0.useGold = arg_29_0.curLevelData_.waveDataList[arg_29_1].useGold
	else
		var_29_0.useSeconds = 0
		var_29_0.losePoint = 0
		var_29_0.useGold = 0
	end

	return var_29_0
end

function var_0_0.GetFinishWaveHeroInfo(arg_30_0, arg_30_1, arg_30_2)
	if table.isEmpty(arg_30_0.curLevelData_) then
		return nil
	end

	local var_30_0 = {}

	for iter_30_0, iter_30_1 in pairs(arg_30_0.curLevelData_.waveDataList[arg_30_1].heroInfo) do
		if iter_30_1.heroID == arg_30_2 then
			var_30_0.leftHp = iter_30_1.leftHp
			var_30_0.maxHp = iter_30_1.maxHp

			return var_30_0
		end
	end
end

function var_0_0.GetCurUsingSkillList(arg_31_0)
	if table.isEmpty(arg_31_0.curLevelData_) then
		return {}
	end

	local var_31_0 = true
	local var_31_1 = {}

	for iter_31_0 = 1, 4 do
		local var_31_2 = arg_31_0.curLevelData_.selectInitiativeSkillList[iter_31_0]

		if var_31_2 > 0 then
			var_31_0 = false

			table.insert(var_31_1, var_31_2)
		else
			table.insert(var_31_1, 0)
		end
	end

	for iter_31_1, iter_31_2 in pairs(arg_31_0.curLevelData_.selectPassiveSkillList) do
		var_31_0 = false

		table.insert(var_31_1, iter_31_2)
	end

	return var_31_1, var_31_0
end

function var_0_0.GetFrontWaveBattleParams(arg_32_0, arg_32_1)
	if table.isEmpty(arg_32_0.curLevelData_) then
		return 0
	end

	local var_32_0 = 0
	local var_32_1 = ActivityReforgeLevelCfg[arg_32_0.curLevelData_.curLevelID].wave_list

	for iter_32_0, iter_32_1 in pairs(var_32_1) do
		if iter_32_1 == arg_32_1 then
			if iter_32_0 == 1 then
				return 0
			else
				var_32_0 = var_32_1[iter_32_0 - 1]

				break
			end
		end
	end

	return arg_32_0.curLevelData_.waveDataList[var_32_0].battleParams
end

function var_0_0.GetPassWaveUsedSkillList(arg_33_0, arg_33_1)
	if table.isEmpty(arg_33_0.curLevelData_) then
		return {}
	end

	local var_33_0 = {}

	for iter_33_0 = 1, 4 do
		local var_33_1 = arg_33_0.curLevelData_.waveDataList[arg_33_1].selectInitiativeSkillList[iter_33_0]

		if var_33_1 > 0 then
			table.insert(var_33_0, var_33_1)
		else
			table.insert(var_33_0, 0)
		end
	end

	for iter_33_1, iter_33_2 in pairs(arg_33_0.curLevelData_.waveDataList[arg_33_1].selectPassiveSkillList) do
		table.insert(var_33_0, iter_33_2)
	end

	return var_33_0
end

function var_0_0.SetCurFinishLevelServerData(arg_34_0, arg_34_1)
	arg_34_0.curLevelData_.finishLevelData_ = {}
	arg_34_0.curLevelData_.finishLevelData_.stageID = arg_34_1.stage_id
	arg_34_0.curLevelData_.finishLevelData_.times = arg_34_1.times
	arg_34_0.curLevelData_.finishLevelData_.minLosePoint = arg_34_1.min_lose_point
	arg_34_0.curLevelData_.finishLevelData_.minUseGold = arg_34_1.min_use_gold
	arg_34_0.curLevelData_.finishLevelData_.minUseSeconds = arg_34_1.min_use_seconds
end

function var_0_0.GetCurFinishLevelServerData(arg_35_0)
	if table.isEmpty(arg_35_0.curLevelData_) then
		return nil
	end

	return arg_35_0.curLevelData_.finishLevelData_
end

function var_0_0.SetLevelAllPlayerServerData(arg_36_0, arg_36_1, arg_36_2, arg_36_3)
	arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2] = {}

	local var_36_0 = ActivityTools.GetMainActivityId(arg_36_1)
	local var_36_1 = ActivityReforgeGameSettingCfg[var_36_0].bar_num_max

	for iter_36_0, iter_36_1 in ipairs(arg_36_3) do
		if iter_36_1.id == 1 then
			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint = {}
			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeValue = {}

			for iter_36_2 = 1, var_36_1 do
				arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeValue[iter_36_2] = 0
			end

			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeLength = iter_36_1.step

			for iter_36_3, iter_36_4 in ipairs(iter_36_1.range_value_list) do
				arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minLosePoint.rangeValue[iter_36_4.index] = iter_36_4.value
			end
		elseif iter_36_1.id == 2 then
			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold = {}
			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeValue = {}

			for iter_36_5 = 1, var_36_1 do
				arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeValue[iter_36_5] = 0
			end

			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeLength = iter_36_1.step

			for iter_36_6, iter_36_7 in ipairs(iter_36_1.range_value_list) do
				arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseGold.rangeValue[iter_36_7.index] = iter_36_7.value
			end
		elseif iter_36_1.id == 3 then
			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds = {}
			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeValue = {}

			for iter_36_8 = 1, var_36_1 do
				arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeValue[iter_36_8] = 0
			end

			arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeLength = iter_36_1.step

			for iter_36_9, iter_36_10 in ipairs(iter_36_1.range_value_list) do
				arg_36_0.cacheFinishLevelAllPlayerData_[arg_36_2].minUseSeconds.rangeValue[iter_36_10.index] = iter_36_10.value
			end
		end
	end
end

function var_0_0.GetLevelAllPlayerServerData(arg_37_0, arg_37_1)
	if table.isEmpty(arg_37_0.cacheFinishLevelAllPlayerData_) or table.isEmpty(arg_37_0.cacheFinishLevelAllPlayerData_[arg_37_1]) then
		return nil
	end

	return arg_37_0.cacheFinishLevelAllPlayerData_[arg_37_1]
end

function var_0_0.GetBestFinishLevelServerData(arg_38_0, arg_38_1)
	if arg_38_0.finishLevelData_[arg_38_1] then
		return arg_38_0.finishLevelData_[arg_38_1]
	end

	return nil
end

function var_0_0.SetCachePopBattleInfoView(arg_39_0, arg_39_1)
	arg_39_0.cachePopBattleInfoView_ = arg_39_1
end

function var_0_0.GetCachePopBattleInfoView(arg_40_0)
	return arg_40_0.cachePopBattleInfoView_
end

function var_0_0.GetCurCanUseGold(arg_41_0)
	if table.isEmpty(arg_41_0.curLevelData_) then
		return 0
	end

	return arg_41_0.curLevelData_.canUseGold
end

function var_0_0.AddCacheAddGoldNum(arg_42_0, arg_42_1)
	arg_42_0.cacheAddGoldNum_ = arg_42_0.cacheAddGoldNum_ + arg_42_1
end

function var_0_0.GetCacheAddGoldNum(arg_43_0)
	return arg_43_0.cacheAddGoldNum_
end

function var_0_0.ClearCacheAddGoldNum(arg_44_0)
	arg_44_0.cacheAddGoldNum_ = 0
end

function var_0_0.GetChapterIsReward(arg_45_0, arg_45_1)
	return arg_45_0.chapterData_[arg_45_1].isReward
end

return var_0_0
