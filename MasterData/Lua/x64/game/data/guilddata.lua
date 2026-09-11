local var_0_0 = singletonClass("GuildData")

function var_0_0.Init(arg_1_0)
	arg_1_0.showImpeachFlag_ = false
	arg_1_0.recommendRefershStamptime_ = 0
	arg_1_0.requiredMemberStamptime_ = 0
	arg_1_0.recommendList_ = {}
	arg_1_0.searchList_ = {}
	arg_1_0.guildInfo_ = {}
	arg_1_0.guildMemberList_ = {}
	arg_1_0.guildRequestList_ = {}
	arg_1_0.cacheGuildListInfo_ = {}
	arg_1_0.bossData_ = {
		day_clear_prepose_times = 0,
		buff_index = 1,
		personal_score = 0,
		initedFromServer = false,
		day_first_clear_prepose = 0,
		currentAssistHeroId = {},
		preInfo = {},
		challengeInfo = {
			total_damage = 0,
			boss_id = 1,
			damage = 0,
			damage_level = 0,
			difficulty = 1,
			collective_damage_award_admitted = {},
			personal_score_award_admitted = {},
			cleared_difficulty_list = {}
		},
		assist_info_list = {},
		rank_list = {}
	}
	arg_1_0.exitGuildTime_ = 0
	arg_1_0.renameFreeCnt_ = 0

	JumpTools.SetSystemOpenCheck(ViewConst.SYSTEM_ID.GUILD_BOSS, function()
		if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
			return false, "NEED_JOIN_CLUB"
		end

		if not GuildData:GetBossData().initedFromServer then
			return false, "GUILD_BOSS_CD_TIP"
		end

		return true, ""
	end)
end

function var_0_0.ParseRecommendData(arg_3_0, arg_3_1, arg_3_2)
	if arg_3_2 then
		return {
			id = arg_3_1.id,
			icon = arg_3_1.icon,
			name = arg_3_1.name,
			level = arg_3_1.level,
			member = arg_3_1.member_count,
			maxMemberCnt = arg_3_1.member_count_limit,
			contribute = arg_3_1.last_week_total_vitality,
			notice = arg_3_1.notice,
			isFree = arg_3_1.club_setting.examine_recruit_join_request_switch == 1,
			is_requested = arg_3_2 or 0
		}
	else
		return {
			id = arg_3_1.id,
			icon = arg_3_1.icon,
			name = arg_3_1.name,
			level = arg_3_1.level,
			member = arg_3_1.member_count,
			maxMemberCnt = arg_3_1.member_count_limit,
			contribute = arg_3_1.last_week_total_vitality,
			notice = arg_3_1.notice,
			isFree = arg_3_1.club_setting.examine_recruit_join_request_switch == 1
		}
	end
end

function var_0_0.ParseRequestMemberData(arg_4_0, arg_4_1)
	return {
		weekContribute = 0,
		contribute = 0,
		id = arg_4_1.id,
		icon = arg_4_1.base_info.icon,
		frame = arg_4_1.base_info.icon_frame,
		name = arg_4_1.base_info.nick,
		post = GuildConst.GUILD_POST.TRAINEE,
		level = arg_4_1.level,
		offlineStamptime = arg_4_1.online_info
	}
end

function var_0_0.ParseMemberData(arg_5_0, arg_5_1)
	return {
		id = arg_5_1.id,
		icon = arg_5_1.user_profile_base.icon,
		frame = arg_5_1.user_profile_base.icon_frame,
		name = arg_5_1.user_profile_base.nick,
		post = arg_5_1.duty,
		level = arg_5_1.level,
		contribute = arg_5_1.total_vitality,
		weekContribute = arg_5_1.vitality,
		offlineStamptime = (arg_5_1.id == USER_ID or nil) and 0
	}
end

function var_0_0:InitGuildRecommendList(arg_6_1)
	self.recommendList_ = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(self.recommendList_, self:ParseRecommendData(iter_6_1.club_info, iter_6_1.is_requested))
	end
end

function var_0_0:AddJoinData(arg_7_1)
	if self.recommendList_ then
		for iter_7_0, iter_7_1 in ipairs(self.recommendList_) do
			if iter_7_1.id == arg_7_1 then
				self.recommendList_[iter_7_0].is_requested = 1
			end
		end
	end
end

function var_0_0:InitBossDataFromServer(arg_8_1)
	self.bossData_.initedFromServer = true
	self.bossData_.day_first_clear_award_admitted = arg_8_1.day_first_clear_award_admitted

	local var_8_0 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.affx_list) do
		local var_8_1 = {}

		table.insert(var_8_1, iter_8_1.affix_id)
		table.insert(var_8_1, iter_8_1.affix_level)
		table.insert(var_8_1, iter_8_1.type)
		table.insert(var_8_0, var_8_1)
	end

	self.bossData_.buff_affix_list = var_8_0
	self.bossData_.day_first_clear_prepose = arg_8_1.day_first_clear_prepose
	self.bossData_.day_clear_prepose_times = arg_8_1.day_clear_prepose_times
	self.bossData_.preInfo = {}

	for iter_8_2, iter_8_3 in ipairs(arg_8_1.pre_info) do
		local var_8_2 = {
			level_id = iter_8_3.level_id,
			score = iter_8_3.score,
			stage_id = iter_8_3.stage_id,
			buff_id = iter_8_3.buff_id
		}

		self.bossData_.preInfo[var_8_2.level_id] = var_8_2
	end

	self.bossData_.challengeInfo = {
		personal_score = arg_8_1.info.personal_score,
		boss_id = arg_8_1.info.boss_tempalte_id,
		difficulty = arg_8_1.info.difficulty,
		total_damage = arg_8_1.info.total_damage,
		collective_damage_award_admitted = {},
		personal_score_award_admitted = {},
		damage_level = arg_8_1.info.damage_level,
		damage = arg_8_1.info.damage,
		cleared_difficulty_list = arg_8_1.info.cleared_difficulty_list
	}

	for iter_8_4, iter_8_5 in pairs(arg_8_1.info.collective_damage_award_admitted) do
		table.insert(self.bossData_.challengeInfo.collective_damage_award_admitted, iter_8_5)
	end

	for iter_8_6, iter_8_7 in ipairs(arg_8_1.info.personal_score_award_admitted) do
		table.insert(self.bossData_.challengeInfo.personal_score_award_admitted, iter_8_7)
	end

	manager.notify:Invoke(GUILD_BOSS_INIT, {})
end

function var_0_0:InitAssistInfoListFromServer(arg_9_1)
	self.bossData_.assist_info_list = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1.member_id ~= tostring(PlayerData:GetPlayerInfo().userID) and HeroCfg[iter_9_1.assist_hero_id] then
			table.insert(self.bossData_.assist_info_list, {
				member_id = iter_9_1.member_id,
				member_post = iter_9_1.member_post,
				assist_hero_id = iter_9_1.assist_hero_id,
				assist_hero_skin = iter_9_1.assist_hero_skin,
				fight_capacity = iter_9_1.fight_capacity,
				hero_rare = iter_9_1.hero_rare,
				hero_level = iter_9_1.hero_level,
				nick = iter_9_1.nick,
				hero_oath_display = iter_9_1.hero_oath_display
			})
		end
	end

	manager.notify:Invoke(GUILD_ASSIST_BRIEF_UPDATE, {})
end

function var_0_0:SetAssistChipId(arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(self.bossData_.assist_info_list) do
		if tostring(iter_10_1.member_id) == tostring(arg_10_1) then
			iter_10_1.chipId = arg_10_2

			break
		end
	end
end

function var_0_0:GetAssistantBriefList()
	return self.bossData_.assist_info_list
end

function var_0_0:OnBossDifficultlyChange(arg_12_1)
	self.bossData_.challengeInfo.difficulty = arg_12_1

	manager.notify:Invoke(GUILD_BOSS_DIFFICULTY_CHANGE, arg_12_1)
end

function var_0_0:InitGuildBossRankFromServer(arg_13_1)
	self.bossData_.rank_list = {}

	for iter_13_0, iter_13_1 in ipairs(arg_13_1) do
		local var_13_0 = {
			id = iter_13_1.id,
			icon = iter_13_1.base_info.icon,
			icon_frame = iter_13_1.base_info.icon_frame,
			nick = iter_13_1.base_info.nick,
			score = iter_13_1.score,
			timestamp = iter_13_1.timestamp,
			member_post = iter_13_1.member_post,
			hero_type_info = {}
		}

		for iter_13_2, iter_13_3 in ipairs(iter_13_1.hero_type_info) do
			table.insert(var_13_0.hero_type_info, {
				hero_id = iter_13_3.hero_id,
				skin_id = iter_13_3.skin_id
			})
		end

		table.insert(self.bossData_.rank_list, var_13_0)
	end

	manager.notify:Invoke(GUILD_BOSS_RANK_UPDATE, {})
end

function var_0_0:UpdateBossDamage(arg_14_1)
	self.bossData_.challengeInfo.total_damage = arg_14_1

	manager.notify:Invoke(GUILD_BOSS_UPDATE, {})
end

function var_0_0:GetRankList()
	return self.bossData_.rank_list
end

function var_0_0:GetBossData()
	return self.bossData_
end

function var_0_0:CanGetBonus()
	return self.bossData_.day_clear_prepose_times >= 1 and not self:IsGetFirstBossBonus()
end

function var_0_0:IsGetFirstBossBonus()
	return self.bossData_.day_first_clear_award_admitted == 1
end

function var_0_0:OnGetGuildBossFirstBonus()
	self.bossData_.day_first_clear_award_admitted = 1
end

function var_0_0:IsPassBossDifficulty(arg_20_1)
	if table.indexof(self.bossData_.challengeInfo.cleared_difficulty_list, arg_20_1) then
		return true
	end

	return false
end

function var_0_0:GetBossDifficulty()
	return self.bossData_.challengeInfo.difficulty
end

function var_0_0.GetLastTime(arg_22_0)
	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_BOSS_PREPARE) then
		return "prepose", ActivityData:GetActivityData(ActivityConst.GUILD_BOSS_PREPARE).stopTime
	else
		return "challenge", ActivityData:GetActivityData(ActivityConst.GUILD_BOSS_CHALLENGE).stopTime
	end
end

function var_0_0:GetGuildBossBuffList()
	return self.bossData_.buff_affix_list
end

function var_0_0:GetHaveGetBossBuffList()
	local var_24_0 = {}

	for iter_24_0, iter_24_1 in ipairs((self:GetGuildBossBuffList())) do
		if self.bossData_.preInfo[iter_24_0].score >= ClubBossPreposeCfg[iter_24_0].point_max then
			table.insert(var_24_0, iter_24_1)
		end
	end

	return var_24_0
end

function var_0_0:GetBossLastTime()
	return GameSetting.club_boss_prepose_max.value[1] - self.bossData_.day_clear_prepose_times
end

function var_0_0:OnPreposeSuccess()
	self.bossData_.day_clear_prepose_times = self.bossData_.day_clear_prepose_times + 1

	if self.bossData_.day_clear_prepose_times > GameSetting.club_boss_prepose_max.value[1] then
		self.bossData_.day_clear_prepose_times = GameSetting.club_boss_prepose_max.value[1]
	end
end

function var_0_0:HaveBossChallengedToday()
	return self.bossData_.day_first_clear_prepose == 1
end

function var_0_0:GetCurrentBossStageId()
	return ClubBossIdCfg[self.bossData_.challengeInfo.boss_id].stage_id
end

function var_0_0:GetCurBossId()
	return BossChallengeUICfg[self.bossData_.challengeInfo.boss_id].boss_id_list[1]
end

function var_0_0:GetBossPersonalScore()
	return self.bossData_.challengeInfo.personal_score
end

function var_0_0:ResetBossPersonalScore(arg_31_1)
	self.bossData_.challengeInfo.personal_score = math.max(self.bossData_.challengeInfo.personal_score, arg_31_1)
end

function var_0_0:GetCurrentBossAssistantHeroId()
	return self.bossData_.currentAssistHeroId
end

function var_0_0:CheckCurrentHeroIDIsAssistant(arg_33_1)
	if self.bossData_.currentAssistHeroId then
		for iter_33_0, iter_33_1 in ipairs(self.bossData_.currentAssistHeroId) do
			if iter_33_1 == arg_33_1 then
				return true
			end
		end
	end
end

function var_0_0:GetPreInfoList()
	return self.bossData_.preInfo
end

function var_0_0:GetCurrentBossDamage()
	return self.bossData_.challengeInfo.total_damage
end

function var_0_0:GetCurrentBossRemainHp()
	return math.max(ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp - self.bossData_.challengeInfo.total_damage, 0)
end

function var_0_0:HaveGetGuildBossPersonalReward(arg_37_1)
	if table.indexof(self.bossData_.challengeInfo.personal_score_award_admitted, arg_37_1) then
		return true
	end

	return false
end

function var_0_0:OnGuildBossPersonalRewardGet(arg_38_1)
	table.insert(self.bossData_.challengeInfo.personal_score_award_admitted, arg_38_1)
	manager.notify:Invoke(GUILD_BOSS_PERSONAL_REWARD_GET, arg_38_1)
end

function var_0_0:HaveGetGuildBossCommonReward(arg_39_1)
	if table.indexof(self.bossData_.challengeInfo.collective_damage_award_admitted, arg_39_1) then
		return true
	end

	return false
end

function var_0_0:OnGuildBossCommonRewardGet(arg_40_1)
	table.insert(self.bossData_.challengeInfo.collective_damage_award_admitted, arg_40_1)
	manager.notify:Invoke(GUILD_BOSS_COMMON_REWARD_GET, arg_40_1)
end

function var_0_0:GetRecommendList()
	return self.recommendList_
end

function var_0_0:InitSearceList(arg_42_1)
	self.searchList_ = {}

	table.insert(self.searchList_, self:ParseRecommendData(arg_42_1))
end

function var_0_0:GetSearchList()
	return self.searchList_
end

function var_0_0:InitGuildInfo(arg_44_1)
	local var_44_0 = {
		id = arg_44_1.id,
		icon = arg_44_1.icon,
		name = arg_44_1.name,
		level = arg_44_1.level,
		exp = arg_44_1.club_exp
	}

	var_44_0.curWeekExp = arg_44_1.weekly_gain_exp or 0
	var_44_0.curWeekCoin = arg_44_1.weekly_gain_coin or 0
	var_44_0.memberCnt = arg_44_1.member_count
	var_44_0.maxMemberCnt = arg_44_1.member_count_limit
	var_44_0.notice = arg_44_1.notice
	var_44_0.captain = arg_44_1.leader.user_profile_base.nick
	var_44_0.post = arg_44_1.post
	var_44_0.impeachTime = arg_44_1.impeach_timestamp + 172800
	var_44_0.reviewFlag = arg_44_1.club_setting.examine_recruit_join_request_switch
	var_44_0.limitLevel = arg_44_1.club_setting.join_request_limit
	var_44_0.isCandidate = arg_44_1.is_candidate == 1
	self.guildInfo_ = var_44_0

	if self.guildInfo_.post == GuildConst.GUILD_POST.CAPTAIN and self.guildInfo_.impeachTime - manager.time:GetServerTime() > 0 then
		manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 1)
	end

	saveData("guildInfo", "guildID", arg_44_1.id)
end

function var_0_0.SetShareTimestamp(arg_45_0, arg_45_1)
	arg_45_0.shareRefreshTimestamp_ = arg_45_1.last_share_timestamp + GameSetting.club_share_colddown.value[1]
end

function var_0_0:GetShareTimestamp()
	return self.shareRefreshTimestamp_ or 0
end

function var_0_0:SetAssistHero(arg_47_1)
	self.bossData_.currentAssistHeroId = {}

	if arg_47_1 and type(arg_47_1) == "table" then
		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			if HeroCfg[iter_47_1] then
				table.insert(self.bossData_.currentAssistHeroId, iter_47_1)
			end
		end
	end

	manager.notify:Invoke(GUILD_BOSS_ASSISTANT_HERO_CHANGE)
end

function var_0_0:GetGuildInfo()
	return self.guildInfo_
end

function var_0_0:SetGuildName(arg_49_1)
	self.guildInfo_.name = arg_49_1
end

function var_0_0:GetRenameFreeCnt()
	return self.renameFreeCnt_
end

function var_0_0.SetRenameFreeCnt(arg_51_0, arg_51_1)
	arg_51_0.renameFreeCnt_ = arg_51_1
end

function var_0_0:UseRenameFree()
	self.renameFreeCnt_ = self.renameFreeCnt_ - 1
end

function var_0_0:SetGuildNotice(arg_53_1)
	self.guildInfo_.notice = arg_53_1
end

function var_0_0:SetGuildIcon(arg_54_1)
	self.guildInfo_.icon = arg_54_1
end

function var_0_0:RefreshWeekResources()
	self.guildInfo_.curWeekExp = 0
	self.guildInfo_.curWeekCoin = 0
end

function var_0_0:ModifyEXP(arg_56_1)
	if self.guildInfo_.id == nil then
		return
	end

	local var_56_0 = self.guildInfo_.level

	if self.guildInfo_.level >= GameSetting.club_max_level.value[1] then
		return
	end

	local var_56_1 = self.guildInfo_.exp

	for iter_56_0 = var_56_0 - 1, 1, -1 do
		var_56_1 = var_56_1 - ClubLevelCfg[iter_56_0].club_level_exp
	end

	self.guildInfo_.exp = arg_56_1
	self.guildInfo_.curWeekExp = self.guildInfo_.curWeekExp + (arg_56_1 - self.guildInfo_.exp)

	local var_56_4 = self.guildInfo_.exp

	for iter_56_1 = 1, GameSetting.club_max_level.value[1] do
		var_56_4 = var_56_4 - ClubLevelCfg[iter_56_1].club_level_exp

		if var_56_4 < 0 then
			self.guildInfo_.level = iter_56_1

			return
		end
	end

	self.guildInfo_.level = GameSetting.club_max_level.value[1]
end

function var_0_0:GetMaxWeekExp()
	if self.guildInfo_.level == nil then
		return 0
	end

	return ClubLevelCfg[self.guildInfo_.level].max_exp_per_week
end

function var_0_0:ModifyCoin(arg_58_1)
	if self.guildInfo_.id == nil then
		return
	end

	local var_58_0 = ClubLevelCfg[self.guildInfo_.level].max_currency_per_week - self.guildInfo_.curWeekCoin

	if ClubLevelCfg[self.guildInfo_.level].max_currency_per_week - self.guildInfo_.curWeekCoin <= 0 then
		return
	end

	self.guildInfo_.curWeekCoin = var_58_0 < arg_58_1 and self.guildInfo_.curWeekCoin + var_58_0 or self.guildInfo_.curWeekCoin + arg_58_1
end

function var_0_0:GetMaxWeekCoin()
	if self.guildInfo_.level == nil then
		return 0
	end

	return ClubLevelCfg[self.guildInfo_.level].max_currency_per_week
end

function var_0_0:UpdateMemberCnt(arg_60_1)
	self.guildInfo_.memberCnt = (self.guildInfo_.memberCnt or 0) + arg_60_1
end

function var_0_0:SetGuildSetting(arg_61_1, arg_61_2)
	self.guildInfo_.reviewFlag = arg_61_1
	self.guildInfo_.limitLevel = arg_61_2
end

function var_0_0.ExitGuild(arg_62_0)
	arg_62_0.guildInfo_ = {}
	arg_62_0.guildRequestList_ = {}
	arg_62_0.guildMemberList_ = {}
	arg_62_0.bossData_ = {
		day_clear_prepose_times = 0,
		buff_index = 1,
		personal_score = 0,
		currentAssistHeroId = 0,
		initedFromServer = false,
		day_first_clear_prepose = 0,
		preInfo = {},
		challengeInfo = {
			total_damage = 0,
			boss_id = 1,
			damage = 0,
			damage_level = 0,
			difficulty = 1,
			collective_damage_award_admitted = {},
			personal_score_award_admitted = {},
			cleared_difficulty_list = {}
		},
		assist_info_list = {},
		rank_list = {}
	}
	arg_62_0.requiredMemberStamptime_ = 0

	manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 0)
	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, 0)
	manager.redPoint:setTip(RedPointConst.CLUB_TASK, 0)
	saveData("guildInfo", "guildID", nil)
end

function var_0_0:GetExitTime()
	return self.exitGuildTime_
end

function var_0_0.SetExitTime(arg_64_0, arg_64_1)
	arg_64_0.exitGuildTime_ = arg_64_1
end

function var_0_0:InitGuildMember(arg_65_1)
	self.guildMemberList_ = {}

	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		self.guildMemberList_[iter_65_1.id] = self:ParseMemberData(iter_65_1)
	end
end

function var_0_0:AddMember(arg_66_1)
	self.guildMemberList_[arg_66_1.member.id] = self:ParseMemberData(arg_66_1.member)

	if arg_66_1.member.id ~= USER_ID then
		self:UpdateMemberCnt(1)
	end
end

function var_0_0:RemoveMember(arg_67_1)
	self.guildMemberList_[arg_67_1.id] = nil
	self.requiredMemberStamptime_ = 0

	if arg_67_1.id ~= USER_ID then
		self:UpdateMemberCnt(-1)
	end
end

function var_0_0:GetGuildMemberData(arg_68_1)
	return self.guildMemberList_[arg_68_1]
end

function var_0_0:GetGuildMemberIDList()
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(self.guildMemberList_) do
		table.insert(var_69_0, iter_69_0)
	end

	if #var_69_0 > 1 then
		table.sort(var_69_0, function(arg_70_0, arg_70_1)
			if self.guildMemberList_[arg_70_0].post < self.guildMemberList_[arg_70_1].post then
				return true
			elseif self.guildMemberList_[arg_70_0].post == self.guildMemberList_[arg_70_1].post then
				if self.guildMemberList_[arg_70_0].offlineStamptime == 0 and self.guildMemberList_[arg_70_1].offlineStamptime ~= 0 or self.guildMemberList_[arg_70_1].offlineStamptime ~= 0 and self.guildMemberList_[arg_70_0].offlineStamptime > self.guildMemberList_[arg_70_1].offlineStamptime then
					return true
				elseif self.guildMemberList_[arg_70_0].offlineStamptime == self.guildMemberList_[arg_70_1].offlineStamptime then
					if self.guildMemberList_[arg_70_0].weekContribute > self.guildMemberList_[arg_70_1].weekContribute then
						return true
					elseif self.guildMemberList_[arg_70_0].weekContribute == self.guildMemberList_[arg_70_1].weekContribute then
						if self.guildMemberList_[arg_70_0].contribute > self.guildMemberList_[arg_70_0].contribute then
							return true
						elseif self.guildMemberList_[arg_70_0].contribute == self.guildMemberList_[arg_70_0].contribute and tonumber(self.guildMemberList_[arg_70_0].id) < tonumber(self.guildMemberList_[arg_70_1].id) then
							return true
						end
					end
				end
			end

			return false
		end)
	end

	return var_69_0
end

function var_0_0:GetGuildContributeList()
	local var_71_0 = {}

	for iter_71_0, iter_71_1 in pairs(self.guildMemberList_) do
		table.insert(var_71_0, iter_71_0)
	end

	if #var_71_0 > 1 then
		table.sort(var_71_0, function(arg_72_0, arg_72_1)
			if self.guildMemberList_[arg_72_0].contribute > self.guildMemberList_[arg_72_1].contribute then
				return true
			elseif self.guildMemberList_[arg_72_0].contribute == self.guildMemberList_[arg_72_1].contribute then
				if self.guildMemberList_[arg_72_0].weekContribute > self.guildMemberList_[arg_72_0].weekContribute then
					return true
				elseif self.guildMemberList_[arg_72_0].weekContribute == self.guildMemberList_[arg_72_0].weekContribute then
					if self.guildMemberList_[arg_72_0].post < self.guildMemberList_[arg_72_1].post then
						return true
					elseif self.guildMemberList_[arg_72_0].post == self.guildMemberList_[arg_72_1].post and tonumber(self.guildMemberList_[arg_72_0].id) < tonumber(self.guildMemberList_[arg_72_1].id) then
						return true
					end
				end
			end

			return false
		end)
	end

	return var_71_0
end

function var_0_0:GetGuildWeekContributeList()
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in pairs(self.guildMemberList_) do
		table.insert(var_73_0, iter_73_0)
	end

	if #var_73_0 > 1 then
		table.sort(var_73_0, function(arg_74_0, arg_74_1)
			if self.guildMemberList_[arg_74_0].weekContribute > self.guildMemberList_[arg_74_1].weekContribute then
				return true
			elseif self.guildMemberList_[arg_74_0].weekContribute == self.guildMemberList_[arg_74_1].weekContribute then
				if self.guildMemberList_[arg_74_0].contribute > self.guildMemberList_[arg_74_0].contribute then
					return true
				elseif self.guildMemberList_[arg_74_0].contribute == self.guildMemberList_[arg_74_0].contribute then
					if self.guildMemberList_[arg_74_0].post < self.guildMemberList_[arg_74_1].post then
						return true
					elseif self.guildMemberList_[arg_74_0].post == self.guildMemberList_[arg_74_1].post and tonumber(self.guildMemberList_[arg_74_0].id) < tonumber(self.guildMemberList_[arg_74_1].id) then
						return true
					end
				end
			end

			return false
		end)
	end

	return var_73_0
end

function var_0_0:InitGuildRequestMember(arg_75_1)
	for iter_75_0, iter_75_1 in ipairs(arg_75_1) do
		self.guildRequestList_[iter_75_1.id] = self:ParseRequestMemberData(iter_75_1)
	end

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, table.length(self.guildRequestList_))
end

function var_0_0:GetGuildRequestData(arg_76_1)
	return self.guildRequestList_[arg_76_1]
end

function var_0_0:GetGuildRequestIDList()
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in pairs(self.guildRequestList_) do
		table.insert(var_77_0, iter_77_0)
	end

	return var_77_0
end

function var_0_0:UpdateRequestMember(arg_78_1)
	if arg_78_1.type == 1 then
		self.guildRequestList_[arg_78_1.id] = self:ParseRequestMemberData(arg_78_1.member)
	elseif arg_78_1.type == 2 then
		self.guildRequestList_[arg_78_1.id] = nil
	elseif arg_78_1.type == 3 then
		self.guildRequestList_[arg_78_1.id] = nil
	end

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, table.length(self.guildRequestList_))
end

function var_0_0.RemoveAllRequestMember(arg_79_0)
	arg_79_0.guildRequestList_ = {}

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, 0)
end

function var_0_0:GetCaptainID()
	for iter_80_0, iter_80_1 in pairs(self.guildMemberList_) do
		if iter_80_1.post == GuildConst.GUILD_POST.CAPTAIN then
			return iter_80_1.id
		end
	end
end

function var_0_0:IsCaptainOrDeputy()
	return self.guildInfo_.post == GuildConst.GUILD_POST.CAPTAIN or self.guildInfo_.post == GuildConst.GUILD_POST.DEPUTY
end

function var_0_0:ChangedCaptain(arg_82_1)
	self.guildInfo_.captain = arg_82_1.nick

	local var_82_0 = self:GetCaptainID()

	if var_82_0 then
		self.guildMemberList_[var_82_0].post = GuildConst.GUILD_POST.MEMBER

		if self.guildMemberList_[var_82_0].id == USER_ID then
			self.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
		end

		self:RemoveAllRequestMember()
	end

	if self.guildMemberList_[arg_82_1.id] then
		self.guildMemberList_[arg_82_1.id].post = GuildConst.GUILD_POST.CAPTAIN
	end

	if arg_82_1.id == USER_ID then
		self.guildInfo_.post = GuildConst.GUILD_POST.CAPTAIN
	end
end

function var_0_0:ChangedDeputy(arg_83_1)
	if self.guildMemberList_[arg_83_1.id] then
		self.guildMemberList_[arg_83_1.id].post = GuildConst.GUILD_POST.DEPUTY
	end

	if arg_83_1.id == USER_ID then
		self.guildInfo_.post = GuildConst.GUILD_POST.DEPUTY
	end
end

function var_0_0:DismissDeputy(arg_84_1)
	if self.guildMemberList_[arg_84_1.id] then
		self.guildMemberList_[arg_84_1.id].post = GuildConst.GUILD_POST.MEMBER
	end

	if arg_84_1.id == USER_ID then
		self.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
	end
end

function var_0_0:GetCaptainOfflineTime()
	local var_85_0 = self:GetCaptainID()

	if self.guildMemberList_[var_85_0].offlineStamptime == 0 then
		return manager.time:GetServerTime()
	end

	return self.guildMemberList_[var_85_0].offlineStamptime
end

function var_0_0:ImpeachCaptain(arg_86_1)
	self.guildInfo_.impeachTime = arg_86_1.time_stamp + 172800
end

function var_0_0:CancelImpeach()
	self.guildInfo_.impeachTime = 0
end

function var_0_0:ApplyCaptain()
	self.guildInfo_.isCandidate = true
end

function var_0_0:Trainee2Member()
	self.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
end

function var_0_0:GetCacheGuildInfo(arg_90_1)
	return self.cacheGuildListInfo_[arg_90_1]
end

function var_0_0:SetCacheGuildInfo(arg_91_1)
	self.cacheGuildListInfo_[arg_91_1.id] = {
		id = arg_91_1.id,
		icon = arg_91_1.icon,
		name = arg_91_1.name,
		level = arg_91_1.level,
		exp = arg_91_1.club_exp,
		memberCnt = arg_91_1.member_count,
		maxMemberCnt = arg_91_1.member_count_limit,
		contribute = arg_91_1.last_week_total_vitality,
		notice = arg_91_1.notice,
		captain = arg_91_1.leader.user_profile_base.nick,
		isFree = arg_91_1.club_setting.examine_recruit_join_request_switch == 1,
		limitLevel = arg_91_1.club_setting.join_request_limit
	}
end

function var_0_0:GetImpeachFlag()
	return self.showImpeachFlag_
end

function var_0_0.SetImpeachFlag(arg_93_0)
	arg_93_0.showImpeachFlag_ = true
end

function var_0_0:GetRecommendRefreshStamptime()
	return self.recommendRefershStamptime_
end

function var_0_0.SetRecommendRefreshStamptime(arg_95_0)
	arg_95_0.recommendRefershStamptime_ = manager.time:GetServerTime()
end

function var_0_0.SetRequiredMemberStamptime(arg_96_0)
	arg_96_0.requiredMemberStamptime_ = manager.time:GetServerTime()
end

function var_0_0:GetRequiredMemberStamptime()
	return self.requiredMemberStamptime_
end

var_0_0.INVALID_GUILD = "0"

function var_0_0.IsGuildValid(arg_98_0)
	if arg_98_0 == nil then
		return false
	elseif type(arg_98_0) == "string" then
		return arg_98_0 ~= "0"
	elseif type(arg_98_0) == "userdata" then
		return arg_98_0 ~= uint64.new(0, 0)
	elseif type(arg_98_0) == "number" then
		return arg_98_0 ~= 0
	else
		return false
	end
end

return var_0_0
