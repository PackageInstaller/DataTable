local var_0_0 = singletonClass("WeekBossData")

function var_0_0:InitData(arg_1_1)
	self.activityId_ = arg_1_1.activity_id
	self.bossInfoList_ = {
		{
			boss_hp = 0,
			stage_id = BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[1][1]
		},
		{
			boss_hp = 0,
			stage_id = BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[1][2]
		},
		{
			boss_hp = 0,
			stage_id = BattleGodEaterDailyMonsterCfg.get_id_list_by_sub_type[1][3]
		}
	}

	for iter_1_0, iter_1_1 in ipairs(self.bossInfoList_) do
		if arg_1_1.boss_info_list[iter_1_0] then
			iter_1_1.boss_hp = arg_1_1.boss_info_list[iter_1_0].boss_hp or 0
		end
	end

	self.heroInfoList_ = arg_1_1.hero_info_list
	self.lastSelectHeroId_ = arg_1_1.hero_id
	self.bossSetting_ = GameSetting.activity_god_eater_week_boss.value

	self:InitHeroList()
	self:RefreshTalentUnlock()

	self.init_ = true
end

function var_0_0:InitHeroList()
	self.heroList_ = {
		ActivityGodEaterWeekBossCfg[1].hero_id,
		ActivityGodEaterWeekBossCfg[2].hero_id
	}
	self.totalDamage_ = {}
	self.selectTalentList_ = {}

	for iter_2_0, iter_2_1 in ipairs(self.heroInfoList_) do
		self.totalDamage_[ActivityGodEaterWeekBossCfg[iter_2_1.id].hero_id] = iter_2_1.value
		self.selectTalentList_[ActivityGodEaterWeekBossCfg[iter_2_1.id].hero_id] = {
			iter_2_1.talent_id_1,
			iter_2_1.talent_id_2
		}
	end

	for iter_2_2, iter_2_3 in ipairs(self.heroList_) do
		self.totalDamage_[iter_2_3] = self.totalDamage_[iter_2_3] or 0
		self.selectTalentList_[iter_2_3] = self.selectTalentList_[iter_2_3] or {
			0,
			0
		}
	end
end

function var_0_0:RefreshTalentUnlock()
	self.talentUnlock_ = {}

	for iter_3_0, iter_3_1 in ipairs(ActivityGodEaterWeekBossCfg.all) do
		for iter_3_2, iter_3_3 in ipairs(ActivityGodEaterWeekBossCfg[iter_3_1].talent_list) do
			for iter_3_4, iter_3_5 in ipairs(iter_3_3) do
				if IsConditionAchieved(TalentTreeCfg[iter_3_5].unlock_condition[1]) then
					self.talentUnlock_[iter_3_5] = true
				end
			end
		end
	end
end

function var_0_0:GetHeroList()
	return self.heroList_
end

function var_0_0:UpdateTalent(arg_5_1, arg_5_2, arg_5_3)
	self.selectTalentList_[arg_5_1][arg_5_2] = arg_5_3
end

function var_0_0:GetIsInit()
	return self.init_
end

function var_0_0:GetActivityId()
	return self.activityId_
end

function var_0_0:GetBossConsumeHp(arg_8_1)
	return self.bossInfoList_[arg_8_1 or self:GetDefaultDiff()].boss_hp
end

function var_0_0:GetRemainHpProp(arg_9_1)
	local var_9_0 = arg_9_1 or self:GetDefaultDiff()

	return math.max(self.bossSetting_[var_9_0][2] - self.bossInfoList_[var_9_0].boss_hp, 0) / self.bossSetting_[var_9_0][2], var_9_0
end

function var_0_0:GetTalentList()
	return self.talentList_
end

function var_0_0:GetBossChallengeCfg(arg_11_1)
	return clone(BossChallengeUICfg[self.bossSetting_[arg_11_1 or self:GetDefaultDiff()][3]])
end

function var_0_0:GetBossTotalHp(arg_12_1)
	return self.bossSetting_[arg_12_1 or self:GetDefaultDiff()][2]
end

function var_0_0:GetStageId(arg_13_1)
	return self.bossSetting_[arg_13_1 or self:GetDefaultDiff()][1]
end

function var_0_0:GetSelectTalent(arg_14_1)
	return self.selectTalentList_[arg_14_1]
end

function var_0_0:GetTalentUnlock(arg_15_1)
	return self.talentUnlock_[arg_15_1]
end

function var_0_0.GetTalentLockDesc(arg_16_0, arg_16_1)
	return string.format(ConditionCfg[TalentTreeCfg[arg_16_1].unlock_condition[1]].desc, ConditionCfg[TalentTreeCfg[arg_16_1].unlock_condition[1]].params[1])
end

function var_0_0:GetDefaultDiff()
	local var_17_0 = 1

	for iter_17_0 = 2, #self.bossInfoList_ do
		if self.bossInfoList_[iter_17_0 - 1].boss_hp >= self.bossSetting_[iter_17_0 - 1][2] and IsConditionAchieved(self.bossSetting_[iter_17_0][4]) then
			var_17_0 = math.max(var_17_0, iter_17_0)
		end
	end

	return var_17_0
end

function var_0_0.SetCameras(arg_18_0, arg_18_1)
	arg_18_0.virtualCameras_ = arg_18_1
end

function var_0_0:GetCameras()
	return self.virtualCameras_
end

function var_0_0:GetIsPassDiff(arg_20_1)
	return self.bossInfoList_[arg_20_1].boss_hp >= self.bossSetting_[arg_20_1][2]
end

function var_0_0:GetLastSelectHero()
	return self.lastSelectHeroId_
end

function var_0_0.SetLastSelectHero(arg_22_0, arg_22_1)
	arg_22_0.lastSelectHeroId_ = arg_22_1
end

return var_0_0
