local var_0_0 = singletonClass("WeekBossData")

function var_0_0.InitData(arg_1_0, arg_1_1)
	arg_1_0.activityId_ = arg_1_1.activity_id

	local var_1_0 = BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[1]

	arg_1_0.bossInfoList_ = {
		{
			boss_hp = 0,
			stage_id = var_1_0[1]
		},
		{
			boss_hp = 0,
			stage_id = var_1_0[2]
		},
		{
			boss_hp = 0,
			stage_id = var_1_0[3]
		}
	}

	for iter_1_0, iter_1_1 in ipairs(arg_1_0.bossInfoList_) do
		iter_1_1.boss_hp = arg_1_1.boss_info_list[iter_1_0] and arg_1_1.boss_info_list[iter_1_0].boss_hp or 0
	end

	arg_1_0.heroInfoList_ = arg_1_1.hero_info_list
	arg_1_0.lastSelectHeroId_ = arg_1_1.hero_id
	arg_1_0.bossSetting_ = GameSetting.activity_god_eater_week_boss.value

	arg_1_0:InitHeroList()
	arg_1_0:RefreshTalentUnlock()

	arg_1_0.init_ = true
end

function var_0_0.InitHeroList(arg_2_0)
	arg_2_0.heroList_ = {
		ActivityGodEaterWeekBossCfg[1].hero_id,
		ActivityGodEaterWeekBossCfg[2].hero_id
	}
	arg_2_0.totalDamage_ = {}
	arg_2_0.selectTalentList_ = {}

	for iter_2_0, iter_2_1 in ipairs(arg_2_0.heroInfoList_) do
		local var_2_0 = ActivityGodEaterWeekBossCfg[iter_2_1.id].hero_id

		arg_2_0.totalDamage_[var_2_0] = iter_2_1.value
		arg_2_0.selectTalentList_[var_2_0] = {
			iter_2_1.talent_id_1,
			iter_2_1.talent_id_2
		}
	end

	for iter_2_2, iter_2_3 in ipairs(arg_2_0.heroList_) do
		arg_2_0.totalDamage_[iter_2_3] = arg_2_0.totalDamage_[iter_2_3] or 0
		arg_2_0.selectTalentList_[iter_2_3] = arg_2_0.selectTalentList_[iter_2_3] or {
			0,
			0
		}
	end
end

function var_0_0.RefreshTalentUnlock(arg_3_0)
	arg_3_0.talentUnlock_ = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityGodEaterWeekBossCfg.all) do
		local var_3_0 = ActivityGodEaterWeekBossCfg[iter_3_1].talent_list

		for iter_3_2, iter_3_3 in ipairs(var_3_0) do
			for iter_3_4, iter_3_5 in ipairs(iter_3_3) do
				if IsConditionAchieved(TalentTreeCfg[iter_3_5].unlock_condition[1]) then
					arg_3_0.talentUnlock_[iter_3_5] = true
				end
			end
		end
	end
end

function var_0_0.GetHeroList(arg_4_0)
	return arg_4_0.heroList_
end

function var_0_0.UpdateTalent(arg_5_0, arg_5_1, arg_5_2, arg_5_3)
	arg_5_0.selectTalentList_[arg_5_1][arg_5_2] = arg_5_3
end

function var_0_0.GetIsInit(arg_6_0)
	return arg_6_0.init_
end

function var_0_0.GetActivityId(arg_7_0)
	return arg_7_0.activityId_
end

function var_0_0.GetBossConsumeHp(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1 or arg_8_0:GetDefaultDiff()

	return arg_8_0.bossInfoList_[var_8_0].boss_hp
end

function var_0_0.GetRemainHpProp(arg_9_0, arg_9_1)
	local var_9_0 = arg_9_1 or arg_9_0:GetDefaultDiff()
	local var_9_1 = arg_9_0.bossInfoList_[var_9_0].boss_hp
	local var_9_2 = arg_9_0.bossSetting_[var_9_0][2]

	return math.max(var_9_2 - var_9_1, 0) / var_9_2, var_9_0
end

function var_0_0.GetTalentList(arg_10_0)
	return arg_10_0.talentList_
end

function var_0_0.GetBossChallengeCfg(arg_11_0, arg_11_1)
	local var_11_0 = arg_11_1 or arg_11_0:GetDefaultDiff()

	return clone(BossChallengeUICfg[arg_11_0.bossSetting_[var_11_0][3]])
end

function var_0_0.GetBossTotalHp(arg_12_0, arg_12_1)
	local var_12_0 = arg_12_1 or arg_12_0:GetDefaultDiff()

	return arg_12_0.bossSetting_[var_12_0][2]
end

function var_0_0.GetStageId(arg_13_0, arg_13_1)
	local var_13_0 = arg_13_1 or arg_13_0:GetDefaultDiff()

	return arg_13_0.bossSetting_[var_13_0][1]
end

function var_0_0.GetSelectTalent(arg_14_0, arg_14_1)
	return arg_14_0.selectTalentList_[arg_14_1]
end

function var_0_0.GetTalentUnlock(arg_15_0, arg_15_1)
	return arg_15_0.talentUnlock_[arg_15_1]
end

function var_0_0.GetTalentLockDesc(arg_16_0, arg_16_1)
	local var_16_0 = ConditionCfg[TalentTreeCfg[arg_16_1].unlock_condition[1]]

	return string.format(var_16_0.desc, var_16_0.params[1])
end

function var_0_0.GetDefaultDiff(arg_17_0)
	local var_17_0 = 1
	local var_17_1 = false
	local var_17_2 = false

	for iter_17_0 = 2, #arg_17_0.bossInfoList_ do
		local var_17_3 = arg_17_0.bossInfoList_[iter_17_0 - 1].boss_hp >= arg_17_0.bossSetting_[iter_17_0 - 1][2]
		local var_17_4 = IsConditionAchieved(arg_17_0.bossSetting_[iter_17_0][4])

		if var_17_3 and var_17_4 then
			var_17_0 = math.max(var_17_0, iter_17_0)
		end
	end

	return var_17_0
end

function var_0_0.SetCameras(arg_18_0, arg_18_1)
	arg_18_0.virtualCameras_ = arg_18_1
end

function var_0_0.GetCameras(arg_19_0)
	return arg_19_0.virtualCameras_
end

function var_0_0.GetIsPassDiff(arg_20_0, arg_20_1)
	return arg_20_0.bossInfoList_[arg_20_1].boss_hp >= arg_20_0.bossSetting_[arg_20_1][2]
end

function var_0_0.GetLastSelectHero(arg_21_0)
	return arg_21_0.lastSelectHeroId_
end

function var_0_0.SetLastSelectHero(arg_22_0, arg_22_1)
	arg_22_0.lastSelectHeroId_ = arg_22_1
end

return var_0_0
