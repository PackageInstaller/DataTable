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
	local var_5_0 = arg_5_1.online_info

	if arg_5_1.id == USER_ID then
		var_5_0 = 0
	end

	return {
		id = arg_5_1.id,
		icon = arg_5_1.user_profile_base.icon,
		frame = arg_5_1.user_profile_base.icon_frame,
		name = arg_5_1.user_profile_base.nick,
		post = arg_5_1.duty,
		level = arg_5_1.level,
		contribute = arg_5_1.total_vitality,
		weekContribute = arg_5_1.vitality,
		offlineStamptime = var_5_0
	}
end

function var_0_0.InitGuildRecommendList(arg_6_0, arg_6_1)
	arg_6_0.recommendList_ = {}

	for iter_6_0, iter_6_1 in ipairs(arg_6_1) do
		table.insert(arg_6_0.recommendList_, arg_6_0:ParseRecommendData(iter_6_1.club_info, iter_6_1.is_requested))
	end
end

function var_0_0.AddJoinData(arg_7_0, arg_7_1)
	if arg_7_0.recommendList_ then
		for iter_7_0, iter_7_1 in ipairs(arg_7_0.recommendList_) do
			if iter_7_1.id == arg_7_1 then
				arg_7_0.recommendList_[iter_7_0].is_requested = 1
			end
		end
	end
end

function var_0_0.InitBossDataFromServer(arg_8_0, arg_8_1)
	local var_8_0 = arg_8_1.pre_info
	local var_8_1 = arg_8_1.info

	arg_8_0.bossData_.initedFromServer = true
	arg_8_0.bossData_.day_first_clear_award_admitted = arg_8_1.day_first_clear_award_admitted

	local var_8_2 = {}

	for iter_8_0, iter_8_1 in ipairs(arg_8_1.affx_list) do
		local var_8_3 = {}

		table.insert(var_8_3, iter_8_1.affix_id)
		table.insert(var_8_3, iter_8_1.affix_level)
		table.insert(var_8_3, iter_8_1.type)
		table.insert(var_8_2, var_8_3)
	end

	arg_8_0.bossData_.buff_affix_list = var_8_2
	arg_8_0.bossData_.day_first_clear_prepose = arg_8_1.day_first_clear_prepose
	arg_8_0.bossData_.day_clear_prepose_times = arg_8_1.day_clear_prepose_times
	arg_8_0.bossData_.preInfo = {}

	for iter_8_2, iter_8_3 in ipairs(var_8_0) do
		local var_8_4 = {
			level_id = iter_8_3.level_id,
			score = iter_8_3.score,
			stage_id = iter_8_3.stage_id,
			buff_id = iter_8_3.buff_id
		}

		arg_8_0.bossData_.preInfo[var_8_4.level_id] = var_8_4
	end

	arg_8_0.bossData_.challengeInfo = {
		personal_score = var_8_1.personal_score,
		boss_id = var_8_1.boss_tempalte_id,
		difficulty = var_8_1.difficulty,
		total_damage = var_8_1.total_damage,
		collective_damage_award_admitted = {},
		personal_score_award_admitted = {},
		damage_level = var_8_1.damage_level,
		damage = var_8_1.damage,
		cleared_difficulty_list = var_8_1.cleared_difficulty_list
	}

	for iter_8_4, iter_8_5 in pairs(var_8_1.collective_damage_award_admitted) do
		table.insert(arg_8_0.bossData_.challengeInfo.collective_damage_award_admitted, iter_8_5)
	end

	for iter_8_6, iter_8_7 in ipairs(var_8_1.personal_score_award_admitted) do
		table.insert(arg_8_0.bossData_.challengeInfo.personal_score_award_admitted, iter_8_7)
	end

	manager.notify:Invoke(GUILD_BOSS_INIT, {})
end

function var_0_0.InitAssistInfoListFromServer(arg_9_0, arg_9_1)
	arg_9_0.bossData_.assist_info_list = {}

	for iter_9_0, iter_9_1 in ipairs(arg_9_1) do
		if iter_9_1.member_id ~= tostring(PlayerData:GetPlayerInfo().userID) and HeroCfg[iter_9_1.assist_hero_id] then
			local var_9_0 = {
				member_id = iter_9_1.member_id,
				member_post = iter_9_1.member_post,
				assist_hero_id = iter_9_1.assist_hero_id,
				assist_hero_skin = iter_9_1.assist_hero_skin,
				fight_capacity = iter_9_1.fight_capacity,
				hero_rare = iter_9_1.hero_rare,
				hero_level = iter_9_1.hero_level,
				nick = iter_9_1.nick,
				hero_oath_display = iter_9_1.hero_oath_display
			}

			table.insert(arg_9_0.bossData_.assist_info_list, var_9_0)
		end
	end

	manager.notify:Invoke(GUILD_ASSIST_BRIEF_UPDATE, {})
end

function var_0_0.SetAssistChipId(arg_10_0, arg_10_1, arg_10_2)
	for iter_10_0, iter_10_1 in ipairs(arg_10_0.bossData_.assist_info_list) do
		if tostring(iter_10_1.member_id) == tostring(arg_10_1) then
			iter_10_1.chipId = arg_10_2

			break
		end
	end
end

function var_0_0.GetAssistantBriefList(arg_11_0)
	return arg_11_0.bossData_.assist_info_list
end

function var_0_0.OnBossDifficultlyChange(arg_12_0, arg_12_1)
	arg_12_0.bossData_.challengeInfo.difficulty = arg_12_1

	manager.notify:Invoke(GUILD_BOSS_DIFFICULTY_CHANGE, arg_12_1)
end

function var_0_0.InitGuildBossRankFromServer(arg_13_0, arg_13_1)
	arg_13_0.bossData_.rank_list = {}

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
			local var_13_1 = {
				hero_id = iter_13_3.hero_id,
				skin_id = iter_13_3.skin_id
			}

			table.insert(var_13_0.hero_type_info, var_13_1)
		end

		table.insert(arg_13_0.bossData_.rank_list, var_13_0)
	end

	manager.notify:Invoke(GUILD_BOSS_RANK_UPDATE, {})
end

function var_0_0.UpdateBossDamage(arg_14_0, arg_14_1)
	arg_14_0.bossData_.challengeInfo.total_damage = arg_14_1

	manager.notify:Invoke(GUILD_BOSS_UPDATE, {})
end

function var_0_0.GetRankList(arg_15_0)
	return arg_15_0.bossData_.rank_list
end

function var_0_0.GetBossData(arg_16_0)
	return arg_16_0.bossData_
end

function var_0_0.CanGetBonus(arg_17_0)
	return arg_17_0.bossData_.day_clear_prepose_times >= 1 and not arg_17_0:IsGetFirstBossBonus()
end

function var_0_0.IsGetFirstBossBonus(arg_18_0)
	return arg_18_0.bossData_.day_first_clear_award_admitted == 1
end

function var_0_0.OnGetGuildBossFirstBonus(arg_19_0)
	arg_19_0.bossData_.day_first_clear_award_admitted = 1
end

function var_0_0.IsPassBossDifficulty(arg_20_0, arg_20_1)
	if table.indexof(arg_20_0.bossData_.challengeInfo.cleared_difficulty_list, arg_20_1) then
		return true
	end

	return false
end

function var_0_0.GetBossDifficulty(arg_21_0)
	return arg_21_0.bossData_.challengeInfo.difficulty
end

function var_0_0.GetLastTime(arg_22_0)
	local var_22_0

	if ActivityData:GetActivityIsOpen(ActivityConst.GUILD_BOSS_PREPARE) then
		local var_22_1 = ActivityData:GetActivityData(ActivityConst.GUILD_BOSS_PREPARE)

		return "prepose", var_22_1.stopTime
	else
		local var_22_2 = ActivityData:GetActivityData(ActivityConst.GUILD_BOSS_CHALLENGE)

		return "challenge", var_22_2.stopTime
	end
end

function var_0_0.GetGuildBossBuffList(arg_23_0)
	return arg_23_0.bossData_.buff_affix_list
end

function var_0_0.GetHaveGetBossBuffList(arg_24_0)
	local var_24_0 = arg_24_0:GetGuildBossBuffList()
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(var_24_0) do
		if arg_24_0.bossData_.preInfo[iter_24_0].score >= ClubBossPreposeCfg[iter_24_0].point_max then
			table.insert(var_24_1, iter_24_1)
		end
	end

	return var_24_1
end

function var_0_0.GetBossLastTime(arg_25_0)
	return GameSetting.club_boss_prepose_max.value[1] - arg_25_0.bossData_.day_clear_prepose_times
end

function var_0_0.OnPreposeSuccess(arg_26_0)
	arg_26_0.bossData_.day_clear_prepose_times = arg_26_0.bossData_.day_clear_prepose_times + 1

	if arg_26_0.bossData_.day_clear_prepose_times > GameSetting.club_boss_prepose_max.value[1] then
		arg_26_0.bossData_.day_clear_prepose_times = GameSetting.club_boss_prepose_max.value[1]
	end
end

function var_0_0.HaveBossChallengedToday(arg_27_0)
	return arg_27_0.bossData_.day_first_clear_prepose == 1
end

function var_0_0.GetCurrentBossStageId(arg_28_0)
	return ClubBossIdCfg[arg_28_0.bossData_.challengeInfo.boss_id].stage_id
end

function var_0_0.GetCurBossId(arg_29_0)
	return BossChallengeUICfg[arg_29_0.bossData_.challengeInfo.boss_id].boss_id_list[1]
end

function var_0_0.GetBossPersonalScore(arg_30_0)
	return arg_30_0.bossData_.challengeInfo.personal_score
end

function var_0_0.ResetBossPersonalScore(arg_31_0, arg_31_1)
	arg_31_0.bossData_.challengeInfo.personal_score = math.max(arg_31_0.bossData_.challengeInfo.personal_score, arg_31_1)
end

function var_0_0.GetCurrentBossAssistantHeroId(arg_32_0)
	return arg_32_0.bossData_.currentAssistHeroId
end

function var_0_0.CheckCurrentHeroIDIsAssistant(arg_33_0, arg_33_1)
	if arg_33_0.bossData_.currentAssistHeroId then
		for iter_33_0, iter_33_1 in ipairs(arg_33_0.bossData_.currentAssistHeroId) do
			if iter_33_1 == arg_33_1 then
				return true
			end
		end
	end
end

function var_0_0.GetPreInfoList(arg_34_0)
	return arg_34_0.bossData_.preInfo
end

function var_0_0.GetCurrentBossDamage(arg_35_0)
	return arg_35_0.bossData_.challengeInfo.total_damage
end

function var_0_0.GetCurrentBossRemainHp(arg_36_0)
	local var_36_0 = ClubBossCfg[GuildData:GetBossDifficulty()].boss_hp
	local var_36_1 = arg_36_0.bossData_.challengeInfo.total_damage

	return math.max(var_36_0 - var_36_1, 0)
end

function var_0_0.HaveGetGuildBossPersonalReward(arg_37_0, arg_37_1)
	if table.indexof(arg_37_0.bossData_.challengeInfo.personal_score_award_admitted, arg_37_1) then
		return true
	end

	return false
end

function var_0_0.OnGuildBossPersonalRewardGet(arg_38_0, arg_38_1)
	table.insert(arg_38_0.bossData_.challengeInfo.personal_score_award_admitted, arg_38_1)
	manager.notify:Invoke(GUILD_BOSS_PERSONAL_REWARD_GET, arg_38_1)
end

function var_0_0.HaveGetGuildBossCommonReward(arg_39_0, arg_39_1)
	if table.indexof(arg_39_0.bossData_.challengeInfo.collective_damage_award_admitted, arg_39_1) then
		return true
	end

	return false
end

function var_0_0.OnGuildBossCommonRewardGet(arg_40_0, arg_40_1)
	table.insert(arg_40_0.bossData_.challengeInfo.collective_damage_award_admitted, arg_40_1)
	manager.notify:Invoke(GUILD_BOSS_COMMON_REWARD_GET, arg_40_1)
end

function var_0_0.GetRecommendList(arg_41_0)
	return arg_41_0.recommendList_
end

function var_0_0.InitSearceList(arg_42_0, arg_42_1)
	arg_42_0.searchList_ = {}

	table.insert(arg_42_0.searchList_, arg_42_0:ParseRecommendData(arg_42_1))
end

function var_0_0.GetSearchList(arg_43_0)
	return arg_43_0.searchList_
end

function var_0_0.InitGuildInfo(arg_44_0, arg_44_1)
	arg_44_0.guildInfo_ = {
		id = arg_44_1.id,
		icon = arg_44_1.icon,
		name = arg_44_1.name,
		level = arg_44_1.level,
		exp = arg_44_1.club_exp,
		curWeekExp = arg_44_1.weekly_gain_exp or 0,
		curWeekCoin = arg_44_1.weekly_gain_coin or 0,
		memberCnt = arg_44_1.member_count,
		maxMemberCnt = arg_44_1.member_count_limit,
		notice = arg_44_1.notice,
		captain = arg_44_1.leader.user_profile_base.nick,
		post = arg_44_1.post,
		impeachTime = arg_44_1.impeach_timestamp + 172800,
		reviewFlag = arg_44_1.club_setting.examine_recruit_join_request_switch,
		limitLevel = arg_44_1.club_setting.join_request_limit,
		isCandidate = arg_44_1.is_candidate == 1
	}

	if arg_44_0.guildInfo_.post == GuildConst.GUILD_POST.CAPTAIN and arg_44_0.guildInfo_.impeachTime - manager.time:GetServerTime() > 0 then
		manager.redPoint:setTip(RedPointConst.GUILD_IMPEACH, 1)
	end

	saveData("guildInfo", "guildID", arg_44_1.id)
end

function var_0_0.SetShareTimestamp(arg_45_0, arg_45_1)
	arg_45_0.shareRefreshTimestamp_ = arg_45_1.last_share_timestamp + GameSetting.club_share_colddown.value[1]
end

function var_0_0.GetShareTimestamp(arg_46_0)
	return arg_46_0.shareRefreshTimestamp_ or 0
end

function var_0_0.SetAssistHero(arg_47_0, arg_47_1)
	arg_47_0.bossData_.currentAssistHeroId = {}

	if arg_47_1 and type(arg_47_1) == "table" then
		for iter_47_0, iter_47_1 in ipairs(arg_47_1) do
			if HeroCfg[iter_47_1] then
				table.insert(arg_47_0.bossData_.currentAssistHeroId, iter_47_1)
			end
		end
	end

	manager.notify:Invoke(GUILD_BOSS_ASSISTANT_HERO_CHANGE)
end

function var_0_0.GetGuildInfo(arg_48_0)
	return arg_48_0.guildInfo_
end

function var_0_0.SetGuildName(arg_49_0, arg_49_1)
	arg_49_0.guildInfo_.name = arg_49_1
end

function var_0_0.GetRenameFreeCnt(arg_50_0)
	return arg_50_0.renameFreeCnt_
end

function var_0_0.SetRenameFreeCnt(arg_51_0, arg_51_1)
	arg_51_0.renameFreeCnt_ = arg_51_1
end

function var_0_0.UseRenameFree(arg_52_0)
	arg_52_0.renameFreeCnt_ = arg_52_0.renameFreeCnt_ - 1
end

function var_0_0.SetGuildNotice(arg_53_0, arg_53_1)
	arg_53_0.guildInfo_.notice = arg_53_1
end

function var_0_0.SetGuildIcon(arg_54_0, arg_54_1)
	arg_54_0.guildInfo_.icon = arg_54_1
end

function var_0_0.RefreshWeekResources(arg_55_0)
	arg_55_0.guildInfo_.curWeekExp = 0
	arg_55_0.guildInfo_.curWeekCoin = 0
end

function var_0_0.ModifyEXP(arg_56_0, arg_56_1)
	if arg_56_0.guildInfo_.id == nil then
		return
	end

	local var_56_0 = arg_56_0.guildInfo_.level

	if var_56_0 >= GameSetting.club_max_level.value[1] then
		return
	end

	local var_56_1 = arg_56_0.guildInfo_.exp

	for iter_56_0 = var_56_0 - 1, 1, -1 do
		var_56_1 = var_56_1 - ClubLevelCfg[iter_56_0].club_level_exp
	end

	local var_56_2 = ClubLevelCfg[var_56_0].club_level_exp - var_56_1
	local var_56_3 = ClubLevelCfg[var_56_0].max_exp_per_week - arg_56_0.guildInfo_.curWeekExp
	local var_56_4 = arg_56_1 - arg_56_0.guildInfo_.exp

	arg_56_0.guildInfo_.exp = arg_56_1
	arg_56_0.guildInfo_.curWeekExp = arg_56_0.guildInfo_.curWeekExp + var_56_4

	local var_56_5 = arg_56_0.guildInfo_.exp

	for iter_56_1 = 1, GameSetting.club_max_level.value[1] do
		var_56_5 = var_56_5 - ClubLevelCfg[iter_56_1].club_level_exp

		if var_56_5 < 0 then
			arg_56_0.guildInfo_.level = iter_56_1

			return
		end
	end

	arg_56_0.guildInfo_.level = GameSetting.club_max_level.value[1]
end

function var_0_0.GetMaxWeekExp(arg_57_0)
	local var_57_0 = arg_57_0.guildInfo_.level

	if var_57_0 == nil then
		return 0
	end

	return ClubLevelCfg[var_57_0].max_exp_per_week
end

function var_0_0.ModifyCoin(arg_58_0, arg_58_1)
	if arg_58_0.guildInfo_.id == nil then
		return
	end

	local var_58_0 = arg_58_0.guildInfo_.level
	local var_58_1 = ClubLevelCfg[var_58_0].max_currency_per_week - arg_58_0.guildInfo_.curWeekCoin

	if var_58_1 <= 0 then
		return
	end

	if var_58_1 < arg_58_1 then
		arg_58_0.guildInfo_.curWeekCoin = arg_58_0.guildInfo_.curWeekCoin + var_58_1
	else
		arg_58_0.guildInfo_.curWeekCoin = arg_58_0.guildInfo_.curWeekCoin + arg_58_1
	end
end

function var_0_0.GetMaxWeekCoin(arg_59_0)
	local var_59_0 = arg_59_0.guildInfo_.level

	if var_59_0 == nil then
		return 0
	end

	return ClubLevelCfg[var_59_0].max_currency_per_week
end

function var_0_0.UpdateMemberCnt(arg_60_0, arg_60_1)
	arg_60_0.guildInfo_.memberCnt = (arg_60_0.guildInfo_.memberCnt or 0) + arg_60_1
end

function var_0_0.SetGuildSetting(arg_61_0, arg_61_1, arg_61_2)
	arg_61_0.guildInfo_.reviewFlag = arg_61_1
	arg_61_0.guildInfo_.limitLevel = arg_61_2
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

function var_0_0.GetExitTime(arg_63_0)
	return arg_63_0.exitGuildTime_
end

function var_0_0.SetExitTime(arg_64_0, arg_64_1)
	arg_64_0.exitGuildTime_ = arg_64_1
end

function var_0_0.InitGuildMember(arg_65_0, arg_65_1)
	arg_65_0.guildMemberList_ = {}

	for iter_65_0, iter_65_1 in ipairs(arg_65_1) do
		arg_65_0.guildMemberList_[iter_65_1.id] = arg_65_0:ParseMemberData(iter_65_1)
	end
end

function var_0_0.AddMember(arg_66_0, arg_66_1)
	local var_66_0 = arg_66_1.member

	arg_66_0.guildMemberList_[var_66_0.id] = arg_66_0:ParseMemberData(var_66_0)

	if var_66_0.id ~= USER_ID then
		arg_66_0:UpdateMemberCnt(1)
	end
end

function var_0_0.RemoveMember(arg_67_0, arg_67_1)
	arg_67_0.guildMemberList_[arg_67_1.id] = nil
	arg_67_0.requiredMemberStamptime_ = 0

	if arg_67_1.id ~= USER_ID then
		arg_67_0:UpdateMemberCnt(-1)
	end
end

function var_0_0.GetGuildMemberData(arg_68_0, arg_68_1)
	return arg_68_0.guildMemberList_[arg_68_1]
end

function var_0_0.GetGuildMemberIDList(arg_69_0)
	local var_69_0 = {}

	for iter_69_0, iter_69_1 in pairs(arg_69_0.guildMemberList_) do
		table.insert(var_69_0, iter_69_0)
	end

	if #var_69_0 > 1 then
		table.sort(var_69_0, function(arg_70_0, arg_70_1)
			local var_70_0 = arg_69_0.guildMemberList_[arg_70_0]
			local var_70_1 = arg_69_0.guildMemberList_[arg_70_1]

			if var_70_0.post < var_70_1.post then
				return true
			elseif var_70_0.post == var_70_1.post then
				if var_70_0.offlineStamptime == 0 and var_70_1.offlineStamptime ~= 0 or var_70_1.offlineStamptime ~= 0 and var_70_0.offlineStamptime > var_70_1.offlineStamptime then
					return true
				elseif var_70_0.offlineStamptime == var_70_1.offlineStamptime then
					if var_70_0.weekContribute > var_70_1.weekContribute then
						return true
					elseif var_70_0.weekContribute == var_70_1.weekContribute then
						if var_70_0.contribute > var_70_0.contribute then
							return true
						elseif var_70_0.contribute == var_70_0.contribute and tonumber(var_70_0.id) < tonumber(var_70_1.id) then
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

function var_0_0.GetGuildContributeList(arg_71_0)
	local var_71_0 = {}

	for iter_71_0, iter_71_1 in pairs(arg_71_0.guildMemberList_) do
		table.insert(var_71_0, iter_71_0)
	end

	if #var_71_0 > 1 then
		table.sort(var_71_0, function(arg_72_0, arg_72_1)
			local var_72_0 = arg_71_0.guildMemberList_[arg_72_0]
			local var_72_1 = arg_71_0.guildMemberList_[arg_72_1]

			if var_72_0.contribute > var_72_1.contribute then
				return true
			elseif var_72_0.contribute == var_72_1.contribute then
				if var_72_0.weekContribute > var_72_0.weekContribute then
					return true
				elseif var_72_0.weekContribute == var_72_0.weekContribute then
					if var_72_0.post < var_72_1.post then
						return true
					elseif var_72_0.post == var_72_1.post and tonumber(var_72_0.id) < tonumber(var_72_1.id) then
						return true
					end
				end
			end

			return false
		end)
	end

	return var_71_0
end

function var_0_0.GetGuildWeekContributeList(arg_73_0)
	local var_73_0 = {}

	for iter_73_0, iter_73_1 in pairs(arg_73_0.guildMemberList_) do
		table.insert(var_73_0, iter_73_0)
	end

	if #var_73_0 > 1 then
		table.sort(var_73_0, function(arg_74_0, arg_74_1)
			local var_74_0 = arg_73_0.guildMemberList_[arg_74_0]
			local var_74_1 = arg_73_0.guildMemberList_[arg_74_1]

			if var_74_0.weekContribute > var_74_1.weekContribute then
				return true
			elseif var_74_0.weekContribute == var_74_1.weekContribute then
				if var_74_0.contribute > var_74_0.contribute then
					return true
				elseif var_74_0.contribute == var_74_0.contribute then
					if var_74_0.post < var_74_1.post then
						return true
					elseif var_74_0.post == var_74_1.post and tonumber(var_74_0.id) < tonumber(var_74_1.id) then
						return true
					end
				end
			end

			return false
		end)
	end

	return var_73_0
end

function var_0_0.InitGuildRequestMember(arg_75_0, arg_75_1)
	for iter_75_0, iter_75_1 in ipairs(arg_75_1) do
		arg_75_0.guildRequestList_[iter_75_1.id] = arg_75_0:ParseRequestMemberData(iter_75_1)
	end

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, table.length(arg_75_0.guildRequestList_))
end

function var_0_0.GetGuildRequestData(arg_76_0, arg_76_1)
	return arg_76_0.guildRequestList_[arg_76_1]
end

function var_0_0.GetGuildRequestIDList(arg_77_0)
	local var_77_0 = {}

	for iter_77_0, iter_77_1 in pairs(arg_77_0.guildRequestList_) do
		table.insert(var_77_0, iter_77_0)
	end

	return var_77_0
end

function var_0_0.UpdateRequestMember(arg_78_0, arg_78_1)
	local var_78_0 = arg_78_1.member

	if arg_78_1.type == 1 then
		arg_78_0.guildRequestList_[arg_78_1.id] = arg_78_0:ParseRequestMemberData(arg_78_1.member)
	elseif arg_78_1.type == 2 then
		arg_78_0.guildRequestList_[arg_78_1.id] = nil
	elseif arg_78_1.type == 3 then
		arg_78_0.guildRequestList_[arg_78_1.id] = nil
	end

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, table.length(arg_78_0.guildRequestList_))
end

function var_0_0.RemoveAllRequestMember(arg_79_0)
	arg_79_0.guildRequestList_ = {}

	manager.redPoint:setTip(RedPointConst.GUILD_REQUEST, 0)
end

function var_0_0.GetCaptainID(arg_80_0)
	for iter_80_0, iter_80_1 in pairs(arg_80_0.guildMemberList_) do
		if iter_80_1.post == GuildConst.GUILD_POST.CAPTAIN then
			return iter_80_1.id
		end
	end
end

function var_0_0.IsCaptainOrDeputy(arg_81_0)
	local var_81_0 = arg_81_0.guildInfo_.post

	return var_81_0 == GuildConst.GUILD_POST.CAPTAIN or var_81_0 == GuildConst.GUILD_POST.DEPUTY
end

function var_0_0.ChangedCaptain(arg_82_0, arg_82_1)
	arg_82_0.guildInfo_.captain = arg_82_1.nick

	local var_82_0 = arg_82_0:GetCaptainID()

	if var_82_0 then
		local var_82_1 = arg_82_0.guildMemberList_[var_82_0]

		var_82_1.post = GuildConst.GUILD_POST.MEMBER

		if var_82_1.id == USER_ID then
			arg_82_0.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
		end

		arg_82_0:RemoveAllRequestMember()
	end

	if arg_82_0.guildMemberList_[arg_82_1.id] then
		arg_82_0.guildMemberList_[arg_82_1.id].post = GuildConst.GUILD_POST.CAPTAIN
	end

	if arg_82_1.id == USER_ID then
		arg_82_0.guildInfo_.post = GuildConst.GUILD_POST.CAPTAIN
	end
end

function var_0_0.ChangedDeputy(arg_83_0, arg_83_1)
	if arg_83_0.guildMemberList_[arg_83_1.id] then
		arg_83_0.guildMemberList_[arg_83_1.id].post = GuildConst.GUILD_POST.DEPUTY
	end

	if arg_83_1.id == USER_ID then
		arg_83_0.guildInfo_.post = GuildConst.GUILD_POST.DEPUTY
	end
end

function var_0_0.DismissDeputy(arg_84_0, arg_84_1)
	if arg_84_0.guildMemberList_[arg_84_1.id] then
		arg_84_0.guildMemberList_[arg_84_1.id].post = GuildConst.GUILD_POST.MEMBER
	end

	if arg_84_1.id == USER_ID then
		arg_84_0.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
	end
end

function var_0_0.GetCaptainOfflineTime(arg_85_0)
	local var_85_0 = arg_85_0:GetCaptainID()

	if arg_85_0.guildMemberList_[var_85_0].offlineStamptime == 0 then
		return manager.time:GetServerTime()
	end

	return arg_85_0.guildMemberList_[var_85_0].offlineStamptime
end

function var_0_0.ImpeachCaptain(arg_86_0, arg_86_1)
	arg_86_0.guildInfo_.impeachTime = arg_86_1.time_stamp + 172800
end

function var_0_0.CancelImpeach(arg_87_0)
	arg_87_0.guildInfo_.impeachTime = 0
end

function var_0_0.ApplyCaptain(arg_88_0)
	arg_88_0.guildInfo_.isCandidate = true
end

function var_0_0.Trainee2Member(arg_89_0)
	arg_89_0.guildInfo_.post = GuildConst.GUILD_POST.MEMBER
end

function var_0_0.GetCacheGuildInfo(arg_90_0, arg_90_1)
	return arg_90_0.cacheGuildListInfo_[arg_90_1]
end

function var_0_0.SetCacheGuildInfo(arg_91_0, arg_91_1)
	arg_91_0.cacheGuildListInfo_[arg_91_1.id] = {
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

function var_0_0.GetImpeachFlag(arg_92_0)
	return arg_92_0.showImpeachFlag_
end

function var_0_0.SetImpeachFlag(arg_93_0)
	arg_93_0.showImpeachFlag_ = true
end

function var_0_0.GetRecommendRefreshStamptime(arg_94_0)
	return arg_94_0.recommendRefershStamptime_
end

function var_0_0.SetRecommendRefreshStamptime(arg_95_0)
	arg_95_0.recommendRefershStamptime_ = manager.time:GetServerTime()
end

function var_0_0.SetRequiredMemberStamptime(arg_96_0)
	arg_96_0.requiredMemberStamptime_ = manager.time:GetServerTime()
end

function var_0_0.GetRequiredMemberStamptime(arg_97_0)
	return arg_97_0.requiredMemberStamptime_
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
